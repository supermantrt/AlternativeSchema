local PLUGIN = PLUGIN
PLUGIN.meta = PLUGIN.meta or {}

local QUEST = PLUGIN.meta.quest or {}
QUEST.__index = QUEST
QUEST.name = "undefined"
QUEST.description = "undefined"
QUEST.uniqueID = "undefined"
QUEST.category = "Crafting"

function QUEST:GetName()
	return self.name
end

function QUEST:GetDescription()
	return self.description
end

function QUEST:GetSkin()
	return self.skin
end

function QUEST:GetModel()
	return self.model
end

function QUEST:PreHook(name, func)
	if (!self.preHooks) then
		self.preHooks = {}
	end

	self.preHooks[name] = func
end

function QUEST:PostHook(name, func)
	if (!self.postHooks) then
		self.postHooks = {}
	end

	self.postHooks[name] = func
end

function QUEST:OnCanSee(client)
	local character = client:GetCharacter()

	if (!character) then
		return false
	end

	if (self.preHooks and self.preHooks["OnCanSee"]) then
		local a, b, c, d, e, f = self.preHooks["OnCanSee"](self, client)

		if (a != nil) then
			return a, b, c, d, e, f
		end
	end

	if (self.flag and !character:HasFlags(self.flag)) then
		return false
	end

	if (self.blueprint and !character:GetInventory():HasItem(self.blueprint)) then
		return false
	end

	if (self.postHooks and self.postHooks["OnCanSee"]) then
		local a, b, c, d, e, f = self.postHooks["OnCanSee"](self, client)

		if (a != nil) then
			return a, b, c, d, e, f
		end
	end

	return true
end

PLUGIN.meta.recipe = QUEST