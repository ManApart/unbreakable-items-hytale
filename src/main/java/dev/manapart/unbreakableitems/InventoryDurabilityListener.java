package dev.manapart.unbreakableitems;

import com.hypixel.hytale.event.EventRegistry;
import com.hypixel.hytale.server.core.entity.Entity;
import com.hypixel.hytale.server.core.event.events.entity.LivingEntityInventoryChangeEvent;
import com.hypixel.hytale.server.core.inventory.ItemStack;
import com.hypixel.hytale.server.core.inventory.container.ItemContainer;
import com.hypixel.hytale.server.core.inventory.transaction.ListTransaction;
import com.hypixel.hytale.server.core.inventory.transaction.MoveTransaction;
import com.hypixel.hytale.server.core.inventory.transaction.SlotTransaction;
import com.hypixel.hytale.server.core.inventory.transaction.Transaction;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

final class InventoryDurabilityListener {
  private static final Set<Integer> RESTORING = ConcurrentHashMap.newKeySet();

  private InventoryDurabilityListener() {
  }

  static void register(EventRegistry eventRegistry) {
    eventRegistry.registerGlobal(
      LivingEntityInventoryChangeEvent.class,
      InventoryDurabilityListener::onInventoryChanged
    );
  }

  private static void onInventoryChanged(LivingEntityInventoryChangeEvent event) {
    Entity entity = event.getEntity();
    if (entity == null) {
      return;
    }

    int entityKey = entity.getReference() != null
      ? entity.getReference().getIndex()
      : System.identityHashCode(entity);
    if (!RESTORING.add(entityKey)) {
      return;
    }

    try {
      ItemContainer container = event.getItemContainer();
      restoreBrokenSlotFromTransaction(container, event.getTransaction());
      restoreDamagedStacks(container);
    } finally {
      RESTORING.remove(entityKey);
    }
  }

  private static void restoreBrokenSlotFromTransaction(ItemContainer container, Transaction transaction) {
    if (transaction instanceof SlotTransaction slotTransaction) {
      restoreFromSlotTransaction(container, slotTransaction);
      return;
    }

    if (transaction instanceof ListTransaction<?> listTransaction) {
      for (Transaction child : listTransaction.getList()) {
        restoreBrokenSlotFromTransaction(container, child);
      }
      return;
    }

    if (transaction instanceof MoveTransaction<?> moveTransaction) {
      restoreFromSlotTransaction(container, moveTransaction.getRemoveTransaction());
      restoreBrokenSlotFromTransaction(container, moveTransaction.getAddTransaction());
    }
  }

  private static void restoreFromSlotTransaction(ItemContainer container, SlotTransaction slotTransaction) {
    ItemStack before = slotTransaction.getSlotBefore();
    ItemStack after = slotTransaction.getSlotAfter();
    if (!shouldRestore(before) || after != null && !after.isEmpty()) {
      return;
    }

    container.setItemStackForSlot(slotTransaction.getSlot(), before.withDurability(before.getMaxDurability()));
  }

  private static void restoreDamagedStacks(ItemContainer container) {
    for (short slot = 0; slot < container.getCapacity(); slot++) {
      ItemStack stack = container.getItemStack(slot);
      if (!shouldRestore(stack)) {
        continue;
      }

      container.setItemStackForSlot(slot, stack.withDurability(stack.getMaxDurability()));
    }
  }

  private static boolean shouldRestore(ItemStack stack) {
    if (stack == null || stack.isEmpty() || stack.isUnbreakable()) {
      return false;
    }

    double maxDurability = stack.getMaxDurability();
    return maxDurability > 0 && stack.getDurability() < maxDurability;
  }
}
