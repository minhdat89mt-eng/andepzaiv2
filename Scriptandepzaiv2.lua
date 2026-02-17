----------------------------------------------------------------
-- COPY PHẦN NÀY VÀO ServerScriptService
----------------------------------------------------------------

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local dataStore = DataStoreService:GetDataStore("UpgradeSystemData")

-- Tạo RemoteEvent nếu chưa có
local upgradeEvent = ReplicatedStorage:FindFirstChild("UpgradeEvent")
if not upgradeEvent then
	upgradeEvent = Instance.new("RemoteEvent")
	upgradeEvent.Name = "UpgradeEvent"
	upgradeEvent.Parent = ReplicatedStorage
end

game.Players.PlayerAdded:Connect(function(player)

	-- Leaderstats
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"

	local money = Instance.new("IntValue", leaderstats)
	money.Name = "Money"
	money.Value = 500

	local level = Instance.new("IntValue", leaderstats)
	level.Name = "Level"
	level.Value = 1

	local speed = Instance.new("IntValue", player)
	speed.Name = "SavedSpeed"
	speed.Value = 16

	local jump = Instance.new("IntValue", player)
	jump.Name = "SavedJump"
	jump.Value = 50

	-- Load Data
	local success, data = pcall(function()
		return dataStore:GetAsync(player.UserId)
	end)

	if success and data then
		money.Value = data.Money or 500
		level.Value = data.Level or 1
		speed.Value = data.Speed or 16
		jump.Value = data.Jump or 50
	end

	player.CharacterAdded:Connect(function(char)
		local hum = char:WaitForChild("Humanoid")
		hum.WalkSpeed = speed.Value
		hum.JumpPower = jump.Value
	end)
end)

upgradeEvent.OnServerEvent:Connect(function(player)

	local money = player.leaderstats.Money
	local level = player.leaderstats.Level
	local speed = player.SavedSpeed
	local jump = player.SavedJump

	local cost = 100 * level.Value
	local increase = 2 * level.Value

	if money.Value >= cost then
		
		money.Value -= cost
		speed.Value += increase
		jump.Value += increase
		level.Value += 1

		local char = player.Character
		if char then
			local hum = char:FindFirstChild("Humanoid")
			if hum then
				hum.WalkSpeed = speed.Value
				hum.JumpPower = jump.Value
			end
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(player)

	local data = {
		Money = player.leaderstats.Money.Value,
		Level = player.leaderstats.Level.Value,
		Speed = player.SavedSpeed.Value,
		Jump = player.SavedJump.Value
	}

	pcall(function()
		dataStore:SetAsync(player.UserId, data)
	end)
end)


----------------------------------------------------------------
-- COPY PHẦN NÀY VÀO StarterPlayerScripts (LocalScript)
----------------------------------------------------------------

local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local upgradeEvent = ReplicatedStorage:WaitForChild("UpgradeEvent")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,250,0,150)
frame.Position = UDim2.new(0.5,-125,0.5,-75)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,15)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "🔥 Upgrade Panel"
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(0,255,255)

local info = Instance.new("TextLabel", frame)
info.Size = UDim2.new(1,0,0,40)
info.Position = UDim2.new(0,0,0,45)
info.BackgroundTransparency = 1
info.TextColor3 = Color3.new(1,1,1)

local upgradeBtn = Instance.new("TextButton", frame)
upgradeBtn.Size = UDim2.new(0,180,0,40)
upgradeBtn.Position = UDim2.new(0.5,-90,1,-50)
upgradeBtn.Text = "Upgrade Stats"
upgradeBtn.BackgroundColor3 = Color3.fromRGB(0,200,100)
upgradeBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", upgradeBtn).CornerRadius = UDim.new(0,12)

-- Cập nhật info realtime
local function updateInfo()
	if player:FindFirstChild("SavedSpeed") then
		info.Text = 
			"Speed: "..player.SavedSpeed.Value..
			"\nJump: "..player.SavedJump.Value..
			"\nLevel: "..player.leaderstats.Level.Value
	end
end

player.ChildAdded:Connect(updateInfo)
if player:FindFirstChild("SavedSpeed") then
	player.SavedSpeed:GetPropertyChangedSignal("Value"):Connect(updateInfo)
	player.SavedJump:GetPropertyChangedSignal("Value"):Connect(updateInfo)
	player.leaderstats.Level:GetPropertyChangedSignal("Value"):Connect(updateInfo)
end

updateInfo()

upgradeBtn.MouseButton1Click:Connect(function()
	upgradeEvent:FireServer()
end)
