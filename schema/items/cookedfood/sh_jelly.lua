ITEM.name = "Jelly"
ITEM.model = Model("models/netch_jelly.mdl")
ITEM.description = "Produced by an animal."
ITEM.price = 0
ITEM.flag = "d"
ITEM.category = "Cooked Food"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		client:RestoreStamina(100)
		client:SetHealth( client:Health() + 20 )
		client:EmitSound("npc/antlion_grub/squashed.wav", 75, 150, 0.25)
	end,
	OnCanRun = function(itemTable)
		return !itemTable.player:IsCombine()
	end
}