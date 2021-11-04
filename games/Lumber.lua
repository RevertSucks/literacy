for i,v in pairs(game.CoreGui:GetChildren()) do
    if v.name == "Exxen$$$" then
        v:Destroy()
    end
end
game:GetService("Players").LocalPlayer.SuperBlueprint.Value = true
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()
local main = library:CreateMain({
	projName = "Exxen$$$",
	Resizable = true,
	MinSize = UDim2.new(0,400,0,400),
	MaxSize = UDim2.new(0,750,0,500)
})

local plr = game.Players.LocalPlayer
local speedvar = 16
local jumpvar = 50
local selchar = nil
local gameplrs = {}
local viewCam = false
local mouse = plr:GetMouse()
local mtar = nil
local killtar = nil
local maxspeedvar = 1
local steeranglevar = 0.7
local turningspeedvar = 0.016

local cat2 = main:CreateCategory("LocalPlayer")
local cat1 = main:CreateCategory("World/Base")
local cat3 = main:CreateCategory("Others")
local sec1 = cat2:CreateSection("Movement")
local sec2 = cat1:CreateSection("Base")
local sec6 = cat1:CreateSection("World")
local sec3 = cat3:CreateSection("Spectating")
local sec5 = cat2:CreateSection("Car Stuff")
local sec4 = cat2:CreateSection("Others")
local catDevs = main:CreateCategory("Credits")
local secDevs = catDevs:CreateSection("Creator")
local secDevsa = catDevs:CreateSection("Tutorials")
local secDevsb = catDevs:CreateSection("UI Library")


sec1:Create("Slider","Walkspeed",function(value)
    speedvar = value
end,
    {
        min = 16,
        max = 250,
        default = 16,
    }
)

sec1:Create("Slider","Jumppower",function(value)
    jumpvar = value
end,
    {
        min = 50,
        max = 300,
        default = 50,
    }
)

sec5:Create("Slider","Max Speed",function(value)
    maxspeedvar = value
end,
    {
        min = 1,
        max = 500,
        default = 1,
    }
)

sec5:Create("Slider","Max Steer Angle",function(value)
    steeranglevar = value
end,
    {
        min = 0.7,
        max = 2,
        default = 0.7,
        precise = true
    }
)

sec5:Create("Slider","Turning Speed",function(value)
    turningspeedvar = value
end,
    {
        min = 0.016,
        max = 100,
        default = 0.016,
        precise = true
    }
)

sec5:Create("Button","Fix Car Values",function()
    local seat = plr.Character.Humanoid.SeatPart
    local maxspeedvar = 1
    local steeranglevar = 0.7
    local turningspeedvar = 0.016

    if seat ~= nil then
        if seat.Name == "DriveSeat" then
            seat.Parent:FindFirstChild("Configuration").MaxSpeed.Value = maxspeedvar
            seat.Parent:FindFirstChild("Configuration").SteerVelocity.Value = turningspeedvar
            seat.Parent:FindFirstChild("Configuration").SteerAngle.Value = steeranglevar
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Car Mod",Text = "Get In Driver Seat!",Duration = 5,Button1 = "Ok"})
    end
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Car Mod",Text = "Sit Down!",Duration = 5,Button1 = "Ok"})
    end
end,
    {
        animated = true,
    }
)

sec5:Create("Button","Activate Mods",function()
local seat = plr.Character.Humanoid.SeatPart
if seat ~= nil then
    if seat.Name == "DriveSeat" then
        if seat.Parent:FindFirstChild("Configuration") then
            seat.Parent:FindFirstChild("Configuration").MaxSpeed.Value = maxspeedvar
            seat.Parent:FindFirstChild("Configuration").SteerVelocity.Value = turningspeedvar
            seat.Parent:FindFirstChild("Configuration").SteerAngle.Value = steeranglevar
            end
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Car Mod",Text = "Get In Driver Seat!",Duration = 5,Button1 = "Ok"})
        end
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Car Mod",Text = "Sit Down!",Duration = 5,Button1 = "Ok"})
    end
end,
    {
        animated = true,
    }
)

local walkspeed = game:GetService("RunService").RenderStepped:Connect(function()
    if plr then
        if plr.Character:FindFirstChild("Humanoid") then
            if plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed ~= 0 then
                plr.Character.Humanoid.WalkSpeed = speedvar
            end
        end
    end
end)

local jumppower = game:GetService("RunService").RenderStepped:Connect(function()
    if plr then
        if plr.Character:FindFirstChild("Humanoid") then
            if plr.Character:FindFirstChildOfClass("Humanoid").JumpPower ~= 0 then
                plr.Character.Humanoid.JumpPower = jumpvar
            end
        end
    end
end)

sec3:Create("Dropdown", "Player list",
    function(selected)
        selchar = selected
    end,
    {
    playerlist = true
    }
)

sec3:Create("Button","View Player",function()
    viewCam = not viewCam
    if viewCam then
        if game.Players[selchar] ~= plr then
            game.Workspace.CurrentCamera.CameraSubject = game.Players[selchar].Character.Humanoid
        end
    else
        game.Workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid    
    end
end,
    {
        animated = true,
    }
)

sec3:Create("Button","Goto Base",function()
    if game.Players[selchar].OwnsProperty.Value ~= false then
        for i,v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
            if v:FindFirstChild("Owner") and v.Owner.Value == game.Players[selchar] then
                plr.Character.HumanoidRootPart.CFrame = v.OriginSquare.CFrame + Vector3.new(0,2,0)
            end
        end
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Base Teleport",Text = "No Base!",Duration = 5,Button1 = "Ok"})
    end
    end,
        {
            animated = true,
        }
    )

sec2:Create("Toggle","Grey Paint",function(state)
    if state == true then
        killtar = mouse.Button1Up:Connect(function()
            mtar = mouse.Target
            if mtar.Parent.Type.Value == "Blueprint" then
                if mtar.Parent:FindFirstChild("Owner") and tostring(mtar.Parent.Owner.Value) == tostring(plr) then
                local pos = nil
                if mtar:FindFirstChild("MainCFrame") then
                    pos = mtar.Parent.MainCFrame.Value
                else
                    pos = mtar.Parent.Main.CFrame
                end
                game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedStructure:FireServer(mtar.Parent.ItemName.Value, pos, plr, nil, mtar.Parent, true)
                return
            end
        end
        end)
    else
        killtar:Disconnect()
    end
end,
    {
        default = false,
    }
)

sec2:Create("Button","Free Land, No Sign :(",function()
for i,v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
if v:FindFirstChild("Owner").Value == plr then
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Free Land",Text = "You Have a Base!",Duration = 5,Button1 = "Ok"})
else
    if v:FindFirstChild("Owner").Value == nil then
        game:GetService("ReplicatedStorage").PropertyPurchasing.ClientPurchasedProperty:FireServer(v, v.OriginSquare.CFrame)
    end
end
end
end,
    {
        animated = true,
    }
)

sec2:Create("Button","Max Land",function()
    for i,v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
        if v:FindFirstChild("Owner").Value == plr then
            game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(40,0,80)) 
                game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(80,0,40))
                    game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(-40,0,-80))
                        game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(-80,0,-40))
                            game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(40,0,-80))
                                game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(-40,0,80))
                                    game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(80,0,80))
                                        game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(40,0,40))
                                            game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(40,0,-40))
                                                game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(-40,0,40))
                                                    game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(80,0,-80))
                                                        game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(-80,0,80))
                                                        game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(80,0,0))
                                                    game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(0,0,80))
                                                game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(40,0,0))
                                            game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(0,0,40))
                                        game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(-40,0,0))
                                    game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(0,0,-40))
                                game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(-80,0,0))
                            game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(0,0,-80))
                        game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(-40,0,-40))
                    game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(-80,0,-80))
                game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(80,0,-40))
            game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(v,v.OriginSquare.CFrame+Vector3.new(-80,0,40))
        end
    end
end,
    {
        animated = true,
    }
)

sec6:Create("Toggle","Remove Water",function(state)
if state == true then
    for i,v in pairs(game:GetService("Workspace").Water:GetChildren()) do
        if v.Name == "Water" then
            v.Transparency = 1
        end        
    end
end

if state == false then
    for i,v in pairs(game:GetService("Workspace").Water:GetChildren()) do
        if v.Name == "Water" then
            v.Transparency = 0
        end        
    end
end
end,
    {
        default = false,
    }
)

sec2:Create("Button","Give Blueprints (temp)",function()
    for index,value in pairs(game:GetService("ReplicatedStorage").Purchasables.Structures.BlueprintStructures:GetChildren()) do
        local parent = Instance.new("Folder", plr.PlayerBlueprints.Blueprints)
        parent.Name = value.Name
        local string = Instance.new("StringValue", parent)
        string.Value = value.ItemCategory.Value
        string.Name = "ItemCategory"
    end
end,
    {
        animated = true,
    }
)

sec2:Create("Button","Sell Sign",function()
    for i,v in pairs(game:GetService("Workspace").PlayerModels:GetChildren()) do
        if v.Name == "PropertySoldSign" then
            if v:FindFirstChild("Owner") then
                if v.Owner.Value == plr then
                    for i = 1,4 do
                    game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
                    v:FindFirstChild("Main").CFrame = CFrame.new(314.54,-0.40,86.82)
                    end
                game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Sign Sell",Text = "Completed!",Duration = 5,Button1 = "Ok"})
                end
            end
        end
    end
end,
    {
        animated = true,
    }
)

sec2:Create("Button","Goto Base",function()
if plr.CurrentSaveSlot.Value ~= -1 then
    for i,v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Owner.Value == plr then
            plr.Character.HumanoidRootPart.CFrame = v.OriginSquare.CFrame + Vector3.new(0,2,0)
        end
    end
else
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Base Teleport",Text = "No Base!",Duration = 5,Button1 = "Ok"})
end
end,
    {
        animated = true,
    }
)

sec4:Create("Button","Close GUI",function()
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v.name == "Exxen$$$" then
            v:Destroy()
            wait(0.1)
            plr.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50
        end
    end
    end,
    {
        animated = true,
    }
)

secDevs:Create("Textlabel","Exxen#0001")

secDevsa:Create("Textlabel","Cynical Modder - Inspired this project")
secDevsa:Create("Textlabel","Zerio - Blueprint, Car mod scripts")

secDevsb:Create("Textlabel","Zypher UI-Lib")

local closeScript = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.Name == "Exxen$$$" then
        walkspeed:Disconnect()
        jumppower:Disconnect()
        jumpvar = 50
        speedvar = 16
        closeScript:Disconnect()
    end    
end)
