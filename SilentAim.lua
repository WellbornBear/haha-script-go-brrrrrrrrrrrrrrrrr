if getgenv().ResetMetatableNamecall then
    getgenv().ResetMetatableNamecall()
end

local Workspace = game:GetService("Workspace")
local PlayerService = game:GetService("Players")

local Player = PlayerService.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character.HumanoidRootPart

local ZombieStorage = Workspace:WaitForChild("Zombie Storage")
local EquipStorage = Player:WaitForChild("EquipStorage")

local function GetClosestZombie() [nonamecall]
    local MagnitudeDistance = math.huge
    local ClosestZombie
    local Magnitude

    for _, Zombie in pairs(ZombieStorage:GetChildren()) do
        if Zombie:FindFirstChild("HumanoidRootPart") and Zombie:FindFirstChild("Humanoid") then
            if Zombie.Humanoid.Health > 0 then
                Magnitude = (HumanoidRootPart.Position - Zombie.HumanoidRootPart.Position).Magnitude
                if Magnitude < MagnitudeDistance then
                    MagnitudeDistance = Magnitude
                    ClosestZombie = Zombie
                end
            end
        end
    end
    return ClosestZombie
end

local function Execute()
    local Metatable = getrawmetatable(game)
    local OldNamecall = Metatable.__namecall

    setreadonly(Metatable, false)

    Metatable.__namecall = newcclosure(function(self, ...) [nonamecall]
        local Arguments = {...}
        if not checkcaller() and getnamecallmethod() == 'FireServer' and self.Name == 'WeaponEvent' then
            if Character:FindFirstChildWhichIsA("Tool") then
                local ClosestZombie = GetClosestZombie()
                local Weapon = Character:FindFirstChildWhichIsA("Tool")
                if ClosestZombie and ClosestZombie:FindFirstChild("Humanoid") and Weapon then
                    Arguments[1]["HumanoidTables"] = {
                        [1] = {
                            ["HeadHits"] = Weapon.Configuration.Burst.Value,
                            ["THumanoid"] = GetClosestZombie().Humanoid,
                            ["BodyHits"] = 0
                        }
                    }
                end
            end
        end

        return OldNamecall(self, unpack(Arguments))
    end)
    
    getgenv().ResetMetatableNamecall = function()
        Metatable.__namecall = OldNamecall
        setreadonly(Metatable, true)
    end
end

Execute()

warn("Script by: WellbornBear, OrangeSteak")
warn("Join discord: discord.gg/Ak7MGDEsfu")
setclipboard("discord.gg/Ak7MGDEsfu")

-- im gonna eat you if you change credits
