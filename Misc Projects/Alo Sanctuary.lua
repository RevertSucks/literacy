for i,v in pairs(game:GetService("Workspace").Map.Orbs:GetChildren()) do
    wait(.2)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Part.CFrame
end

for i,v in pairs(game:GetService("Workspace").YogaPoseStations:GetChildren()) do
    wait(.5)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
end
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockMat:FireServer("Black")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockMat:FireServer("Pink")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockMat:FireServer("Yellow")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockMat:FireServer("LightGreen")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockMat:FireServer("DarkGreen")

local ohTable1 = {
	["pose"] = "TreePose",
	["length"] = 1
}

game:GetService("ReplicatedStorage").NetManagedInstances.BeginMeditation:FireServer(ohTable1)
wait(.1)
game:GetService("ReplicatedStorage").NetManagedInstances.FinishMeditation:FireServer()

game.Playesr.LocalPlayer:Kick("If you didnt get the hat re-execute")
