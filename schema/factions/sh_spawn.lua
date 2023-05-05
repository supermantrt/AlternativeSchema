FACTION.name = "Newcomers"
FACTION.description = "Spawn Job"
FACTION.color = Color(77, 54, 54)
FACTION.pay = 0
FACTION.isDefault = true
FACTION.isGloballyRecognized = true
FACTION.models = {"models/muschi/city/muschi_city_citizen_1.mdl"}

function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()
	inventory:Add("starterpack")
end

FACTION_SPW = FACTION.index