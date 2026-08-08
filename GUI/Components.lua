-- ===== GUI/COMPONENTS.LUA =====
local Components = {}

-- Tạo một nút với hiệu ứng hover
function Components:CreateButton(parent, text, position, size, callback, colors)
    local btn = Instance.new("TextButton")
    btn.Size = size or UDim2.new(0.8, 0, 0, 30)
    btn.Position = position or UDim2.new(0.1, 0, 0, 0)
    btn.Text = text or "Button"
    btn.TextColor3 = colors and colors.Text or Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = colors and colors.Background or Color3.fromRGB(60,60,80)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = parent

    -- Hover effect
    local hoverColor = colors and colors.Hover or Color3.fromRGB(80,80,120)
    local normalColor = btn.BackgroundColor3
    btn.MouseEnter:Connect(function()
        local tween = game:GetService("TweenService"):Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor})
        tween:Play()
    end)
    btn.MouseLeave:Connect(function()
        local tween = game:GetService("TweenService"):Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = normalColor})
        tween:Play()
    end)

    btn.MouseButton1Click:Connect(callback or function() end)
    return btn
end

-- Tạo toggle switch
function Components:CreateToggle(parent, label, configKey, configTable, position, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 30)
    frame.Position = position or UDim2.new(0.05, 0, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0.2, 0, 0.8, 0)
    toggleBtn.Position = UDim2.new(0.78, 0, 0.1, 0)
    toggleBtn.Text = ""
    toggleBtn.BackgroundColor3 = configTable[configKey] and Color3.fromRGB(0,200,0) or Color3.fromRGB(100,100,100)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = frame

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0.4, 0, 0.8, 0)
    dot.Position = configTable[configKey] and UDim2.new(0.55, 0, 0.1, 0) or UDim2.new(0.05, 0, 0.1, 0)
    dot.BackgroundColor3 = Color3.fromRGB(255,255,255)
    dot.BorderSizePixel = 0
    dot.Parent = toggleBtn

    toggleBtn.MouseButton1Click:Connect(function()
        configTable[configKey] = not configTable[configKey]
        toggleBtn.BackgroundColor3 = configTable[configKey] and Color3.fromRGB(0,200,0) or Color3.fromRGB(100,100,100)
        local targetPos = configTable[configKey] and UDim2.new(0.55, 0, 0.1, 0) or UDim2.new(0.05, 0, 0.1, 0)
        game:GetService("TweenService"):Create(dot, TweenInfo.new(0.2), {Position = targetPos}):Play()
        if callback then callback(configTable[configKey]) end
    end)

    return toggleBtn
end

-- Tạo slider (thanh trượt)
function Components:CreateSlider(parent, label, configKey, configTable, min, max, position, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 40)
    frame.Position = position or UDim2.new(0.05, 0, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5, 0, 0.5, 0)
    lbl.Text = label .. ": " .. tostring(configTable[configKey])
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.Parent = frame

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0.7, 0, 0.2, 0)
    slider.Position = UDim2.new(0, 0, 0.6, 0)
    slider.BackgroundColor3 = Color3.fromRGB(50,50,70)
    slider.BorderSizePixel = 0
    slider.Parent = frame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((configTable[configKey] - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0,150,255)
    fill.BorderSizePixel = 0
    fill.Parent = slider

    local drag = Instance.new("TextButton")
    drag.Size = UDim2.new(0, 12, 1.5, 0)
    drag.Position = UDim2.new((configTable[configKey] - min) / (max - min) - 0.03, 0, -0.25, 0)
    drag.BackgroundColor3 = Color3.fromRGB(255,255,255)
    drag.BorderSizePixel = 0
    drag.Text = ""
    drag.Parent = slider

    local dragging = false
    drag.MouseButton1Down:Connect(function()
        dragging = true
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    game:GetService("RunService").RenderStepped:Connect(function()
        if dragging then
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
            local sliderPos = slider.AbsolutePosition
            local sliderSize = slider.AbsoluteSize
            local percent = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
            local value = min + (max - min) * percent
            configTable[configKey] = value
            fill.Size = UDim2.new(percent, 0, 1, 0)
            drag.Position = UDim2.new(percent - 0.03, 0, -0.25, 0)
            lbl.Text = label .. ": " .. string.format("%.1f", value)
            if callback then callback(value) end
        end
    end)

    return slider
end

-- Tạo dropdown
function Components:CreateDropdown(parent, label, options, configKey, configTable, position, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 30)
    frame.Position = position or UDim2.new(0.05, 0, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5, 0, 1, 0)
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.Parent = frame

    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0.4, 0, 0.8, 0)
    dropdown.Position = UDim2.new(0.55, 0, 0.1, 0)
    dropdown.Text = configTable[configKey] or options[1]
    dropdown.TextColor3 = Color3.fromRGB(255,255,255)
    dropdown.BackgroundColor3 = Color3.fromRGB(50,50,70)
    dropdown.BorderSizePixel = 0
    dropdown.Font = Enum.Font.Gotham
    dropdown.TextSize = 13
    dropdown.Parent = frame

    local listVisible = false
    local listFrame = Instance.new("Frame")
    listFrame.Size = UDim2.new(0.4, 0, 0, 0)
    listFrame.Position = UDim2.new(0.55, 0, 1.1, 0)
    listFrame.BackgroundColor3 = Color3.fromRGB(40,40,60)
    listFrame.BorderSizePixel = 0
    listFrame.ClipsDescendants = true
    listFrame.Parent = frame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = listFrame

    for _, opt in ipairs(options) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 25)
        btn.Text = opt
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.BackgroundColor3 = Color3.fromRGB(50,50,70)
        btn.BorderSizePixel = 0
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 13
        btn.Parent = listFrame
        btn.MouseButton1Click:Connect(function()
            configTable[configKey] = opt
            dropdown.Text = opt
            listVisible = false
            game:GetService("TweenService"):Create(listFrame, TweenInfo.new(0.2), {Size = UDim2.new(0.4, 0, 0, 0)}):Play()
            if callback then callback(opt) end
        end)
    end

    dropdown.MouseButton1Click:Connect(function()
        listVisible = not listVisible
        local targetHeight = listVisible and #options * 27 or 0
        game:GetService("TweenService"):Create(listFrame, TweenInfo.new(0.3), {Size = UDim2.new(0.4, 0, 0, targetHeight)}):Play()
    end)

    return dropdown
end

return Components
