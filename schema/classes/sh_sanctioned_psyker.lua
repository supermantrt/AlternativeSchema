CLASS.name = "Psyker"
CLASS.faction = FACTION_ASTROPATHS
CLASS.isDefault = false
CLASS.health = 200

function CLASS:OnSpawn(client)
    -- Custom health and armor for players in this faction.
	local character = client:GetCharacter()
	client:SetMaxHealth( self.health + (character:GetAttribute("con", 0) * ix.config.Get("constitutionMultiplier")))
	client:SetHealth( self.health + (character:GetAttribute("con", 0) * ix.config.Get("constitutionMultiplier")))
end

function CLASS:CanSwitchTo(client)
	return false
end

CLASS_PSY = CLASS.index