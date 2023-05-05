
-- @module ix.traits

ix.traits = ix.traits or {}
ix.traits.list = ix.traits.list or {}
ix.traits.denied = ix.traits.denied or {}
ix.traits.deniedbackground = ix.traits.deniedbackground or {}

function ix.traits.LoadFromDir(directory)
	for _, v in ipairs( file.Find( directory.."/*.lua", "LUA" ) ) do
		local niceName = v:sub(4, -5) -- Trims out "sh_" and ".lua" from the name.

		TRAIT = ix.traits.list[niceName] or {} -- Adds the trait to the trait list, or keeps the trait if it was alreaded loaded in.

		if (PLUGIN) then
			TRAIT.plugin = PLUGIN.uniqueID
		end

		ix.util.Include(directory.."/"..v) -- Includes the trait file.

		TRAIT.name = TRAIT.name or "Unknown"
		TRAIT.description = TRAIT.description or "No description available."
		TRAIT.icon = TRAIT.icon or "icon16/bomb.png"
		TRAIT.points = TRAIT.points or 0

		for k, v in pairs(TRAIT) do
			if isfunction(v) then
				HOOKS_CACHE[k] = HOOKS_CACHE[k] or {}
				HOOKS_CACHE[k][TRAIT] = v
			end
		end

		ix.traits.list[niceName] = TRAIT

		TRAIT = nil -- Clears the TRAIT table so we can cleanly read in a new one.
	end
end

function ix.traits.Setup(client)
	local character = client:GetCharacter()

	if (character) then
		for k, v in pairs(ix.traits.list) do
			if (v.OnSetup) then
				v:OnSetup(client, character:GetTrait(k, false)) -- If there's an OnSetup() function, call it.
			end
		end
	end
end

do
	
	-- Character meta for traits
	-- @classmod Character

	local charMeta = ix.meta.character

	if (SERVER) then

		-- Network string for trait updates
		util.AddNetworkString("ixTraitUpdate")

		-- Sets the state of the given trait on a character to true or false.
		-- @realm: Server
		-- @string: key - The name of the trait to set.
		-- @bool: value - The state to assign to the trait.
		function charMeta:SetTrait(key, value)
			local trait = ix.traits.list[key]
			local client = self:GetPlayer()

			if ( trait ) then
				local traitTable = self:GetTraits()

				traitTable[key] = value

				if IsValid( client ) then
					net.Start( "ixTraitUpdate" )
						net.WriteUInt( self:GetID(), 32 )
						net.WriteString( key )
						net.WriteBool( value )
					net.Send( client )
				end

				self:SetTraits(traitTable)
			end
		end

		-- Adds a trait to the character.
		-- @realm: Server
		-- @string: key - The name of the trait to add to the character.
		function charMeta:AddTrait(key)
			self:SetTrait(key, true)
		end

		-- Remove a trait from the character.
		-- @realm: Server
		-- @string: key - The name of the trait to remove from the character
		function charMeta:RemoveTrait(key)
			self:SetTrait(key, nil)
		end

		-- Check if a character has a trait.
		-- @realm: Server
		-- @string: key - The name of the trait to check.
		-- @return: True if the character has the trait, false if they do not.
		function charMeta:HasTrait(key)
			return self:GetTraits()[key] and true or false
		end

		-- Check if a character has a trait.
		-- @realm: Server
		-- @string: key - The name of the trait to check.
		-- @return: True if the character has the trait, false if they do not, and nil if it does not exist.
		-- @treturn: The trait's table.
		function charMeta:GetTrait(key)
			return self:GetTraits()[key]
		end
	else
		net.Receive( "ixTraitUpdate", function()
			local id = net.ReadUInt(32)
			local character = ix.char.loaded[id]

			if ( character ) then
				local key = net.ReadString()
				local value = net.ReadBool()

				character:GetSkills()[key] = value
			end
		end)
	end

end

do
	
	ix.char.RegisterVar("traits", {   
		field = "traits",
		fieldType = ix.type.text,
		default = {},
		index = 6,
		category = "traits",
		isLocal = true,
		OnDisplay = function(self, container, payload)
			local maximum = hook.Run("GetDefaultTraitPoints", LocalPlayer(), payload) or 3
 
			if (maximum < 1) then
				return
			end

			for k, v in pairs( ix.traits.list ) do
				local points = ix.traits.list[k]
				local amount = points["points"]

				if (amount > maximum) then
					table.insert( ix.traits.denied, v.name)
				end
			end

			traitpointusage = maximum

			local traits = container:Add("Panel")
			traits:Dock(FILL)

			local barPanel = traits:Add("DPanel")
			barPanel:Dock(TOP)

			local y = 0
			local total = 0

			payload.traits = {}

			-- total spendable trait points
			local totalBar = barPanel:Add("ixAttributeBar")
			totalBar:SetMax(traitpointusage)
			totalBar:SetValue(traitpointusage)
			totalBar:Dock(TOP)
			totalBar:DockMargin(2, 2, 2, 2)
			totalBar:SetText("Attribute Points Remaining : " .. traitpointusage)
			totalBar:SetReadOnly(true)
			totalBar:SetColor(Color(20, 120, 20, 255))

			y = totalBar:GetTall() + 4

			barPanel:SetTall(y)

			---

			local traitScrollPanel = traits:Add("DScrollPanel")
			traitScrollPanel:DockMargin(2, 2, 2, 2)
			traitScrollPanel:Dock(FILL)
			traitScrollPanel.Paint = function(panel, width, height)
				derma.SkinFunc("DrawImportantBackground", 0, 0, width, height, Color(255, 255, 255, 25))
			end

			local traitSelectList = traitScrollPanel:Add( "ixTraitList" )
			traitSelectList:SetColumns( 8 )
			traitSelectList:Dock(FILL)

			function traitSelectList:AllowPicking( state )
				for k, v in pairs(ix.traits.denied) do
					for x, y in pairs( traitSelectList:GetTraitList() ) do
						if !y:GetActivated() and (x == v) then
							y:SetSelectable(state)
						end
					end
				end
			end		
			
			function traitSelectList:AllowPicking2( state )
				for k, v in pairs(ix.traits.deniedbackground) do
					for x, y in pairs( traitSelectList:GetTraitList() ) do
						if !y:GetActivated() and (x == v) then
							y:SetSelectable(state)
						end
					end
				end
			end		

			timer.Create("FirstTimeCheckTrait", 0.01 , 1  , function()
				traitSelectList:AllowPicking( false )
			end)

			timer.Create("TestTraits", 0.25 , 0  , function()

				if(traitSelectList:isValid() == false) then
					timer.Remove("TestTraits")
				end
				
				traitSelectList:AllowPicking2 (true)

				table.Empty(ix.traits.deniedbackground)
				for k, v in pairs(ix.traits.list) do
					if(v.BackstoryAdded == true) then
						table.insert(ix.traits.deniedbackground, v.name)
						traitSelectList:AllowPicking2 (false)
					end
				end

			end)


			for k, v in pairs( ix.traits.list ) do
				
				if not v.noStartSelection then

					local trait = traitSelectList:AddTrait( v, false, true )
					
					function trait:OnActivated()
						local points = ix.traits.list[k]
						traitpointusage = traitpointusage - points["points"]

						if(traitpointusage < 0) then
							return 
						end

						totalBar:SetValue( traitpointusage )
						totalBar:SetText("Attribute Points Remaining : " .. traitpointusage)

						payload.traits[k] = true

						for k,v in pairs(ix.traits.denied) do ix.traits.denied[k]=nil end


						if totalBar.value >= 0 then
							for k, v in pairs( ix.traits.list ) do
								local points = ix.traits.list[k]
								if((traitpointusage - points["points"]) <= 0) then
									for x , y in pairs( ix.traits.deniedbackground) do
										if(x != v) then
											table.insert(ix.traits.denied, points["name"])
										end
									end
								end
							end
							traitSelectList:AllowPicking( false  )

							for k,v in pairs(ix.traits.denied) do ix.traits.denied[k]=nil end

							for k, v in pairs( ix.traits.list ) do
								local points = ix.traits.list[k]
								if((traitpointusage - points["points"]) >= 0) then
									for x , y in pairs( ix.traits.deniedbackground) do
										if(x != v) then
											table.insert(ix.traits.denied, points["name"])
										end
									end
								end
							end

							traitSelectList:AllowPicking( true  )

						end

						if totalBar.value < 0 then
							for k, v in pairs( ix.traits.list ) do
								for x , y in pairs( ix.traits.deniedbackground) do
									if(x != v) then
										table.insert(ix.traits.denied, points["name"])
									end
								end
							end
							traitSelectList:AllowPicking( false  )
						end
					end

					function trait:OnDeactivated()
						local points = ix.traits.list[k]
						traitpointusage = traitpointusage + points["points"]
						totalBar:SetValue( traitpointusage )
						totalBar:SetText("Attribute Points Remaining : " .. traitpointusage)

						payload.traits[k] = nil

						for k,v in pairs(ix.traits.denied) do ix.traits.denied[k]=nil end

						if totalBar.value >= 0 then
							for k, v in pairs( ix.traits.list ) do
								local points = ix.traits.list[k]
								if((traitpointusage - points["points"]) >= 0) then
									table.insert(ix.traits.denied, points["name"])
								end
							end
							traitSelectList:AllowPicking( true  )

							for k,v in pairs(ix.traits.denied) do ix.traits.denied[k]=nil end

							for k, v in pairs( ix.traits.list ) do
								local points = ix.traits.list[k]
								if((traitpointusage - points["points"]) < 0) then
									table.insert(ix.traits.denied, points["name"])
								end
							end
							traitSelectList:AllowPicking( false   )

						end
					end
				end

			end

			return traits
		end,
		OnValidate = function(self, value, data, client)
			if (value != nil) then
				if (istable(value)) then
					local count = table.Count( value )

					if (count > (hook.Run("GetDefaultSkillPoints", client, count) or 10)) then
						return false, "unknownError"
					end
				else
					return false, "unknownError"
				end
			end
		end,
		ShouldDisplay = function(self, container, payload)
			return !table.IsEmpty(ix.traits.list)
		end
	})

	hook.Add( "DoPluginIncludes", "HRPGLoadTraits", function( path, PLUGIN )
		ix.traits.LoadFromDir(path.."/traits") 
	end)

end