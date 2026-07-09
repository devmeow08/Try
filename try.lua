--// VOIDWARE UI - FULL VERSION
--// Optimized for Android / Touch Screen
--// Updated Slider Style matching your example

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
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
    SidebarBg = Color3.fromRGB(90, 30, 130),
    ContentBg = Color3.fromRGB(110, 40, 150),
    SearchBg = Color3.fromRGB(70, 25, 110),
    TabSelected = Color3.fromRGB(150, 60, 210),
    UserProfileBg = Color3.fromRGB(80, 28, 120),
    ScrollbarColor = Color3.fromRGB(180, 100, 220),
    -- 🎨 Updated Slider Colors matching your example
    SliderBg = Color3.fromRGB(85, 45, 115),
    SliderFill = Color3.fromRGB(230, 160, 255),
    SliderKnob = Color3.fromRGB(255, 255, 255),
    SliderText = Color3.fromRGB(220, 220, 220),
    IconColor = Color3.new(1, 1, 1),
    IconTransparency = 0.2,
    TextColor = Color3.new(1, 1, 1),
    HeaderIcon = "user-round",
    HeaderTitle = "Voidware",
    HeaderSubtitle = "discord.gg/voidware",
    HeaderFont = Enum.Font.GothamBold,
    HeaderTextSize = 15,
    HeaderSubtitleSize = 11,
    HeaderTextTransparency = 0.2,
    HeaderSubtitleTransparency = 0.35,
    HeaderIconSize = 25,
    CornerRadius = UDim.new(0, 10),
    NormalWindowSize = UDim2.new(0, 650, 0, 450),
    NormalWindowPos = UDim2.new(0.5, -325, 0.5, -225),
    MinimizedBarSize = UDim2.new(0, 240, 0, 36),
    MinimizedBarPos = UDim2.new(0.5, -120, 0, 12),
    HeaderHeight = 36,
    SidebarWidth = 160,
    UserProfileHeight = 60,
    MinWindowWidth = 420,
    MinWindowHeight = 280,
    TweenTime = 0.22,
    TweenStyle = Enum.EasingStyle.Quad,
    TweenDirection = Enum.EasingDirection.Out,
    NormalTransparency = 0,
    MinimizedTransparency = 0.4
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
        ZIndex = 10
    })

    Instance.new("UICorner", Window.Instance).CornerRadius = self.Theme.CornerRadius
    local Border = Instance.new("UIStroke", Window.Instance)
    Border.Color = Color3.new(0, 0, 0)
    Border.Transparency = 0.8
    Border.Thickness = 1

    -- 📌 HEADER / DRAG AREA
    local DragArea = Base.new("Frame", {
        Size = UDim2.new(1, 0, 0, self.Theme.HeaderHeight),
        BackgroundTransparency = 1,
        Parent = Window.Instance
    })

    -- 📝 HEADER CONTENT
    local HeaderContainer = Base.new("Frame", {
        Size = UDim2.new(0, 260, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Parent = DragArea.Instance
    })

    -- 🖼️ HEADER ICON
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
    else
        Base.new("TextLabel", {
            Text = "●",
            Font = Enum.Font.GothamBold,
            TextSize = 22,
            TextColor3 = self.Theme.IconColor,
            TextTransparency = self.Theme.IconTransparency,
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            Parent = HeaderIcon.Instance
        })
    end

    -- 📄 TITLE + SUBTITLE
    local TextContainer = Base.new("Frame", {
        Size = UDim2.new(0, 220, 1, 0),
        Position = UDim2.new(0, self.Theme.HeaderIconSize + 10, 0, 4),
        BackgroundTransparency = 1,
        Parent = HeaderContainer.Instance
    })

    Base.new("TextLabel", {
        Text = self.Theme.HeaderTitle,
        Font = self.Theme.HeaderFont,
        TextSize = self.Theme.HeaderTextSize,
        TextColor3 = self.Theme.TextColor,
        TextTransparency = self.Theme.HeaderTextTransparency,
        Size = UDim2.new(1, 0, 0, 16),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = TextContainer.Instance
    })

    Base.new("TextLabel", {
        Text = self.Theme.HeaderSubtitle,
        Font = Enum.Font.Gotham,
        TextSize = self.Theme.HeaderSubtitleSize,
        TextColor3 = self.Theme.TextColor,
        TextTransparency = self.Theme.HeaderSubtitleTransparency,
        Size = UDim2.new(1, 0, 0, 12),
        Position = UDim2.new(0, 0, 0, 16),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = TextContainer.Instance
    })

    -- 🎛️ CONTROL BUTTONS
    local Controls = Base.new("Frame", {
        Size = UDim2.new(0, 88, 0, 28),
        Position = UDim2.new(1, -96, 0, 4),
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
        else
            local fallback = { minus = "—", maximize = "⛶", x = "✕" }
            Base.new("TextLabel", {
                Text = fallback[iconName] or "?",
                Font = Enum.Font.GothamBold,
                TextSize = 16,
                TextColor3 = self.Theme.IconColor,
                TextTransparency = self.Theme.IconTransparency,
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Parent = Icon.Instance
            })
        end

        return Btn
    end

    local MinimizeBtn = CreateBtn("minus", 0)
    local MaximizeBtn = CreateBtn("maximize", 32)
    local CloseBtn = CreateBtn("x", 64)

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

    -- ✅ SEARCH BAR
    local SearchBox = Base.new("Frame", {
        Size = UDim2.new(1, -12, 0, 36),
        Position = UDim2.new(0, 6, 0, 6),
        BackgroundColor3 = self.Theme.SearchBg,
        BackgroundTransparency = 0.15,
        Parent = Sidebar.Instance
    })
    Instance.new("UICorner", SearchBox.Instance).CornerRadius = UDim.new(0, 6)

    local SearchIcon = Base.new("ImageLabel", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 8, 0.5, -8),
        BackgroundTransparency = 1,
        ImageColor3 = self.Theme.TextColor,
        ImageTransparency = 0.3,
        Parent = SearchBox.Instance
    })
    if Lucide and Lucide["48px"]["search"] then
        SearchIcon.Instance.Image = "rbxassetid://" .. Lucide["48px"]["search"][1]
        SearchIcon.Instance.ImageRectSize = Vector2.new(unpack(Lucide["48px"]["search"][2]))
        SearchIcon.Instance.ImageRectOffset = Vector2.new(unpack(Lucide["48px"]["search"][3]))
    end

    local SearchInput = Base.new("TextBox", {
        Size = UDim2.new(1, -32, 1, 0),
        Position = UDim2.new(0, 32, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        PlaceholderText = "Search tabs...",
        PlaceholderColor3 = Color3.new(0.8, 0.8, 0.8),
        Font = Enum.Font.Gotham,
        TextSize = 14,
        TextColor3 = self.Theme.TextColor,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        Parent = SearchBox.Instance
    })

    -- ✅ SCROLL FRAME FOR TABS (REMAINS WITH SCROLLBAR)
    local SidebarScroll = Base.new("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -48 - self.Theme.UserProfileHeight),
        Position = UDim2.new(0, 0, 0, 48),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        ScrollBarImageColor3 = self.Theme.ScrollbarColor,
        VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
        Parent = Sidebar.Instance
    })
    SidebarScroll.Instance.CanvasSize = UDim2.new(0, 0, 0, 0)

    -- ✅ AUTO USER PROFILE SECTION
    local UserProfile = Base.new("Frame", {
        Size = UDim2.new(1, 0, 0, self.Theme.UserProfileHeight),
        Position = UDim2.new(0, 0, 1, -self.Theme.UserProfileHeight),
        BackgroundColor3 = self.Theme.UserProfileBg,
        BackgroundTransparency = 0.1,
        Parent = Sidebar.Instance
    })
    Instance.new("UICorner", UserProfile.Instance).CornerRadius = UDim.new(0, 6)

    -- User Avatar
    local UserAvatar = Base.new("ImageLabel", {
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(0, 8, 0.5, -20),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.new(0,0,0),
        Parent = UserProfile.Instance
    })
    Instance.new("UICorner", UserAvatar.Instance).CornerRadius = UDim.new(0, 8)

    -- Auto-load avatar thumbnail
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    local success, avatarUrl = pcall(Players.GetUserThumbnailAsync, Players, LocalPlayer.UserId, thumbType, thumbSize)
    if success then
        UserAvatar.Instance.Image = avatarUrl
    else
        UserAvatar.Instance.Image = "rbxassetid://6034220868"
    end

    -- Username & Display Name
    local UserInfoContainer = Base.new("Frame", {
        Size = UDim2.new(1, -56, 1, 0),
        Position = UDim2.new(0, 52, 0, 0),
        BackgroundTransparency = 1,
        Parent = UserProfile.Instance
    })

    Base.new("TextLabel", {
        Text = LocalPlayer.DisplayName or LocalPlayer.Name,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = self.Theme.TextColor,
        TextTransparency = 0.15,
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, 8),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = UserInfoContainer.Instance
    })

    Base.new("TextLabel", {
        Text = "@" .. LocalPlayer.Name,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextColor3 = self.Theme.TextColor,
        TextTransparency = 0.35,
        Size = UDim2.new(1, 0, 0, 16),
        Position = UDim2.new(0, 0, 0, 28),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = UserInfoContainer.Instance
    })

    -- ✅ RIGHT CONTENT AREA (SCROLLBAR REMOVED, BUT STILL SCROLLABLE)
    local ContentScroll = Base.new("ScrollingFrame", {
        Size = UDim2.new(1, -self.Theme.SidebarWidth, 1, 0),
        Position = UDim2.new(0, self.Theme.SidebarWidth, 0, 0),
        BackgroundColor3 = self.Theme.ContentBg,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        ScrollBarImageColor3 = Color3.new(0,0,0,0),
        VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
        CanvasSize = UDim2.new(1, 0, 0, 300),
        Parent = MainContainer.Instance
    })
    Instance.new("UICorner", ContentScroll.Instance).CornerRadius = self.Theme.CornerRadius

    -- 📋 TAB LIST - ISA LANG: MOVEMENTS
    local Tabs = {
        {Name = "Movements", Icon = "shoe-print"}
    }

    local TabButtons = {}
    local TweenInfo = TweenInfo.new(self.Theme.TweenTime, self.Theme.TweenStyle, self.Theme.TweenDirection)

    -- Create each tab button
    for i, tabData in ipairs(Tabs) do
        local TabBtn = Base.new("TextButton", {
            Size = UDim2.new(1, -12, 0, 36),
            Position = UDim2.new(0, 6, 0, (i-1)*42),
            BackgroundTransparency = 1,
            AutoButtonColor = false,
            Text = "",
            Visible = true,
            Parent = SidebarScroll.Instance
        })
        Instance.new("UICorner", TabBtn.Instance).CornerRadius = UDim.new(0, 6)

        local TabIcon = Base.new("ImageLabel", {
            Size = UDim2.new(0, 18, 0, 18),
            Position = UDim2.new(0, 10, 0.5, -9),
            BackgroundTransparency = 1,
            ImageColor3 = self.Theme.TextColor,
            ImageTransparency = 0.2,
            Parent = TabBtn.Instance
        })
        if Lucide and Lucide["48px"][tabData.Icon] then
            TabIcon.Instance.Image = "rbxassetid://" .. Lucide["48px"][tabData.Icon][1]
            TabIcon.Instance.ImageRectSize = Vector2.new(unpack(Lucide["48px"][tabData.Icon][2]))
            TabIcon.Instance.ImageRectOffset = Vector2.new(unpack(Lucide["48px"][tabData.Icon][3]))
        end

        Base.new("TextLabel", {
            Text = tabData.Name,
            Font = Enum.Font.GothamSemibold,
            TextSize = 14,
            TextColor3 = self.Theme.TextColor,
            TextTransparency = 0.2,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -40, 1, 0),
            Position = UDim2.new(0, 36, 0, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = TabBtn.Instance
        })

        -- ✅ PININDOT ANG TAB
        TabBtn.Instance.Activated:Connect(function()
            -- Ibalik lahat sa normal
            for _, btn in ipairs(TabButtons) do
                TweenService:Create(btn.Button, TweenInfo, {
                    BackgroundTransparency = 1,
                    BackgroundColor3 = self.Theme.SidebarBg
                }):Play()
            end

            -- Ilagay ang shade sa napiling tab
            TweenService:Create(TabBtn.Instance, TweenInfo, {
                BackgroundTransparency = 0.6,
                BackgroundColor3 = self.Theme.TabSelected
            }):Play()

            -- ✅ LAMAN NG MOVEMENTS TAB - UPDATED SLIDER STYLE
            ContentScroll.Instance:ClearAllChildren()

            -- 🎯 WALK SPEED SLIDER
            -- Slider Container
            local SliderContainer = Base.new("Frame", {
                Size = UDim2.new(1, -20, 0, 44),
                Position = UDim2.new(0, 10, 0, 20),
                BackgroundTransparency = 1,
                Parent = ContentScroll.Instance
            })

            -- Label: Walk Speed
            Base.new("TextLabel", {
                Text = "Walk Speed",
                Font = Enum.Font.GothamBold,
                TextSize = 18,
                TextColor3 = self.Theme.TextColor,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 120, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = SliderContainer.Instance
            })

            -- Value Text (nasa kanan)
            local SpeedLabel = Base.new("TextLabel", {
                Text = "16",
                Font = Enum.Font.Gotham,
                TextSize = 17,
                TextColor3 = self.Theme.SliderText,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 50, 1, 0),
                Position = UDim2.new(1, -160, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Right,
                Parent = SliderContainer.Instance
            })

            -- Slider Track
            local SliderBg = Base.new("Frame", {
                Size = UDim2.new(0, 140, 0, 6),
                Position = UDim2.new(1, -145, 0.5, -3),
                BackgroundColor3 = self.Theme.SliderBg,
                BackgroundTransparency = 0.2,
                Parent = SliderContainer.Instance
            })
            Instance.new("UICorner", SliderBg.Instance).CornerRadius = UDim.new(0, 3)

            -- Slider Fill
            local SliderFill = Base.new("Frame", {
                Size = UDim2.new(0, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundColor3 = self.Theme.SliderFill,
                BackgroundTransparency = 0,
                Parent = SliderBg.Instance
            })
            Instance.new("UICorner", SliderFill.Instance).CornerRadius = UDim.new(0, 3)

            -- Slider Knob (puting bilog)
            local SliderKnob = Base.new("Frame", {
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(0, -8, 0.5, -8),
                BackgroundColor3 = self.Theme.SliderKnob,
                BackgroundTransparency = 0,
                ZIndex = 2,
                Parent = SliderFill.Instance
            })
            Instance.new("UICorner", SliderKnob.Instance).CornerRadius = UDim.new(0, 8)

            -- Slider Settings
            local MinSpeed = 16
            local MaxSpeed = 300
            local CurrentSpeed = 16
            local DraggingSlider = false

            -- Update Function
            local function UpdateSpeed(newValue)
                CurrentSpeed = math.clamp(math.floor(newValue + 0.5), MinSpeed, MaxSpeed)
                local percent = (CurrentSpeed - MinSpeed) / (MaxSpeed - MinSpeed)
                SliderFill.Instance.Size = UDim2.new(percent, 0, 1, 0)
                SpeedLabel.Instance.Text = tostring(CurrentSpeed)
                if Humanoid and Humanoid:IsDescendantOf(game) then
                    Humanoid.WalkSpeed = CurrentSpeed
                end
            end

            -- Auto update kapag nag-respawn ang character
            LocalPlayer.CharacterAdded:Connect(function(newChar)
                Character = newChar
                Humanoid = newChar:WaitForChild("Humanoid", 10)
                if Humanoid then
                    Humanoid.WalkSpeed = CurrentSpeed
                end
            end)

            -- Touch Input
            SliderBg.Instance.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    DraggingSlider = true
                    local posX = input.Position.X - SliderBg.Instance.AbsolutePosition.X
                    local percent = math.clamp(posX / SliderBg.Instance.AbsoluteSize.X, 0, 1)
                    UpdateSpeed(MinSpeed + (MaxSpeed - MinSpeed) * percent)
                end
            end)

            SliderBg.Instance.InputChanged:Connect(function(input)
                if not DraggingSlider then return end
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
                    local posX = input.Position.X - SliderBg.Instance.AbsolutePosition.X
                    local percent = math.clamp(posX / SliderBg.Instance.AbsoluteSize.X, 0, 1)
                    UpdateSpeed(MinSpeed + (MaxSpeed - MinSpeed) * percent)
                end
            end)

            SliderBg.Instance.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    DraggingSlider = false
                end
            end)

            -- Simulan sa default
            UpdateSpeed(16)
        end)

        table.insert(TabButtons, {Button = TabBtn.Instance, Name = tabData.Name})
    end

    -- ✅ Search Bar Function
    SearchInput.Instance:GetPropertyChangedSignal("Text"):Connect(function()
        local searchText = SearchInput.Instance.Text:lower()
        local offset = 0
        local visibleCount = 0

        for _, tab in ipairs(TabButtons) do
            if tab.Name:lower():find(searchText) then
                tab.Button.Visible = true
                tab.Button.Position = UDim2.new(0, 6, 0, offset)
                offset = offset + 42
                visibleCount = visibleCount + 1
            else
                tab.Button.Visible = false
            end
        end

        SidebarScroll.Instance.CanvasSize = UDim2.new(0, 0, 0, visibleCount * 42)
    end)

    -- ✅ Update scroll height
    SidebarScroll.Instance.CanvasSize = UDim2.new(0, 0, 0, #Tabs * 42)

    -- ✅ Unang tab ang naka-highlight sa simula
    if #TabButtons > 0 then
        TabButtons[1].Button.BackgroundTransparency = 0.6
        TabButtons[1].Button.BackgroundColor3 = self.Theme.TabSelected
    end

    -- 📌 MINIMIZE / RESTORE
    local IsMinimized = false
    local IsMaximized = false

    MinimizeBtn.Instance.Activated:Connect(function()
        if not IsMinimized then
            TweenService:Create(Window.Instance, TweenInfo, {
                Size = self.Theme.MinimizedBarSize,
                Position = self.Theme.MinimizedBarPos,
                BackgroundTransparency = self.Theme.MinimizedTransparency
            }):Play()

            task.wait(self.Theme.TweenTime / 2)
            MainContainer.Instance.Visible = false
            MinimizeBtn.Instance.Visible = false
            CloseBtn.Instance.Visible = false
            MaximizeBtn.Instance.Position = UDim2.new(1, -32, 0, 0)
            IsMinimized = true
        end
    end)

    MaximizeBtn.Instance.Activated:Connect(function()
        if IsMinimized then
            MainContainer.Instance.Visible = true
            MinimizeBtn.Instance.Visible = true
            CloseBtn.Instance.Visible = true
            MaximizeBtn.Instance.Position = UDim2.new(0, 32, 0, 0)

            TweenService:Create(Window.Instance, TweenInfo, {
                Size = self.Theme.NormalWindowSize,
                Position = self.Theme.NormalWindowPos,
                BackgroundTransparency = self.Theme.NormalTransparency
            }):Play()
            IsMinimized = false
        else
            if not IsMaximized then
                self.Theme.NormalWindowSize = Window.Instance.Size
                self.Theme.NormalWindowPos = Window.Instance.Position
                TweenService:Create(Window.Instance, TweenInfo, {
                    Size = UDim2.new(0.92, 0, 0.88, 0),
                    Position = UDim2.new(0.04, 0, 0, 0)
                }):Play()
                IsMaximized = true
            else
                TweenService:Create(Window.Instance, TweenInfo, {
                    Size = self.Theme.NormalWindowSize,
                    Position = self.Theme.NormalWindowPos
                }):Play()
                IsMaximized = false
            end
        end
    end)

    CloseBtn.Instance.Activated:Connect(function()
        Window.Instance:Destroy()
    end)

    -- 🖱️ DRAG LOGIC
    local UIS = game:GetService("UserInputService")
    local Dragging = false
    local StartPos, StartInputPos

    DragArea.Instance.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            local pos = Vector2.new(input.Position.X, input.Position.Y)
            local cPos = Controls.Instance.AbsolutePosition
            local cSize = Controls.Instance.AbsoluteSize

            local overControls = pos.X >= cPos.X and pos.X <= cPos.X + cSize.X and pos.Y >= cPos.Y and pos.Y <= cPos.Y + cSize.Y
            if not overControls then
                Dragging = true
                StartPos = Window.Instance.Position
                StartInputPos = pos
            end
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if not Dragging then return end
        if input.UserInputType ~= Enum.UserInputType.Touch and input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
        local delta = Vector2.new(input.Position.X, input.Position.Y) - StartInputPos
        Window.Instance.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
    end)

    UIS.InputEnded:Connect(function()
        Dragging = false
    end)

    Window.ContentArea = ContentScroll.Instance
    return Window
end

-- 🚀 INITIALIZE UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoidwareUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Window = MyUILib:CreateWindow()
Window.Instance.Parent = ScreenGui

return MyUILib
