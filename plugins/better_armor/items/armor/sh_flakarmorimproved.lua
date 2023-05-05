ITEM.name = "Improved Flak Armor"
ITEM.description = "An improved piece of Flak Armour."
ITEM.model = "models/props_junk/cardboard_box001a.mdl"
ITEM.width = 4
ITEM.height = 3
ITEM.armorAmount = 150
ITEM.Durability = 125
ITEM.gasmask = true -- It will protect you from bad air
ITEM.flag = "a"
ITEM.category = "armor"
ITEM.resistance = true -- This will activate the protection bellow
ITEM.damage = { -- It is scaled; so 100 damage * 0.8 will makes the damage be 80.
			0.7, -- Bullets
			0.75, -- Slash
			1, -- Shock
			1, -- Burn
			1, -- Radiation
			0.9, -- Acid
			1, -- Explosion
}