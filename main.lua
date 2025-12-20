-- UI Loader Test

local ScreenGui = Instance.new("ScreenGui")
local TextLabel = Instance.new("TextLabel")

ScreenGui.Parent = game:GetService("CoreGui")

TextLabel.Parent = ScreenGui
TextLabel.Size = UDim2.new(0, 300, 0, 50)
TextLabel.Position = UDim2.new(0.35, 0, 0.4, 0)
TextLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Text = "SCRIPT LOADED FROM GITHUB"
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = 16

