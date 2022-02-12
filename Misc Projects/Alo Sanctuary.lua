for i,v in pairs(Workspace.Map.Orbs:GetChildren()) do
    game:GetService("ReplicatedStorage").NetManagedInstances.orbCollection:FireServer(tostring(v))
end
--collects orbs

game:GetService("ReplicatedStorage").NetManagedInstances.UnlockPose:FireServer("WarriorI")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockPose:FireServer("WarriorII")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockPose:FireServer("TreePose")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockPose:FireServer("MountainPose")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockPose:FireServer("LotusPose")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockPose:FireServer("HighLunge")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockPose:FireServer("TrianglePose")
--collects poses


game:GetService("ReplicatedStorage").NetManagedInstances.UnlockMat:FireServer("Black")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockMat:FireServer("Pink")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockMat:FireServer("Yellow")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockMat:FireServer("LightGreen")
game:GetService("ReplicatedStorage").NetManagedInstances.UnlockMat:FireServer("DarkGreen")
--collects mats

local ohTable1 = {
	["pose"] = "TreePose",
	["length"] = 1
}

game:GetService("ReplicatedStorage").NetManagedInstances.BeginMeditation:FireServer(ohTable1)
wait(.1)
game:GetService("ReplicatedStorage").NetManagedInstances.FinishMeditation:FireServer()
