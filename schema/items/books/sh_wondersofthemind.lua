local PLUGIN = PLUGIN

ITEM.name = "The Wonders of the Mind"
ITEM.model = "models/hpwrewrite/books/book2.mdl"
ITEM.description = "The cover is made of a wonderously fine material that is leathery to the touch."
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Books"
ITEM.flag = "p"

ITEM.functions.Read = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()
		if(client:GetCharacter():GetData("HasRead6", true) == false) then
			client:ChatNotify("I have already read this book and can gain no further knowledge from it")
			return false
		end
		character:UpdateAttrib("wil", 0.5)
		client:GetCharacter():SetData("HasRead6", false)
		client:GetCharacter():SetData("CanRepair", true)
		client:ChatNotify("The book shows in high details by the process which one can increase their willpower to combat psychic effects, torture and brainwashing. The pages give instructions to allow for greater clarity within the moment and remain an iron bastion even in the face of the worst horrors which this galaxy has to offer.")
	end,
	OnCanRun = function(itemTable)
		return !itemTable.player:IsCombine()
	end
}