local PLUGIN = PLUGIN

ITEM.name = "Nightvision"
ITEM.model = "models/props_clutter/book_mq103.mdl"
ITEM.description = "The Book has a cheap look with the print date recent but almost falling apart"
ITEM.width = 2
ITEM.height = 2
ITEM.category = "Books"
ITEM.flag = "p"

ITEM.functions.Equip = {
	OnRun = function(itemTable)
		local client = itemTable.player
		print(render.GetLightColor( client:GetPos()))
	end,
	OnCanRun = function(itemTable)
		return !itemTable.player:IsCombine()
	end
}

function ITEM:OnEquipped()
end

function ITEM:OnUnequipped()
end
