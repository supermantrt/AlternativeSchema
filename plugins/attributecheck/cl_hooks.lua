local PLUGIN = PLUGIN

net.Receive("ixAttribLogs", function()
    local logPanel = vgui.Create("DFrame")
    logPanel:SetSize(ScrW() / 3, ScrH() / 1.5)
    logPanel:SetPos((ScrW() / 1.2) - (ScrW() / 2), (ScrH()/1.2) - (ScrH() / 1.5))
    logPanel:MakePopup()
    logPanel:SetTitle("Attribute Logs")

    scrollPanel = logPanel:Add("DListView")
    scrollPanel:Dock(FILL)
    
    scrollPanel:AddColumn("Date")
    scrollPanel:AddColumn("Action")
    scrollPanel:AddColumn("Players")

end)