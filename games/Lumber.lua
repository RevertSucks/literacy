for i,v in pairs(game.CoreGui:GetChildren()) do
    if v.name == "Exxen$$$" then
        v:Destroy()
    end
end
local idkwhathisdoes = 1
for i,v in pairs(game:GetService("Workspace").Stores.FurnitureStore.Parts:GetChildren()) do
if v.Name == "Part" then
    if v:FindFirstChild("Texture") then
        local aight = idkwhathisdoes+1
        v.Name = "part"..idkwhathisdoes
        idkwhathisdoes = aight
        end
    end
end

game:GetService("Players").LocalPlayer.SuperBlueprint.Value = true
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()
local main = library:CreateMain({
	projName = "Exxen$$$",
	Resizable = true,
	MinSize = UDim2.new(0,400,0,400),
	MaxSize = UDim2.new(0,750,0,500),
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
local woodsel = nil

local cat2 = main:CreateCategory("LocalPlayer")
local cat1 = main:CreateCategory("World/Base")
local cat4 = main:CreateCategory("Teleports")
local cat3 = main:CreateCategory("Others")
local sec1 = cat2:CreateSection("Movement")
local sec2 = cat1:CreateSection("Base")
local sec6 = cat1:CreateSection("World")
local sec3 = cat3:CreateSection("Spectating")
local sec5 = cat2:CreateSection("Car Stuff")
local sec4 = cat2:CreateSection("Others")
local sec7 = cat4:CreateSection("Wood")


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

sec6:Create("Toggle","Buyable Many Axe (Furniture Store)",function(state)
    if state == true then
        local many_part1 = Instance.new("Part")
        many_part1.Parent = Workspace
        many_part1.Anchored = true
        many_part1.Name = "WTF"
        local many_part2 = Instance.new("TrussPart")
        many_part2.Parent = Workspace
        many_part2.Anchored = true
        many_part2.Name = "WTF2"
        many_part1.CFrame = CFrame.new(504.199799,-40.100006104,-1768.79968,1,0,0,0,1,0,0,0,1)
        many_part1.Size = Vector3.new(200,0.2,200)
        many_part2.CFrame = CFrame.new(551.59021, -30.20000601, -1709.85864, -0.0126609923, 3.15467901e-08, -0.999919832, -3.6248295e-08, 1, 3.20082982e-08, 0.999919832, 3.6650647e-08, -0.0126609923)
        many_part2.Size = Vector3.new(2, 200, 2)
        game:GetService("Workspace").Stores.FurnitureStore.Parts.part3.CFrame = CFrame.new(549.600098, 0.100006104, -1712.09985, 1, 0, 0, 0, 1, 0, 0, 0, 1)        
    end

    if state == false then
        game.Workspace['WTF']:Destroy()
        game.Workspace['WTF2']:Destroy()
        game:GetService("Workspace").Stores.FurnitureStore.Parts.part3.CFrame = CFrame.new(554.600098, 0.100006104, -1712.09985, 1, 0, 0, 0, 1, 0, 0, 0, 1)  
    end  
    end,
        {
            default = false,
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

sec2:Create("Button","Bring Wood",function()
    for i,v in pairs(game:GetService("Workspace").LogModels:GetChildren()) do
            if v:FindFirstChild("Owner") then
                if v.Owner.Value == plr then
                    for i = 1,100 do
                    game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
                    v:FindFirstChild("WoodSection").CFrame = plr.Character.HumanoidRootPart.CFrame
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
        if v.Name == "Exxen$$$" then
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

sec7:Create("Dropdown", "Wood",function(selected)
    woodsel = selected
    end,
    {
    options = {
        "Palm Wood 1",
        "Palm Wood 2",
        "Palm Wood 3",
        "Blue Wood",
        "Snow Glow",
        "Red Wood"
    }
    }
)

sec7:Create("Button","Goto Wood",function()
        if woodsel == "Palm Wood 1" then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(2625.79102, -5.89998531, -20.0698681, 0.0075901784, 1.23019802e-07, 0.999970376, -4.27361648e-08, 1, -1.22699021e-07, -0.999970376, -4.18035633e-08, 0.0075901784)
        elseif woodsel == "Palm Wood 2" then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(1848.82458, -5.90000153, -2453.66431, 0.0116119236, -5.3768769e-08, 0.999931693, 5.55722046e-08, 1, 5.31270565e-08, -0.999931693, 5.49515242e-08, 0.0116119236)
        elseif woodsel == "Palm Wood 3" then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(4337.73682, -5.90000153, -1815.07434, -0.0111504393, 1.99736564e-06, 0.999937475, 1.95550479e-06, 1, -1.97568579e-06, -0.999937475, 1.93335222e-06, -0.0111504393)
        elseif  woodsel == "Blue Wood" then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(3318.05444, -225.800125, 491.158264, 0.999999762, -8.29025595e-08, 0.000719949137, 8.28789979e-08, 1, 3.27516361e-08, -0.000719949137, -3.26919576e-08, 0.999999762)
        elseif woodsel == "Snow Glow" then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(-1144.12915, 13.8198757, -943.979919, 0.012524128, 0.0437808596, -0.998961747, -0.00285720243, 0.999038517, 0.043748375, 0.999917269, 0.00230632629, 0.0126373665)
        elseif woodsel == "Red Wood" then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(-1606.73633, 623.000061, 1047.73535, -0.49010092, -5.14402068e-08, 0.871666014, 3.3597497e-10, 1, 5.92025842e-08, -0.871666014, 2.93081044e-08, -0.49010092)
    end
    end,
    {
        animated = true,
    }
)

local closeScript = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.Name == "Exxen$$$" then
        walkspeed:Disconnect()
        jumppower:Disconnect()
        jumpvar = 50
        speedvar = 16
        closeScript:Disconnect()
    end    
end)
