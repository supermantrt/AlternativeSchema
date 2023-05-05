ITEM.name = "Cromwell's Powered Armor"
ITEM.description = "I will protect you!"
ITEM.model = "models/props_junk/cardboard_box001a.mdl"
ITEM.width = 3
ITEM.armorAmount = 40
ITEM.Durability = 200
ITEM.gasmask = true -- It will protect you from bad air
ITEM.height = 3
ITEM.flag = "a"
ITEM.category = "armor"
ITEM.resistance = true -- This will activate the protection bellow
ITEM.damage = { -- It is scaled; so 100 damage * 0.8 will makes the damage be 80.
			0.67, -- Bullets
			0.6, -- Slash
			0.9, -- Shock
			0.9, -- Burn
			0.7, -- Radiation
			0.9, -- Acid
			0.8, -- Explosion
}