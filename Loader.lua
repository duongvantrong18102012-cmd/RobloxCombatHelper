-- ===== LOADER.LUA =====
local CombatHub = {}

local function LoadModule(path)
    local url = "https://raw.githubusercontent.com/duongvantrong18102012-cmd/RobloxCombatHub/main/" .. path
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then
        warn("⚠️ Lỗi tải module: " .. path .. "\n" .. result)
        return {}
    end
    return result
end

print("🔄 Đang tải Combat Hub Pro...")

-- Core
CombatHub.Config = LoadModule("Config.lua")
CombatHub.Utils = LoadModule("Core/Utils.lua")
CombatHub.Events = LoadModule("Core/Events.lua")

-- Modules (giữ nguyên)
CombatHub.ESP_Base = LoadModule("Modules/ESP/Base.lua")
CombatHub.ESP_Advanced = LoadModule("Modules/ESP/Advanced.lua")
CombatHub.Aimbot_Base = LoadModule("Modules/Aimbot/Base.lua")
CombatHub.Aimbot_Silent = LoadModule("Modules/Aimbot/Silent.lua")
CombatHub.Aimbot_Triggerbot = LoadModule("Modules/Aimbot/Triggerbot.lua")
CombatHub.Hitbox_Base = LoadModule("Modules/Hitbox/Base.lua")
CombatHub.AutoShoot = LoadModule("Modules/Combat/AutoShoot.lua")
CombatHub.AntiFlash = LoadModule("Modules/Combat/AntiFlash.lua")

-- GUI mới
CombatHub.Theme = LoadModule("GUI/Theme.lua")
CombatHub.Animations = LoadModule("GUI/Animations.lua")
CombatHub.Components = LoadModule("GUI/Components.lua")
CombatHub.MainGUI = LoadModule("GUI/MainGUI.lua")
CombatHub.ESPTab = LoadModule("GUI/ESPTab.lua")
CombatHub.AimbotTab = LoadModule("GUI/AimbotTab.lua")
CombatHub.HitboxTab = LoadModule("GUI/HitboxTab.lua")
CombatHub.SettingsTab = LoadModule("GUI/SettingsTab.lua")

-- Data
CombatHub.Colors = LoadModule("Data/Colors.lua")
CombatHub.Keybinds = LoadModule("Data/Keybinds.lua")

print("✅ Tất cả module đã tải. Khởi tạo GUI...")
CombatHub.MainGUI:Create(CombatHub)

print("🚀 Combat Hub Pro sẵn sàng!")
return CombatHub
