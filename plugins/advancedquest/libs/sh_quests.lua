
-- @module ix.quests

ix.quests = ix.quests or {}
ix.quests.list = ix.quests.list or {}

function ix.quests.LoadFromDir(directory)
	for _, v in ipairs(file.Find(directory.."/*.lua", "LUA")) do
		local niceName = v:sub(4, -5)

		QUESTS = ix.quests.list[niceName] or {}
			if (PLUGIN) then
				QUESTS.plugin = PLUGIN.uniqueID
			end

			ix.util.Include(directory.."/"..v)

			QUESTS.name = QUESTS.name or "Unknown"
			QUESTS.description = QUESTS.description or "No description available."

			ix.quests.list[niceName] = QUESTS
		QUESTS = nil
	end
end

do
	hook.Add( "DoPluginIncludes", "AQLoadQuests", function( path, PLUGIN )
		ix.quests.LoadFromDir(path.."/quests") 
	end)

	PrintTable(ix.quests.list)
end