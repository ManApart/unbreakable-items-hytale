package dev.manapart.unbreakableitems;

import com.hypixel.hytale.server.core.plugin.JavaPlugin;
import com.hypixel.hytale.server.core.plugin.JavaPluginInit;

public class UnbreakableItems extends JavaPlugin {
  public UnbreakableItems(JavaPluginInit init) {
    super(init);
  }

  @Override
  protected void setup() {
    InventoryDurabilityListener.register(getEventRegistry());
  }
}
