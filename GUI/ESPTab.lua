-- ===== GUI/ESPTAB.LUA =====
local ESPTab = {}

function ESPTab:Create(Hub, parent, colors)
    local y = 10

    -- Hàm tạo toggle
    local function AddToggle(label, configKey)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.9, 0, 0, 30)
        frame.Position = UDim2.new(0.05, 0, 0, y)
        frame.BackgroundTransparency = 1
        frame.Parent = parent

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.7, 0, 1, 0)
        lbl.Text = label
        lbl.TextColor3 = colors.Text
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.BackgroundTransparency = 1
        lbl.Font = Hub.Theme:GetFont()
        lbl.TextSize = 14
        lbl.Parent = frame

        local toggle = Instance.new("TextButton")
        toggle.Size = UDim2.new(0.2, 0, 0.8, 0)
        toggle.Position = UDim2.new(0.78, 0, 0.1, 0)
        toggle.Text = ""
        toggle.BackgroundColor3 = Hub.Config[configKey] and Color3.fromRGB(0,200,0) or Color3.fromRGB(100,100,100)
        toggle.BorderSizePixel = 0
        toggle.Parent = frame

        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0.4, 0, 0.8, 0)
        dot.Position = Hub.Config[configKey] and UDim2.new(0.55, 0, 0.1, 0) or UDim2.new(0.05, 0, 0.1, 0)
        dot.BackgroundColor3 = colors.Text
        dot.BorderSizePixel = 0
        dot.Parent = toggle

        toggle.MouseButton1Click:Connect(function()
            Hub.Config[configKey] = not Hub.Config[configKey]
            toggle.BackgroundColor3 = Hub.Config[configKey] and Color3.fromRGB(0,200,0) or Color3.fromRGB(100,100,100)
            local targetPos = Hub.Config[configKey] and UDim2.new(0.55, 0, 0.1, 0) or UDim2.new(0.05, 0, 0.1, 0)
            game:GetService("TweenService"):Create(dot, TweenInfo.new(0.2), {Position = targetPos}):Play()
        end)

        y = y + 35
        return toggle
    end

    -- Thêm các toggle
    AddToggle("ESP Enabled", "ESP_Enabled")
    AddToggle("Show Box", "ESP_ShowBox")
    AddToggle("Show Name", "ESP_ShowName")
    AddToggle("Show Health", "ESP_ShowHealth")
    AddToggle("Show Distance", "ESP_ShowDistance")
    AddToggle("Show Snaplines", "ESP_ShowSnaplines")
    AddToggle("Show Chams", "ESP_ShowChams")
    AddToggle("Team Color", "ESP_TeamColor")
end

return ESPTab
