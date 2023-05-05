local PLUGIN = PLUGIN

local HotkeysKey = {}
local HotkeyItem = {}
local DelayHotkeyAndCheckPress = false
local DelayHotkeyUse = false
local FirstCheck = true

net.Receive( "ixHotkeyDataSend", function( len,ply )
    local key = net.ReadInt( 10 )
    table.SortByKey( HotkeysKey)

    for k , v in pairs( HotkeysKey ) do
        if (key == v) then
            ply:Notify("You already have [" .. net.ReadString() .. "] binded")
            return
        end
    end

    for k , v in pairs( HotkeyItem ) do
        if (ply:GetNetVar("HotkeySelection", nil) == v) then
            ply:Notify("You already have [" .. ply:GetNetVar("HotkeySelection", nil) .. "] binded")
            return
        end
    end

    DelayHotkeyAndCheckPress = true

    table.insert(HotkeysKey , key)
    table.insert(HotkeyItem , ply:GetNetVar("HotkeySelection", nil))
    PrintTable(HotkeysKey)

    timer.Create( "DelayHotkeyAndCheckPress" .. ply:SteamID() , 2.5, 1, function() DelayHotkeyAndCheckPress = false end )


end )

function PLUGIN:PlayerLoadedCharacter(ply, character, currentChar)

    if(FirstCheck == true and (ply:GetData("PersonalHotkeyKey", HotkeysKey) != HotkeysKey or ply:GetData("PersonalHotkeyItem", HotkeyItem) != HotkeyItem)) then
        HotkeysKey = ply:GetData("PersonalHotkeyKey", HotkeysKey)
        HotkeyItem = ply:GetData("PersonalHotkeyKey", HotkeyItem)
    end
    FirstCheck = false

end

function PLUGIN:PlayerButtonDown(ply , key)

    for k, v in pairs ( HotkeysKey) do
        if(v == key and DelayHotkeyAndCheckPress == false) then
            for x,y in pairs (HotkeyItem) do
                if(x == table.KeyFromValue(HotkeysKey, v)) then
                    local inv = ix.inventory.Get(ply:GetNetVar("HotkeySelectionInventory", nil))
                    local ItemsInInv = inv:GetItemsByUniqueID(y)
                    local HasItem = inv:HasItem(y)
                    if(HasItem == false ) then
                        ply:Notify("You have no [" .. y .. "] left")
                        table.remove(HotkeyItem , x)
                        table.remove(HotkeysKey , x)
                        return
                    end
                    for k, z in pairs (ItemsInInv) do
                        if(DelayHotkeyUse == false) then
                            DelayHotkeyUse = true
                            z.functions.Eat.OnRun(ix.item.Get(y), ply)
                            z:Remove()
                            ply:Notify("You have used [" .. y .. "] bind")
                        end
                        break
                    end
                    -- Network Inventory
                    -- Call Item function for use `
                    timer.Create( "DelayHotkeyUse" .. ply:SteamID() , 1, 1, function() DelayHotkeyUse = false end )
                end
            end
        end
    end
end

function PLUGIN:OnCharacterDisconnect(client,char)
    client:SetData("PersonalHotkeyKey", HotkeysKey)
    client:SetData("PersonalHotkeyItem", HotkeyItem)
end

-- Append Key + Item Unique ID to table
-- Check on KeyPress if item is in inventory if not remove from list
-- Apply Use function if in inventory and add delay