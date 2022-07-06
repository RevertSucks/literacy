local autofarmToggle
local autofarmToggle2 = false
local autofarmSpeed = 25
local autofarmSpeed2 = 1

local winterChest = false
local winterAmount = 1

local selectedChestTog = false
local selectedChest
local selectedAmount

local function closeUi()
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v.name == "Discord" then
            v:Destroy()
            autofarmToggle = false
            winterChest = false
        end
    end
end
closeUi()

local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()

local win = DiscordLib:Window("Build A Boat")
local serv = win:Server("Made By Exxen#0001", "http://www.roblox.com/asset/?id=6031075938")

local autofarmChan = serv:Channel("Autofarm")
local buyingChan = serv:Channel("Buying")
local morphChan = serv:Channel("Morphs")

local fireworkType = "FireworkA"
local fireworkAmount = 1

local function teleport(time,cframe)
    local Time = time
    local CFrameEnd = cframe
    local tween =  game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time), {CFrame = CFrameEnd})
    tween:Play()
    tween.Completed:Wait()
end

buyingChan:Dropdown("Firework Buy", {"A","B","C","D"}, function(t)
   fireworkType = "Firework"..t
end)

buyingChan:Slider("Amount (100 per)", 1, 250,1,function(t)
    fireworkAmount = t
end)

buyingChan:Button("Buy", function()
    workspace.ItemBoughtFromShop:InvokeServer(fireworkType, fireworkAmount)
    DiscordLib:Notification("Alert!", "Attempted to buy "..fireworkType..", "..fireworkAmount.." times!", "Okay!")
end)

buyingChan:Seperator()

buyingChan:Slider("Amount (60 per)", 1, 250,1,function(t)
    winterAmount = t
end)

buyingChan:Button("Buy Winter Chest", function()
    workspace.ItemBoughtFromShop:InvokeServer("Winter Chest", winterAmount)
     DiscordLib:Notification("Alert!", "Attempted to buy Winter Chest!", "Okay!")
 end)

 buyingChan:Toggle("Auto Buy Winter Chest",false, function(t)
    winterChest = t
end)

buyingChan:Seperator()

buyingChan:Dropdown("Selected Chest Buy", {"Common","Uncommon","Rare","Epic","Legendary"}, function(t)
    selectedChest = t.." Chest"
 end)

buyingChan:Slider("Amount", 1, 250,1,function(t)
    selectedAmount = t
end)

buyingChan:Button("Buy Selected Chest", function()
    workspace.ItemBoughtFromShop:InvokeServer(selectedChest, selectedAmount)
     DiscordLib:Notification("Alert!", "Attempted to buy Winter Chest!", "Okay!")
 end)

 buyingChan:Toggle("Auto Buy Selected Chest",false, function(t)
    selectedChestTog = t
end)

autofarmChan:Toggle("Auto-Farm Coins",false, function(t)
    autofarmToggle = t
end)

autofarmChan:Slider("Speed (lower = faster)", 0, 60,25,function(t)
    autofarmSpeed = t
end)

autofarmChan:Slider("Start/End Speed (lower = faster)", 0, 5,1,function(t)
    autofarmSpeed2 = t
end)

morphChan:Button("Fox", function()
    workspace.ChangeCharacter:FireServer("FoxCharacter")
    DiscordLib:Notification("Alert!", "Morped into Fox!", "Okay!")
end)

morphChan:Button("Penguin", function()
    workspace.ChangeCharacter:FireServer("PenguinCharacter")
    DiscordLib:Notification("Alert!", "Morped into Penguin!", "Okay!")
end)

morphChan:Button("Chicken", function()
    workspace.ChangeCharacter:FireServer("ChickenCharacter")
    DiscordLib:Notification("Alert!", "Morped into Chicken!", "Okay!")
end)

game:GetService('RunService').Heartbeat:connect(function()
    if autofarmToggle2 == false then
        if autofarmToggle == true then
        print('2')
        autofarmToggle2 = true
        workspace[tostring(game.Players.LocalPlayer.TeamColor).."Zone"].VoteLaunchRE:FireServer()
        workspace.ClaimRiverResultsGold:FireServer()
        teleport(autofarmSpeed2,CFrame.new(-46.0902061, 48.5532112, 306.818024, -0.99999994, 3.08585768e-05, -0.000243538874, -9.61094049e-09, 0.992062867, 0.125742793, 0.000245486124, 0.125742793, -0.992062867))
        teleport(autofarmSpeed,CFrame.new(-45.6405792, 130.776764, 8651.52832, -0.999574065, -0.00129274174, 0.0291543398, 8.45643378e-09, 0.999018371, 0.0442980789, -0.0291829873, 0.0442792103, -0.998592854))
        teleport(autofarmSpeed2,CFrame.new(-54.9334946, -360.095276, 9488.80078, -0.964331031, -0.0507260226, 0.259793192, -0.0149418572, 0.990332782, 0.137904868, -0.264277071, 0.129104152, -0.955766559))
        teleport(5,CFrame.new(-54.9334946, -360.095276, 9488.80078, -0.964331031, -0.0507260226, 0.259793192, -0.0149418572, 0.990332782, 0.137904868, -0.264277071, 0.129104152, -0.955766559))
        wait(14)
        autofarmToggle2 = false
        end
    end
    if winterChest == true then
        workspace.ItemBoughtFromShop:InvokeServer("Winter Chest", 1)
    end
    if selectedChestTog == true then
        workspace.ItemBoughtFromShop:InvokeServer(selectedChest, 1)
    end
end)
