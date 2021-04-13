local me = game.Players.LocalPlayer
function closest() [nonamecall]
   local md = math.huge
   local closestplayer
   for i,v in next, game:GetService("Workspace").enemies:GetChildren() do
       if v:FindFirstChild("HumanoidRootPart") then
           mag = (me.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
           if mag < md then
               md = mag
               closestplayer = v
           end
       end
   end
   return closestplayer
end

local me = game.Players.LocalPlayer
function closest_boss() [nonamecall]
   local md = math.huge
   local closestplayer
   for i,v in next, game:GetService("Workspace").BossFolder:GetChildren() do
       if v:FindFirstChild("HumanoidRootPart") then
           mag = (me.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
           if mag < md then
               md = mag
               closestplayer = v
           end
       end
   end
   return closestplayer
end

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...) [nonamecall]
   local args = {...}
   if not checkcaller() and getnamecallmethod() == 'FireServer' and self.Name == 'Gun' then
        if #game:GetService("Workspace").BossFolder:GetChildren() > 0 then
            args[1]["Hit"] = closest_boss().Head
        else
            args[1]["Hit"] = closest().Head
        end
   end
   return old(self, unpack(args))
end)

getgenv().RSDSXX = function()
    mt.__namecall = old
end

warn("Script by: WellbornBear, YouAreExploit000")
warn("Join discord: discord.gg/Ak7MGDEsfu")
setclipboard("discord.gg/Ak7MGDEsfu")

-- im gonna eat you if you change the credits