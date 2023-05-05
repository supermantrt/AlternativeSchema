ITEM.name = "Dragonscale Power Armor"
ITEM.description = "Forged in the heat of the Omnissiah, it protects the Machine God's servants like no other."
ITEM.model = "models/props_junk/cardboard_box001a.mdl"
ITEM.width = 4
ITEM.height = 3
ITEM.armorAmount = 180
ITEM.Durability = 200
ITEM.gasmask = true -- It will protect you from bad air
ITEM.category = "armor"
ITEM.flag = "a"
ITEM.resistance = true -- This will activate the protection bellow
ITEM.damage = { -- It is scaled; so 100 damage * 0.8 will makes the damage be 80.
			0.7, -- Bullets
			0.7, -- Slash
			0.75, -- Shock
			0.7, -- Burn
			0.7, -- Radiation
			0.7, -- Acid
			0.75, -- Explosion
}