ITEM.name = "Chemicals Base"
ITEM.model = "models/props_lab/clipboard.mdl"
ITEM.description = "A Chemical for doping."
ITEM.category = "Chemicals"
ITEM.chemical = "none"


ITEM.functions.Hotkey = {
    name = "Hotkey", -- uses the "myFunctionPhrase" language phrase when displaying in the UI
    tip = "myFunctionDescription", -- uses the "myFunctionDescription" language phrase when displaying in the UI
    icon = "icon16/add.png", -- path to the icon material
    OnRun = function(item)

        item:GetOwner():SetNetVar("HotkeySelection" , item.uniqueID)
        item:GetOwner():SetNetVar("HotkeySelectionInventory" , item.invID)

        net.Start("ixHotkey")
		net.Send(item:GetOwner())
        
        -- do not remove this item from the owning player's inventory
        return false
    end,
}
