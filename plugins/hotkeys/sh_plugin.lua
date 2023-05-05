local PLUGIN = PLUGIN
PLUGIN.name = "Item Hotkeys"
PLUGIN.author = "Supermantrt"
PLUGIN.desc = "Allows for use of hotkeys to be used for pre-defined item usage."

ix.util.Include("sv_plugin.lua")

if SERVER then 
    util.AddNetworkString("ixHotkey")
    util.AddNetworkString("ixHotkeyDataSend")
end 

net.Receive("ixHotkey", function()
    local panel = vgui.Create("ixHotkeyPanel")
end)