-- STS Hub | Chiyo-style UI Framework

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("DollHub") then
    CoreGui.DollHub:Destroy()
end

local UI = Instance.new("ScreenGui", CoreGui)
UI.Name = "DollHub"

-- ================= ICON TOGGLE =================
local Icon = Instance.new("ImageButton", UI)
Icon.Size = UDim2.new(0,50,0,50)
Icon.Position = UDim2.new(0,20,0.5,-25)
Icon.Image = "rbxassetid://ASSET_ID_HERE"
Icon.BackgroundColor3 = Color3.fromRGB(0,0,0)
Icon.BackgroundTransparency = .2
Icon.Active, Icon.Draggable = true, true
Instance.new("UICorner",Icon).CornerRadius = UDim.new(1,0)

-- ================= MAIN =================
local Main = Instance.new("Frame", UI)
Main.Size = UDim2.new(0,650,0,380)
Main.Position = UDim2.new(.5,-325,.5,-190)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.Active, Main.Draggable = true, true
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,12)

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0,160,1,0)
Sidebar.BackgroundColor3 = Color3.fromRGB(14,14,14)
Instance.new("UICorner",Sidebar).CornerRadius = UDim.new(0,12)

-- Content
local Pages = Instance.new("Folder", Main)
Pages.Name = "Pages"

-- ================= UI MAKERS =================
local function CreatePage(name)
    local p = Instance.new("Frame", Pages)
    p.Name = name
    p.Position = UDim2.new(0,160,0,0)
    p.Size = UDim2.new(1,-160,1,0)
    p.BackgroundTransparency = 1
    p.Visible = false
    return p
end

local function CreateTab(text, order, page)
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.new(1,-20,0,36)
    b.Position = UDim2.new(0,10,0,60+(order*40))
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)

    b.MouseButton1Click:Connect(function()
        for _,v in pairs(Pages:GetChildren()) do v.Visible = false end
        page.Visible = true
    end)
end

local function Section(parent, title, y)
    local s = Instance.new("Frame", parent)
    s.Size = UDim2.new(0,420,0,200)
    s.Position = UDim2.new(0,20,0,y)
    s.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Instance.new("UICorner",s).CornerRadius = UDim.new(0,10)

    local t = Instance.new("TextLabel", s)
    t.Text = title
    t.Size = UDim2.new(1,-20,0,40)
    t.Position = UDim2.new(0,10,0,0)
    t.BackgroundTransparency = 1
    t.Font = Enum.Font.GothamBold
    t.TextSize = 16
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.TextColor3 = Color3.new(1,1,1)

    return s
end

local function Toggle(parent, text, y, callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0,180,0,36)
    b.Position = UDim2.new(0,20,0,y)
    b.Text = text.." : OFF"
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)

    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = text.." : "..(state and "ON" or "OFF")
        b.BackgroundColor3 = state and Color3.fromRGB(255,90,90) or Color3.fromRGB(40,40,40)
        callback(state)
    end)
end

-- ================= PAGES =================
local MainPage = CreatePage("Main")
local Quest = CreatePage("Quest")
local Upgrade = CreatePage("Upgrade")
local Selling = CreatePage("Selling")
local Shop = CreatePage("Shop")
local Webhook = CreatePage("Webhook")
local Player = CreatePage("Player")
local Settings = CreatePage("Settings")

MainPage.Visible = true

-- ================= TABS =================
CreateTab("Main",0,MainPage)
CreateTab("Quest",1,Quest)
CreateTab("Upgrade",2,Upgrade)
CreateTab("Selling",3,Selling)
CreateTab("Shop",4,Shop)
CreateTab("Webhook",5,Webhook)
CreateTab("Player",6,Player)
CreateTab("Settings",7,Settings)

-- ================= MAIN FEATURES =================
local sec = Section(MainPage,"Farming",20)

Toggle(sec,"Auto Farm",50,function(v)
    -- TODO: Auto Farm logic
end)

Toggle(sec,"Auto Claim",90,function(v)
    -- TODO
end)

Toggle(sec,"Auto Code",130,function(v)
    -- TODO
end)

-- ================= PLAYER =================
local psec = Section(Player,"Movement",20)

Toggle(psec,"Fly",50,function(v)
    -- TODO Fly
end)

Toggle(psec,"No Clip",90,function(v)
    -- TODO
end)

-- ================= ICON ANIM =================
local open = true
local openPos = Main.Position
local closePos = openPos + UDim2.new(0,0,0,60)

Icon.MouseButton1Click:Connect(function()
    open = not open
    local t = TweenService:Create(
        Main,
        TweenInfo.new(.25),
        {Position = open and openPos or closePos}
    )
    t:Play()
    if not open then
        t.Completed:Wait()
        Main.Visible = false
    else
        Main.Visible = true
    end
end)
