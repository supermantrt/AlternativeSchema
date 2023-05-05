local PLUGIN = PLUGIN
PLUGIN.name = "Attribute System"
PLUGIN.author = "Hoooldini"
PLUGIN.description = "Implementation of an attribute system for roleplay."
require( "gtimelib" )

-- [[ CONFIGURATION OPTIONS ]] --

ix.config.Add("enableStamina", true, "Whether or not stamina drain is enabled.", nil, {
	category = "Stamina"
})

ix.config.Add("strengthMeleeMultiplier", 0.3, "The strength multiplier for melee damage.", nil, {
	data = {min = 0, max = 1.0, decimals = 1},
	category = "Attributes"
})

ix.config.Add("strengthMultiplier", 1, "The strength multiplier for carrying objects.", nil, {
	data = {min = 0, max = 10.0, decimals = 1},
	category = "Attributes"
})

ix.config.Add("constitutionMultiplier", 1, "Mutiplies the health that constitution adds to characters.", nil, {
	data = {min = 0, max = 10.0, decimals = 1},
	category = "Attributes"
})

ix.config.Add("medicalMultiplier", 1, "Mutiplies the health that is healed.", nil, {
	data = {min = 0, max = 10.0, decimals = 1},
	category = "Attributes"
})

ix.config.Add("defaultMaxHealth", 100, "Sets the default max health of characters.", nil, {
	data = {min = 0, max = 200.0, decimals = 1},
	category = "Characters"
})

ix.config.Add("agilityMultiplier", 1, "Mutiplies the speed that agility adds to sprinting.", nil, {
	data = {min = 0, max = 10.0, decimals = 1},
	category = "Attributes"
})

ix.config.Add("staminaMax", 0, "Max amount of stamina players will have.", nil, {
	data = {min = -30, max = 30, decimals = 2},
	category = "Stamina"
})

ix.config.Add("staminaDrain", 1, "How much stamina to drain per tick (every quarter second). This is calculated before attribute reduction.", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "Stamina"
})

ix.config.Add("staminaRegeneration", 1.75, "How much stamina to regain per tick (every quarter second).", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "Stamina"
})

ix.config.Add("staminaCrouchRegeneration", 2, "How much stamina to regain per tick (every quarter second) while crouching.", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "Stamina"
})

-- [[ COMMANDS ]] --

--[[
	COMMAND: /RollStat
	DESCRIPTION: RollStat is designed to allow for a client to roll one of their attributes in a 1-100 roll. Attributes must be
	their three letter abbreviation as designated in their file name.
]]--

ix.command.Add("RollStat", {
	syntax = "<stat>",
	description = "Rolls and adds a bonus for the stat provided",
	arguments = {
		ix.type.text
	},
	OnRun = function(self, client, stat)
		local save = stat
		print(save)
		local character = client:GetCharacter()
		if (character and character:GetAttribute(stat, 0)) then
			local bonus = character:GetAttribute(stat, 0)
			local roll = tostring(math.random(0, 100))
			
			ix.chat.Send(client, "roll", save , nil, nil, nil)
			
			ix.chat.Send(client, "roll", (roll + bonus).." ( "..save.." "..roll.." + "..bonus.." )", nil, nil, { --tostring(math.random(0, 100))
				max = maximum
			})
		end
	end
})

-- [[ FUNCTIONS ]] --

if (SERVER) then

	--[[
		FUNCTION: PLUGIN:PostPlayerLoadout(client)
		DESCRIPTION: Code taken from the stamina plugin that was taken for use here.
		Sets up the stamina and run speed of the character and contains hooks for stamina.
	]]-- 

	function PLUGIN:PostPlayerLoadout(client)
		local uniqueID = "ixStam"..client:SteamID()
		local offset = 0
		local runSpeed = client:GetRunSpeed() - 5
		local character = client:GetCharacter()
		local filter = RecipientFilter()
		local FilterDelay = Time.Now + (Time.Seconds( 60 ))

		timer.Create(uniqueID, 0.25, 0, function()

			if (!IsValid(client)) then
				timer.Remove(uniqueID)
				return
			end


			local character = client:GetCharacter()

			if (!character or client:GetMoveType() == MOVETYPE_NOCLIP) then
				return
			end

			runSpeed = ix.config.Get("runSpeed") + (character:GetAttribute("agi", 0) * ix.config.Get("agilityMultiplier"))
			
			if (client:WaterLevel() > 1) then
				runSpeed = runSpeed * 0.775
			end

			if(character:HasTrait("frozenbones") and client:KeyDown(IN_SPEED)) then

				if(FilterDelay < Time.Now ) then
					if(filter:GetCount() <= 3 or filter:GetCount() == nil) then
						FilterDelay = Time.Now + (Time.Seconds( 60 ))
						filter:AddAllPlayers()
					end
				end

				if(AgiResetFrozenBones < Time.Now and filter:GetCount() > 3) then
					print("Running FrozenBones Reset!")
					AgiResetFrozenBones = Time.Now + (Time.Seconds( 30 ) * client:GetLocalVar("agi", 1))
		    		character:UpdateAttrib("agi", 0.01)
				end
			end

			local walkSpeed = ix.config.Get("walkSpeed")
			local maxAttributes = ix.config.Get("maxAttributes", 30)

			if (client:KeyDown(IN_SPEED) and client:GetVelocity():LengthSqr() >= (walkSpeed * walkSpeed) and ix.config.Get("enableStamina", false)) then
				-- characters could have attribute values greater than max if the config was changed
				offset = -ix.config.Get("staminaDrain", 1) + math.min(ix.config.Get("staminaMax", 0), maxAttributes) / maxAttributes
			else
				offset = client:Crouching() and ix.config.Get("staminaCrouchRegeneration", 2) or ix.config.Get("staminaRegeneration", 1.75)
			end

			offset = hook.Run("AdjustStaminaOffset", client, offset) or offset

			local current = client:GetLocalVar("agi", 0)
			local value = math.Clamp(current + offset, 0, 100)

			if (current != value) then
				client:SetLocalVar("agi", value)

				if (value == 0 and !client:GetNetVar("brth", false)) then
					client:SetRunSpeed(walkSpeed)
					client:SetNetVar("brth", true)

					hook.Run("PlayerStaminaLost", client)

					if(FilterDelay < Time.Now ) then
						if(filter:GetCount() <= 3 or filter:GetCount() == nil) then
							FilterDelay = Time.Now + (Time.Seconds( 60 ))
							filter:AddAllPlayers()
						end
					end

					if(AgiReset < Time.Now and filter:GetCount() > 3 and character:HasTrait("frozenbones") == false) then
						AgiReset = Time.Now + (Time.Seconds( 15 ) * client:GetLocalVar("agi", 1))
						character:UpdateAttrib("agi", 0.01)
					end

				elseif (value >= 50 and client:GetNetVar("brth", false)) then
					client:SetRunSpeed(runSpeed)
					client:SetNetVar("brth", nil)

					hook.Run("PlayerStaminaGained", client)
				end
			end
		end)
	end
	
	--[[
		FUNCTION: PLUGIN:CharacterPreSave(character)
		DESCRIPTION: Code taken from the stamina plugin that was taken for use here.
		Saves stamina of the character, or the agility depending on how you look at it.
	]]--`
	
	function PLUGIN:PlayerHurt(client , attacker)

		local character = client:GetCharacter()
		local filter = RecipientFilter()
		local FilterDelay = Time.Now + (Time.Seconds( 60 ))


		if(FilterDelay < Time.Now ) then
			if(filter:GetCount() <= 3 or filter:GetCount() == nil) then
				FilterDelay = Time.Now + (Time.Seconds( 60 ))
				filter:AddAllPlayers()
			end
		end


		if(ConReset < Time.Now ) then
			print("Running Con Reset!")
			ConReset = Time.Now + (Time.Seconds( 15 ) * client:GetLocalVar("agi", 1))
			if( attacker:IsNPC() == true) then
		    	character:UpdateAttrib("con", 0.001)
        	end
		end
	end

	--[[
		FUNCTION: PLUGIN:CharacterPreSave(character)
		DESCRIPTION: Code taken from the stamina plugin that was taken for use here.
		Saves stamina of the character, or the agility depending on how you look at it.
	]]--

    function PLUGIN:CharacterLoaded(character)
--        character:SetData("LastAttributeAgiCheck", character:GetAttribute("agi") + 0.5)
--		character:SetData("LastCheckTimeAgi", 0)
--		character:SetData("LastAttributeConCheck", character:GetAttribute("con") + 0.5)
--		character:SetData("LastCheckTime", 0)

		ConReset = Time.Seconds( 0 )
		AgiReset = Time.Seconds( 0 )
		AgiResetFrozenBones = Time.Seconds( 0 )
    end

	function PLUGIN:CharacterPreSave(character)
		local client = character:GetPlayer()

		if (IsValid(client)) then
			character:SetData("stamina", client:GetLocalVar("agi", 0))
		end
	end

	--[[
		FUNCTION: PLUGIN:PlayerLoadedCharacter(client, character)
		DESCRIPTION: Code taken from the stamina plugin that was taken for use here.
		Sets stamina of the character, or the agility depending on how you look at it.
	]]--

	function PLUGIN:PlayerLoadedCharacter(client, character)
		timer.Simple(0.25, function()
			client:SetLocalVar("agi", character:GetData("stamina", 100))
		end)
	end

	local playerMeta = FindMetaTable("Player")

	--[[
		FUNCTION: PLUGIN:RestoreStamina(amount)
		DESCRIPTION: Code taken from the stamina plugin that was taken for use here.
		Restores the stamina of the character, probably.
	]]--

	function playerMeta:RestoreStamina(amount)
		local current = self:GetLocalVar("agi", 0)
		local value = math.Clamp(current + amount, 0, 100)

		self:SetLocalVar("agi", value)
	end

	--[[
		FUNCTION: PLUGIN:GetPlayerPunchDamage(client, damage, context)
		DESCRIPTION: Code taken from the strength plugin. Changes the damage value of the fists.
	]]--

	function PLUGIN:GetPlayerPunchDamage(client, damage, context)
		if (client:GetCharacter()) then
			-- Add to the total fist damage.
			context.damage = context.damage + (client:GetCharacter():GetAttribute("str", 0) * ix.config.Get("strengthMeleeMultiplier", 0.3))
		end
	end

	function PLUGIN:GetPlayerHeal(client, heal, context)
		if (client:GetCharacter()) then
			-- Add Medical Skill
			context.heal = context.heal + (client:GetCharacter():GetSkill("medical", 0) * ix.config.Get("medicalMultiplier", 1))
		end
	end

	function PLUGIN:GetPlayerNeedHeal(client, need, needcontext)
		if (client:GetCharacter()) then
			-- Add to the total fist damage.
--			print(client:GetCharacter():GetAttribute("med", 0))
			needcontext.need = math.ceil(needcontext.need * (ix.config.Get("medicalMultiplier", 1) / (client:GetCharacter():GetSkill("medical", 1))))
		end
	end

	--[[
		FUNCTION: PLUGIN:CanPlayerHoldObject(client, entity)
		DESCRIPTION: Code taken from the strength plugin. Changes how much a player can
		hold in their hand.
	]]--

	function PLUGIN:CanPlayerHoldObject(client, entity)
		if (client:GetCharacter()) then
			local physics = entity:GetPhysicsObject()

			return IsValid(physics) and 
			 	(physics:GetMass() <= (ix.config.Get("maxHoldWeight", 100) + client:GetCharacter():GetAttribute("str", 0) * ix.config.Get("strengthMultiplier", 1)))
		end
	end

	--[[
		FUNCTION: PLUGIN:PlayerThrowPunch(client, trace)
		DESCRIPTION: Code taken from the strength plugin. Currently defunct as I try to find a non
		abusable way of gaining stats.
	]]--
	function PLUGIN:PlayerHeal(client, trace)
		if (client:GetCharacter() and IsValid(trace.Entity) and trace.Entity:IsPlayer()) then
			client:GetCharacter():UpdateSkill("medical", 0.0005)
		end
	end


	function PLUGIN:PlayerThrowPunch(client, trace)
		if (client:GetCharacter() and IsValid(trace.Entity) and trace.Entity:IsPlayer()) then
			--client:GetCharacter():UpdateAttrib("str", 0.001)
		end
	end
else
	ix.bar.Add(function()
		return LocalPlayer():GetLocalVar("agi", 0) / 100
	end, Color(200, 200, 40), nil, "agi")
end