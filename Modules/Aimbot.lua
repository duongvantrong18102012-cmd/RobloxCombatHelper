-- ===== MODULES/AIMBOT.LUA =====
local AimbotModule = {}
local isRunning = false

function AimbotModule:Start(Hub)
    if isRunning then return end
    isRunning = true
    print("🎯 Aimbot đã khởi động")

    local function GetClosestTarget()
        local camera = Hub.Helpers:GetCamera()
        local rootPart = Hub.Helpers:GetRootPart()
        if not rootPart or not camera then return end

        local targets = {}
        if Hub.Config.Aimbot_TargetPlayers then
            for _, char in ipairs(Hub.Helpers:GetAllPlayers()) do
                table.insert(targets, char)
            end
        end
        if Hub.Config.Aimbot_TargetNPCs then
            for _, npc in ipairs(Hub.Helpers:GetAllNPCs()) do
                table.insert(targets, npc)
            end
        end

        local closest = nil
        local bestAngle = Hub.Config.Aimbot_FOV

        for _, target in ipairs(targets) do
            local aimPart = target:FindFirstChild(Hub.Config.Aimbot_AimPart) or target:FindFirstChild("HumanoidRootPart")
            if aimPart then
                local pos, onScreen = camera:WorldToScreenPoint(aimPart.Position)
                if onScreen then
                    local center = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
                    local angle = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if angle < bestAngle then
                        bestAngle = angle
                        closest = target
                    end
                end
            end
        end
        return closest
    end

    spawn(function()
        while isRunning do
            if Hub.Config.Aimbot_Enabled then
                local target = GetClosestTarget()
                if target then
                    local aimPart = target:FindFirstChild(Hub.Config.Aimbot_AimPart) or target:FindFirstChild("HumanoidRootPart")
                    if aimPart then
                        local camera = Hub.Helpers:GetCamera()
                        local rootPart = Hub.Helpers:GetRootPart()
                        if camera and rootPart then
                            -- Tính toán góc ngắm
                            local targetPos = aimPart.Position
                            local lookVector = (targetPos - camera.CFrame.Position).Unit
                            local newCFrame = CFrame.lookAt(camera.CFrame.Position, targetPos)
                            
                            -- Làm mượt
                            local smooth = Hub.Config.Aimbot_Smoothness
                            if smooth > 0 then
                                local currentCF = camera.CFrame
                                local lerpedCF = currentCF:Lerp(newCFrame, smooth)
                                camera.CFrame = lerpedCF
                            else
                                camera.CFrame = newCFrame
                            end
                        end
                    end
                end
            end
            wait()
        end
    end)

    function AimbotModule:Stop()
        isRunning = false
        print("🎯 Aimbot đã tắt")
    end
end

return AimbotModule
