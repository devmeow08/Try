--// VOIDWARE UI - HEIGHT ONLY AUTO-SIZE
--// No fixed width, height starts at 0, auto-adjusts

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local MyUILib = {}
MyUILib.__index = MyUILib

-- 🧩 Load Lucide Icons
local Lucide = nil
pcall(function()
    Lucide = loadstring(game:HttpGet("https://raw.githubusercontent.com/latte-soft/lucide-roblox/refs/heads/master/lib/Icons.luau"))()
end)

-- 🎨 THEME SETTINGS
MyUILib.Theme = {
    WindowBg = Color3.fromRGB(216, 128, 255),
    SidebarBg = Color3.fromRGB(70, 30, 110),
    ContentBg = Color3.fromRGB(90, 40, 140),
    SearchBg = Color3.fromRGB(60, 25, 100),
    TabSelected = Color3.fromRGB(100, 45, 160),
    UserProfileBg = Color3.fromRGB(65, 28, 105),
    ScrollbarColor = Color3.fromRGB(150, 80, 200),
    SliderBg = Color3.fromRGB(120, 60, 180),
    SliderFill = Color3.fromRGB(200, 120, 255),
    SliderKnob = Color3.fromRGB(255, 255, 255),
    SliderText = Color3.fromRGB(230, 230, 230),
    IconColor = Color3.new(1, 1, 1),
    IconTransparency = 0.1,
    TextColor = Color3.new(1, 1, 1),
    HeaderIcon = "user-round",
    HeaderTitle = "Voidware",
    HeaderSubtitle = "discord.gg/voidware",
    HeaderFont = Enum.Font.GothamBold,
    HeaderTextSize = 16,
    HeaderSubtitleSize = 12,
    HeaderTextTransparency = 0.1,
    HeaderSubtitleTransparency = 0.3,
    HeaderIconSize = 24,
    CornerRadius = UDim.new(0, 8),
    NormalWindowSize = UDim2.new(0, 720, 0, 480),
    NormalWindowPos = UDim2.new(0.5, -360, 0.5, -240),
    MinimizedBarSize = UDim2.new(0, 240, 0, 36),
    MinimizedBarPos = UDim2.new(0.5, -120, 0, 12),
    HeaderHeight = 40,
    SidebarWidth = 180,
    UserProfileHeight = 64,
    MinWindowWidth = 450,
    MinWindowHeight = 320,
    TweenTime = 0.2,
    TweenStyle = Enum.EasingStyle.Quad,
    TweenDirection = Enum.EasingDirection.Out,
    NormalTransparency = 0,
    MinimizedTransparency = 0.3
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
        BackgroundTransparency = self.Theme.NormalTransparency,
        Size = self.Theme.NormalWindowSize,
        Position = self.Theme.NormalWindowPos,
        ClipsDescendants = true,
        ZIndex = 10,
        Active = true
    })

    Instance.new("UICorner", Window.Instance).CornerRadius = self.Theme.CornerRadius
    local Border = Instance.new("UIStroke", Window.Instance)
    Border.Color = Color3.new(0,0,0)
    Border.Transparency = 0.75
    Border.Thickness = 1

    -- 📌 HEADER / DRAG AREA
    local DragArea = Base.new("Frame", {
        Size = UDim2.new(1, 0, 0, self.Theme.HeaderHeight),
        BackgroundTransparency = 1,
        Parent = Window.Instance
    })

    local HeaderContainer = Base.new("Frame", {
        Size = UDim2.new(0, 280, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1,
        Parent = DragArea.Instance
    })

    local HeaderIcon = Base.new("ImageLabel", {
        Size = UDim2.new(0, self.Theme.HeaderIconSize, 0, self.Theme.HeaderIconSize),
        Position = UDim2.new(0, 0, 0.5, -self.Theme.HeaderIconSize/2),
        BackgroundTransparency = 1,
        ImageColor3 = self.Theme.IconColor,
        ImageTransparency = self.Theme.IconTransparency,
        Parent = HeaderContainer.Instance
    })

    if Lucide and Lucide["48px"][self.Theme.HeaderIcon] then
        HeaderIcon.Instance.Image = "rbxassetid://" .. Lucide["48px"][self.Theme.HeaderIcon][1]
        HeaderIcon.Instance.ImageRectSize = Vector2.new(unpack(Lucide["48px"][self.Theme.HeaderIcon][2]))
        HeaderIcon.Instance.ImageRectOffset = Vector2.new(unpack(Lucide["48px"][self.Theme.HeaderIcon][3]))
    end

    Base.new("TextLabel", {
        Text = self.Theme.HeaderTitle,
        Font = self.Theme.HeaderFont,
        TextSize = self.Theme.HeaderTextSize,
        TextColor3 = self.Theme.TextColor,
        TextTransparency = self.Theme.HeaderTextTransparency,
        Size = UDim2.new(1, 0, 0, 18),
        Position = UDim2.new(0, self.Theme.HeaderIconSize + 10, 0, 0),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = HeaderContainer.Instance
    })

    Base.new("TextLabel", {
        Text = self.Theme.HeaderSubtitle,
        Font = Enum.Font.Gotham,
        TextSize = self.Theme.HeaderSubtitleSize,
        TextColor3 = self.Theme.TextColor,
        TextTransparency = self.Theme.HeaderSubtitleTransparency,
        Size = UDim2.new(1, 0, 0, 14),
        Position = UDim2.new(0, self.Theme.HeaderIconSize + 10, 0, 20),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = HeaderContainer.Instance
    })

    -- 🎛️ CONTROL BUTTONS
    local Controls = Base.new("Frame", {
        Size = UDim2.new(0, 96, 0, 28),
        Position = UDim2.new(1, -104, 0, 6),
        BackgroundTransparency = 1,
        Parent = DragArea.Instance
    })

    local function CreateBtn(iconName, posX, parent)
        local Btn = Base.new("TextButton", {
            Text = "",
            Size = UDim2.new(0, 28, 0, 28),
            Position = UDim2.new(0, posX, 0, 0),
            BackgroundTransparency = 1,
            AutoButtonColor = false,
            Parent = parent or Controls.Instance
        })

        local Icon = Base.new("ImageLabel", {
            Size = UDim2.new(0, 14, 0, 14),
            Position = UDim2.new(0.5, -7, 0.5, -7),
            BackgroundTransparency = 1,
            ImageColor3 = self.Theme.IconColor,
            ImageTransparency = self.Theme.IconTransparency,
            Parent = Btn.Instance
        })

        if Lucide and Lucide["48px"][iconName] then
            Icon.Instance.Image = "rbxassetid://" .. Lucide["48px"][iconName][1]
            Icon.Instance.ImageRectSize = Vector2.new(unpack(Lucide["48px"][iconName][2]))
            Icon.Instance.ImageRectOffset = Vector2.new(unpack(Lucide["48px"][iconName][3]))
        end

        return Btn
    end

    local MinimizeBtn = CreateBtn("minus", 0)
    local MaximizeBtn = CreateBtn("maximize", 34)
    local CloseBtn = CreateBtn("x", 68)

    -- ✅ MAIN CONTAINER
    local MainContentContainer = Base.new("Frame", {
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
        BackgroundTransparency = 0.05,
        Parent = MainContentContainer.Instance
    })
    Instance.new("UICorner", Sidebar.Instance).CornerRadius = self.Theme.CornerRadius

    -- Search Bar
    local SearchBox = Base.new("Frame", {
        Size = UDim2.new(1, -12, 0, 38),
        Position = UDim2.new(0, 6, 0, 6),
        BackgroundColor3 = self.Theme.SearchBg,
        BackgroundTransparency = 0.1,
        Parent = Sidebar.Instance
    })
    Instance.new("UICorner", SearchBox.Instance).CornerRadius = UDim.new(0, 6)

    Base.new("ImageLabel", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 8, 0.5, -8),
        BackgroundTransparency = 1,
        ImageColor3 = self.Theme.TextColor,
        ImageTransparency = 0.25,
        Image = Lucide and "rbxassetid://"..Lucide["48px"]["search"][1] or "",
        Parent = SearchBox.Instance
    })

    local SearchInput = Base.new("TextBox", {
        Size = UDim2.new(1, -32, 1, 0),
        Position = UDim2.new(0, 32, 0, 0),
        BackgroundTransparency = 1,
        PlaceholderText = "Search tabs...",
        PlaceholderColor3 = Color3.new(0.75,0.75,0.75),
        Font = Enum.Font.Gotham,
        TextSize = 14,
        TextColor3 = self.Theme.TextColor,
        ClearTextOnFocus = false,
        Parent = SearchBox.Instance
    })

    -- Tab Scroll
    local SidebarScroll = Base.new("ScrollingFrame", {
        Size = UDim2.new(1,0,1,-50-self.Theme.UserProfileHeight),
        Position = UDim2.new(0,0,0,50),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 5,
        ScrollBarImageColor3 = self.Theme.ScrollbarColor,
        Parent = Sidebar.Instance
    })
    SidebarScroll.Instance.CanvasSize = UDim2.new(0,0,0,0)
    SidebarScroll.Instance.AutomaticCanvasSize = Enum.AutomaticSize.Y

    -- User Profile
    local UserProfile = Base.new("Frame", {
        Size = UDim2.new(1,0,0,self.Theme.UserProfileHeight),
        Position = UDim2.new(0,0,1,-self.Theme.UserProfileHeight),
        BackgroundColor3 = self.Theme.UserProfileBg,
        BackgroundTransparency = 0.1,
        Parent = Sidebar.Instance
    })
    Instance.new("UICorner", UserProfile.Instance).CornerRadius = UDim.new(0,6)

    local Avatar = Base.new("ImageLabel", {
        Size = UDim2.new(0,42,0,42),
        Position = UDim2.new(0,8,0.5,-21),
        BackgroundColor3 = Color3.new(0,0,0),
        Parent = UserProfile.Instance
    })
    Instance.new("UICorner", Avatar.Instance).CornerRadius = UDim.new(0,8)
    local success, url = pcall(Players.GetUserThumbnailAsync, Players, LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    Avatar.Instance.Image = success and url or "rbxassetid://6034220868"

    Base.new("TextLabel", {
        Text = LocalPlayer.DisplayName or LocalPlayer.Name,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = self.Theme.TextColor,
        Position = UDim2.new(0,52,0,8),
        Size = UDim2.new(1,-56,0,18),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = UserProfile.Instance
    })

    Base.new("TextLabel", {
        Text = "@"..LocalPlayer.Name,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextColor3 = self.Theme.TextColor,
        TextTransparency = 0.3,
        Position = UDim2.new(0,52,0,26),
        Size = UDim2.new(1,-56,0,14),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = UserProfile.Instance
    })

    -- ✅ RIGHT CONTENT AREA - WIDTH REMOVED, ONLY HEIGHT 0
    local ContentScroll = Base.new("ScrollingFrame", {
        Size = UDim2.new(1, -self.Theme.SidebarWidth, 1, 0),
        Position = UDim2.new(0, self.Theme.SidebarWidth, 0, 0),
        BackgroundColor3 = self.Theme.ContentBg,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.Y, -- Only height updates
        CanvasSize = UDim2.new(0, 0, 0, 0), -- No fixed width, height starts at 0
        Parent = MainContentContainer.Instance
    })
    Instance.new("UICorner", ContentScroll.Instance).CornerRadius = self.Theme.CornerRadius

    -- Layout to auto-arrange elements
    local ContentLayout = Instance.new("UIListLayout", ContentScroll.Instance)
    ContentLayout.Padding = UDim.new(0, 20)
    ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.FillDirection = Enum.FillDirection.Vertical

    -- 📋 TAB LOGIC
    local Tabs = {{Name = "Movements", Icon = "shoe-print"}}
    local TabButtons = {}
    local TweenInfo = TweenInfo.new(self.Theme.TweenTime, self.Theme.TweenStyle, self.Theme.TweenDirection)

    for i, tab in ipairs(Tabs) do
        local TabBtn = Base.new("TextButton", {
            Size = UDim2.new(1,-12,0,40),
            Position = UDim2.new(0,6,0,(i-1)*46),
            BackgroundTransparency = 1,
            AutoButtonColor = false,
            Parent = SidebarScroll.Instance
        })
        Instance.new("UICorner", TabBtn.Instance).CornerRadius = UDim.new(0,6)

        Base.new("ImageLabel", {
            Size = UDim2.new(0,18,0,18),
            Position = UDim2.new(0,10,0.5,-9),
            BackgroundTransparency = 1,
            ImageColor3 = self.Theme.TextColor,
            Image = Lucide and "rbxassetid://"..Lucide["48px"][tab.Icon][1] or "",
            Parent = TabBtn.Instance
        })

        Base.new("TextLabel", {
            Text = tab.Name,
            Font = Enum.Font.GothamSemibold,
            TextSize = 14,
            TextColor3 = self.Theme.TextColor,
            BackgroundTransparency = 1,
            Position = UDim2.new(0,36,0,0),
            Size = UDim2.new(1,-40,1,0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = TabBtn.Instance
        })

        TabBtn.Instance.Activated:Connect(function()
            for _,b in ipairs(TabButtons) do
                TweenService:Create(b.Button, TweenInfo, {BackgroundTransparency=1, BackgroundColor3=self.Theme.SidebarBg}):Play()
            end
            TweenService:Create(TabBtn.Instance, TweenInfo, {BackgroundTransparency=0.4, BackgroundColor3=self.Theme.TabSelected}):Play()

            -- Clear content, keep layout
            ContentScroll.Instance:ClearAllChildren()
            ContentLayout.Parent = ContentScroll.Instance

            -- ✅ WALK SPEED SLIDER
            Base.new("TextLabel", {
                Text = "Walk Speed",
                Font = Enum.Font.GothamBold,
                TextSize = 18,
                TextColor3 = self.Theme.TextColor,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 130, 0, 24),
                Position = UDim2.new(0, 16, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = 1,
                Parent = ContentScroll.Instance
            })

            local SliderContainer = Base.new("Frame", {
                Size = UDim2.new(1, -32, 0, 40),
                Position = UDim2.new(0, 16, 0, 0),
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Parent = ContentScroll.Instance
            })

            local SpeedLabel = Base.new("TextLabel", {
                Text = "16",
                Font = Enum.Font.Gotham,
                TextSize = 16,
                TextColor3 = self.Theme.SliderText,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 40, 1, 0),
                Position = UDim2.new(1, -45, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Right,
                Parent = SliderContainer.Instance
            })

            local SliderBg = Base.new("Frame", {
                Size = UDim2.new(1, -50, 0, 5),
                Position = UDim2.new(0, 0, 0.5, -2.5),
                BackgroundColor3 = self.Theme.SliderBg,
                BackgroundTransparency = 0.15,
                Parent = SliderContainer.Instance
            })
            Instance.new("UICorner", SliderBg.Instance).CornerRadius = UDim.new(0, 2.5)

            local SliderFill = Base.new("Frame", {
                Size = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = self.Theme.SliderFill,
                Parent = SliderBg.Instance
            })
            Instance.new("UICorner", SliderFill.Instance).CornerRadius = UDim.new(0, 2.5)

            local SliderKnob = Base.new("Frame", {
                Size = UDim2.new(0,14,0,14),
                Position = UDim2.new(0,-7,0.5,-7),
                BackgroundColor3 = self.Theme.SliderKnob,
                ZIndex = 2,
                Parent = SliderFill.Instance
            })
            Instance.new("UICorner", SliderKnob.Instance).CornerRadius = UDim.new(0,7)

            local MinSpeed, MaxSpeed, CurrentSpeed = 16, 300, 16
            local function Update(v)
                CurrentSpeed = math.clamp(math.floor(v+0.5), MinSpeed, MaxSpeed)
                local pct = (CurrentSpeed-MinSpeed)/(MaxSpeed-MinSpeed)
                SliderFill.Instance.Size = UDim2.new(pct,0,1,0)
                SpeedLabel.Instance.Text = tostring(CurrentSpeed)
                if Humanoid and Humanoid:IsDescendantOf(game) then Humanoid.WalkSpeed = CurrentSpeed end
            end

            LocalPlayer.CharacterAdded:Connect(function(c) Character=c; Humanoid=c:WaitForChild("Humanoid",10); if Humanoid then Humanoid.WalkSpeed=CurrentSpeed end end)

            local dragging = false
            SliderBg.Instance.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true; local x = i.Position.X - SliderBg.Instance.AbsolutePosition.X; Update(MinSpeed + (MaxSpeed-MinSpeed)*math.clamp(x/SliderBg.Instance.AbsoluteSize.X,0,1)) end end)
            UserInputService.InputChanged:Connect(function(i) if not dragging then return end; if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then local x = i.Position.X - SliderBg.Instance.AbsolutePosition.X; Update(MinSpeed + (MaxSpeed-MinSpeed)*math.clamp(x/SliderBg.Instance.AbsoluteSize.X,0,1)) end end)
            UserInputService.InputEnded:Connect(function() dragging=false end)
            Update(16)
        end)

        table.insert(TabButtons, {Button = TabBtn.Instance, Name = tab.Name})
    end

    SidebarScroll.Instance.CanvasSize = UDim2.new(0,0,0,#Tabs*46)
    TabButtons[1].Button.BackgroundTransparency = 0.4
    TabButtons[1].Button.BackgroundColor3 = self.Theme.TabSelected

    -- ✅ DRAG & RESIZE LOGIC
    local DragStart, MouseStart
    DragArea.Instance.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then local pos = Vector2.new(i.Position.X,i.Position.Y); local c = Controls.Instance.AbsolutePosition; local cs = Controls.Instance.AbsoluteSize; if not (pos.X>=c.X and pos.X<=c.X+cs.X and pos.Y>=c.Y and pos.Y<=c.Y+cs.Y) then DragStart=Window.Instance.Position; MouseStart=pos end end end)
    UserInputService.InputChanged:Connect(function(i) if not DragStart then return end; if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then local delta = Vector2.new(i.Position.X,i.Position.Y)-MouseStart; Window.Instance.Position = UDim2.new(DragStart.X.Scale, DragStart.X.Offset+delta.X, DragStart.Y.Scale, DragStart.Y.Offset+delta.Y) end end)
    UserInputService.InputEnded:Connect(function() DragStart=nil end)

    local ResizeHandle = Base.new("Frame", {Size=UDim2.new(0,16,0,16), Position=UDim2.new(1,-16,1,-16), BackgroundTransparency=1, Parent=Window.Instance, ZIndex=20})
    Base.new("TextLabel", {Text="⤢", Font=Enum.Font.GothamBold, TextSize=12, TextColor3=Color3.new(1,1,1), Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Parent=ResizeHandle.Instance})
    local ResizeStart, ResizeMouse
    ResizeHandle.Instance.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then ResizeStart=Window.Instance.Size; ResizeMouse=Vector2.new(i.Position.X,i.Position.Y) end end)
    UserInputService.InputChanged:Connect(function(i) if not ResizeStart then return end; if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then local d = Vector2.new(i.Position.X,i.Position.Y)-ResizeMouse; local w = math.max(ResizeStart.X.Offset+d.X, self.Theme.MinWindowWidth); local h = math.max(ResizeStart.Y.Offset+d.Y, self.Theme.MinWindowHeight); Window.Instance.Size=UDim2.new(0,w,0,h) end end)
    UserInputService.InputEnded:Connect(function() ResizeStart=nil end)

    -- Minimize/Maximize/Close
    local Minimized = false
    MinimizeBtn.Instance.Activated:Connect(function() if not Minimized then TweenService:Create(Window.Instance, TweenInfo, {Size=self.Theme.MinimizedBarSize, Position=self.Theme.MinimizedBarPos, BackgroundTransparency=self.Theme.MinimizedTransparency}):Play(); task.wait(0.1); MainContentContainer.Instance.Visible=false; ResizeHandle.Instance.Visible=false; MinimizeBtn.Instance.Visible=false; CloseBtn.Instance.Visible=false; MaximizeBtn.Instance.Position=UDim2.new(1,-32,0,0); Minimized=true end end)
    MaximizeBtn.Instance.Activated:Connect(function() if Minimized then MainContentContainer.Instance.Visible=true; ResizeHandle.Instance.Visible=true; MinimizeBtn.Instance.Visible=true; CloseBtn.Instance.Visible=true; MaximizeBtn.Instance.Position=UDim2.new(0,34,0,0); TweenService:Create(Window.Instance, TweenInfo, {Size=self.Theme.NormalWindowSize, Position=self.Theme.NormalWindowPos, BackgroundTransparency=self.Theme.NormalTransparency}):Play(); Minimized=false end end)
    CloseBtn.Instance.Activated:Connect(function() Window.Instance:Destroy() end)

    return Window
end

-- 🚀 INITIALIZE
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoidwareUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Window = MyUILib:CreateWindow()
Window.Instance.Parent = ScreenGui

return MyUILib
