
for i,v in pairs(game.CoreGui:GetChildren()) do
    if v.name == "Exxen$$$" then
        v:Destroy()
    end
end

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Flare Bomb",Text = "If its not working please try equiping your flare gun",Duration = 5,Button1 = "Ok"})


local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()
local main = library:CreateMain({
	projName = "Exxen$$$",
	Resizable = true,
	MinSize = UDim2.new(0,400,0,400),
	MaxSize = UDim2.new(0,750,0,500),
})

local https = game:GetService("HttpService")
local sharkfolder = Workspace.Sharks
local plr = game.Players.LocalPlayer
local selchar = nil
local viewCam = false
local mouse = plr:GetMouse()
local duckbomb = false
local duckbombvar = 0
local flare_sidevar = 0
local flare_heightvar = 0
local flare_frontbackvar = 0
local flarebomb = false
local flarebombvar = 0
local stored_duck = 0
local stored_flare = 0
local previous_pos = nil
local char = plr.Character
local respmethod = nil
local flareresp = false
local oxygenresp = false

local cat = main:CreateCategory("Main")
local bombcat = main:CreateCategory("Bombers")
local options = main:CreateCategory("Options")
local bombtab = bombcat:CreateSection("Bombs")
local optionssec = options:CreateSection("Options")
local flare = cat:CreateSection("Flare")
local sec = cat:CreateSection("Other")

optionssec:Create("Toggle","Backpack Flare Shooting",function(state)
getgenv().settingstbl.flare_backpack = state
savesettings()
end,
    {
        default = false,
    }
)

optionssec:Create("Dropdown", "Respawn Method",function(selected)
    respmethod = selected
end,
{
options = {
    "0 Health",
    "Void"
}
}
)

flare:Create("Slider","Sideways Modifer",function(value)
    flare_sidevar = value
end,
    {
        min = 0,
        max = 100,
        default = 1,
        precise = true
    }
)
flare:Create("Slider","Height Modifer",function(value)
    flare_heightvar = value
end,
    {
        min = 0,
        max = 100,
        default = 1,
        precise = true
    }
)
flare:Create("Slider","Forwards/Backwards Modifer",function(value)
    flare_frontbackvar = value
end,
    {
        min = 0,
        max = 100,
        default = 1,
        precise = true
    }
)

flare:Create("Button","Shoot Modded Flare",function()
    for i,v in pairs(plr.Backpack:GetChildren()) do
        if getgenv().settingstbl.flare_backpack == true then
            if v.Name == "FlareGun" then
                v.Parent = plr.Character
                wait()
                v.Parent = plr.Backpack
                workspace.Events.Projectiles.FlareEvent:FireServer(v.Handle, Vector3.new(flare_sidevar,flare_heightvar,flare_frontbackvar))
            end
        else
            workspace.Events.Projectiles.FlareEvent:FireServer(plr.Character["FlareGun"].Handle, Vector3.new(flare_sidevar,flare_heightvar,flare_frontbackvar))
        end
    end
end,
    {
        animated = true,
    }
)
flare:Create("Button","Give Flare Gun",function()
    game:GetService("Workspace").Events.GamePasses.EquipFlareGun:FireServer()
end,
    {
            animated = true,
    }
)

sec:Create("Toggle","Give Flare Gun on Respawn",function(state)
    flareresp = state
end,
    {
        default = false,
    }
)

sec:Create("Toggle","Give Oxygen Tank on Respawn",function(state)
    oxygenresp = state
end,
    {
        default = false,
    }
)

plr.CharacterAdded:Connect(function(character)
    if flareresp == true then
        game:GetService("Workspace").Events.GamePasses.EquipFlareGun:FireServer()
    end
    if oxygenresp == true then
        workspace.Events.GamePasses.EquipScubaGear:FireServer()
    end
end)

sec:Create("Button","Remove Barrier",function()
    game:GetService("Workspace").StuffSimonHasntFoldered.Barrier:Destroy()
    game:GetService("Workspace")["3rdBarrier"]:Destroy()
    game:GetService("Workspace").IslandBarrier.SmallIslandBarriers:Destroy()

    end,
        {
            animated = true,
        }
    )
sec:Create("Button","Respawn",function()
if respmethod == "0 Health" then
char.Humanoid.Health = 0
elseif respmethod == "Void" then
plr.Character.HumanoidRootPart.CFrame = CFrame.new(934.347351, -5000, 750.938049, -0.998328626, 0.000192540378, 0.0577924959, 8.65171224e-09, 0.999994457, -0.00333141279, -0.0577928163, -0.00332584418, -0.998323083)
end
end,
        {
            animated = true,
        }
    )


    bombtab:Create("Dropdown", "Player Target",
    function(selected)
        selchar = selected
    end,
    {
    playerlist = true
    }
)

bombtab:Create("Slider","Duck Amount",function(value)
    duckbombvar = value
    stored_duck = value
end,
    {
        min = 1,
        max = 1000
    }
)

bombtab:Create("Button","Duck Bomb",function()
duckbomb = true
end,
    {
        animated = true,
    }
)

function duckybomb()
    if duckbombvar ~= 0 and duckbomb == true then
        local subtraction = duckbombvar-1
        duckbombvar = subtraction
        local ohCFrame2 = game.Workspace[selchar].HumanoidRootPart.CFrame
        game:GetService("Players").LocalPlayer.Backpack.RubberRingTool.RubberDuckyCommander.RubberDucky:InvokeServer(nil, ohCFrame2)
else
    duckbombvar = stored_duck
    duckbomb = false
    end
end

game:GetService('RunService').Heartbeat:connect(function()
duckybomb()
end)

bombtab:Create("Slider","Flare Amount",function(value)
    flarebombvar = value
    stored_flare = value
end,
    {
        min = 50,
        max = 10000,
        default = 50,
    }
)

bombtab:Create("Button","Flare Bomb",function()
    flarebomb = true
    previous_pos = plr.Character.HumanoidRootPart.CFrame
    end,
        {
            animated = true,
        }
    )
    
function flarebomber() --hahha like the unibomber!!!!
        if flarebombvar ~= 0 and flarebomb == true then
            local subtraction2 = flarebombvar-1
            flarebombvar = subtraction2
            local cframetarget = game.Workspace[selchar].HumanoidRootPart.CFrame+Vector3.new(0,50,0)
            game:GetService("Workspace")[plr.Name]["HumanoidRootPart"].CFrame = cframetarget
            workspace.Events.Projectiles.FlareEvent:FireServer(plr.Character["FlareGun"].Handle, Vector3.new(0,0,0))
    else
        flarebombvar = stored_flare
        flarebomb = false
        end
    end
    
    game:GetService('RunService').Heartbeat:connect(function()
    flarebomber()
    end)

bombtab:Create("Button","View Player",function()
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
