-- PROFFT Hub UI Base (Fixed & Lightweight)

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("DollHub") then
    CoreGui.DollHub:Destroy()
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DollHub"
ScreenGui.Parent = CoreGui

-- Icon Toggle Button
local IconBtn = Instance.new("ImageButton")
IconBtn.Parent = ScreenGui
IconBtn.Size = UDim2.new(0, 50, 0, 50)
IconBtn.Position = UDim2.new(0, 20, 0.5, -25)
IconBtn.BackgroundColor3 = Color3.fromRGB(255, 90, 90)
IconBtn.Image = "rbxassetid://7733960981"
IconBtn.Active = true
IconBtn.Draggable = true
IconBtn.AutoButtonColor = true
Instance.new("UICorner", IconBtn).CornerRadius = UDim.new(1, 0)

-- Main Frame
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 600, 0, 360)
Main.Position = UDim2.new(0.5, -300, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Visible = true
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

-- Title
local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "DOLL HUB"
Title.TextColor3 = Color3.fromRGB(255, 120, 120)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Content
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0, 150, 0, 0)
Content.Size = UDim2.new(1, -150, 1, 0)
Content.BackgroundTransparency = 1

-- Section
local Section = Instance.new("Frame", Content)
Section.Size = UDim2.new(0, 400, 0, 200)
Section.Position = UDim2.new(0, 20, 0, 20)
Section.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", Section).CornerRadius = UDim.new(0, 10)

local SectionTitle = Instance.new("TextLabel", Section)
SectionTitle.Size = UDim2.new(1, -20, 0, 40)
SectionTitle.Position = UDim2.new(0, 10, 0, 0)
SectionTitle.BackgroundTransparency = 1
SectionTitle.Text = "Main Feature"
SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SectionTitle.Font = Enum.Font.GothamBold
SectionTitle.TextSize = 16
SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle Button
local Toggle = Instance.new("TextButton", Section)
Toggle.Size = UDim2.new(0, 160, 0, 40)
Toggle.Position = UDim2.new(0, 20, 0, 60)
Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Toggle.Text = "Enable Feature: OFF"
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Font = Enum.Font.Gotham
Toggle.TextSize = 14
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 8)

-- UI Animation
local isOpen = true
local openPos = Main.Position
local closePos = openPos + UDim2.new(0, 0, 0, 60)

local function OpenUI()
    Main.Visible = true
    TweenService:Create(
        Main,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = openPos}
    ):Play()
end

local function CloseUI()
    local tween = TweenService:Create(
        Main,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Position = closePos}
    )
    tween:Play()
    tween.Completed:Wait()
    Main.Visible = false
end

IconBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        OpenUI()
    else
        CloseUI()
    end
end)

-- Feature Toggle Logic
local enabled = false
Toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    Toggle.Text = enabled and "Enable Feature: ON" or "Enable Feature: OFF"
    Toggle.BackgroundColor3 = enabled
        and Color3.fromRGB(255, 90, 90)
        or Color3.fromRGB(40, 40, 40)
end)

