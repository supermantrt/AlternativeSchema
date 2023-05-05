RECIPE.name = "Improved Flak Armor"
RECIPE.description = "Upgrade Standard Flak Armor."
RECIPE.model = "models/props_junk/cardboard_box001a.mdl"
RECIPE.category = "Armor"
RECIPE.requirements = {
	["flakarmorupgradeingot"] = 3,
	["cameleolinesubstitute"] = 2,
	["flakarmorstandard"] = 1
}
RECIPE.results = {
	["flakarmorimproved"] = 1
}
RECIPE.tools = {
	"tools",
	"schematicflakarmor"
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