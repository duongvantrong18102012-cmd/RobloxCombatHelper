-- ===== LOADER.LUA =====
local CombatHelper = {}

local function LoadModule(path)
    local url = "https://raw.githubusercontent.com/duongvantrong18102012-cmd/RobloxCombatHelper/main/" .. path
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then
        warn("⚠️ Lỗi tải module: " .. path .. "\n" .. result)
        return {}
    end
    return result
end

print("🔄 Đang tải Combat Helper...")

CombatHelper.Config = LoadModule("Config.lua")
CombatHelper.Helpers = LoadModule("Utils/Helpers.lua")
CombatHelper.ESP = LoadModule("Modules/ESP.lua")
CombatHelper.Aimbot = LoadModule("Modules/Aimbot.lua")
CombatHelper.Hitbox = LoadModule("Modules/Hitbox.lua")
CombatHelper.Combat = LoadModule("Modules/CombatHelper.lua")
CombatHelper.GUI = LoadModule("GUI/MainGUI.lua")

print("✅ Đã tải xong. Khởi tạo GUI...")
CombatHelper.GUI:Create(CombatHelper)

print("🚀 Combat Helper sẵn sàng!")
return CombatHelper
