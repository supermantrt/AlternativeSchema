ITEM.name = "Refractor Field Generator"
ITEM.description = " refractor field generator is a small device which projects a protective energy field around the user. Its effect is to disperse the energy of an incoming shot or blow over the total area of the field."
ITEM.model = "models/props_junk/cardboard_box001a.mdl"
ITEM.width = 4
ITEM.height = 3
ITEM.armorAmount = 150
ITEM.gasmask = true -- It will protect you from bad air
ITEM.category = "armor"
ITEM.flag = "a"
ITEM.resistance = true -- This will activate the protection bellow
ITEM.damage = { -- It is scaled; so 100 damage * 0.8 will makes the damage be 80.
			0.65, -- Bullets
			0.85, -- Slash
			0.25, -- Shock
			0.1, -- Burn
			1, -- Radiation
			0.65, -- Acid
			0.65, -- Explosion
}