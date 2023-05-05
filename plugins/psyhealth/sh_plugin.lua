
local PLUGIN = PLUGIN

PLUGIN.name = "Mental Health"
PLUGIN.author = "supermantrt"
PLUGIN.description = "Adds a mental health status to players"

ix.config.Add("PsyHealthRecoverTime", 600, "How many seconds it takes to restore 1 percent PsyHealth.", nil, {
	data = {min = 30, max = 3600},
	category = "Player"
})


ix.char.RegisterVar("PsyHP", {
	field = "PsyHP",
	fieldType = ix.type.number,
	default = 100,
	bNoDisplay = true,
})

--[[
Create a new health type 

Damage it by a personel check for pvs of player and or trace 

If 0 die for now 
]]

local playerMeta = FindMetaTable("Player")

function playerMeta:DamagePsyHealth(amount)
	local char = self:GetCharacter()

	if (char) then
		char:SetPsyHP(char:GetPsyHP() - amount)
		self:SetLocalVar("psyhealth", char:GetPsyHP() - amount)
	end
end

function playerMeta:HealPsyHealth(amount)
	self:DamagePsyHealth(-amount)
end

function playerMeta:SetPsyHealth(amount)
	local char = self:GetCharacter()

	if (char) then
		char:SetPsyHP(amount)
		self:SetLocalVar("psyhealth", amount)
	end
end

function playerMeta:TickPsyHealth(amount)
	local char = self:GetCharacter()

	if (char) then
		char:SetPsyHP(char:GetPsyHP() + amount)
		self:SetLocalVar("psyhealth", char:GetPsyHP() + amount)

		if char:GetPsyHP() > 100 then
			char:SetPsyHP(100)
			self:SetLocalVar("psyhealth", 100)
		end
		self:UpdatePsyHealthState(self)
	end
end

function playerMeta:GetPsyHealth()
	local char = self:GetCharacter()
	if (char) then
		return self:GetLocalVar("psyhealth", 100)
	end
end

function playerMeta:GetPsyResist()
	local res = 0
	local char = self:GetCharacter()
	local items = char:GetInventory():GetItems(true)

	for j, i in pairs(items) do
		if (i.psyProt and i:GetData("equip") == true) then
			res = res + i.psyProt
			break
		end
	end

	res = res + self:GetNetVar("ix_psyblock",0)

	return res
end

if CLIENT then 
	ix.bar.Add(function()
    	return LocalPlayer():GetPsyHealth()/100
	end, Color(98,89,129), nil, "Psy")
end

if(SERVER) then

	function PLUGIN:TableManagement(entity)

		NpcPSYDamage = {"npc_zombie" }


		FullTable = ents.FindInPVS(entity)

		for k, v in pairs(FullTable) do
 			if(v:IsNPC()) then
				for x, y in pairs(NpcPSYDamage) do
					entity:DamagePsyHealth(1)
				end
 			end
		end
	end


------------------------------------------------------------------------

	function PLUGIN:PostPlayerLoadout(client)
		local uniqueID = "ixPsy"..client:SteamID()
		timer.Create(uniqueID, 5, 0, function()

			PLUGIN:TableManagement(client)

			if(client:GetPsyHealth() <= 0) then
				client:Kill()
				client:SetPsyHealth(100/4)
			end
		end)
	end
else

end

