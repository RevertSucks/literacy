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
local teletime = 10



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
            return itm.shipment.type.Value.." Shipment"
        end,
        Color = Color3.fromRGB(255, 255, 0),
        IsEnabled = "Items"
    })
end)

ESPTypes:Create("Toggle","Players",function(state)
    esp.Players = state
end,
    {
        default = false,
    }
)

ESPTypes:Create("Toggle","Printers/Shipments",function(state)
    esp.Items = state
end,
    {
        default = false,
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