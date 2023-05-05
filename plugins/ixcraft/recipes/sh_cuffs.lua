RECIPE.name = "Hanfcuffs"
RECIPE.description = "Crafting rec."
RECIPE.model = "models/dizcordum/wh/props/handcuffs_prop.mdl"
RECIPE.category = "Utility"
RECIPE.requirements = {
	["valuable4"] = 4,
	["scrap"] = 5,
}
RECIPE.results = {
	["cuffs"] = 1
}
RECIPE.tools = {
	"tools"
}
RECIPE.flag = "Q"

RECIPE:PostHook("OnCanCraft", function(recipeTable, client)
	for _, v in pairs(ents.FindByClass("ix_station_workbench")) do
		if (client:GetPos():DistToSqr(v:GetPos()) < 100 * 100) then
			return true
		end
	end

	return false, "You need to be near a workbench."
end)