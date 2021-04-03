while true do
wait(0.01)
local Items = workspace.Truck:GetDescendants()
for _, item in pairs(Items) do
    if not item:IsA("ParticleEmitter") and item.ClassName:find("Part") or item.ClassName:find("Union")  then
        local args = {
            [1] = item,
            [2] = game:GetService("Players").LocalPlayer
        }

        game:GetService("ReplicatedStorage").Events.Network.SetNetworkOwnership:FireServer(unpack(args))

        item.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
      end
   end
end
