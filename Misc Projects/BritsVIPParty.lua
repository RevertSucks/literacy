--collects all coins
local meshes = {}
local collectlimit = 25 --math.huge for inf

for i,v in pairs(Workspace:GetChildren()) do
   if v:IsA("MeshPart") then
        table.insert(meshes, v.Name)
   end
end

for i,v in pairs(meshes) do
wait(.1)
    if i < collectlimit then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace[v].CFrame
        table.remove(meshes, i)
        print(i)
    else
        break
    end
end

--collects all text
for i,v in pairs(game:GetService("Workspace").PantheressText:GetChildren()) do
    wait(.1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame 
end
