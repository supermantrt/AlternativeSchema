ITEM.name = "Rosarius"
ITEM.description = "Faith is my shield, but a Rosarius also helps."
ITEM.model = "models/props_junk/cardboard_box001a.mdl"
ITEM.width = 4
ITEM.height = 3
ITEM.armorAmount = 300
ITEM.gasmask = true -- It will protect you from bad air
ITEM.category = "armor"
ITEM.flag = "a"
ITEM.resistance = true -- This will activate the protection bellow
ITEM.damage = { -- It is scaled; so 100 damage * 0.8 will makes the damage be 80.
			0.5, -- Bullets
			0.5, -- Slash
			0.5, -- Shock
			0.5, -- Burn
			1, -- Radiation
			0.5, -- Acid
			0.4, -- Explosion
}