local PLUGIN = PLUGIN
PLUGIN.name = "Warhammer Questing"
PLUGIN.author = "Supermantrt"
PLUGIN.description = "Quests"

local test = false

function PLUGIN:PostProcessPermitted(class)
	return true
end

function PLUGIN:Think() 
	hook.Run("3d_camera_example")

	if(test == true) then
		test = false
	end
end

if SERVER then 
    util.AddNetworkString("ixQuestingWarhammer")
end 

net.Receive("ixQuestingWarhammer", function()
	local questorigin = net.ReadVector()
	local questangle = net.ReadAngle()
	local questgiverent = net.ReadEntity()
	local panel = vgui.Create("ixQuestMaster")

	test = true

	hook.Add( "CalcView", "3d_camera_example", function(ply, pos, angles, fov)
		if test == true then
			RenderDoF(questorigin, questangle, questorigin, 60, 2 ,2, true )
			print("running")
		end

		local view = {
			origin = questorigin,
			angles = questangle,
			fov = fov,
			drawviewer = true
		}

		return view
	end)

	hook.Add( "RenderScreenspaceEffects", "camera_example", function()
--		RenderDoF(questorigin, questangle, questgiverent:GetPos(), 60, 3 ,3, true )
		test = true
	end)

end)
