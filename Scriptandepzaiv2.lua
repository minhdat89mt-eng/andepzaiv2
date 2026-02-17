--[[
    Tên Script: ANDEPZAI V2
    Tính năng: Menu di chuyển, Viền Rainbow, Farm Level, Fast Attack
]]

local Library = {} -- Giả sử bạn dùng một Library UI để dựng cho nhanh
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIStroke = Instance.new("UIStroke") -- Viền bảy sắc cầu vồng

-- 1. SETTING GIAO DIỆN (Menu màu trắng, lấp lánh ✨)
MainFrame.Name = "AndepzaiV2_Menu"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Màu trắng
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.Active = true
MainFrame.Draggable = true -- Có thể di chuyển được

local Title = Instance.new("TextLabel")
Title.Text = "Andepzai V2 ✨"
Title.Parent = MainFrame
-- (Thêm các thành phần UI khác ở đây...)

--- 2. TÍNH NĂNG VIỀN BẢY SẮC CẦU VỒNG (Có thể bật/tắt)
local RainbowActive = true
task.spawn(function()
    while task.wait() do
        if RainbowActive then
            local hue = tick() % 5 / 5
            UIStroke.Color = Color3.fromHSV(hue, 1, 1)
        end
    end
end)

--- 3. LOGIC FARM LEVEL (Tự nhận quest, gôm quái, đánh trên cao)
local AutoFarm = false

function GetQuest(level)
    -- Logic kiểm tra Level và nhận nhiệm vụ tương ứng
    print("Đang nhận nhiệm vụ cho Level: " .. level)
end

task.spawn(function()
    while task.wait() do
        if AutoFarm then
            -- 1. Nhận nhiệm vụ
            GetQuest(game.Players.LocalPlayer.Data.Level.Value)
            
            -- 2. Di chuyển tới quái và đánh trên cao (để quái không chạm tới)
            local Monster = workspace.Enemies:FindFirstChild("Tên Quái")
            if Monster then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Monster.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) -- Đứng trên đầu 10 unit
                -- Logic gôm quái 2-3 con (Bring Monsters)
            end
        end
    end
end)

--- 4. SIÊU CẤP FAST ATTACK (Mặc định bật, không trễ)
-- Cảnh báo: Tốc độ quá cao có thể gây văng game (Kick)
task.spawn(function()
    while true do
        -- Logic đánh siêu nhanh (nhanh hơn bản cũ)
        -- Bypass Delay
        task.wait(0.01) -- Cực ít độ trễ
        -- Trigger RemoteEvent đánh ở đây
    end
end)

-- 5. ANTI-AFK (Tự động bật)
local VirtualUser = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)
