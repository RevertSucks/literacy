--basic esp using kiriot library :), wont work on games that dont use the basic humanoid (i think)
local esp = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()

for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "ESP" then
        v:Destroy()
    end
end

local main = library:CreateMain({
	projName = "ESP",
	Resizable = true,
	MinSize = UDim2.new(0,400,0,400),
	MaxSize = UDim2.new(0,750,0,500),
})
 
local category = main:CreateCategory("Main")
local section = category:CreateSection("ESP")

section:Create("Toggle","Toggle",function(state)
    esp:Toggle(state)
end,
    {
        default = false,
    }
)
section:Create("Toggle","Name",function(state)
    esp.Names = state
end,
    {
        default = true,
    }
)
section:Create("Toggle","Boxes",function(state)
    esp.Boxes = state
end,
    {
        default = true,
    }
)
section:Create("Toggle","Tracers",function(state)
    esp.Tracers = state
end,
    {
        default = false,
    }
)
section:Create("Toggle","Team Color",function(state)
    esp.TeamColor = state
end,
    {
        default = true,
    }
)
section:Create("Toggle","ESP Faces Camera",function(state)
    esp.FaceCamera = state
end,
    {
        default = false,
    }
)
