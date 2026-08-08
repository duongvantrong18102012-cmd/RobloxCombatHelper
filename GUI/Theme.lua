-- ===== GUI/THEME.LUA =====
local Theme = {}

function Theme:GetColors(themeName)
    if themeName == "Dark" then
        return {
            Background = Color3.fromRGB(20, 20, 30),
            BackgroundAlt = Color3.fromRGB(30, 30, 50),
            Foreground = Color3.fromRGB(255, 255, 255),
            Accent = Color3.fromRGB(0, 150, 255),
            AccentHover = Color3.fromRGB(0, 180, 255),
            Success = Color3.fromRGB(0, 200, 0),
            Danger = Color3.fromRGB(200, 0, 0),
            Warning = Color3.fromRGB(200, 200, 0),
            Text = Color3.fromRGB(255, 255, 255),
            TextMuted = Color3.fromRGB(150, 150, 150),
            Border = Color3.fromRGB(50, 50, 70),
            Shadow = Color3.fromRGB(0, 0, 0),
        }
    else -- Light
        return {
            Background = Color3.fromRGB(240, 240, 250),
            BackgroundAlt = Color3.fromRGB(220, 220, 230),
            Foreground = Color3.fromRGB(0, 0, 0),
            Accent = Color3.fromRGB(0, 120, 255),
            AccentHover = Color3.fromRGB(0, 150, 255),
            Success = Color3.fromRGB(0, 180, 0),
            Danger = Color3.fromRGB(180, 0, 0),
            Warning = Color3.fromRGB(180, 180, 0),
            Text = Color3.fromRGB(0, 0, 0),
            TextMuted = Color3.fromRGB(100, 100, 100),
            Border = Color3.fromRGB(180, 180, 200),
            Shadow = Color3.fromRGB(0, 0, 0),
        }
    end
end

function Theme:GetFont()
    return Enum.Font.Gotham
end

function Theme:GetFontSize(size)
    return size -- có thể map nếu cần
end

return Theme
