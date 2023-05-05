
ENT.Type = "anim"
ENT.PrintName = "Quest Master"
ENT.Category = "IX:WARHAMMER"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AutomaticFrameAdvance = true 
ENT.bNoPersist = true

function ENT:Initialize()
	if (SERVER) then
		self:SetModel("models/mossman.mdl")
		self:SetUseType(SIMPLE_USE)
		self:SetMoveType(MOVETYPE_NONE)
		self:DrawShadow(true)
		self:SetSolid(SOLID_OBB)
		self:PhysicsInit(SOLID_OBB)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end
--[[
	timer.Simple(1, function()
		if (IsValid(self)) then
			self:SetAnim()
		end
	end)
    ]]
end

function ENT:Think()
    self:NextThink(CurTime())
    return true
end


if (SERVER) then
	local PLUGIN = PLUGIN

	function ENT:SpawnFunction(client, trace)
		local angles = (trace.HitPos - client:GetPos()):Angle()
		angles.r = 0
		angles.p = 0
		angles.y = angles.y + 180

		local entity = ents.Create("ix_guestmaster")
        local Test = trace.HitPos - Vector(0,0,4)
		entity:SetPos(Test)
		entity:SetAngles(angles)
		entity:Spawn()

		return entity
	end

	function ENT:Use(activator)
		local HeadQuest = self:GetBonePosition(self:LookupBone("ValveBiped.Bip01_Head1"))
		local ForwardAngle = self:EyeAngles()
		local EndVector = ForwardAngle:Forward() * 20
		local DownVector = Vector(0,0,0.35)
		local CrossVec = DownVector:Cross(EndVector)
		local FinalPos = HeadQuest + EndVector 
		local ForwardAngleCalc = ForwardAngle + Angle(0,180 ,0)

		activator:Freeze(false)
		activator:SetNoDraw(true)
        self:ResetSequence( "wave_close" ) -- Play the open sequence
		net.Start("ixQuestingWarhammer")
		net.WriteVector(FinalPos)
		net.WriteAngle(ForwardAngleCalc)
		net.WriteEntity(self)
		net.Send(activator)
	end

else

	function ENT:Draw()
		self:DrawModel()
	end

	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(container)
		local name = container:AddRow("name")
		name:SetImportant()
		name:SetText("Coolio")
		name:SizeToContents()

		local description = container:AddRow("description")
		description:SetText("cool person")
		description:SizeToContents()
		
	end
end

