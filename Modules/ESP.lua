-- ===== MODULES/ESP.LUA =====
local ESPModule = {}
local isRunning = false
local espObjects = {} -- Lưu các đối tượng vẽ

function ESPModule:Start(Hub)
    if isRunning then return end
    isRunning = true
    print("👁️ ESP đã khởi động")

    local function CreateESP(target)
        local char = target
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then return end

        -- Tạo các đối tượng vẽ (Box, Tên, Máu, Khoảng cách)
        local box = Instance.new("BoxHandleAdornment")
        box.Size = Vector3.new(4, 5, 2)
        box.Adornee = char
        box.AlwaysOnTop = true
        box.ZIndex = 0
        box.Parent = char

        local nameLabel = Instance.new("BillboardGui")
        nameLabel.Size = UDim2.new(0, 100, 0, 20)
        nameLabel.Adornee = char
        nameLabel.AlwaysOnTop = true
        nameLabel.Parent = char

        local nameText = Instance.new("TextLabel", nameLabel)
        nameText.Size = UDim2.new(1, 0, 1, 0)
        nameText.BackgroundTransparency = 1
        nameText.TextColor3 = Color3.fromRGB(255,255,255)
        nameText.TextStrokeTransparency = 0.5
        nameText.Text = char.Name

        -- Thanh máu
        local healthBar = Instance.new("BillboardGui")
        healthBar.Size = UDim2.new(0, 50, 0, 5)
        healthBar.Adornee = char
        healthBar.AlwaysOnTop = true
        healthBar.Parent = char

        local healthFrame = Instance.new("Frame", healthBar)
        healthFrame.Size = UDim2.new(1, 0, 1, 0)
        healthFrame.BackgroundColor3 = Color3.fromRGB(0,255,0)
        healthFrame.BackgroundTransparency = 0.5

        -- Lưu để cập nhật sau
        espObjects[char] = {
            Box = box,
            NameLabel = nameLabel,
            NameText = nameText,
            HealthBar = healthBar,
            HealthFrame = healthFrame,
        }
    end

    -- Hàm xóa ESP khi mục tiêu bị xóa
    local function RemoveESP(target)
        if espObjects[target] then
            for _, obj in pairs(espObjects[target]) do
                obj:Destroy()
            end
            espObjects[target] = nil
        end
    end

    -- Vòng lặp cập nhật ESP
    spawn(function()
        while isRunning do
            local targets = Hub.Helpers:GetAllTargets()
            for _, char in ipairs(targets) do
                if not espObjects[char] then
                    CreateESP(char)
                end
                -- Cập nhật tên và máu
                local data = espObjects[char]
                if data then
                    local humanoid = char:FindFirstChild("Humanoid")
                    if humanoid then
                        data.NameText.Text = char.Name .. " [" .. math.floor(humanoid.Health) .. "/" .. humanoid.MaxHealth .. "]"
                        local healthPercent = humanoid.Health / humanoid.MaxHealth
                        data.HealthFrame.Size = UDim2.new(healthPercent, 0, 1, 0)
                        data.HealthFrame.BackgroundColor3 = healthPercent > 0.5 and Color3.fromRGB(0,255,0) or (healthPercent > 0.25 and Color3.fromRGB(255,255,0) or Color3.fromRGB(255,0,0))
                    end
                end
            end

            -- Xóa ESP cho mục tiêu không còn tồn tại
            for char, _ in pairs(espObjects) do
                if not char.Parent then
                    RemoveESP(char)
                end
            end
            wait(0.1)
        end
    end)

    -- Xóa ESP khi tắt module
    function ESPModule:Stop()
        isRunning = false
        for char, data in pairs(espObjects) do
            for _, obj in pairs(data) do
                obj:Destroy()
            end
        end
        espObjects = {}
        print("👁️ ESP đã tắt")
    end
end

return ESPModule
