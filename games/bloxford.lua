local gamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local uiversion = "V.Alpha"


local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()
local esp = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()

--init
local suc,er = pcall(function()
    workspace.Animals.Goat:Destroy()
end)

function destroyui()
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v.name == tostring(gamename)..uiversion then
            v:Destroy()
            _G.mineaura = false
            _G.hunting = false
            _G.nonlr = false
            _G.huntingauto = false
            esp:Toggle(false)
        end
    end
end
destroyui()

local main = library:CreateMain({
	projName = tostring(gamename)..uiversion,
	Resizable = true,
	MinSize = UDim2.new(0,400,0,400),
	MaxSize = UDim2.new(0,750,0,500),
})

--//functions\\--
function teleport(time,cframe)
    local Time = time
    local CFrameEnd = cframe
    local tween =  game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time), {CFrame = CFrameEnd})
    tween:Play()
    tween.Completed:Wait()    
end
function huntdeer()
    for i,v in pairs(workspace.Animals:GetChildren()) do
        game:GetService("ReplicatedStorage").Events.Hunt:FireServer(v)
    end
end

--//locals\\--
local minetable = {
	[1] = "Mine",
	[2] = "E"
}
local processtable = {
	[1] = "Process Ores",
	[2] = "E"
}
local destroytbl = {
	[1] = "Destroy",
	[2] = "E"
}
local pickuptbl = {
	[1] = "Pick Up",
	[2] = "E"
}
local cooktbl = {
	[1] = "Cook Raw Meat",
	[2] = "E"
}
local guttingtbl = {
	[1] = "Gut Deer",
	[2] = "E"
}

--//variables\\--
_G.mineaura = false
_G.hunting = false
_G.nonlr = false
_G.huntingauto = false
local teletime = 15
local hidetype = true



local Jobs = main:CreateCategory("Jobs")
local ESPCat = main:CreateCategory("ESP")
local TeleportMenu = main:CreateCategory("Teleports")
local Misc = main:CreateCategory("Misc")


local Miner = Jobs:CreateSection("Miner")
local Hunter = Jobs:CreateSection("Hunter")
local Police = Jobs:CreateSection("Police")

local Teleports = TeleportMenu:CreateSection("Yurrr")

local ESPSettings = ESPCat:CreateSection("Settings")
local ESPTypes = ESPCat:CreateSection("ESP Types")

local MiscCat = Misc:CreateSection("Misc")

Miner:Create("Toggle","Mining Aura *SHIT*",function(state)

    _G.mineaura = toggle

    while _G.mineaura == true do
        for _,v in pairs(game:GetService("Workspace").Map["Mining Rocks"]:GetChildren()) do
            if v.mine.health.Value ~= 0 then
                game:GetService("ReplicatedStorage").Events.ActionHandler2:FireServer(v.mine, minetable)
                wait(0.01)
            end
        end
    end

end,
    {
        default = false,
    }
)

Miner:Create("DropDown","Sell Ore", function(current)
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer(current)
end,
    {
        options = {"Emerald","Platinum Bar","Ruby","Gold Ore","Rock","Diamond","Gold Bar","Iron Bar","Copper Bar"},
        default = "Rock",
        search = true
    }
)

Miner:Create("Button","Sell All Ores",function()
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Emerald")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Platinum Bar")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Ruby")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Gold Ore")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Rock")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Diamond")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Gold Bar")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Iron Bar")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Copper Bar")
end,
    {
        animated = true,
    }
)

Miner:Create("Button","Smelt Ores",function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v.Name == "smelter" then
            game:GetService("ReplicatedStorage").Events.ActionHandler2:FireServer(v, processtable)
            break
        end
    end
end,
    {
        animated = true,
    }
)

Hunter:Create("Toggle","Auto Hunt *MANUAL GUTTING*",function(state)

    _G.hunting = toggle

    while _G.hunting == true do
        huntdeer()
        wait(1)
    end

end,
    {
        default = false,
    }
)

Hunter:Create("Toggle","Auto Hunt *MUST BE AT CAMPFIRE*",function(state)

    _G.huntingauto = toggle

    while _G.huntingauto == true do

        for i,v in pairs(workspace.Animals:GetChildren()) do
            game:GetService("ReplicatedStorage").Events.Hunt:FireServer(v)
            wait(.5)
            v.CanCollide = false
            v.CFrame = CFrame.new(873.347, 30.5709, -1685.36)
            wait(.5)
            game:GetService("ReplicatedStorage").Events.ActionHandler2:FireServer(v.deer, guttingtbl)
        end


        for i,v in pairs(workspace:GetChildren()) do
            if v.Name == "Handle" and string.find(v.droppeditem.itemName.Value,"Meat") then
                v.CFrame = CFrame.new(873.347, 28.5709, -1685.36)
                wait(.3)
                game:GetService("ReplicatedStorage").Events.ActionHandler2:FireServer(v.droppeditem, pickuptbl)
            end
        end
        wait(.5)

        for i,v in pairs(workspace.Map.CampfireModel:GetDescendants()) do
            if v.Name == "campfire" then
                game:GetService("ReplicatedStorage").Events.ActionHandler2:FireServer(v, cooktbl)
            end
        end

        wait(3.5)

        for i,v in pairs(workspace:GetChildren()) do
            if v.Name == "Handle" and string.find(v.droppeditem.itemName.Value,"Cooked") then
                game:GetService("ReplicatedStorage").Events.ActionHandler2:FireServer(v.droppeditem, pickuptbl)
            end
        end
        wait(.2)
        game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Cooked Meat")

    end

end,
    {
        default = false,
    }
)

Hunter:Create("Button","Hunt Deer *MANUAL GUTTING*",function()
    huntdeer()
end,
    {
        animated = true,
    }
)

Hunter:Create("Button","Sell Meat *MUST BE COOKED*",function()
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Cooked Meat")
end,
    {
        animated = true,
    }
)

Police:Create("Button","Destroy All Printers",function()
    for i,v in pairs(workspace.Entities:GetChildren()) do
        if string.find(v.name,"Printer") then
            game:GetService("ReplicatedStorage").Events.ActionHandler2:FireServer(v.Main.moneyprinter, destroytbl)
        end
    end
end,
    {
        animated = true,
    }
)


Teleports:Create("Slider","Teleport Speed *PUT HIGHER IF FAR AWAY*",function(value)
    teletime = value
end,
    {
        min = 5,
        max = 60,
        default = 15,
        changablevalue = true
    }
)

Teleports:Create("Button","Campfire",function()
    teleport(teletime,CFrame.new(873.347, 28.5709, -1685.36))
end,
    {
        animated = true,
    }
)

Teleports:Create("Button","Spawn",function()
    teleport(teletime,CFrame.new(473.065, 13.4125, -220.866))
end,
    {
        animated = true,
    }
)

Teleports:Create("Button","Suburbs",function()
    teleport(teletime,CFrame.new(355.742, 13.7437, -557.904))
end,
    {
        animated = true,
    }
)

Teleports:Create("Button","Desert",function()
    teleport(teletime,CFrame.new(1888.87, 21.9031, -164.663))
end,
    {
        animated = true,
    }
)

Teleports:Create("DropDown","PlayerTeleport", function(current)
    if current ~= game.Players.LocalPlayer.Name then
        teleport(teletime,CFrame.new(workspace[current].HumanoidRootPart.Position))
    end
end,
    {
        playerlist = true,
        search = true
    }
)

ESPSettings:Create("Toggle","Toggle ESP",function(state)
    esp:Toggle(state)
end,
    {
        default = false,
    }
)
ESPSettings:Create("Toggle","Toggle Names",function(state)
    esp.Names = state
end,
    {
        default = true,
    }
)
ESPSettings:Create("Toggle","Toggle Boxes",function(state)
    esp.Boxes = state
end,
    {
        default = true,
    }
)
ESPSettings:Create("Toggle","Toggle Boxes Face Cam",function(state)
    esp.FaceCamera = state
end,
    {
        default = false,
    }
)

--printer esp
esp:AddObjectListener(game:GetService("Workspace").Entities, {
    Color =  Color3.new(1,1,0),
    Type = "Model",
    PrimaryPart = function(itm)
        repeat wait() until itm.Main
        return itm.Main
    end,
    CustomName = function(itm)
        if tostring(itm) ~= nil or "" then
            return tostring(itm)
        elseif itm.Name ~= nil or "" then
            return itm.Name
        end
    end,
    IsEnabled = "Items",
})
game:GetService("Workspace").Entities.ChildAdded:Connect(function(obj)
    esp:Add(obj, {
    Type = "Model",
    CustomName = function(itm)
        if tostring(itm) ~= nil or "" then
            return tostring(itm)
        elseif itm.Name ~= nil or "" then
            return itm.Name
        end
    end,
    Color = Color3.new(1,1,0),
    PrimaryPart = function(itm)
        repeat wait() until itm.Main
        return itm.Main
    end,
    IsEnabled = "Items"
    })
end)
--shipment esp
esp:AddObjectListener(game:GetService("Workspace").Entities, {
    Name = "Shipment",
    CustomName = function(itm)
        return itm.shipment.type.Value.." Shipment"
    end,
    Color = Color3.fromRGB(255, 255, 0),
    IsEnabled = "Items"
})
game:GetService("Workspace").Entities.ChildAdded:Connect(function(obj)
    esp:Add(obj, {
        Name = "Shipment",
        CustomName = function(itm)
            return itm:FindFirstChildOfClass("IntValue").type.Value.." Shipment"
        end,
        Color = Color3.fromRGB(255, 255, 0),
        IsEnabled = "Items"
    })
end)

ESPTypes:Create("Toggle","Players",function(state)
    esp.Players = state
end,
    {
        default = true,
    }
)

ESPTypes:Create("Toggle","Printers/Shipments",function(state)
    esp.Items = state
end,
    {
        default = false,
    }
)

MiscCat:Create("KeyBind","Hide Menu", function()
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v.name == tostring(gamename)..uiversion then
            if hidetype == true then
                hidetype = false
                v.Enabled = hidetype
            elseif hidetype == false then
                hidetype = true
                v.Enabled = hidetype
            end
        end
    end
end,
    {
        default = Enum.KeyCode.N
    }
)

MiscCat:Create("Button","Grab Crates",function()
    for i,v in pairs(workspace:GetChildren()) do
        if v.Name == "CrateSpawner" and v:FindFirstChild("Crate") then
            teleport(15,v.Crate.CFrame)
            v.Crate.CanCollide = false
            wait(.1)
            game:GetService("ReplicatedStorage").Events.ActionHandler2:FireServer(v.Crate.lootcrate, pickuptbl)
        end
    end
end,
    {
        animated = true,
    }
)

MiscCat:Create("Button","Close UI",function()
    destroyui()
end,
    {
        animated = true,
    }
)

MiscCat:Create("Textlabel",tostring(gamename).."\n"..uiversion)