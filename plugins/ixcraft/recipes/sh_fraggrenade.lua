RECIPE.name = "Frag Grenade"
RECIPE.description = "Crafting rec."
RECIPE.model = "models/props_junk/cardboard_box001a.mdl"
RECIPE.category = "Utility"
RECIPE.requirements = {
	["valuable4"] = 2,
	["explosivepowder"] = 15,
	["explosivemechanisim"] = 1
}
RECIPE.results = {
	["frag"] = 1
}
RECIPE.tools = {
	"tools",
	"schematicfraggrenade"
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