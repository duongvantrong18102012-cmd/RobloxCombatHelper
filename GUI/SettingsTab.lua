-- ===== GUI/SETTINGSTAB.LUA =====
local SettingsTab = {}

function SettingsTab:Create(Hub, parent, colors)
    local y = 10

    -- Theme dropdown
    local themeFrame = Instance.new("Frame")
    themeFrame.Size = UDim2.new(0.9, 0, 0, 30)
    themeFrame.Position = UDim2.new(0.05, 0, 0, y)
    themeFrame.BackgroundTransparency = 1
    themeFrame.Parent = parent

    local themeLbl = Instance.new("TextLabel")
    themeLbl.Size = UDim2.new(0.5, 0, 1, 0)
    themeLbl.Text = "Theme"
    themeLbl.TextColor3 = colors.Text
    themeLbl.TextXAlignment = Enum.TextXAlignment.Left
    themeLbl.BackgroundTransparency = 1
    themeLbl.Font = Hub.Theme:GetFont()
    themeLbl.TextSize = 14
    themeLbl.Parent = themeFrame

    local themeDropdown = Instance.new("TextButton")
    themeDropdown.Size = UDim2.new(0.4, 0, 0.8, 0)
    themeDropdown.Position = UDim2.new(0.55, 0, 0.1, 0)
    themeDropdown.Text = Hub.Config.Theme or "Dark"
    themeDropdown.TextColor3 = colors.Text
    themeDropdown.BackgroundColor3 = colors.BackgroundAlt
    themeDropdown.BorderSizePixel = 0
    themeDropdown.Font = Hub.Theme:GetFont()
    themeDropdown.TextSize = 13
    themeDropdown.Parent = themeFrame

    local themeOptions = {"Dark", "Light"}
    local themeList = Instance.new("Frame")
    themeList.Size = UDim2.new(0.4, 0, 0, 0)
    themeList.Position = UDim2.new(0.55, 0, 1.1, 0)
    themeList.BackgroundColor3 = colors.BackgroundAlt
    themeList.BorderSizePixel = 0
    themeList.ClipsDescendants = true
    themeList.Parent = themeFrame

    for _, opt in ipairs(themeOptions) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 25)
        btn.Text = opt
        btn.TextColor3 = colors.Text
        btn.BackgroundColor3 = colors.Background
        btn.BorderSizePixel = 0
        btn.Font = Hub.Theme:GetFont()
        btn.TextSize = 13
        btn.Parent = themeList
        btn.MouseButton1Click:Connect(function()
            Hub.Config.Theme = opt
            themeDropdown.Text = opt
            themeList.Size = UDim2.new(0.4, 0, 0, 0)
            -- Yêu cầu reload GUI (có thể làm phức tạp hơn)
            print("🔁 Đã đổi theme thành " .. opt .. ". Vui lòng khởi động lại GUI để áp dụng.")
        end)
    end

    themeDropdown.MouseButton1Click:Connect(function()
        local visible = themeList.Size.Y.Offset > 0
        local targetHeight = visible and 0 or #themeOptions * 27
        game:GetService("TweenService"):Create(themeList, TweenInfo.new(0.3), {Size = UDim2.new(0.4, 0, 0, targetHeight)}):Play()
    end)

    y = y + 40

    -- Transparency slider
    local transFrame = Instance.new("Frame")
    transFrame.Size = UDim2.new(0.9, 0, 0, 40)
    transFrame.Position = UDim2.new(0.05, 0, 0, y)
    transFrame.BackgroundTransparency = 1
    transFrame.Parent = parent

    local transLbl = Instance.new("TextLabel")
    transLbl.Size = UDim2.new(0.5, 0, 0.5, 0)
    transLbl.Text = "Transparency: " .. string.format("%.2f", Hub.Config.GUI_Transparency or 0.1)
    transLbl.TextColor3 = colors.Text
    transLbl.TextXAlignment = Enum.TextXAlignment.Left
    transLbl.BackgroundTransparency = 1
    transLbl.Font = Hub.Theme:GetFont()
    transLbl.TextSize = 13
    transLbl.Parent = transFrame

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0.7, 0, 0.2, 0)
    slider.Position = UDim2.new(0, 0, 0.6, 0)
    slider.BackgroundColor3 = colors.BackgroundAlt
    slider.BorderSizePixel = 0
    slider.Parent = transFrame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(Hub.Config.GUI_Transparency or 0.1, 0, 1, 0)
    fill.BackgroundColor3 = colors.Accent
    fill.BorderSizePixel = 0
    fill.Parent = slider

    local drag = Instance.new("TextButton")
    drag.Size = UDim2.new(0, 12, 1.5, 0)
    drag.Position = UDim2.new((Hub.Config.GUI_Transparency or 0.1) - 0.03, 0, -0.25, 0)
    drag.BackgroundColor3 = colors.Text
    drag.BorderSizePixel = 0
    drag.Text = ""
    drag.Parent = slider

    local dragging = false
    drag.MouseButton1Down:Connect(function() dragging = true end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    game:GetService("RunService").RenderStepped:Connect(function()
        if dragging then
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
            local sliderPos = slider.AbsolutePosition
            local sliderSize = slider.AbsoluteSize
            local percent = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
            Hub.Config.GUI_Transparency = percent
            fill.Size = UDim2.new(percent, 0, 1, 0)
            drag.Position = UDim2.new(percent - 0.03, 0, -0.25, 0)
            transLbl.Text = "Transparency: " .. string.format("%.2f", percent)
            -- Cập nhật transparency cho mainFrame (cần tham chiếu)
            local mainFrame = parent.Parent
            if mainFrame then
                mainFrame.BackgroundTransparency = percent
            end
        end
    end)

    y = y + 50

    -- Nút lưu config (giả lập)
    local saveBtn = Instance.new("TextButton")
    saveBtn.Size = UDim2.new(0.4, 0, 0, 30)
    saveBtn.Position = UDim2.new(0.3, 0, 0, y)
    saveBtn.Text = "💾 Lưu Config"
    saveBtn.TextColor3 = colors.Text
    saveBtn.BackgroundColor3 = colors.Accent
    saveBtn.BorderSizePixel = 0
    saveBtn.Font = Hub.Theme:GetFont()
    saveBtn.TextSize = 14
    saveBtn.Parent = parent
    saveBtn.MouseButton1Click:Connect(function()
        print("✅ Config đã được lưu (giả lập).")
        -- Ở đây có thể ghi vào DataStore hoặc file
    end)

    -- Nút reset
    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0.4, 0, 0, 30)
    resetBtn.Position = UDim2.new(0.3, 0, 0, y + 40)
    resetBtn.Text = "🔄 Reset Config"
    resetBtn.TextColor3 = colors.Text
    resetBtn.BackgroundColor3 = colors.Danger
    resetBtn.BorderSizePixel = 0
    resetBtn.Font = Hub.Theme:GetFont()
    resetBtn.TextSize = 14
    resetBtn.Parent = parent
    resetBtn.MouseButton1Click:Connect(function()
        print("🔄 Đã reset config về mặc định.")
        -- Tải lại Config từ file gốc
    end)
end

return SettingsTab
