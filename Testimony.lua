local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

if not getgenv().TestimonyConfig then
    getgenv().TestimonyConfig = {
        Aimbot = { Enabled = false, Smoothness = 4, FOV = 120, TargetPart = "Head", Visibility = true },
        ESP = { Enabled = false, Boxes = true, Skeletons = false, Names = true, Distance = true, MaxDistance = 1000 },
        Flags = {}
    }
end

local Config = getgenv().TestimonyConfig

local Library = {
    Connections = {},
    Objects = {},
    Toggled = true,
    Theme = {
        Background = Color3.fromRGB(10, 10, 12),
        Accent = Color3.fromRGB(115, 60, 255),
        Outline = Color3.fromRGB(30, 30, 35),
        Text = Color3.fromRGB(240, 240, 240),
        DarkText = Color3.fromRGB(140, 140, 140)
    }
}

function Library:Tween(obj, info, prop)
    local t = TweenService:Create(obj, TweenInfo.new(unpack(info)), prop)
    t:Play()
    return t
end

function Library:MakeDraggable(frame, parent)
    local dragStart, startPos, dragging
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = parent.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            parent.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function Library:CreateWindow()
    local Window = { Tabs = {}, CurrentTab = nil }

    local Screen = Instance.new("ScreenGui")
    Screen.Name = "Testimony_Internal"
    Screen.DisplayOrder = 1000
    Screen.Parent = RunService:IsStudio() and LocalPlayer.PlayerGui or (gethui and gethui()) or CoreGui

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.new(0, 580, 0, 400)
    Main.Position = UDim2.new(0.5, -290, 0.5, -200)
    Main.BackgroundColor3 = self.Theme.Background
    Main.BorderSizePixel = 0
    Main.Parent = Screen

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = Main

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = self.Theme.Outline
    MainStroke.Thickness = 1
    MainStroke.Parent = Main

    local Blur = Instance.new("BlurEffect")
    Blur.Enabled = false
    Blur.Size = 20
    Blur.Parent = game.Lighting
    
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 160, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(7, 7, 8)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main

    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 8)
    SidebarCorner.Parent = Sidebar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 60)
    Title.BackgroundTransparency = 1
    Title.Text = "TESTIMONY"
    Title.TextColor3 = self.Theme.Accent
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextLetterSpacing = 2
    Title.Parent = Sidebar

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Size = UDim2.new(1, 0, 1, -80)
    TabContainer.Position = UDim2.new(0, 0, 0, 70)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 0
    TabContainer.Parent = Sidebar

    local TabList = Instance.new("UIListLayout")
    TabList.Padding = UDim.new(0, 5)
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabList.Parent = TabContainer

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -170, 1, -20)
    Content.Position = UDim2.new(0, 165, 0, 10)
    Content.BackgroundTransparency = 1
    Content.Parent = Main

    self:MakeDraggable(Sidebar, Main)

    function Window:CreateTab(name)
        local Tab = { Sections = {} }
        
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0.9, 0, 0, 32)
        TabBtn.BackgroundColor3 = Library.Theme.Accent
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = name:upper()
        TabBtn.TextColor3 = Library.Theme.DarkText
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.TextSize = 12
        TabBtn.AutoButtonColor = false
        TabBtn.Parent = TabContainer

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 4)
        TabCorner.Parent = TabBtn

        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.BorderSizePixel = 0
        TabFrame.ScrollBarThickness = 0
        TabFrame.Visible = false
        TabFrame.Parent = Content

        local TabGrid = Instance.new("UIGridLayout")
        TabGrid.CellPadding = UDim2.new(0, 10, 0, 10)
        TabGrid.CellSize = UDim2.new(0.5, -5, 0, 0)
        TabGrid.SortOrder = Enum.SortOrder.LayoutOrder
        TabGrid.Parent = TabFrame

        TabBtn.MouseButton1Click:Connect(function()
            if Window.CurrentTab then
                Window.CurrentTab.Btn.TextColor3 = Library.Theme.DarkText
                Library:Tween(Window.CurrentTab.Btn, {0.3}, {BackgroundTransparency = 1})
                Window.CurrentTab.Frame.Visible = false
            end
            Window.CurrentTab = {Btn = TabBtn, Frame = TabFrame}
            TabBtn.TextColor3 = Library.Theme.Text
            Library:Tween(TabBtn, {0.3}, {BackgroundTransparency = 0.8})
            TabFrame.Visible = true
        end)

        function Tab:CreateSection(sName)
            local Section = {}
            
            local SFrame = Instance.new("Frame")
            SFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
            SFrame.Size = UDim2.new(1, 0, 0, 100)
            SFrame.Parent = TabFrame

            local SCorner = Instance.new("UICorner")
            SCorner.CornerRadius = UDim.new(0, 6)
            SCorner.Parent = SFrame

            local SStroke = Instance.new("UIStroke")
            SStroke.Color = Library.Theme.Outline
            SStroke.Thickness = 1
            SStroke.Parent = SFrame

            local STitle = Instance.new("TextLabel")
            STitle.Size = UDim2.new(1, -10, 0, 30)
            STitle.Position = UDim2.new(0, 10, 0, 0)
            STitle.BackgroundTransparency = 1
            STitle.Text = sName:upper()
            STitle.TextColor3 = Library.Theme.Accent
            STitle.Font = Enum.Font.GothamBold
            STitle.TextSize = 11
            STitle.TextXAlignment = Enum.TextXAlignment.Left
            STitle.Parent = SFrame

            local Container = Instance.new("Frame")
            Container.Size = UDim2.new(1, -20, 1, -35)
            Container.Position = UDim2.new(0, 10, 0, 30)
            Container.BackgroundTransparency = 1
            Container.Parent = SFrame

            local CList = Instance.new("UIListLayout")
            CList.Padding = UDim.new(0, 5)
            CList.Parent = Container

            CList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SFrame.Size = UDim2.new(1, 0, 0, CList.AbsoluteContentSize.Y + 40)
            end)

            function Section:CreateToggle(tName, state, callback)
                local Toggle = { Value = state }
                local TBtn = Instance.new("TextButton")
                TBtn.Size = UDim2.new(1, 0, 0, 24)
                TBtn.BackgroundTransparency = 1
                TBtn.Text = ""
                TBtn.Parent = Container

                local TLab = Instance.new("TextLabel")
                TLab.Size = UDim2.new(1, -30, 1, 0)
                TLab.BackgroundTransparency = 1
                TLab.Text = tName
                TLab.TextColor3 = Library.Theme.DarkText
                TLab.Font = Enum.Font.Gotham
                TLab.TextSize = 13
                TLab.TextXAlignment = Enum.TextXAlignment.Left
                TLab.Parent = TBtn

                local Box = Instance.new("Frame")
                Box.Size = UDim2.new(0, 18, 0, 18)
                Box.Position = UDim2.new(1, -18, 0.5, -9)
                Box.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
                Box.BorderSizePixel = 0
                Box.Parent = TBtn

                local Inner = Instance.new("Frame")
                Inner.Size = UDim2.new(0, 0, 0, 0)
                Inner.Position = UDim2.new(0.5, 0, 0.5, 0)
                Inner.BackgroundColor3 = Library.Theme.Accent
                Inner.BorderSizePixel = 0
                Inner.Parent = Box

                local function Set(v)
                    Toggle.Value = v
                    Library:Tween(Inner, {0.2}, {Size = v and UDim2.new(1, -4, 1, -4) or UDim2.new(0,0,0,0), Position = v and UDim2.new(0,2,0,2) or UDim2.new(0.5,0,0.5,0)})
                    TLab.TextColor3 = v and Library.Theme.Text or Library.Theme.DarkText
                    callback(v)
                end

                TBtn.MouseButton1Click:Connect(function() Set(not Toggle.Value) end)
                Set(Toggle.Value)
                return Toggle
            end

            function Section:CreateSlider(slName, min, max, default, callback)
                local Slider = { Value = default }
                local SMain = Instance.new("Frame")
                SMain.Size = UDim2.new(1, 0, 0, 36)
                SMain.BackgroundTransparency = 1
                SMain.Parent = Container

                local SLab = Instance.new("TextLabel")
                SLab.Size = UDim2.new(1, 0, 0, 20)
                SLab.BackgroundTransparency = 1
                SLab.Text = slName
                SLab.TextColor3 = Library.Theme.DarkText
                SLab.Font = Enum.Font.Gotham
                SLab.TextSize = 12
                SLab.TextXAlignment = Enum.TextXAlignment.Left
                SLab.Parent = SMain

                local VLab = Instance.new("TextLabel")
                VLab.Size = UDim2.new(0, 40, 0, 20)
                VLab.Position = UDim2.new(1, -40, 0, 0)
                VLab.BackgroundTransparency = 1
                VLab.Text = tostring(default)
                VLab.TextColor3 = Library.Theme.Accent
                VLab.Font = Enum.Font.GothamMedium
                VLab.TextSize = 11
                VLab.TextXAlignment = Enum.TextXAlignment.Right
                VLab.Parent = SMain

                local Bar = Instance.new("Frame")
                Bar.Size = UDim2.new(1, 0, 0, 4)
                Bar.Position = UDim2.new(0, 0, 0, 25)
                Bar.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
                Bar.BorderSizePixel = 0
                Bar.Parent = SMain

                local Fill = Instance.new("Frame")
                Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                Fill.BackgroundColor3 = Library.Theme.Accent
                Fill.BorderSizePixel = 0
                Fill.Parent = Bar

                local function Update(input)
                    local per = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
                    local val = math.floor(min + (max - min) * per)
                    Slider.Value = val
                    VLab.Text = tostring(val)
                    Library:Tween(Fill, {0.1}, {Size = UDim2.new(per, 0, 1, 0)})
                    callback(val)
                end

                local active = false
                SMain.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then active = true Update(i) end end)
                UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then active = false end end)
                UserInputService.InputChanged:Connect(function(i) if active and i.UserInputType == Enum.UserInputType.MouseMovement then Update(i) end end)

                return Slider
            end

            return Section
        end
        return Tab
    end
    return Window
end

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 100
FOVCircle.Radius = Config.Aimbot.FOV
FOVCircle.Color = Library.Theme.Accent

local function GetTarget()
    local nearest = nil
    local shortest = Config.Aimbot.FOV
    local mPos = UserInputService:GetMouseLocation()

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(Config.Aimbot.TargetPart) then
            local p = v.Character[Config.Aimbot.TargetPart]
            local hum = v.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local sPos, on = Camera:WorldToViewportPoint(p.Position)
                if on then
                    if Config.Aimbot.Visibility then
                        local ray = Camera:ViewportPointToRay(sPos.X, sPos.Y)
                        local hit = workspace:FindPartOnRayWithIgnoreList(Ray.new(ray.Origin, p.Position - ray.Origin), {LocalPlayer.Character, v.Character})
                        if hit then continue end
                    end
                    local dist = (Vector2.new(sPos.X, sPos.Y) - mPos).Magnitude
                    if dist < shortest then
                        shortest = dist
                        nearest = v
                    end
                end
            end
        end
    end
    return nearest
end

RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = Config.Aimbot.Enabled
    FOVCircle.Position = UserInputService:GetMouseLocation()
    FOVCircle.Radius = Config.Aimbot.FOV

    if Config.Aimbot.Enabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local t = GetTarget()
        if t then
            local p = t.Character[Config.Aimbot.TargetPart]
            local sPos = Camera:WorldToViewportPoint(p.Position)
            local mPos = UserInputService:GetMouseLocation()
            local move = (Vector2.new(sPos.X, sPos.Y) - mPos) / Config.Aimbot.Smoothness
            mousemoverel(move.X, move.Y)
        end
    end

    if Config.ESP.Enabled then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                local sPos, on = Camera:WorldToViewportPoint(hrp.Position)
                
                if on then
                    local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                    if dist <= Config.ESP.MaxDistance then
                        local h = (Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y)
                        local w = h / 2
                    end
                end
            end
        end
    end
end)

local win = Library:CreateWindow()
local comb = win:CreateTab("Combat")
local aim = comb:CreateSection("Aimbot")
aim:CreateToggle("Enabled", Config.Aimbot.Enabled, function(v) Config.Aimbot.Enabled = v end)
aim:CreateSlider("Smoothness", 1, 20, Config.Aimbot.Smoothness, function(v) Config.Aimbot.Smoothness = v end)
aim:CreateSlider("FOV", 10, 800, Config.Aimbot.FOV, function(v) Config.Aimbot.FOV = v end)

local vis = win:CreateTab("Visuals")
local esp = vis:CreateSection("ESP")
esp:CreateToggle("Enabled", Config.ESP.Enabled, function(v) Config.ESP.Enabled = v end)

UserInputService.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.RightControl then
        Library.Toggled = not Library.Toggled
        win.Main.Visible = Library.Toggled
    end
end)

return Library
