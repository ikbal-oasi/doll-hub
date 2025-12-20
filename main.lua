-- Doll Hub UI (Base)

if game:GetService("CoreGui"):FindFirstChild("DollHub") then
    game:GetService("CoreGui"):FindFirstChild("DollHub"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DollHub"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 350, 0, 220)
Frame.Position = UDim2.new(0.5, -175, 0.5, -110)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "DOLL HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

local Button = Instance.new("TextButton")
Button.Parent = Frame
Button.Size = UDim2.new(0.8, 0, 0, 45)
Button.Position = UDim2.new(0.1, 0, 0.5, 0)
Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Button.Text = "TEST BUTTON"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.Gotham
Button.TextSize = 16

local UICorner2 = Instance.new("UICorner", Button)
UICorner2.CornerRadius = UDim.new(0, 10)

Button.MouseButton1Click:Connect(function()
    Button.Text = "Clicked!"
end)
