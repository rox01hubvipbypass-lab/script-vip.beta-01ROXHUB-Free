local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local PlatformActive = true
local activePlatforms = {}

local function spawnPlatforms()
    task.spawn(function()
        while PlatformActive do
            task.wait(0.05)
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                local hum = char.Humanoid
                if hum.MoveDirection.Magnitude > 0 or char.HumanoidRootPart.AssemblyLinearVelocity.Y ~= 0 then
                    local platform = Instance.new("Part")
                    platform.Size = Vector3.new(6, 0.6, 6)
                    platform.Anchored = true
                    platform.CanCollide = true
                    platform.Color = Color3.fromRGB(5, 5, 5) -- Negro casi puro
                    platform.Material = Enum.Material.Neon -- Brillo neón
                    platform.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, -3.3, 0)
                    platform.Parent = workspace
                    
                    table.insert(activePlatforms, platform)
                    if #activePlatforms > 3 then
                        local oldPlatform = table.remove(activePlatforms, 1)
                        if oldPlatform then oldPlatform:Destroy() end
                    end
                end
            end
        end
    end)
end

-- Iniciar automáticamente
spawnPlatforms()
print("✅ Plataformas negras neón activadas")
