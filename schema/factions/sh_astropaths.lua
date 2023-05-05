FACTION.name = "Astropathic Choir"
FACTION.description = "Working in servitude to the Rogue Trader."
FACTION.color = Color(53, 44, 176)
FACTION.pay = 0
FACTION.isDefault = false
FACTION.isGloballyRecognized = true
FACTION.models = {"models/player/bloodborne_male.mdl", "models/player/bloodborne_female.mdl", "models/muschi/inquisition/muschi_inq_acolyte.mdl"}
FACTION.weapons = {"none"}

FACTION_ASTROPATHS = FACTION.index

function FACTION:OnSpawn(client)
    -- Custom health and armor for players in this faction.
    client:SetArmor(self.armor)
    client:SetAmmo( 100 , 1 )
	client:SetAmmo( 100 , 23 )
	client:SetAmmo( 100 , 6 )
	client:SetAmmo( 100 , 7 )
	client:SetAmmo( 100 , 4 )
	client:SetAmmo( 100 , 5 )
	client:SetAmmo( -1 , "hatshook_ammo")
	client:SetAmmo( 20 , "cod4rm_claymore")
	client:SetAmmo( 5 , "cod4rm_c4")
	client:SetAmmo( 20 , 8 )
	client:SetAmmo( 20 , 10 )
	client:SetAmmo( 10 , 94 )
	client:SetAmmo( 10 , 93 )
end