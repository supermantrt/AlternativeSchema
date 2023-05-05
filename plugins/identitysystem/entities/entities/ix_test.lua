AddCSLuaFile()
--[[-------------------------------------------------------------------------
TODO: PLAY ANIMATION WHEN DEPLOYING SUPPORT
---------------------------------------------------------------------------]]
ENT.Base = "base_entity"
ENT.Type = "anim"
ENT.PrintName = "test"
ENT.Category = "Helix"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/dizcordum/wh/props2/wk_cogitator_five.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		--self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end
else

	function ENT:Draw()
		self:DrawModel()
		local ang = self:GetAngles()
		local pos = self:GetPos() + ang:Up() * 48 + ang:Right() * -5 + ang:Forward() * -9.75

	end
end
