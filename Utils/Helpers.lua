-- ===== UTILS/HELPERS.LUA =====
local Helpers = {}

-- Lấy người chơi địa phương
function Helpers:GetPlayer()
    return game.Players.LocalPlayer
end

-- Lấy nhân vật người chơi
function Helpers:GetCharacter()
    local player = self:GetPlayer()
    return player.Character or player.CharacterAdded:Wait()
end

-- Lấy HumanoidRootPart
function Helpers:GetRootPart()
    local char = self:GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- Lấy Camera hiện tại
function Helpers:GetCamera()
    return workspace.CurrentCamera
end

-- Kiểm tra NPC (có Humanoid nhưng không phải người chơi)
function Helpers:IsNPC(obj)
    return obj:FindFirstChild("Humanoid") and not obj:FindFirstChild("PlayerGui")
end

-- Lấy tất cả NPC trong workspace
function Helpers:GetAllNPCs()
    local npcs = {}
    for _, obj in pairs(workspace:GetChildren()) do
        if self:IsNPC(obj) then
            table.insert(npcs, obj)
        end
    end
    return npcs
end

-- Lấy tất cả Player (có Character)
function Helpers:GetAllPlayers()
    local players = {}
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= self:GetPlayer() then
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                table.insert(players, char)
            end
        end
    end
    return players
end

-- Lấy các mục tiêu (Player + NPC)
function Helpers:GetAllTargets()
    local targets = {}
    if self.Config.ESP_ShowPlayers then
        for _, char in ipairs(self:GetAllPlayers()) do
            table.insert(targets, char)
        end
    end
    if self.Config.ESP_ShowNPCs then
        for _, npc in ipairs(self:GetAllNPCs()) do
            table.insert(targets, npc)
        end
    end
    return targets
end

return Helpers
