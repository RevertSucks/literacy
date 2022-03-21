--idk why i made this but yeah look at the very bottom for how yo use



local pos = 25
local yuh = -1
local neg = -25

local ohCFrame2 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
local ohNumber3 = 1
local ohString4 = ""
function generate(current)
repeat 
    yuh = yuh+1
    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(25,current,yuh), ohCFrame2, ohNumber3, ohString4)
until yuh == pos
yuh = 0 
repeat 
    yuh = yuh-1
    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(25,current,yuh), ohCFrame2, ohNumber3, ohString4)
until yuh == neg
--right side ^
yuh = -1
repeat 
    yuh = yuh+1
    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(-25,current,yuh), ohCFrame2, ohNumber3, ohString4)
until yuh == pos
yuh = 0 
repeat 
    yuh = yuh-1
    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(-25,current,yuh), ohCFrame2, ohNumber3, ohString4)
until yuh == neg
--left side ^
yuh = -1
repeat 
    yuh = yuh+1
    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(yuh,current,25), ohCFrame2, ohNumber3, ohString4)
until yuh == pos
yuh = 0 
repeat 
    yuh = yuh-1
    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(yuh,current,25), ohCFrame2, ohNumber3, ohString4)
until yuh == neg
--back side ^
yuh = -1
repeat 
    yuh = yuh+1
    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(yuh,current,-25), ohCFrame2, ohNumber3, ohString4)
until yuh == pos
yuh = 0 
repeat 
    yuh = yuh-1
    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(yuh,current,-25), ohCFrame2, ohNumber3, ohString4)
until yuh == neg
--top side ^
yuh = -1
repeat 
    yuh = yuh+1
    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(yuh,current,yuh), ohCFrame2, ohNumber3, ohString4)
until yuh == pos
yuh = 0 
repeat 
    yuh = yuh-1
    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(yuh,current,-yuh), ohCFrame2, ohNumber3, ohString4)
until yuh == neg
yuh = 0 
repeat 
    yuh = yuh-1
    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(-yuh,current,yuh), ohCFrame2, ohNumber3, ohString4)
until yuh == neg
yuh = 0
repeat 
    yuh = yuh+1
    game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(-yuh,current,-yuh), ohCFrame2, ohNumber3, ohString4)
until yuh == pos
--midle cross ^
end
function generatepillar(topheight)
    local currentnum = 0
    repeat
        currentnum = currentnum+1
        game:GetService("ReplicatedStorage").Remotes.PlaceBIockRegion:InvokeServer(Vector3.new(0,currentnum,0), ohCFrame2, ohNumber3, ohString4)
    until currentnum == topheight
end


generatepillar(39)--creates a pillar at the middle of your plot with the height being the number you provided (39 is height limit)
wait(5)
generate(2)--creates a box w/ a x in it at desired height

--keep in mind running these 2 fast will result in a kick so wait until one ends to do another
