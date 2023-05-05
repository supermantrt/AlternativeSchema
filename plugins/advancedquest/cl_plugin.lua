local padding = ScreenScale(32)
local errorModel = "models/error.mdl"
local PANEL = {}

AccessorFunc(PANEL, "animationTime", "AnimationTime", FORCE_NUMBER)

function PANEL:Init()
	ix.gui.dialogue = self
	self:SetSize(ScrW(), ScrH())
	self:MakePopup()
	local scrW, scrH = ScrW(), ScrH()
	self:Center()

	self.Paint = function(s,w,h)

		draw.RoundedBox(0,0,0,w , h,Color(0,0,0))

	end

	local w, h = self:GetSize()
	self.TextPanel = self:Add("DPanel")
	self.TextPanel:SetWidth(w / 2)
	self.TextPanel:SetHeight(h / 3)
	
	self.TextPanel:Dock(RIGHT)
	self.TextPanel:DockMargin(0.9,(2*h)/3 -2 ,-2.5,0)


	self.TextPanel.PanelList = self.TextPanel:Add("DIconLayout")
	self.TextPanel.PanelList:Dock(FILL)
	


	self.DialoguePanel = self:Add("DPanel")
	self.DialoguePanel:SetSize(ScrW() /2 , (2 * ScrH()) / 3)
	self.DialoguePanel:SetPos(w/2,28)

	local parent = self:GetParent()
	local halfWidth = parent:GetWide() * 0.5 - (padding * 2)
	local halfHeight = parent:GetTall() - (padding * 2)
	local modelFOV = (ScrW() > ScrH() * 1.8) and 65 or 45

	self.factionButtons = {}
	self.repopulatePanels = {}

	-- faction selection subpanel
	self.factionPanel = self:Add("DPanel")
	self.factionPanel:SetSize( ScrW() /2 , ScrH() )
	self.factionPanel:SetPos(0,500)
	self.factionPanel:Dock(LEFT)

	local modelList = self.factionPanel:Add("Panel")
	modelList:SetSize(halfWidth + padding *2, halfHeight)
	modelList:Dock(FILL) 

	self.factionModel = modelList:Add("ixModelPanel")
	self.factionModel:Dock(FILL)
	self.factionModel:SetModel("models/knight_ig/muschi_ig_guard_chad.mdl")
	self.factionModel:SetFOV(modelFOV)
	self.factionModel.PaintModel = self.factionModel.Paint


	self.DialogueList = self.DialoguePanel:Add("DScrollPanel")
	self.DialogueList:Dock(FILL)


	self.CurDialogue = self.DialoguePanel:Add("DLabel")
	self.CurDialogue:SetPos( 350, 200 )
	self.CurDialogue:SetWrap(true)
	self.CurDialogue:SetFont("ixBigFont")
	self.CurDialogue:SetText(" Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras massa ipsum, mattis vitae elit laoreet, consequat semper est. Suspendisse tempor enim mi, et dignissim lectus euismod dictum. Aenean aliquam, dui a faucibus auctor, elit mauris malesuada lacus, in laoreet nibh tortor id orci. Maecenas eleifend pharetra turpis vel lacinia. Nullam vel faucibus nisi. Vestibulum enim nunc, faucibus quis ultrices nec, luctus eget justo. Cras at dolor egestas, malesuada eros in, vestibulum mauris.Integer finibus neque orci, in placerat justo pharetra in. Aliquam sollicitudin quis mauris pulvinar eleifend. Aliquam erat volutpat. Nunc ac venenatis ligula. Integer venenatis sem risus, vitae eleifend ante laoreet at. Mauris tempus vulputate nulla, eget facilisis enim interdum tempor. Proin non ex eu mi dapibus ultrices a ut lorem. Ut a porttitor nunc.Duis lacinia odio eget orci interdum, nec lobortis nisl tempus. Duis dictum aliquet pellentesque. Donec massa justo, auctor non ornare quis, aliquam vel lacus. Mauris dignissim nisl vehicula, eleifend magna tempus, facilisis nibh. Ut eget diam risus. Pellentesque ante purus, laoreet vel varius ut, tempus eget libero. Nam consectetur elit in quam aliquet elementum. Aenean sodales auctor mi ut rhoncus. Donec posuere vulputate convallis. Etiam id dolor metus. Proin dictum, purus vel faucibus feugiat, nisl ex molestie purus, nec laoreet neque nunc quis turpis. Mauris faucibus luctus est.  ")
	self.CurDialogue:SetSize(1000,750)
	self.CurDialogue:SetAutoStretchVertical(true)

	self.NameDialogue = self.DialoguePanel:Add("DLabel")
	self.NameDialogue:SetPos( 350, 50 )
	self.NameDialogue:SetFont("ixMenuButtonFontThick")
	self.NameDialogue:SetText(" Name ")



	self.DialogueList:AddItem(self.CurDialogue)

	self.DialoguePanelList = self:Add("DPanelList")
	self.DialoguePanelList:Dock(FILL)
	self.DialoguePanelList:EnableVerticalScrollbar(true)
	self.DialoguePanelList:SetPos( 0, 1000 )
--	self.Background = self:Add("DPanel")
--	self.Background:SetSize(w,h)
--	self.Background:Center()
end

function PANEL:Say(text)
	self.CurDialogue:SetText(text)
	self.CurDialogue:SizeToContents()
end

function PANEL:Name(name)
	self.NameDialogue:SetText(name)
	self.NameDialogue:SizeToContents()
end

function PANEL:Model(model)
	self.factionModel:SetModel(model)
end

function PANEL:AddDialogueOption(text, callback, response)
	local button = self:Add("DButton")
	button:SetText(text)
--	print(button:GetPos())
	self.TextPanel.PanelList:Add(button)
	button:Dock(TOP)
	button.id = text

	function button:DoClick()
		surface.PlaySound("buttons/button24.wav")

		if callback then
			callback()
		end

		if response then

			print(text)

			local safeboxpurchase = "Sure here is the cash for the storage space"

			if(text == safeboxpurchase) then
				print(LocalPlayer():GetCharacter():GetMoney())
			end

			if(text == safeboxpurchase and LocalPlayer():GetCharacter():GetMoney() >= 250) then
				if(LocalPlayer():GetNetVar("SafeBoxPurchaseCheck", false ) == false) then
					ix.gui.dialogue:Say(response)
					print(LocalPlayer():GetCharacter())
--					LocalPlayer():GetCharacter():SetMoney(LocalPlayer():GetCharacter():GetMoney() - 250)
					LocalPlayer():SetNetVar("NewSafeBoxPurchase" , true )
				end

				if(LocalPlayer():GetNetVar("SafeBoxPurchaseCheck", false ) == true) then
					ix.gui.dialogue:Say(response)
					print("run2")
					LocalPlayer():GetCharacter():SetMoney(LocalPlayer():GetCharacter():GetMoney() - 250)
					LocalPlayer():SetNetVar("NewSafeBoxPurchase2" , true )
				end
			end

			if(text ==  safeboxpurchase and LocalPlayer():GetCharacter():GetMoney() <= 250) then
				local response = "You dont have enough cash. Come back if you have enough"
				print("run3")
				ix.gui.dialogue:Say(response)
			end

			if(text !=  safeboxpurchase) then
				print("run4")
				ix.gui.dialogue:Say(response)
			end
		end
	end
end

function PANEL:SetCharacter(ent)
	ix.gui.dialogue.ent = ent

	self:Name(ent:GetNetVar("Name", "John Doe"))
	self:Model(ent:GetModel())

	-- Dialouge
	for k, v in pairs(ent:GetNetVar("dialogue", {})) do
		for k2, v2 in pairs(GLOBAL_PreDefinedDialogue) do
			if v == k2 then
				if not v2.Additional then
					self:AddDialogueOption(v2.Button, v2.Callback, v2.Response)
				else
					self:AddDialogueOption(v2.Button, function()
						for k3, v3 in pairs(v2.Additional) do
							self:AddDialogueOption(v3.Button, v3.Callback, v3.Response)

							if v2.Callback then
								v2.Callback()
							end
						end
					end, v2.Response)
				end
			end
		end
	end

	local EntDataQuests = ent:GetNetVar("quests", {})
	local check = table.Random(EntDataQuests)


	if table.Count(ent:GetNetVar("quests", {})) > 0 then
		if not (table.HasValue(LocalPlayer():GetCharacter():GetData("finishquests", {}), check) or table.HasValue(LocalPlayer():GetCharacter():GetData("quests", {}), check))then
			self:AddDialogueOption("Do you have work for me ?", function()

				local quests = ent:GetNetVar("quests", {})

				if table.Count(quests) < 1 then
					LocalPlayer():Notify("You should not be able to start a quest with this NPC, contact a developer.")
				else
					local rnd = table.Random(quests)

					for k, v in pairs(GLOBAL_Quests) do
						if k == rnd then
							ix.gui.dialogue:Say(v.dialogue.start)
							PrintTable(v)
						end
					end

					netstream.Start("GetQuest", {ent, rnd})

					self.TextPanel.PanelList:Remove()

					self.TextPanel.PanelList = self.TextPanel:Add("DPanelList")
					self.TextPanel.PanelList:Dock(FILL)
					self.TextPanel.PanelList:EnableVerticalScrollbar(true)

					self:AddDialogueOption("Goodbye.", function()
						ix.gui.dialogue:Remove()
					end, false)
				end
			end, false)
		end
	end

	self:QuestStuff(ent)

	self:AddDialogueOption("Goodbye.", function()
		ix.gui.dialogue:Remove()
	end, false)
end

function PANEL:QuestStuff(ent)
	local data = LocalPlayer():GetCharacter():GetData("quests", {})
	local entquests = ent:GetNetVar("quests", {})
	local rnd = table.Random(entquests)
	local quest = "Unknown"

	for k, v in pairs(data) do
		if v == rnd then
			quest = v
		end
	end


	if table.HasValue(ent:GetNetVar("quests", {}), quest) then
		self:AddDialogueOption("About this quest...", function()
			self:AddDialogueOption("Can you tell me more?", function()
				for k, v in pairs(GLOBAL_Quests) do
					if k == quest then
						ix.gui.dialogue:Say(v.dialogue.question)
					end
				end
			end, false)

			self:AddDialogueOption("I completed it.", function()
				ix.gui.dialogue:CheckQuestCompletion(ent, quest)
			end, false)
		end)
	end
end

function PANEL:CheckQuestCompletion(ent, quest)
	local char = LocalPlayer():GetCharacter()
	local inv = char:GetInventory()
	local items = inv:GetItems()

	for k, v in pairs(GLOBAL_Quests) do
		if quest == k then
			for k2, v2 in pairs(v.requirements) do
				if inv:GetItemCount(k2) < v2 then
					ix.gui.dialogue:Say("You didn't finish it, are you trying to trick me ?")

					return
				end
			end

			self.TextPanel.PanelList:Remove()

			self.TextPanel.PanelList = self.TextPanel:Add("DPanelList")
			self.TextPanel.PanelList:Dock(FILL)
			self.TextPanel.PanelList:EnableVerticalScrollbar(true)

			self:AddDialogueOption("Goodbye.", function()
				ix.gui.dialogue:Remove()
			end, false)

			ix.gui.dialogue:Say(v.dialogue.complete)
			netstream.Start("QuestCompleted", {ent, quest})
		end
	end
end

function PANEL:StartQuest(ent)
	local quests = ent:GetNetVar("quests", {})

	if table.Count(quests) < 1 then
		LocalPlayer():Notify("You should not be able to start a quest with this NPC, contact a developer.")
	else
		netstream.Start("GetQuest", {ent})
	end
end

vgui.Register("ixDialogueUI", PANEL, "DFrame")
local PANEL = {}

function PANEL:Init()
	ix.gui.npcedit = self
	self:SetSize(ScrW() / 4, ScrH() / 4)
	self:Center()
	self:MakePopup()
	self.Desc = self:Add("DLabel")
	self.Desc:Dock(TOP)
	self.Desc:SetText("What do you want to edit?")
	self.Desc:SizeToContents()
	self.ButtonDialogue = self:Add("DButton")
	self.ButtonDialogue:SetText("Predefined dialog")
	self.ButtonDialogue:Dock(BOTTOM)
	self.ButtonQuests = self:Add("DButton")
	self.ButtonQuests:Dock(BOTTOM)
	self.ButtonQuests:SetText("Quests")

	timer.Simple(0.1, function()
		self.TextName = self:Add("DTextEntry")
		self.TextName:Dock(TOP)
		self.TextName:SetText(ix.gui.npcedit.npc:GetNetVar("Name", "Name"))
		self.DescBox = self:Add("DTextEntry")
		self.DescBox:Dock(TOP)
		self.DescBox:SetText(ix.gui.npcedit.npc:GetNetVar("Description", "Description"))
		self.ModelBox = self:Add("DTextEntry")
		self.ModelBox:Dock(TOP)
		self.ModelBox:SetText(ix.gui.npcedit.npc:GetModel())
		self.AnimLabel = self:Add("DLabel")
		self.AnimLabel:Dock(TOP)
		self.AnimLabel:SetText("Animation Index, must be a number.")
		self.AnimLabel:SizeToContents()
		self.AnimBox = self:Add("DTextEntry")
		self.AnimBox:Dock(TOP)
		self.AnimBox:SetText(ix.gui.npcedit.npc:GetNetVar("anim", 4))
		self.SubmitBox = self:Add("DButton")
		self.SubmitBox:Dock(TOP)
		self.SubmitBox:SetText("Submit changes")

		self.SubmitBox.DoClick = function()
			netstream.Start("ChangeNPCValues", {ix.gui.npcedit.npc, self.TextName:GetText(), self.DescBox:GetText(), self.ModelBox:GetText(), self.AnimBox:GetText()})
		end
	end)

	function self.ButtonDialogue:DoClick()
		local ui = vgui.Create("DFrame")
		ui:SetSize(ScrW() / 2, ScrH() / 2)
		ui:Center()
		ui:MakePopup()

		for k, v in pairs(GLOBAL_PreDefinedDialogue) do
			local checkbox = ui:Add("DCheckBoxLabel")
			checkbox:Dock(TOP)
			checkbox.dialogue = {k, v}
			checkbox:SetText(v.Button)
			local data = ix.gui.npcedit.npc:GetNetVar("dialogue", {})

			if table.HasValue(data, k) then
				checkbox:SetChecked(true)
			end

			function checkbox:OnChange(val)
				if val then
					netstream.Start("DialogueOptionAdd", {k, v, ix.gui.npcedit.npc})
				else
					netstream.Start("DialogueOptionRemove", {k, v, ix.gui.npcedit.npc})
				end
			end
		end
	end

	function self.ButtonQuests:DoClick()
		local ui = vgui.Create("DFrame")
		ui:SetSize(ScrW() / 2, ScrH() / 2)
		ui:Center()
		ui:MakePopup()

		for k, v in pairs(GLOBAL_Quests) do
			local checkbox = ui:Add("DCheckBoxLabel")
			checkbox:Dock(TOP)
			checkbox.quest = {k, v}
			checkbox:SetText(v.name)
			local data = ix.gui.npcedit.npc:GetNetVar("quests", {})

			if table.HasValue(data, k) then
				checkbox:SetChecked(true)
			end

			function checkbox:OnChange(val)
				if val then
					netstream.Start("QuestOptionAdd", {k, v, ix.gui.npcedit.npc})
				else
					netstream.Start("QuestOptionRemove", {k, v, ix.gui.npcedit.npc})
				end
			end
		end
	end
end

function PANEL:SetCharacter(ent)
	ix.gui.npcedit.npc = ent
end

vgui.Register("ixNPCEdit", PANEL, "DFrame")

netstream.Hook("OpenQuestDialogue", function(data)
	local ui = vgui.Create("ixDialogueUI")
	ui:SetCharacter(data[1])
end)

netstream.Hook("OpenQuestEditMenu", function(data)
	local ui = vgui.Create("ixNPCEdit")
	ui:SetCharacter(data[1])
end)
