PLUGIN.name = "Anti ERP"
PLUGIN.description = "zakaz seksu"

if(SERVER) then
    
    util.AddNetworkString("screamerban")
    local DetectChatTypes = {
        ["me"] = true,
        ["it"] = true,
		["ic"] = true,
		["ooc"] = true
    }
    local NotAllowedWords = {"sussy bakka", "boonana", "Boonana", "Sussy bakka", "Sussy Bakka"}
	local NotAllowedWords2 = {"nigger", "nigga", "n i g g e r", "n i g g a", "N I G G E R", "N I G G A", "Faggot", "FAGGOT", "F A G G O T"}
    function PLUGIN:PrePlayerMessageSend(client, chatType, message, bAnonymous)
        if(DetectChatTypes[chatType]) then
            for _,v in pairs(NotAllowedWords) do
                if(string.find(message,v))then
                    local message = string.format("ERPER DETECTED: (%s) (%s) ", client:GetCharacter():GetName(), message)
					client:TakeDamage(1000)
                    for _,ply in pairs(player.GetAll()) do
                        if(ply:IsAdmin())then
                            ply:PrintMessage( HUD_PRINTTALK, message )
                        end
                    end
                    break
                end
            end
			for _,v in pairs(NotAllowedWords2) do
                if(string.find(message,v))then
                    local message = string.format("ERPER DETECTED: (%s) (%s) ", client:GetCharacter():GetName(), message)
					client:Kick("No Racisim : BOT")
                    for _,ply in pairs(player.GetAll()) do
                        if(ply:IsAdmin())then
                            ply:PrintMessage( HUD_PRINTTALK, message )
                        end
                    end
                    break
                end
            end
        end
    end
end
--[[
ix.command.Add("ScreamerBan", {
	description = "Ban erper",
	AdminOnly = true,
	arguments = ix.type.player,
	OnRun = function(self, client, target)
        net.Start("screamerban")
        net.Send(target)
        timer.Simple(5, function()
            if(IsValid(target))then
                target:Ban(0,true)
            end
        end)
	end
})


if(CLIENT)then
    net.Receive("screamerban", function()
        SCREAMER_EFFECT = true
        surface.PlaySound("jumpscare.wav")
    end)
    function PLUGIN:PostRenderVGUI()
        if(SCREAMER_EFFECT) then
        surface.SetDrawColor(math.random(0, 255),math.random(0, 255),math.random(0, 255),255)
        surface.DrawRect(0, 0, ScrW(), ScrH())
        end
    end
end
]]--