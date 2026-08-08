-- ===== CONFIG.LUA =====
local Config = {
    -- ESP
    ESP_Enabled = true,
    ESP_ShowBox = true,
    ESP_ShowName = true,
    ESP_ShowHealth = true,
    ESP_ShowDistance = true,
    ESP_ShowSnaplines = false,
    ESP_ShowChams = false,
    ESP_TeamColor = true,

    -- Aimbot
    Aimbot_Enabled = true,
    Aimbot_Mode = "Normal",   -- "Normal", "Silent", "Triggerbot"
    Aimbot_TargetPlayers = true,
    Aimbot_TargetNPCs = true,
    Aimbot_AimPart = "Head",
    Aimbot_FOV = 120,
    Aimbot_Smoothness = 0.3,
    Aimbot_VisibleCheck = true,
    Aimbot_Prediction = true,
    Aimbot_TriggerbotDelay = 0.1,

    -- Hitbox
    Hitbox_Enabled = true,
    Hitbox_Expand = 2.5,
    Hitbox_IncludePlayers = true,
    Hitbox_IncludeNPCs = true,
    Hitbox_ExpandHead = 2.0,
    Hitbox_ExpandTorso = 2.5,

    -- Combat
    AutoShoot_Enabled = false,
    AutoShoot_Delay = 0.2,
    AntiAFK_Enabled = false,
    AntiFlash_Enabled = false,

    -- GUI Settings (mới)
    Theme = "Dark",           -- "Dark" hoặc "Light"
    GUI_Transparency = 0.1,
    GUI_Color = Color3.fromRGB(30, 30, 50),
    Accent_Color = Color3.fromRGB(0, 150, 255),
    Font = Enum.Font.Gotham,
    Animation_Speed = 0.3,
}

return Config
