-- ===== CONFIG.LUA =====
local Config = {
    -- ESP
    ESP_Enabled = true,
    ESP_ShowBox = true,          -- Vẽ khung
    ESP_ShowName = true,         -- Hiển thị tên
    ESP_ShowHealth = true,       -- Hiển thị thanh máu
    ESP_ShowDistance = true,     -- Hiển thị khoảng cách
    ESP_ShowPlayers = true,      -- Bật ESP cho Player
    ESP_ShowNPCs = true,         -- Bật ESP cho NPC
    ESP_TeamColor = true,        -- Màu theo team (Player) / Đỏ cho NPC

    -- Aimbot
    Aimbot_Enabled = true,
    Aimbot_TargetPlayers = true,
    Aimbot_TargetNPCs = true,
    Aimbot_FOV = 120,            -- Góc nhìn tối đa để ngắm (độ)
    Aimbot_Smoothness = 0.3,     -- Độ mượt (0 = tức thời, 1 = chậm)
    Aimbot_AimPart = "Head",     -- "Head" hoặc "HumanoidRootPart"

    -- Hitbox
    Hitbox_Enabled = true,
    Hitbox_Expand = 2.5,         -- Hệ số mở rộng (1 = bình thường, 2 = gấp đôi)
    Hitbox_IncludePlayers = true,
    Hitbox_IncludeNPCs = true,
}

return Config
