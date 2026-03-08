# unpacked should have a Server/ folder
MOD_FOLDER=Manapart.UnbreakableItems
ITEMS=Server/Item/Items
TOOL_FOLDER="$ITEMS/Tool"
ARMOR_FOLDER="$ITEMS/Armor"
INTERACTIONS=Server/Item/Interactions/
INTERACTIONS_WEAPON=$INTERACTIONS/Weapons
NEW_ROOT="$(pwd)/$MOD_FOLDER"

pushd "unpacked"
  cp --parents $TOOL_FOLDER/Pickaxe/* "$NEW_ROOT"
  cp --parents $TOOL_FOLDER/Hoe/* "$NEW_ROOT"
  cp --parents $TOOL_FOLDER/Hatchet/* "$NEW_ROOT"
  cp --parents $TOOL_FOLDER/Hammer/* "$NEW_ROOT"
  cp --parents $TOOL_FOLDER/Shears/* "$NEW_ROOT"
  cp --parents $TOOL_FOLDER/Shovel/* "$NEW_ROOT"
  cp --parents $ARMOR_FOLDER/Adamantite/* "$NEW_ROOT"
  cp --parents $ARMOR_FOLDER/Copper/* "$NEW_ROOT"
  cp --parents $ARMOR_FOLDER/Bronze/* "$NEW_ROOT"
  cp --parents $ARMOR_FOLDER/Mithril/* "$NEW_ROOT"
  cp --parents $ARMOR_FOLDER/Iron/* "$NEW_ROOT"
  cp --parents $ARMOR_FOLDER/Steel/* "$NEW_ROOT"
  cp --parents $ARMOR_FOLDER/Thorium/* "$NEW_ROOT"
  cp --parents $ARMOR_FOLDER/Wood/* "$NEW_ROOT"
  cp --parents Server/Item/Items/Container/Container_Bucket.json "$NEW_ROOT"
  cp --parents Server/Item/Items/Weapon/Staff/Weapon_Staff_Crystal_Ice.json "$NEW_ROOT"
  cp --parents $INTERACTIONS/Tools/Fertilizer_Use.json "$NEW_ROOT"
  cp --parents $INTERACTIONS/Tools/Watering_Can_Use.json "$NEW_ROOT"
  cp --parents $INTERACTIONS_WEAPON/Hatchet/Attacks/Chop/Hatchet_Chop_Damage.json "$NEW_ROOT"
  cp --parents $INTERACTIONS_WEAPON/Hoe/Attacks/Till/Hoe_Till.json "$NEW_ROOT"
  cp --parents $INTERACTIONS_WEAPON/Pickaxe/Attacks/Pickaxe_Mine_Damage.json "$NEW_ROOT"
  cp --parents $INTERACTIONS_WEAPON/Sickle/Attacks/Swing_Left/Sickle_Swing_Left_Selector.json "$NEW_ROOT"
  cp --parents $INTERACTIONS_WEAPON/Sickle/Attacks/Swing_Right/Sickle_Swing_Right_Selector.json "$NEW_ROOT"
  cp --parents $INTERACTIONS_WEAPON/Staff/Ice/Ice_Staff_Primary_Entry.json "$NEW_ROOT"
  cp --parents $INTERACTIONS_WEAPON/Stick/Magic/Primary/Charged_Projectiles/Weapon_Stick_Fire_Projectile_Charged_0.json "$NEW_ROOT"
  cp --parents $INTERACTIONS_WEAPON/Stick/Magic/Primary/Charged_Projectiles/Weapon_Stick_Fire_Projectile_Charged_1.json "$NEW_ROOT"
  cp --parents $INTERACTIONS_WEAPON/Stick/Magic/Primary/Charged_Projectiles/Weapon_Stick_Fire_Projectile_Charged_2.json "$NEW_ROOT"
  cp --parents $INTERACTIONS_WEAPON/Stick/Magic/Primary/Charged_Projectiles/Weapon_Stick_Fire_Projectile_Charged_3.json "$NEW_ROOT"
  cp --parents $INTERACTIONS_WEAPON/Stick/Magic/Secondary/Weapon_Stick_Fire_Secondary_Entry.json "$NEW_ROOT"
popd

find Manapart.UnbreakableItems/Server -type f -name "*.json" -exec sed -i -E 's/"DurabilityLossOnHit":[[:space:]]*[0-9.]+/"DurabilityLossOnHit": 0/g' {} +
find Manapart.UnbreakableItems/Server -type f -name "*.json" -exec sed -i -E 's/"AdjustHeldItemDurability":[[:space:]]*-?[0-9.]+/"AdjustHeldItemDurability": 0/g' {} +
find Manapart.UnbreakableItems/Server -type f -name "*.json" -exec sed -i -E 's/"DurabilityLossOnUse":[[:space:]]*[0-9.]+/"DurabilityLossOnUse": 0/g' {} +
