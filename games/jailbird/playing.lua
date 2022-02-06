for i,v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "CoreNiggaService" then
        v:Destroy()
    end
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
local main = library:CreateMain({
    projName = "CoreNiggaService",
    Resizable = true,
    MinSize = UDim2.new(0,400,0,400),
    MaxSize = UDim2.new(0,750,0,500),
})

local ammo = false
local damage= false
local firerate= false
local recoil= false
local spread= false
local autoapply=false
local speedvar = 16
local plr = game.Players.LocalPlayer
local plrname = plr.Name
local mouse = plr:GetMouse()


local maincat = main:CreateCategory("Main")
local espcat = main:CreateCategory("ESP (Kiriot)")
local espsec = espcat:CreateSection("ESP")
local gunmods = maincat:CreateSection("Guns")
local misc = maincat:CreateSection("Main Misc")
local reportcat = main:CreateCategory("Report Info")
local reportsec = reportcat:CreateSection("Reports")

espsec:Create("Toggle","Toggle ESP",function(state)
    ESP:Toggle(state)
end,
    {
        default = false,
    }
)

espsec:Create("Toggle","Toggle Tracers",function(state)
    ESP.Tracers = state
end,
    {
        default = false,
    }
)

ESP.TeamColor = true

espsec:Create("Toggle","Toggle Names",function(state)
    ESP.Names = state
end,
    {
        default = true,
    }
)

espsec:Create("Toggle","Toggle Boxes",function(state)
    ESP.Boxes = state
end,
    {
        default = true,
    }
)

espsec:Create("Toggle","Toggle Boxes Face Camera",function(state)
    ESP.FaceCamera = state
end,
    {
        default = false,
    }
)

gunmods:Create("Toggle","Ammo",function(state)
    ammo = state
end,
    {
        default = false,
    }
)

gunmods:Create("Toggle","Damage",function(state)
    damage = state
end,
    {
        default = false,
    }
)

gunmods:Create("Toggle","Firerate",function(state)
    firerate = state
end,
    {
        default = false,
    }
)

gunmods:Create("Toggle","Recoil",function(state)
    recoil = state
end,
    {
        default = false,
    }
)

gunmods:Create("Toggle","Spread",function(state)
    spread = state
end,
    {
        default = false,
    }
)

gunmods:Create("Button","Add Mods",function()
local plrwork = game:GetService("Workspace")[plrname]
    local settings = require(plrwork:FindFirstChildOfClass("Tool"):FindFirstChildOfClass("Folder").Variaveis.Settings)
    if ammo == true then
        settings.Ammo = math.huge
    end
    if damage == true then
        settings.LimbsDamage = {500,500}
        settings.TorsoDamage = {505,505}
        settings.HeadDamage = {510,510}
        settings.BulletPenetration = math.huge
    end
    if firerate == true then
        settings.FireRate = 9000
        settings.Mode = "Auto"
    end
    if recoil == true then
        settings.RecoilPunch = 0
        settings.VRecoil = {0,0}
        settings.HRecoil = {0,0}
        settings.MinRecoilPower = 0
        settings.MaxRecoilPower = 0
    end
    if spread == true then
        settings.MinSpread = 0 
        settings.MaxSpread = 0.1
    end
end,
    {
            animated = true,
    }
)

gunmods:Create("Toggle","Auto apply",function(state)
 autoapply = state
end,
    {
        default = false,
    }
)

game:GetService('RunService').Heartbeat:connect(function()
local plrwork = game:GetService("Workspace")[plrname] 
if autoapply == true then
    local settings = require(plrwork:FindFirstChildOfClass("Tool"):FindFirstChildOfClass("Folder").Variaveis.Settings)
    if ammo == true then
        settings.Ammo = math.huge
    end
    if damage == true then
        settings.LimbsDamage = {500,500}
        settings.TorsoDamage = {505,505}
        settings.HeadDamage = {510,510}
        settings.BulletPenetration = math.huge
    end
    if firerate == true then
        settings.FireRate = 9000
        settings.Mode = "Auto"
    end
    if recoil == true then
        settings.RecoilPunch = 0
        settings.VRecoil = {0,0}
        settings.HRecoil = {0,0}
        settings.MinRecoilPower = 0
        settings.MaxRecoilPower = 0
    end
    if spread == true then
        settings.MinSpread = 0 
        settings.MaxSpread = 0.1
    end
end
end)

misc:Create("Slider","Walkspeed",function(value)
    speedvar = value
end,
    {
        min = 16,
        max = 250,
        default = 16,
        precise = false
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


misc:Create("Slider","Ping Spoof",function(value)
    game:GetService("ReplicatedStorage").GameEvents.SendPing:FireServer(value)
end,
    {
        min = -10000,
        max = 10000,
        default = 52,
        precise = false
    }
)
misc:Create("Button","Lock Ping (credit: xchonkster, remote blocker)",function()
    local BlockedRemotes = {
        "SendPing",
    }
    
    local Events = {
        Fire = true, 
        Invoke = true, 
        FireServer = true, 
        InvokeServer = true,
    }
    
    local gameMeta = getrawmetatable(game)
    local psuedoEnv = {
        ["__index"] = gameMeta.__index,
        ["__namecall"] = gameMeta.__namecall;
    }
    setreadonly(gameMeta, false)
    gameMeta.__index, gameMeta.__namecall = newcclosure(function(self, index, ...)
        if Events[index] then
            for i,v in pairs(BlockedRemotes) do
                if v == self.Name and not checkcaller() then return nil end
            end
        end
        return psuedoEnv.__index(self, index, ...)
    end)
    setreadonly(gameMeta, true)
end,
    {
        animated = true,
    }
)

misc:Create("Toggle","Anti VK (obvious)",function(state)
    while wait(.5) do
        local rplr = game.Players:GetPlayers()[math.random(#game.Players:GetPlayers())]
        if state == true then
            if rplr.Name ~= plrname then
                game:GetService("ReplicatedStorage").GameEvents.VoteKick:FireServer(rplr.Name)
            end
        end
    end
   end,
       {
           default = false,
       }
   )

local report = plr.PlayerData.Report

reportsec:Create("Textlabel","You've been reported for hacking "..report.Hacking.Value.." times.")
reportsec:Create("Textlabel","You've been reported for TKing "..report.TeamKilling.Value.." times.")
reportsec:Create("Textlabel","You've been reported for griefing "..report.Griefing.Value.." times.")
reportsec:Create("Textlabel","You've been reported for being toxic "..report.ToxicBehaviour.Value.." times.")
reportsec:Create("Textlabel","------------------------------------------------------------------")
for i,v in pairs(report.PlayersReported:GetChildren()) do
    reportsec:Create("Textlabel","You have reported "..v.Name)
end

mouse.KeyDown:connect(function(key)
    if key == "n" then
        local gui = game:GetService("CoreGui"):FindFirstChild("CoreNiggaService").Motherframe
        if gui.Visible == true then
            gui.Visible = false
        else
            gui.Visible = true
        end
    end
end)

local closeScript = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.Name == "Exxen$$$" then
        walkspeed:Disconnect()
        speedvar = 16
        closeScript:Disconnect()
    end 
end)
