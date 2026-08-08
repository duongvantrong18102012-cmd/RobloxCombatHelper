-- ===== GUI/MAINGUI.LUA =====
local MainGUI = {}

function MainGUI:Create(Hub)
    local player = game.Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CombatHubGUI"
    screenGui.Parent = player.PlayerGui

    -- Lấy theme
    local colors = Hub.Theme:GetColors(Hub.Config.Theme or "Dark")
    local font = Hub.Theme:GetFont()

    -- Frame chính
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
    mainFrame.BackgroundColor3 = colors.Background
    mainFrame.BackgroundTransparency = Hub.Config.GUI_Transparency or 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    -- Shadow (hiệu ứng đổ bóng)
    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.Image = "rbxassetid://131604537" -- Shadow asset
    shadow.ImageColor3 = colors.Shadow
    shadow.ImageTransparency = 0.6
    shadow.BackgroundTransparency = 1
    shadow.ZIndex = 0
    shadow.Parent = mainFrame

    -- Title bar (có nút thu nhỏ)
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = colors.BackgroundAlt
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(0.6, 0, 1, 0)
    titleText.Position = UDim2.new(0.05, 0, 0, 0)
    titleText.Text = "⚔️ Combat Hub Pro"
    titleText.TextColor3 = colors.Accent
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.BackgroundTransparency = 1
    titleText.Font = font
    titleText.TextSize = 18
    titleText.Parent = titleBar

    -- Nút thu nhỏ
    local collapseBtn = Instance.new("TextButton")
    collapseBtn.Size = UDim2.new(0, 30, 1, 0)
    collapseBtn.Position = UDim2.new(0.9, 0, 0, 0)
    collapseBtn.Text = "➖"
    collapseBtn.TextColor3 = colors.Text
    collapseBtn.BackgroundTransparency = 1
    collapseBtn.Font = font
    collapseBtn.TextSize = 20
    collapseBtn.Parent = titleBar

    -- Nút đóng
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 1, 0)
    closeBtn.Position = UDim2.new(0.95, 0, 0, 0)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = colors.Danger
    closeBtn.BackgroundTransparency = 1
    closeBtn.Font = font
    closeBtn.TextSize = 20
    closeBtn.Parent = titleBar

    -- Tab buttons (nằm dưới title)
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1, 0, 0, 35)
    tabBar.Position = UDim2.new(0, 0, 0, 35)
    tabBar.BackgroundColor3 = colors.BackgroundAlt
    tabBar.BorderSizePixel = 0
    tabBar.Parent = mainFrame

    local tabs = {"ESP", "Aimbot", "Hitbox", "Settings"}
    local tabButtons = {}
    for i, name in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.25, 0, 1, 0)
        btn.Position = UDim2.new((i-1)*0.25, 0, 0, 0)
        btn.Text = name
        btn.TextColor3 = colors.TextMuted
        btn.BackgroundTransparency = 1
        btn.Font = font
        btn.TextSize = 15
        btn.Parent = tabBar
        tabButtons[name] = btn
    end

    -- Content container (chứa các tab)
    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, 0, 1, -70)
    contentContainer.Position = UDim2.new(0, 0, 0, 70)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = mainFrame

    -- Hàm tạo tab content
    local function SwitchTab(tabName)
        -- Xóa content cũ
        for _, child in pairs(contentContainer:GetChildren()) do
            child:Destroy()
        end

        -- Reset màu tab
        for _, btn in pairs(tabButtons) do
            btn.TextColor3 = colors.TextMuted
            btn.BackgroundTransparency = 1
        end
        if tabButtons[tabName] then
            tabButtons[tabName].TextColor3 = colors.Accent
            tabButtons[tabName].BackgroundTransparency = 0.2
        end

        -- Tạo nội dung cho tab
        if tabName == "ESP" then
            Hub.ESPTab:Create(Hub, contentContainer, colors)
        elseif tabName == "Aimbot" then
            Hub.AimbotTab:Create(Hub, contentContainer, colors)
        elseif tabName == "Hitbox" then
            Hub.HitboxTab:Create(Hub, contentContainer, colors)
        elseif tabName == "Settings" then
            Hub.SettingsTab:Create(Hub, contentContainer, colors)
        end
    end

    -- Gắn sự kiện cho tab buttons
    for name, btn in pairs(tabButtons) do
        btn.MouseButton1Click:Connect(function()
            SwitchTab(name)
        end)
    end

    -- Mặc định chọn tab ESP
    SwitchTab("ESP")

    -- Toggle thu nhỏ/mở rộng
    local isCollapsed = false
    local originalSize = mainFrame.Size
    collapseBtn.MouseButton1Click:Connect(function()
        isCollapsed = not isCollapsed
        local targetSize = isCollapsed and UDim2.new(0, 400, 0, 45) or originalSize
        collapseBtn.Text = isCollapsed and "➕" or "➖"
        game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = targetSize}):Play()
        -- Ẩn content khi thu nhỏ
        contentContainer.Visible = not isCollapsed
        tabBar.Visible = not isCollapsed
    end)

    -- Nút đóng
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        print("🔄 Đã đóng GUI.")
    end)

    -- Kéo thả (drag) cho mainFrame
    local dragging = false
    local dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    game:GetService("RunService").RenderStepped:Connect(function()
        if dragging then
            local delta = game:GetService("UserInputService"):GetMouseLocation() - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Tạo 1 frame nhỏ để hiển thị trạng thái (tùy chọn)
    print("✅ GUI Pro đã khởi tạo.")
end

return MainGUI
