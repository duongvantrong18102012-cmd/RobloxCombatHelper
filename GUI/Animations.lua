-- ===== GUI/ANIMATIONS.LUA =====
local Animations = {}

-- Tween helper
function Animations:Tween(object, properties, duration, style)
    duration = duration or 0.3
    style = style or Enum.EasingStyle.Quad
    local tween = game:GetService("TweenService"):Create(object, TweenInfo.new(duration, style, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

-- Fade in
function Animations:FadeIn(guiObject, duration)
    guiObject.BackgroundTransparency = 1
    guiObject.Visible = true
    return self:Tween(guiObject, {BackgroundTransparency = 0}, duration or 0.3)
end

-- Fade out
function Animations:FadeOut(guiObject, duration)
    local tween = self:Tween(guiObject, {BackgroundTransparency = 1}, duration or 0.3)
    tween.Completed:Connect(function()
        guiObject.Visible = false
    end)
    return tween
end

-- Slide in (từ trái sang phải)
function Animations:SlideIn(guiObject, offset, duration)
    local originalPos = guiObject.Position
    guiObject.Position = UDim2.new(offset, 0, originalPos.Y.Scale, originalPos.Y.Offset)
    guiObject.Visible = true
    return self:Tween(guiObject, {Position = originalPos}, duration or 0.4)
end

-- Slide out
function Animations:SlideOut(guiObject, offset, duration)
    local targetPos = UDim2.new(offset, 0, guiObject.Position.Y.Scale, guiObject.Position.Y.Offset)
    local tween = self:Tween(guiObject, {Position = targetPos}, duration or 0.4)
    tween.Completed:Connect(function()
        guiObject.Visible = false
    end)
    return tween
end

-- Scale pop (hiệu ứng nổi lên)
function Animations:Pop(guiObject, scale, duration)
    local originalSize = guiObject.Size
    guiObject.Size = UDim2.new(originalSize.X.Scale * scale, originalSize.X.Offset, originalSize.Y.Scale * scale, originalSize.Y.Offset)
    local tween = self:Tween(guiObject, {Size = originalSize}, duration or 0.2)
    return tween
end

-- Hover effect (thay đổi màu nền)
function Animations:Hover(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        self:Tween(button, {BackgroundColor3 = hoverColor}, 0.15)
    end)
    button.MouseLeave:Connect(function()
        self:Tween(button, {BackgroundColor3 = normalColor}, 0.15)
    end)
end

return Animations
