
local PLUGIN = PLUGIN
PLUGIN.meta = PLUGIN.meta or {}

local DIALOUGE = PLUGIN.meta.station or {}
DIALOUGE.__index = dialouge
DIALOUGE.name = "undefined"
DIALOUGE.description = "undefined"
DIALOUGE.uniqueID = "undefined"

function DIALOUGE:GetModel()
	return self.model
end

PLUGIN.meta.dialouge = DIALOUGE
