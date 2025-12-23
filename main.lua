-- ECH HUB - FULL AUTO MINING + UI (FINAL)

------------------------------------------------
-- SERVICES
------------------------------------------------
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local player = Players.LocalPlayer

------------------------------------------------
-- CHARACTER
------------------------------------------------
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

------------------------------------------------
-- STATE
------------------------------------------------
local AutoMining = false
local SelectedRockName = nil
local UseTeleport = false
local SkipUsedRock = true
local MoveSpeed = 160

------------------------------------------------
-- FLOATING BUTTON
------------------------------------------------
local toggleGui = Instance.new("ScreenGui", player.PlayerGui)
toggleGui.Name = "ECHToggle"
toggleGui.ResetOnSpawn = false

local toggleBtn = Instance.new("TextButton", toggleGui)
toggleBtn.Size = UDim2.new(0,54,0,54)
toggleBtn.Position = UDim2.new(0,20,0.5,-27)
toggleBtn.Text = "C"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 22
toggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
toggleBtn.TextColor3 = Color3.fromRGB(255,160,160)
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1,0)

------------------------------------------------
-- MAIN UI
------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "ECHHubUI"
gui.Enabled = false
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,520,0,340)
main.Position = UDim2.new(0.5,-260,0.5,-170)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", main).CornerRadius = UDim.new(0,10)

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0,26,0,26)
closeBtn.Position = UDim2.new(1,-30,0,6)
closeBtn.Text = "✕"
closeBtn.TextSize = 14
closeBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
Instance.new("UICorner", closeBtn)

local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,20,0,40)
content.Size = UDim2.new(1,-40,1,-60)
content.BackgroundColor3 = Color3.fromRGB(18,18,18)
Instance.new("UICorner", content).CornerRadius = UDim.new(0,8)

------------------------------------------------
-- UI BUTTON MAKER
------------------------------------------------
local function makeBtn(txt,y)
	local b = Instance.new("TextButton", content)
	b.Size = UDim2.new(0,220,0,32)
	b.Position = UDim2.new(0,20,0,y)
	b.Text = txt
	b.Font = Enum.Font.Gotham
	b.TextSize = 12
	b.BackgroundColor3 = Color3.fromRGB(38,38,38)
	b.TextColor3 = Color3.fromRGB(220,220,220)
	Instance.new("UICorner", b)
	return b
end

local autoBtn = makeBtn("Auto Mining : OFF",10)
local modeBtn = makeBtn("Mode : STEALTH",52)
local skipBtn = makeBtn("Skip Used Rock : ON",94)
local speedBtn = makeBtn("Speed : 160",136)

------------------------------------------------
-- ROCK LIST (MENU NAME = rock)
------------------------------------------------
local rockFrame = Instance.new("Frame", content)
rockFrame.Name = "rock"
rockFrame.Size = UDim2.new(0,220,0,140)
rockFrame.Position = UDim2.new(0,20,0,178)
rockFrame.BackgroundColor3 = Color3.fromRGB(28,28,28)
Instance.new("UICorner", rockFrame)

local title = Instance.new("TextLabel", rockFrame)
title.Size = UDim2.new(1,0,0,22)
title.Text = "ROCK"
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextColor3 = Color3.fromRGB(200,200,200)
title.BackgroundTransparency = 1

local list = Instance.new("ScrollingFrame", rockFrame)
list.Position = UDim2.new(0,4,0,24)
list.Size = UDim2.new(1,-8,1,-26)
list.CanvasSize = UDim2.new(0,0,0,0)
list.ScrollBarImageTransparency = 0.4
list.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0,4)

local RockList = {
	"Basalt Core","Basalt Rock","Basalt Vein","Boulder",
	"Crimson Crystal","Cyan Crystal","Earth Crystal",
	"Light Crystal","Lucky Block","Pebble","Rock",
	"Violet Crystal","Volcanic Rock"
}

for _,name in ipairs(RockList) do
	local b = Instance.new("TextButton", list)
	b.Size = UDim2.new(1,0,0,22)
	b.Text = name
	b.Font = Enum.Font.Gotham
	b.TextSize = 11
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	b.TextColor3 = Color3.fromRGB(220,220,220)
	Instance.new("UICorner", b)
	b.MouseButton1Click:Connect(function()
		SelectedRockName = name
		autoBtn.Text = "Target : "..name
	end)
end

task.wait()
list.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)

------------------------------------------------
-- UI TOGGLE
------------------------------------------------
local opened = false
toggleBtn.MouseButton1Click:Connect(function()
	opened = not opened
	gui.Enabled = opened
end)
closeBtn.MouseButton1Click:Connect(function()
	gui.Enabled = false
	opened = false
end)

------------------------------------------------
-- BUTTON LOGIC
------------------------------------------------
autoBtn.MouseButton1Click:Connect(function()
	AutoMining = not AutoMining
	autoBtn.Text = AutoMining and "Auto Mining : ON" or "Auto Mining : OFF"
end)

modeBtn.MouseButton1Click:Connect(function()
	UseTeleport = not UseTeleport
	modeBtn.Text = UseTeleport and "Mode : TELEPORT" or "Mode : STEALTH"
end)

skipBtn.MouseButton1Click:Connect(function()
	SkipUsedRock = not SkipUsedRock
	skipBtn.Text = SkipUsedRock and "Skip Used Rock : ON" or "Skip Used Rock : OFF"
end)

speedBtn.MouseButton1Click:Connect(function()
	MoveSpeed += 40
	if MoveSpeed > 280 then MoveSpeed = 80 end
	speedBtn.Text = "Speed : "..MoveSpeed
end)

------------------------------------------------
-- CORE LOGIC
------------------------------------------------
local function validRock(r)
	if not r or not r.Parent then return false end
	if SkipUsedRock and (r.Transparency > 0.3 or not r.CanCollide) then
		return false
	end
	return true
end

local function getRock()
	local best, dist = nil, math.huge
	for _,r in ipairs(CollectionService:GetTagged("Rock")) do
		if r:IsA("BasePart") and r.Name == SelectedRockName and validRock(r) then
			local d = (r.Position - hrp.Position).Magnitude
			if d < dist then
				best, dist = r, d
			end
		end
	end
	return best
end

local function moveTo(pos)
	if UseTeleport then
		hrp.CFrame = CFrame.new(pos)
	else
		local d = (hrp.Position - pos).Magnitude
		local t = TweenService:Create(
			hrp,
			TweenInfo.new(d / MoveSpeed, Enum.EasingStyle.Linear),
			{CFrame = CFrame.new(pos)}
		)
		t:Play()
		t.Completed:Wait()
	end
end

local function hitRock(r)
	local tool = char:FindFirstChildOfClass("Tool")
	if tool then
		for _=1,8 do
			if not r.Parent then break end
			tool:Activate()
			task.wait(0.12)
		end
	end
end

------------------------------------------------
-- MAIN LOOP (NONSTOP)
------------------------------------------------
task.spawn(function()
	while task.wait(0.2) do
		if AutoMining and SelectedRockName then
			local rock = getRock()
			if rock then
				moveTo(rock.Position + Vector3.new(0,0,-3))
				hitRock(rock)
			end
		end
	end
end)
