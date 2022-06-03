local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/MagikManz/Venyx-UI-Library/main/source.lua"))()
local esplib = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()

local suc,er = pcall(function()
    workspace.Animals.Goat:Destroy()
end)

function destroyold()
    for i,v in pairs(game.CoreGui:GetDescendants()) do
        if v.ClassName == "TextLabel" and v.Text == "Bloxford :scream:" then
            v.Parent.Parent.Parent.Parent:Destroy()
            _G.mineaura = false
            _G.hunting = false
            _G.nonlr = false
            _G.huntingauto = false
            esplib:Toggle(false)
        end
    end
end
destroyold()

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

local ui = UI.new("Bloxford")

--//tabs\\--
local jobtab = ui:Tab("Jobs")
local teleportab = ui:Tab("Teleports")
local esptab = ui:Tab("Esp")
local misctab = ui:Tab("Misc")

--//sections\\--
local mining = jobtab:Section("Mining")
local hunting = jobtab:Section("Hunting (not a job in the menu)")
local police = jobtab:Section("Any Police")
local tele = teleportab:Section("Yurrr")
local esp = esptab:Section("Settings")
local espparts = esptab:Section("ESP Types")
local misc = misctab:Section("Misc")

mining:Toggle("Mine Aura", false, function(toggle)
    _G.mineaura = toggle

    while _G.mineaura == true do
        for _,v in pairs(game:GetService("Workspace").Map["Mining Rocks"]:GetChildren()) do
            if v.mine.health.Value ~= 0 then
                game:GetService("ReplicatedStorage").Events.ActionHandler2:FireServer(v.mine, minetable)
                wait(0.01)
            end
        end
    end

end)

mining:Dropdown("Sell Ore", {"Emerald","Platinum Bar","Ruby","Gold Ore","Rock","Diamond","Gold Bar","Iron Bar","Copper Bar"}, "Rock", function(selected)
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer(selected)
end)

mining:Button("Sell All Ores", function()
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Emerald")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Platinum Bar")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Ruby")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Gold Ore")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Rock")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Diamond")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Gold Bar")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Iron Bar")
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Copper Bar")
end)

mining:Button("Smelt Ores", function()
for _,v in pairs(workspace:GetDescendants()) do
    if v.Name == "smelter" then
        game:GetService("ReplicatedStorage").Events.ActionHandler2:FireServer(v, processtable)
    break
    end
end
end)

hunting:Toggle("Auto Hunt *MANUAL GUTTING*", false, function(toggle)
    _G.hunting = toggle

    while _G.hunting == true do
        huntdeer()
        wait(1)
    end
end)

hunting:Toggle("Auto Farm *BE AT CAMPFIRE*", false, function(toggle)
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
end)

hunting:Button("Hunt All Deer *MANUAL GUTTING*", function()
    huntdeer()
end)

hunting:Button("Sell All Meat *MUST BE COOKED*", function()
    game:GetService("ReplicatedStorage").Events.Trader2:FireServer("Cooked Meat")
end)

police:Button("Destroy All Printers", function()
    for i,v in pairs(workspace.Entities:GetChildren()) do
        if string.find(v.name,"Printer") then
            game:GetService("ReplicatedStorage").Events.ActionHandler2:FireServer(v.Main.moneyprinter, destroytbl)
        end
    end
end)

tele:Slider("Teleport Time *WARNING, PUT HIGHER IF FAR AWAY*", 5, 50, 10, function(value)
	teletime = value
end)

tele:Button("Campfire (hunting spot)", function()
    teleport(teletime,CFrame.new(873.347, 28.5709, -1685.36))
end)

tele:Button("Spawn", function()
    teleport(teletime,CFrame.new(473.065, 13.4125, -220.866))
end)

tele:Button("Suburbs", function()
    teleport(teletime,CFrame.new(355.742, 13.7437, -557.904))
end)

tele:Button("Desert... Thing", function()
    teleport(teletime,CFrame.new(1888.87, 21.9031, -164.663))
end)

esp:Toggle("Toggle ESP", false, function(toggle)
    esplib:Toggle(toggle)
end)
esp:Toggle("Toggle Names", true, function(toggle)
    esplib.Names = toggle
end)
esp:Toggle("Toggle Boxes", true, function(toggle)
    esplib.Boxes = toggle
end)
esp:Toggle("Toggle Boxes Face Cam", false, function(toggle)
    esplib.FaceCamera = toggle
end)

esplib:AddObjectListener(game:GetService("Workspace").Entities, {
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
    esplib:Add(obj, {
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

esplib:AddObjectListener(game:GetService("Workspace").Entities, {
    Name = "Shipment",
    CustomName = function(itm)
        return itm.shipment.type.Value.." Shipment"
    end,
    Color = Color3.fromRGB(255, 255, 0),
    IsEnabled = "Items"
})

game:GetService("Workspace").Entities.ChildAdded:Connect(function(obj)
    esplib:Add(obj, {
        Name = "Shipment",
        CustomName = function(itm)
            return itm.shipment.type.Value.." Shipment"
        end,
        Color = Color3.fromRGB(255, 255, 0),
        IsEnabled = "Items"
    })
end)

esplib:AddObjectListener(game:GetService("Workspace").Animals, {
    Name = "Deer",
    CustomName = "Deer",
    Color = Color3.fromRGB(255, 255, 0),
    IsEnabled = "Animals"
})

game:GetService("Workspace").Animals.ChildAdded:Connect(function(obj)
    esplib:Add(obj, {
        Name = "Deer",
        CustomName = "Deer",
        Color = Color3.fromRGB(255, 255, 0),
        IsEnabled = "Animals" 
    })
end)

espparts:Toggle("Players", true, function(toggle)
    esplib.Players = toggle
end)
espparts:Toggle("Printers/Shipments", false, function(toggle)
    esplib.Items = toggle
end)
espparts:Toggle("Deer", false, function(toggle)
    esplib.Animals = toggle
end)


misc:Toggle("No NLR Bubble", false, function(toggle)
    _G.nonlr = toggle

    if _G.nonlr == true then
        for i,v in pairs(workspace.NLRBarrier:GetChildren()) do
            if v.Name == "Part" then
                v:Destroy()
            end
        end
    end
end)

misc:Button("Grab Crates", function()
    for i,v in pairs(workspace:GetChildren()) do
        if v.Name == "CrateSpawner" and v:FindFirstChild("Crate") then
            teleport(15,v.Crate.CFrame)
            v.Crate.CanCollide = false
            wait(.1)
            game:GetService("ReplicatedStorage").Events.ActionHandler2:FireServer(v.Crate.lootcrate, pickuptbl)
        end
    end
end)

misc:Button("Close UI", function()
    destroyold()
end)


workspace.NLRBarrier.ChildAdded:Connect(function(obj)
    if _G.nonlr == true then
        obj:Destroy()
    end
end)