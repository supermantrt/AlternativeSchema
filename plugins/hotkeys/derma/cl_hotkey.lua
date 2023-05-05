
local PLUGIN = PLUGIN

local PANEL = {}

function PANEL:Init()
	if (IsValid(PLUGIN.panel)) then
		PLUGIN.panel:Remove()
	end

	self:SetSize(ScrW() / 4, ScrH() / 4)
	self:Center()
	self:SetBackgroundBlur(true)
	self:SetDeleteOnClose(true)

	self.infoLabel = self:Add("DLabel")
    self.infoLabel:SetTextColor(Color(255, 255, 255, 255))
    self.infoLabel:SetFont("ixMenuButtonFont")
    self.infoLabel:SetText("Input Hotkey")
	self.infoLabel:SetPos(ScrW() / (ScrW() * 0.0035)  , ScrH() / (ScrH() * 0.0075) )
    self.infoLabel:SetSize(ScrW() / 2, ScrH() / 2)
    self.infoLabel:SizeToContents()
	self:MakePopup()
end

function PANEL:OnKeyCodePressed (key)
	net.Start("ixHotkeyDataSend")
	net.WriteInt(key , 10)
	net.WriteString(input.GetKeyName(key))
	net.SendToServer()
	self:Close()
end

function PANEL:OnRemove()
	PLUGIN.panel = nil
end

vgui.Register("ixHotkeyPanel", PANEL, "DFrame")
