--// VOIDWARE UI - CUSTOM VERSION
--// Only 1 Tab: Movements + Sliders inside
--// Matches your purple theme

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MyUILib = {}
MyUILib.__index = MyUILib

-- Load Icons
local Lucide = nil
pcall(function()
    Lucide = loadstring(game:HttpGet("https://raw.githubusercontent.com/latte-soft/lucide-roblox/refs/heads/master/lib/Icons.luau"))()
end)

-- 🎨 THEME
MyUILib.Theme = {
    WindowBg = Color3.fromRGB(216, 128, 255),
    SidebarBg = Color3.fromRGB(90, 30, 130),
    ContentBg = Color3.fromRGB(110, 40, 150),
    SearchBg = Color3.fromRGB(70, 25, 110),
    TabNormal = Color3.fromRGB(90, 30, 130),
    TabSelected = Color3.fromRGB(150, 60, 210),
    UserProfileBg = Color3.fromRGB(80, 28, 120),
    ScrollbarColor = Color3.fromRGB(180, 100, 220),
    SliderTrack = Color3.fromRGB(60, 20, 90),
    SliderFill = Color3.fromRGB(200, 120, 255),
    SliderKnob = Color3.new(1,1,1),
    IconColor = Color3.new(1,1,1),
    TextColor = Color3.new(1,1,1),
    HeaderTitle = "Voidware",
    HeaderSubtitle = "discord.gg/voidware",
    CornerRadius = UDim.new(0, 10),
    NormalWindowSize = UDim2.new(0, 450, 0, 530),
    NormalWindowPos = UDim2.new(0.5, -225, 0.5, -265),
    HeaderHeight = 36,
    SidebarWidth = 160,
    UserProfileHeight = 60
}

-- 🧱 BASE CLASS
local Base = {}
Base.__index = Base
function Base.new(class, props)
    local self = setmetatable({}, Base)
    self.Instance = Instance.new(class)
    if props then
        for k, v in pairs(props) do
            self.Instance[k] = v
        end
    end
    return self
end

-- 🪟 CREATE WINDOW
function MyUILib:CreateWindow()
    local Window = Base.new("Frame", {
        BackgroundColor3 = self.Theme.WindowBg,
        BackgroundTransparency = 0,
        Size = self.Theme.NormalWindowSize,
        Position = self.Theme.NormalWindowPos,
        ClipsDescendants = true,
        ZIndex = 10
    })
    Instance.new("UICorner", Window.Instance).CornerRadius = self.Theme.CornerRadius

    -- 📌 HEADER / DRAG AREA
    local DragArea = Base.new("Frame", {
        Size = UDim2.new(1, 0, 0, self.Theme.HeaderHeight),
        BackgroundTransparency = 1,
        Parent = Window.Instance
    })

    Base.new("TextLabel", {
        Text = self.Theme.HeaderTitle,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = self.Theme.TextColor,
        Position = UDim2.new(0, 12, 0, 4),
        Size = UDim2.new(0, 120, 0, 20),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = DragArea.Instance
    })

    Base.new("TextLabel", {
        Text = self.Theme.HeaderSubtitle,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextColor3 = self.Theme.TextColor,
        TextTransparency = 0.35,
        Position = UDim2.new(0, 12, 0, 22),
        Size = UDim2.new(0, 160, 0, 14),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = DragArea.Instance
    })

    -- Control Buttons
    local Controls = Base.new("Frame", {
        Size = UDim2.new(0, 80, 0, 28),
        Position = UDim2.new(1, -88, 0, 4),
        BackgroundTransparency = 1,
        Parent = DragArea.Instance
    })

    local function MakeBtn(text, pos)
        local btn = Base.new("TextButton", {
            Text = text,
            Size = UDim2.new(0, 24, 0, 24),
            Position = UDim2.new(0, pos, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold,
            TextColor3 = self.Theme.TextColor,
            Parent = Controls.Instance
        })
        return btn
    end

    local MinBtn = MakeBtn("—", 0)
    local MaxBtn = MakeBtn("⛶", 28)
    local CloseBtn = MakeBtn("✕", 56)

    -- 📄 MAIN CONTAINER
    local MainContainer = Base.new("Frame", {
        Size = UDim2.new(1, 0, 1, -self.Theme.HeaderHeight),
        Position = UDim2.new(0, 0, 0, self.Theme.HeaderHeight),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = Window.Instance
    })

    -- 📌 LEFT SIDEBAR
    local Sidebar = Base.new("Frame", {
        Size = UDim2.new(0, self.Theme.SidebarWidth, 1, 0),
        BackgroundColor3 = self.Theme.SidebarBg,
        BackgroundTransparency = 0.1,
        Parent = MainContainer.Instance
    })
    Instance.new("UICorner", Sidebar.Instance).CornerRadius = self.Theme.CornerRadius

    -- Search Bar
    local SearchBox = Base.new("Frame", {
        Size = UDim2.new(1, -12, 0, 36),
        Position = UDim2.new(0, 6, 0, 6),
        BackgroundColor3 = self.Theme.SearchBg,
        BackgroundTransparency = 0.15,
        Parent = Sidebar.Instance
    })
    Instance.new("UICorner", SearchBox.Instance).CornerRadius = UDim.new(0,6)

    Base.new("TextBox", {
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 20, 0, 0),
        BackgroundTransparency = 1,
        PlaceholderText = "Search tabs...",
        TextColor3 = self.Theme.TextColor,
        PlaceholderColor3 = Color3.new(0.7,0.7,0.7),
        Font = Enum.Font.Gotham,
        TextSize = 14,
        Parent = SearchBox.Instance
    })

    -- Sidebar Scroll
    local SidebarScroll = Base.new("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -48 - self.Theme.UserProfileHeight),
        Position = UDim2.new(0, 0, 0, 48),
        BackgroundTransparency = 1,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = self.Theme.ScrollbarColor,
        Parent = Sidebar.Instance
    })
    SidebarScroll.Instance.CanvasSize = UDim2.new(0,0,0,50)

    -- User Profile
    local UserProfile = Base.new("Frame", {
        Size = UDim2.new(1, 0, 0, self.Theme.UserProfileHeight),
        Position = UDim2.new(0, 0, 1, -self.Theme.UserProfileHeight),
        BackgroundColor3 = self.Theme.UserProfileBg,
        BackgroundTransparency = 0.1,
        Parent = Sidebar.Instance
    })
    Instance.new("UICorner", UserProfile.Instance).CornerRadius = UDim.new(0,6)

    Base.new("ImageLabel", {
        Size = UDim2.new(0,40,0,40),
        Position = UDim2.new(0,8,0.5,-20),
        BackgroundColor3 = Color3.new(0,0,0),
        Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420),
        Parent = UserProfile.Instance
    })
    Instance.new("UICorner", UserProfile.Instance.ImageLabel).CornerRadius = UDim.new(0,8)

    Base.new("TextLabel", {
        Text = LocalPlayer.DisplayName,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = self.Theme.TextColor,
        Position = UDim2.new(0,56,0,8),
        Size = UDim2.new(0,100,0,18),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = UserProfile.Instance
    })

    Base.new("TextLabel", {
        Text = "@"..LocalPlayer.Name,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextColor3 = self.Theme.TextColor,
        TextTransparency = 0.35,
        Position = UDim2.new(0,56,0,26),
        Size = UDim2.new(0,100,0,16),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = UserProfile.Instance
    })

    -- 📌 RIGHT CONTENT AREA (ScrollingFrame)
    local ContentScroll = Base.new("ScrollingFrame", {
        Size = UDim2.new(1, -self.Theme.SidebarWidth, 1, 0),
        Position = UDim2.new(0, self.Theme.SidebarWidth, 0, 0),
        BackgroundColor3 = self.Theme.ContentBg,
        BackgroundTransparency = 0.1,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = self.Theme.ScrollbarColor,
        ClipsDescendants = true,
        Parent = MainContainer.Instance
    })
    Instance.new("UICorner", ContentScroll.Instance).CornerRadius = self.Theme.CornerRadius
    ContentScroll.Instance.CanvasSize = UDim2.new(0,0,0,0)

    -- ✅ SLIDER FUNCTION
    function Window:AddSlider(config)
        config = config or {}
        local Name = config.Name or "Slider"
        local Min = config.Min or 0
        local Max = config.Max or 100
        local Default = math.clamp(config.Default or Min, Min, Max)
        local Step = config.Step or 1
        local Callback = config.Callback or function() end

        local offset = ContentScroll.Instance:GetAttribute("SliderOffset") or 10
        ContentScroll.Instance:SetAttribute("SliderOffset", offset + 70)

        local SliderContainer = Base.new("Frame", {
            Size = UDim2.new(1, -20, 0, 60),
            Position = UDim2.new(0, 10, 0, offset),
            BackgroundTransparency = 1,
            Parent = ContentScroll.Instance
        })

        ContentScroll.Instance.CanvasSize = UDim2.new(0,0,0, offset + 70)

        local Label = Base.new("TextLabel", {
            Text = Name .. " : " .. Default,
            Font = Enum.Font.GothamSemibold,
            TextSize = 14,
            TextColor3 = self.Theme.TextColor,
            Size = UDim2.new(1,0,0,20),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = SliderContainer.Instance
        })

        local Track = Base.new("Frame", {
            Size = UDim2.new(1,0,0,6),
            Position = UDim2.new(0,0,0,30),
            BackgroundColor3 = self.Theme.SliderTrack,
            Parent = SliderContainer.Instance
        })
        Instance.new("UICorner", Track.Instance).CornerRadius = UDim.new(0,3)

        local Fill = Base.new("Frame", {
            Size = UDim2.new((Default-Min)/(Max-Min),0,1,0),
            BackgroundColor3 = self.Theme.SliderFill,
            Parent = Track.Instance
        })
        Instance.new("UICorner", Fill.Instance).CornerRadius = UDim.new(0,3)

        local Knob = Base.new("Frame", {
            Size = UDim2.new(0,16,0,16),
            Position = UDim2.new((Default-Min)/(Max-Min), -8, 0.5, -8),
            BackgroundColor3 = self.Theme.SliderKnob,
            ZIndex = 2,
            Parent = Track.Instance
        })
        Instance.new("UICorner", Knob.Instance).CornerRadius = UDim.new(0,8)

        local Dragging = false
        local function UpdateSlider(x)
            local relX = math.clamp(x / Track.Instance.AbsoluteSize.X, 0, 1)
            local val = Min + math.floor((relX*(Max-Min))/Step + 0.5)*Step
            val = math.clamp(val, Min, Max)
            relX = (val-Min)/(Max-Min)
            Fill.Instance.Size = UDim2.new(relX,0,1,0)
            Knob.Instance.Position = UDim2.new(relX, -8, 0.5, -8)
            Label.Instance.Text = Name .. " : " .. val
            Callback(val)
        end

        Knob.Instance.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then Dragging = true end
        end)
        Track.Instance.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                UpdateSlider(i.Position.X - Track.Instance.AbsolutePosition.X)
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if not Dragging then return end
            if i.UserInputType ~= Enum.UserInputType.MouseMovement and i.UserInputType ~= Enum.UserInputType.Touch then return end
            UpdateSlider(i.Position.X - Track.Instance.AbsolutePosition.X)
        end)
        UserInputService.InputEnded:Connect(function() Dragging = false end)
    end

    -- ✅ ONLY 1 TAB: MOVEMENTS
    local MovementsTab = Base.new("TextButton", {
        Size = UDim2.new(1, -12, 0, 36),
        Position = UDim2.new(0, 6, 0, 6),
        BackgroundColor3 = self.Theme.TabSelected,
        BackgroundTransparency = 0.4,
        Font = Enum.Font.GothamSemibold,
        TextColor3 = self.Theme.TextColor,
        Text = "Movements",
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = SidebarScroll.Instance
    })
    Instance.new("UICorner", MovementsTab.Instance).CornerRadius = UDim.new(0,6)

    Base.new("ImageLabel", {
        Size = UDim2.new(0,18,0,18),
        Position = UDim2.new(0,8,0.5,-9),
        BackgroundTransparency = 1,
        ImageColor3 = self.Theme.TextColor,
        Parent = MovementsTab.Instance
    })

    Base.new("TextLabel", {
        Text = "Movements",
        Font = Enum.Font.GothamSemibold,
        TextSize = 14,
        TextColor3 = self.Theme.TextColor,
        Position = UDim2.new(0,32,0,0),
        Size = UDim2.new(1,-36,1,0),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = MovementsTab.Instance
    })

    -- ✅ CONTENT NG MOVEMENTS TAB (MGA SLIDERS)
    ContentScroll.Instance:ClearAllChildren()
    ContentScroll.Instance:SetAttribute("SliderOffset", 10)
    ContentScroll.Instance.CanvasSize = UDim2.new(0,0,0,0)

    Base.new("TextLabel", {
        Text = "Movement Settings",
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        TextColor3 = self.Theme.TextColor,
        Size = UDim2.new(1,-20,0,30),
        Position = UDim2.new(0,10,0,10),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = ContentScroll.Instance
    })

    -- MGA SLIDERS
    Window:AddSlider({
        Name = "Walk Speed",
        Min = 16,
        Max = 250,
        Default = 16,
        Step = 2,
        Callback = function(val)
            print("Walk Speed =", val)
            -- pwedeng ilagay dito ang code para baguhin ang bilis
            -- LocalPlayer.Character.Humanoid.WalkSpeed = val
        end
    })

    Window:AddSlider({
        Name = "Jump Power",
        Min = 0,
        Max = 300,
        Default = 50,
        Step = 5,
        Callback = function(val)
            print("Jump Power =", val)
            -- LocalPlayer.Character.Humanoid.JumpPower = val
        end
    })

    Window:AddSlider({
        Name = "Gravity",
        Min = 0,
        Max = 200,
        Default = 100,
        Step = 10,
        Callback = function(val)
            print("Gravity =", val)
        end
    })

    -- Drag function
    local DragStart, StartPos
    DragArea.Instance.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            DragStart = Vector2.new(i.Position.X, i.Position.Y)
            StartPos = Window.Instance.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if not DragStart then return end
        if i.UserInputType ~= Enum.UserInputType.MouseMovement and i.UserInputType ~= Enum.UserInputType.Touch then return end
        local delta = Vector2.new(i.Position.X, i.Position.Y) - DragStart
        Window.Instance.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
    end)
    UserInputService.InputEnded:Connect(function() DragStart = nil end)

    -- Close button
    CloseBtn.Instance.Activated:Connect(function() Window.Instance:Destroy() end)

    return Window
end

-- 🚀 PAGPAPATULOY NG UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoidwareUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Window = MyUILib:CreateWindow()
Window.Instance.Parent = ScreenGui

return MyUILib
