--[[
game link: https://www.roblox.com/games/8656125900/Brits-VIP-Party-ft-PinkPantheress
]]--

--collects all coins
for i,v in pairs(Workspace:GetChildren()) do
    if v.Name == "Coin" then
        wait(.1)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame 
    end
end

--collects all text
for i,v in pairs(game:GetService("Workspace").PantheressText:GetChildren()) do
    wait(.1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame 
end
