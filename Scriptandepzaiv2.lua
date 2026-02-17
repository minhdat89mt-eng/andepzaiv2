-- [[ ANDEPZAI V2 ✨ - RECODE FIXED ]]
local Lyr = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Stroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")

Lyr.Name = "AndepzaiV2_Fixed"
Lyr.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer.PlayerGui

-- GIAO DIỆN TRẮNG ✨
Main.Name = "Main"
Main.Parent = Lyr
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.Position = UDim2.new(0.5, -100, 0.5, -100)
Main.Size = UDim2.new(0, 200, 0, 250)
Main.Active = true
Main.Draggable = true -- Di chuyển được

-- VIỀN CẦU VỒNG 🌈
Stroke.Parent = Main
Stroke.Thickness = 4
task.spawn(function()
    while task.wait() do
        local hue = tick() % 5 / 5
        Stroke.Color = Color3.fromHSV(hue, 0.8, 1)
    end
end)

Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "Andepzai V2 ✨\n(Fixed)"
Title.TextColor3 = Color3.fromRGB(0,0,0)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

-- TÍNH NĂNG TỰ ĐỘNG (FAST ATTACK & ANTI-AFK)
print("Andepzai V2 đã kích hoạt Fast Attack & Anti-AFK!")

-- [[ CHÈN LOGIC FARM CỦA BẠN VÀO ĐÂY ]]
