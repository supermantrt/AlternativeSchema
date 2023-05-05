local PLUGIN = PLUGIN

PLUGIN.name = "Attribute Check"
PLUGIN.description = "Check Attribute."
PLUGIN.author = "supermantrt"
PLUGIN.schema = "Any"

ix.util.Include("sv_hooks.lua")
ix.util.Include("cl_hooks.lua")

ix.command.Add("CharCheckAttribute", {
    description = "Check a character's attribute.",
    arguments = {ix.type.character,},
    superAdminOnly = true,
    OnRun = function(self, client, char, attrib, int)
        client:PrintMessage(3, char:GetName())
        client:PrintMessage(3 , "Constitution : " .. char:GetAttribute("con", 0) )
        client:PrintMessage(3 , "Agility : " .. char:GetAttribute("agi", 0))
        client:PrintMessage(3 , "Intelligence : " .. char:GetAttribute("intelligence", 0))
        client:PrintMessage(3 , "Psychic : " .. char:GetAttribute("psy", 0))
        client:PrintMessage(3 , "Maintenance : " .. char:GetAttribute("maintenance", 0))

         net.Start("ixAttribLogs")
            net.WriteTable(ix.attribs.logs)
        net.Send(client)
    end
})
