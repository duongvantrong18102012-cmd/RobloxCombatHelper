-- ===== MODULES/COMBATHELPER.LUA =====
local CombatModule = {}
local isRunning = false

function CombatModule:Start(Hub)
    if isRunning then return end
    isRunning = true
    print("⚔️ Combat Helper đã khởi động")

    -- Khởi động các module con
    Hub.ESP:Start(Hub)
    Hub.Aimbot:Start(Hub)
    Hub.Hitbox:Start(Hub)

    -- Vòng lặp điều khiển chung (có thể thêm logic đồng bộ)
    spawn(function()
        while isRunning do
            wait(1)
        end
    end)
end

function CombatModule:Stop()
    isRunning = false
    print("⚔️ Combat Helper đã tắt")
end

return CombatModule
