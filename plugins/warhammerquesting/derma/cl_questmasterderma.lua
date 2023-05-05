
local PLUGIN = PLUGIN

local PANEL = {}

function PANEL:Init()
	if (IsValid(PLUGIN.panel)) then
		PLUGIN.panel:Remove()
	end

	self:SetSize(ScrW() * 0.33333333 , ScrH() *0.75 )
	self:SetPos(ScrW() * 0.666666666 , ScrH() *0.5)
	self:SetDeleteOnClose(true)

	self:MakePopup()
end

function PANEL:OnRemove()
	PLUGIN.panel = nil
end

vgui.Register("ixQuestMaster", PANEL, "DFrame")