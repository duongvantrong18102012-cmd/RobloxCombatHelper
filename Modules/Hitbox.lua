-- ===== MODULES/HITBOX.LUA =====
local HitboxModule = {}
local isRunning = false
local originalSizes = {} -- Lưu kích thước ban đầu

function HitboxModule:Start(Hub)
    if isRunning then return end
    isRunning = true
    print("📦 Hitbox đã khởi động")

    local function ExpandHitbox(char)
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end

        if not originalSizes[char] then
            originalSizes[char] = rootPart.Size
        end

        local expand = Hub.Config.Hitbox_Expand
        if expand > 1 then
            local newSize = originalSizes[char] * expand
            rootPart.Size = newSize
        end
    end

    spawn(function()
        while isRunning do
            if Hub.Config.Hitbox_Enabled then
                local targets = {}
                if Hub.Config.Hitbox_IncludePlayers then
                    for _, char in ipairs(Hub.Helpers:GetAllPlayers()) do
                        table.insert(targets, char)
                    end
                end
                if Hub.Config.Hitbox_IncludeNPCs then
                    for _, npc in ipairs(Hub.Helpers:GetAllNPCs()) do
                        table.insert(targets, npc)
                    end
                end

                for _, char in ipairs(targets) do
                    ExpandHitbox(char)
                end
            end
            wait(0.5) -- Cập nhật định kỳ
        end
    end)

    function HitboxModule:Stop()
        isRunning = false
        -- Khôi phục kích thước ban đầu
        for char, size in pairs(originalSizes) do
            local rootPart = char:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.Size = size
            end
        end
        originalSizes = {}
        print("📦 Hitbox đã tắt, đã khôi phục kích thước ban đầu")
    end
end

return HitboxModule
