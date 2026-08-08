-- ===== GUI/MAINGUI.LUA =====
local MainGUI = {}

function MainGUI:Create(Hub)
    local player = game.Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local title = Instance.new("TextLabel")
    local toggleBtn = Instance.new("TextButton")
    local espBtn = Instance.new("TextButton")
    local aimBtn = Instance.new("TextButton")
    local hitBtn = Instance.new("TextButton")

    screenGui.Parent = player.PlayerGui
    frame.Size = UDim2.new(0, 260, 0, 220)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(20,20,30)
    frame.BackgroundTransparency = 0.2
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui

    title.Size = UDim2.new(1,0,0,30)
    title.BackgroundTransparency = 1
    title.Text = "⚔️ Combat Helper"
    title.TextColor3 = Color3.fromRGB(255,100,100)
    title.Parent = frame

    -- Nút bật/tắt toàn bộ
    local isActive = false
    toggleBtn.Size = UDim2.new(0.9,0,0,30)
    toggleBtn.Position = UDim2.new(0.05,0,0,35)
    toggleBtn.Text = "BẬT TẤT CẢ"
    toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(0,150,0)
    toggleBtn.Parent = frame

    toggleBtn.MouseButton1Click:Connect(function()
        isActive = not isActive
        if isActive then
            toggleBtn.Text = "TẮT TẤT CẢ"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(150,0,0)
            Hub.Combat:Start(Hub)
        else
            toggleBtn.Text = "BẬT TẤT CẢ"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0,150,0)
            Hub.Combat:Stop()
        end
    end)

    -- Nút bật/tắt ESP
    local espActive = true
    espBtn.Size = UDim2.new(0.45,0,0,30)
    espBtn.Position = UDim2.new(0.05,0,0,75)
    espBtn.Text = "👁️ ESP: BẬT"
    espBtn.TextColor3 = Color3.fromRGB(255,255,255)
    espBtn.BackgroundColor3 = Color3.fromRGB(0,150,0)
    espBtn.Parent = frame
    espBtn.MouseButton1Click:Connect(function()
        espActive = not espActive
        Hub.Config.ESP_Enabled = espActive
        espBtn.Text = espActive and "👁️ ESP: BẬT" or "👁️ ESP: TẮT"
        espBtn.BackgroundColor3 = espActive and Color3.fromRGB(0,150,0) or Color3.fromRGB(150,0,0)
        if espActive then Hub.ESP:Start(Hub) else Hub.ESP:Stop() end
    end)

    -- Nút bật/tắt Aimbot
    local aimActive = true
    aimBtn.Size = UDim2.new(0.45,0,0,30)
    aimBtn.Position = UDim2.new(0.5,0,0,75)
    aimBtn.Text = "🎯 Aimbot: BẬT"
    aimBtn.TextColor3 = Color3.fromRGB(255,255,255)
    aimBtn.BackgroundColor3 = Color3.fromRGB(0,150,0)
    aimBtn.Parent = frame
    aimBtn.MouseButton1Click:Connect(function()
        aimActive = not aimActive
        Hub.Config.Aimbot_Enabled = aimActive
        aimBtn.Text = aimActive and "🎯 Aimbot: BẬT" or "🎯 Aimbot: TẮT"
        aimBtn.BackgroundColor3 = aimActive and Color3.fromRGB(0,150,0) or Color3.fromRGB(150,0,0)
        if aimActive then Hub.Aimbot:Start(Hub) else Hub.Aimbot:Stop() end
    end)

    -- Nút bật/tắt Hitbox
    local hitActive = true
    hitBtn.Size = UDim2.new(0.45,0,0,30)
    hitBtn.Position = UDim2.new(0.05,0,0,115)
    hitBtn.Text = "📦 Hitbox: BẬT"
    hitBtn.TextColor3 = Color3.fromRGB(255,255,255)
    hitBtn.BackgroundColor3 = Color3.fromRGB(0,150,0)
    hitBtn.Parent = frame
    hitBtn.MouseButton1Click:Connect(function()
        hitActive = not hitActive
        Hub.Config.Hitbox_Enabled = hitActive
        hitBtn.Text = hitActive and "📦 Hitbox: BẬT" or "📦 Hitbox: TẮT"
        hitBtn.BackgroundColor3 = hitActive and Color3.fromRGB(0,150,0) or Color3.fromRGB(150,0,0)
        if hitActive then Hub.Hitbox:Start(Hub) else Hub.Hitbox:Stop() end
    end)

    -- Nút Reset (khôi phục)
    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0.45,0,0,30)
    resetBtn.Position = UDim2.new(0.5,0,0,115)
    resetBtn.Text = "🔄 Reset"
    resetBtn.TextColor3 = Color3.fromRGB(255,255,255)
    resetBtn.BackgroundColor3 = Color3.fromRGB(200,100,0)
    resetBtn.Parent = frame
    resetBtn.MouseButton1Click:Connect(function()
        Hub.Hitbox:Stop()
        Hub.ESP:Stop()
        Hub.Aimbot:Stop()
        print("🔄 Đã reset toàn bộ")
    end)

    print("✅ GUI Combat Helper đã tạo.")
end

return MainGUI
