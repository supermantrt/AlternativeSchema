ITEM.name = "Slaught"
ITEM.model = Model("models/dizcordum/wh/props/syringe_imperial_blood.mdl")
ITEM.description = "Combat Stimm."
ITEM.category = "Chemicals"
ITEM.flag = "i"
ITEM.price = 10

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player
		client:GetCharacter():AddBoost("slaughtstr","str", 10)
		client:GetCharacter():AddBoost("slaughtcon","con", 10)
		client:GetCharacter():AddBoost("slaughtagi","agi", 5)
		client:GetCharacter():AddBoost("slaughtint","int", -30)
		client:RestoreStamina(100)
		client:SetMaxHealth( client:GetMaxHealth() - 150 )
		client:SetHealth( client:Health() + 250 )
		client:SetRunSpeed(client:GetRunSpeed() * 1.75 )
		client:SetWalkSpeed(client:GetWalkSpeed() * 1.75)
		client:EmitSound("npc/antlion_grub/squashed.wav", 75, 150, 0.25)
		
		if(client:GetRunSpeed() < 0) then
		    client:SetRunSpeed( 0 )
		end
		if(client:GetWalkSpeed() < 0) then
		    client:SetWalkSpeed( 0 )
		end
		
		if(client:GetMaxHealth() <= 0) then
			client:Kill()
		end
		
	end,
	OnCanRun = function(itemTable)
		return !itemTable.player:IsCombine()
	end
}