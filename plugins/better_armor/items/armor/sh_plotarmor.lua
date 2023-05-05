ITEM.name = "Plot Armor"
ITEM.description = "Woaw, is this power armor?"
ITEM.model = "models/props_junk/cardboard_box001a.mdl"
ITEM.width = 4
ITEM.height = 3
ITEM.armorAmount = 9000
ITEM.Durability = 9000
ITEM.gasmask = true -- It will protect you from bad air
ITEM.category = "armor"
ITEM.flag = "a"
ITEM.resistance = true -- This will activate the protection bellow
ITEM.damage = { -- It is scaled; so 100 damage * 0.8 will makes the damage be 80.
			0.1, -- Bullets
			0.1, -- Slash
			0.1, -- Shock
			0.1, -- Burn
			0.1, -- Radiation
			0.1, -- Acid
			0.1, -- Explosion
}