local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Aurora = {
    Registry = {},
    Signals = {},
    Theme = {
        Main = Color3.fromRGB(12, 12, 14),
        Sidebar = Color3.fromRGB(10, 10, 12),
        Accent = Color3.fromRGB(115, 60, 255),
        AccentLight = Color3.fromRGB(140, 90, 255),
        Stroke = Color3.fromRGB(30, 30, 35),
        Text = Color3.fromRGB(240, 240, 240),
        DarkText = Color3.fromRGB(150, 150, 150),
        Element = Color3.fromRGB(18, 18, 20),
        Hover = Color3.fromRGB(25, 25, 28),
        Success = Color3.fromRGB(0, 255, 128),
        Error = Color3.fromRGB(255, 70, 70),
        Warning = Color3.fromRGB(255, 200, 0)
    },
    Font = Enum.Font.Inter,
    Notifications = {},
    Flags = {},
    Tooltips = {}
}

function Aurora:Tween(obj, info, prop)
    local t = TweenService:Create(obj, TweenInfo.new(unpack(info)), prop)
    t:Play()
    return t
end

function Aurora:MakeDraggable(frame, parent)
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

function Aurora:Ripple(obj)
    task.spawn(function()
        local mousePos = UserInputService:GetMouseLocation()
        local relativePos = mousePos - obj.AbsolutePosition
        local circle = Instance.new("Frame")
        circle.Name = "Ripple"
        circle.Parent = obj
        circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        circle.BackgroundTransparency = 0.8
        circle.ZIndex = obj.ZIndex + 1
        circle.Position = UDim2.new(0, relativePos.X, 0, relativePos.Y)
        circle.Size = UDim2.new(0, 0, 0, 0)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = circle
        self:Tween(circle, {0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {Size = UDim2.new(0, 200, 0, 200), Position = UDim2.new(0, relativePos.X - 100, 0, relativePos.Y - 100), BackgroundTransparency = 1})
        task.wait(0.5)
        circle:Destroy()
    end)
end

function Aurora:CreateTooltip(obj, text)
    obj.MouseEnter:Connect(function()
        local tip = Instance.new("Frame")
        tip.Name = "Tooltip"
        tip.Size = UDim2.new(0, 0, 0, 20)
        tip.BackgroundColor3 = self.Theme.Main
        tip.BorderSizePixel = 0
        tip.ZIndex = 1000
        tip.Parent = self.Screen
        local tc = Instance.new("UICorner") tc.CornerRadius = UDim.new(0, 4) tc.Parent = tip
        local ts = Instance.new("UIStroke") ts.Color = self.Theme.Stroke ts.Parent = tip
        local tl = Instance.new("TextLabel")
        tl.Size = UDim2.new(1, -10, 1, 0)
        tl.Position = UDim2.new(0, 5, 0, 0)
        tl.BackgroundTransparency = 1
        tl.Text = text
        tl.TextColor3 = self.Theme.Text
        tl.Font = Enum.Font.GothamMedium
        tl.TextSize = 11
        tl.Parent = tip
        local textSize = tl.TextBounds.X + 20
        tip.Size = UDim2.new(0, textSize, 0, 20)
        local connection
        connection = RunService.RenderStepped:Connect(function()
            if not tip.Parent then connection:Disconnect() return end
            local m = UserInputService:GetMouseLocation()
            tip.Position = UDim2.new(0, m.X + 15, 0, m.Y + 15)
        end)
        obj.MouseLeave:Connect(function() tip:Destroy() end)
    end)
end

function Aurora:Notify(data)
    local title = data.Title or "Notification"
    local content = data.Content or ""
    local duration = data.Duration or 5
    local type = data.Type or "Default"
    local accent = self.Theme.Accent
    if type == "Success" then accent = self.Theme.Success
    elseif type == "Error" then accent = self.Theme.Error
    elseif type == "Warning" then accent = self.Theme.Warning end
    local Screen = self.Screen
    if not Screen then return end
    local n = Instance.new("Frame")
    n.Size = UDim2.new(0, 280, 0, 70)
    n.Position = UDim2.new(1, 20, 1, -100 - (#self.Notifications * 80))
    n.BackgroundColor3 = self.Theme.Main
    n.BorderSizePixel = 0
    n.ClipsDescendants = true
    n.Parent = Screen
    local nc = Instance.new("UICorner") nc.CornerRadius = UDim.new(0, 6) nc.Parent = n
    local ns = Instance.new("UIStroke") ns.Color = accent ns.Thickness = 1.2 ns.Transparency = 0.5 ns.Parent = n
    local nt = Instance.new("TextLabel")
    nt.Size = UDim2.new(1, -20, 0, 30)
    nt.Position = UDim2.new(0, 10, 0, 5)
    nt.BackgroundTransparency = 1
    nt.Text = title:upper()
    nt.TextColor3 = accent
    nt.Font = Enum.Font.GothamBold
    nt.TextSize = 13
    nt.TextXAlignment = Enum.TextXAlignment.Left
    nt.Parent = n
    local nb = Instance.new("TextLabel")
    nb.Size = UDim2.new(1, -20, 0, 30)
    nb.Position = UDim2.new(0, 10, 0, 30)
    nb.BackgroundTransparency = 1
    nb.Text = content
    nb.TextColor3 = self.Theme.Text
    nb.Font = Enum.Font.Gotham
    nb.TextSize = 12
    nb.TextXAlignment = Enum.TextXAlignment.Left
    nb.TextWrapped = true
    nb.Parent = n
    local progress = Instance.new("Frame")
    progress.Size = UDim2.new(1, 0, 0, 2)
    progress.Position = UDim2.new(0, 0, 1, -2)
    progress.BackgroundColor3 = accent
    progress.BorderSizePixel = 0
    progress.Parent = n
    table.insert(self.Notifications, n)
    self:Tween(n, {0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {Position = UDim2.new(1, -300, 1, n.Position.Y.Offset)})
    self:Tween(progress, {duration, Enum.EasingStyle.Linear}, {Size = UDim2.new(0, 0, 0, 2)})
    task.delay(duration, function()
        self:Tween(n, {0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In}, {Position = UDim2.new(1, 20, 1, n.Position.Y.Offset)}).Completed:Connect(function()
            n:Destroy()
            table.remove(self.Notifications, table.find(self.Notifications, n))
            for i, remaining in ipairs(self.Notifications) do
                self:Tween(remaining, {0.3}, {Position = UDim2.new(1, -300, 1, -100 - ((i-1) * 80))})
            end
        end)
    end)
end

function Aurora:CreateWindow(data)
    local name = data.Name or "TESTIMONY"
    local footer = data.Footer or "v1"
    local Screen = Instance.new("ScreenGui")
    Screen.Name = "Aurora_Hub"
    Screen.IgnoreGuiInset = true
    Screen.ResetOnSpawn = false
    Screen.Parent = RunService:IsStudio() and LocalPlayer.PlayerGui or (gethui and gethui()) or CoreGui
    self.Screen = Screen
    
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 720, 0, 520)
    Main.Position = UDim2.new(0.5, -360, 0.5, -260)
    Main.BackgroundColor3 = self.Theme.Main
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Parent = Screen
    local mc = Instance.new("UICorner") mc.CornerRadius = UDim.new(0, 8) mc.Parent = Main
    local ms = Instance.new("UIStroke") ms.Color = self.Theme.Stroke ms.Thickness = 1.2 ms.Parent = Main
    
    local ResizeHandle = Instance.new("Frame")
    ResizeHandle.Size = UDim2.new(0, 15, 0, 15)
    ResizeHandle.Position = UDim2.new(1, -15, 1, -15)
    ResizeHandle.BackgroundTransparency = 1
    ResizeHandle.Parent = Main
    local rImg = Instance.new("ImageLabel")
    rImg.Size = UDim2.new(1, 0, 1, 0)
    rImg.BackgroundTransparency = 1
    rImg.Image = "rbxassetid://10714902127"
    rImg.ImageColor3 = self.Theme.DarkText
    rImg.ImageTransparency = 0.5
    rImg.Parent = ResizeHandle
    local draggingResize = false
    local startSize, startMousePos
    ResizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingResize = true
            startSize = Main.AbsoluteSize
            startMousePos = UserInputService:GetMouseLocation()
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingResize and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = UserInputService:GetMouseLocation() - startMousePos
            Main.Size = UDim2.new(0, math.clamp(startSize.X + delta.X, 500, 1200), 0, math.clamp(startSize.Y + delta.Y, 400, 900))
        end
    end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingResize = false end end)

    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 200, 1, 0)
    Sidebar.BackgroundColor3 = self.Theme.Sidebar
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    local sc = Instance.new("UICorner") sc.CornerRadius = UDim.new(0, 8) sc.Parent = Sidebar
    self:MakeDraggable(Sidebar, Main)
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 70)
    Title.BackgroundTransparency = 1
    Title.Text = name:upper()
    Title.TextColor3 = self.Theme.Accent
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextLetterSpacing = 4
    Title.Parent = Sidebar
    
    local SearchFrame = Instance.new("Frame")
    SearchFrame.Size = UDim2.new(1, -24, 0, 32)
    SearchFrame.Position = UDim2.new(0, 12, 0, 70)
    SearchFrame.BackgroundColor3 = self.Theme.Element
    SearchFrame.Parent = Sidebar
    local sfc = Instance.new("UICorner") sfc.CornerRadius = UDim.new(0, 6) sfc.Parent = SearchFrame
    local sfs = Instance.new("UIStroke") sfs.Color = self.Theme.Stroke sfs.Parent = SearchFrame
    local sInput = Instance.new("TextBox")
    sInput.Size = UDim2.new(1, -30, 1, 0)
    sInput.Position = UDim2.new(0, 8, 0, 0)
    sInput.BackgroundTransparency = 1
    sInput.Text = ""
    sInput.PlaceholderText = "Search..."
    sInput.PlaceholderColor3 = self.Theme.DarkText
    sInput.TextColor3 = self.Theme.Text
    sInput.Font = Enum.Font.Gotham
    sInput.TextSize = 13
    sInput.TextXAlignment = Enum.TextXAlignment.Left
    sInput.Parent = SearchFrame

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Size = UDim2.new(1, -20, 1, -160)
    TabContainer.Position = UDim2.new(0, 10, 0, 110)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 0
    TabContainer.Parent = Sidebar
    local tl = Instance.new("UIListLayout") tl.Padding = UDim.new(0, 6) tl.Parent = TabContainer
    
    local Footer = Instance.new("TextLabel")
    Footer.Size = UDim2.new(1, -24, 0, 40)
    Footer.Position = UDim2.new(0, 12, 1, -45)
    Footer.BackgroundTransparency = 1
    Footer.Text = footer
    Footer.TextColor3 = self.Theme.DarkText
    Footer.Font = Enum.Font.GothamMedium
    Footer.TextSize = 11
    Footer.TextXAlignment = Enum.TextXAlignment.Left
    Footer.Parent = Sidebar
    
    local ContentArea = Instance.new("Frame")
    ContentArea.Size = UDim2.new(1, -210, 1, -20)
    ContentArea.Position = UDim2.new(0, 205, 0, 10)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = Main
    
    function Window:CreateWatermark(wData)
        local wName = wData.Name or "TESTIMONY"
        local wMain = Instance.new("Frame")
        wMain.Size = UDim2.new(0, 260, 0, 30)
        wMain.Position = UDim2.new(0, 20, 0, 20)
        wMain.BackgroundColor3 = Aurora.Theme.Sidebar
        wMain.BorderSizePixel = 0
        wMain.Parent = Screen
        local wc = Instance.new("UICorner") wc.CornerRadius = UDim.new(0, 4) wc.Parent = wMain
        local ws = Instance.new("UIStroke") ws.Color = Aurora.Theme.Accent ws.Parent = wMain
        local wLabel = Instance.new("TextLabel")
        wLabel.Size = UDim2.new(1, -10, 1, 0)
        wLabel.Position = UDim2.new(0, 5, 0, 0)
        wLabel.BackgroundTransparency = 1
        wLabel.TextColor3 = Aurora.Theme.Text
        wLabel.Font = Enum.Font.GothamMedium
        wLabel.TextSize = 12
        wLabel.TextXAlignment = Enum.TextXAlignment.Left
        wLabel.Parent = wMain
        task.spawn(function()
            while task.wait(1) do
                local fps = math.floor(1/RunService.RenderStepped:Wait())
                local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():split(" ")[1]
                wLabel.Text = string.format("%s | %s | %d FPS | %s MS", wName, LocalPlayer.Name, fps, ping)
            end
        end)
    end
    
    local WindowInterface = { Tabs = {}, CurrentTab = nil }
    
    function WindowInterface:CreateTab(tData)
        local tName = tData.Name or "Tab"
        local tIcon = tData.Icon or ""
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1, 0, 0, 40)
        TabBtn.BackgroundColor3 = Aurora.Theme.Accent
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = ""
        TabBtn.AutoButtonColor = false
        TabBtn.Parent = TabContainer
        local tc = Instance.new("UICorner") tc.CornerRadius = UDim.new(0, 6) tc.Parent = TabBtn
        local tImg = Instance.new("ImageLabel")
        tImg.Size = UDim2.new(0, 20, 0, 20)
        tImg.Position = UDim2.new(0, 12, 0.5, -10)
        tImg.BackgroundTransparency = 1
        tImg.Image = tIcon
        tImg.ImageColor3 = Aurora.Theme.DarkText
        tImg.Visible = tIcon ~= ""
        tImg.Parent = TabBtn
        local tLabel = Instance.new("TextLabel")
        tLabel.Size = UDim2.new(1, tIcon ~= "" and -45 or -15, 1, 0)
        tLabel.Position = UDim2.new(0, tIcon ~= "" and 42 or 15, 0, 0)
        tLabel.BackgroundTransparency = 1
        tLabel.Text = tName
        tLabel.TextColor3 = Aurora.Theme.DarkText
        tLabel.Font = Enum.Font.GothamMedium
        tLabel.TextSize = 14
        tLabel.TextXAlignment = Enum.TextXAlignment.Left
        tLabel.Parent = TabBtn
        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.BorderSizePixel = 0
        TabPage.Visible = false
        TabPage.ScrollBarThickness = 2
        TabPage.ScrollBarImageColor3 = Aurora.Theme.Accent
        TabPage.Parent = ContentArea
        local tpl = Instance.new("UIListLayout") tpl.Padding = UDim.new(0, 12) tpl.Parent = TabPage
        tpl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, tpl.AbsoluteContentSize.Y + 20)
        end)
        local Tab = { Sections = {} }
        function Tab:Select()
            if WindowInterface.CurrentTab then
                WindowInterface.CurrentTab.Btn.TextColor3 = Aurora.Theme.DarkText
                if WindowInterface.CurrentTab.Icon then WindowInterface.CurrentTab.Icon.ImageColor3 = Aurora.Theme.DarkText end
                Aurora:Tween(WindowInterface.CurrentTab.BtnBack, {0.3}, {BackgroundTransparency = 1})
                WindowInterface.CurrentTab.Page.Visible = false
            end
            WindowInterface.CurrentTab = {Btn = tLabel, Icon = tImg, BtnBack = TabBtn, Page = TabPage}
            tLabel.TextColor3 = Aurora.Theme.Text
            tImg.ImageColor3 = Aurora.Theme.Text
            Aurora:Tween(TabBtn, {0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {BackgroundTransparency = 0.88})
            TabPage.Visible = true
        end
        TabBtn.MouseButton1Click:Connect(function() Tab:Select() end)
        if not WindowInterface.CurrentTab then Tab:Select() end
        sInput:GetPropertyChangedSignal("Text"):Connect(function() TabBtn.Visible = tName:lower():find(sInput.Text:lower()) ~= nil end)
        
        function Tab:CreateSection(sName)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, -10, 0, 40)
            SectionFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
            SectionFrame.BorderSizePixel = 0
            SectionFrame.Parent = TabPage
            local sc = Instance.new("UICorner") sc.CornerRadius = UDim.new(0, 8) sc.Parent = SectionFrame
            local ss = Instance.new("UIStroke") ss.Color = Aurora.Theme.Stroke ss.Thickness = 1 ss.Parent = SectionFrame
            local sTitle = Instance.new("TextLabel")
            sTitle.Size = UDim2.new(1, -20, 0, 35)
            sTitle.Position = UDim2.new(0, 15, 0, 0)
            sTitle.BackgroundTransparency = 1
            sTitle.Text = sName:upper()
            sTitle.TextColor3 = Aurora.Theme.Accent
            sTitle.Font = Enum.Font.GothamBold
            sTitle.TextSize = 12
            sTitle.TextXAlignment = Enum.TextXAlignment.Left
            sTitle.Parent = SectionFrame
            local ItemContainer = Instance.new("Frame")
            ItemContainer.Size = UDim2.new(1, -24, 1, -40)
            ItemContainer.Position = UDim2.new(0, 12, 0, 35)
            ItemContainer.BackgroundTransparency = 1
            ItemContainer.Parent = SectionFrame
            local il = Instance.new("UIListLayout") il.Padding = UDim.new(0, 6) il.Parent = ItemContainer
            il:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionFrame.Size = UDim2.new(1, -10, 0, il.AbsoluteContentSize.Y + 45)
            end)
            local Methods = {}
            
            function Methods:CreateLabel(text)
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0, 24)
                label.BackgroundTransparency = 1
                label.Text = text
                label.TextColor3 = Aurora.Theme.DarkText
                label.Font = Enum.Font.Gotham
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = ItemContainer
                return label
            end

            function Methods:CreateButton(data)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 36)
                btn.BackgroundColor3 = Aurora.Theme.Element
                btn.BorderSizePixel = 0
                btn.Text = ""
                btn.AutoButtonColor = false
                btn.Parent = ItemContainer
                local bc = Instance.new("UICorner") bc.CornerRadius = UDim.new(0, 6) bc.Parent = btn
                local bs = Instance.new("UIStroke") bs.Color = Aurora.Theme.Stroke bs.Thickness = 1 bs.Parent = btn
                local l = Instance.new("TextLabel")
                l.Size = UDim2.new(1, 0, 1, 0)
                l.BackgroundTransparency = 1
                l.Text = data.Name or "Button"
                l.TextColor3 = Aurora.Theme.Text
                l.Font = Enum.Font.GothamMedium
                l.TextSize = 13
                l.Parent = btn
                btn.MouseButton1Down:Connect(function() Aurora:Tween(btn, {0.1}, {BackgroundColor3 = Aurora.Theme.Hover}) end)
                btn.MouseButton1Up:Connect(function() Aurora:Tween(btn, {0.1}, {BackgroundColor3 = Aurora.Theme.Element}) end)
                btn.MouseButton1Click:Connect(function() Aurora:Ripple(btn) data.Callback() end)
                if data.Tooltip then Aurora:CreateTooltip(btn, data.Tooltip) end
            end
            
            function Methods:CreateToggle(data)
                local toggle = { Value = data.Default or false }
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 36)
                btn.BackgroundTransparency = 1
                btn.Text = ""
                btn.Parent = ItemContainer
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -50, 1, 0)
                label.Position = UDim2.new(0, 12, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = data.Name or "Toggle"
                label.TextColor3 = Aurora.Theme.DarkText
                label.Font = Enum.Font.Gotham
                label.TextSize = 14
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = btn
                local track = Instance.new("Frame")
                track.Size = UDim2.new(0, 36, 0, 20)
                track.Position = UDim2.new(1, -45, 0.5, -10)
                track.BackgroundColor3 = Aurora.Theme.Element
                track.Parent = btn
                local tc = Instance.new("UICorner") tc.CornerRadius = UDim.new(1, 0) tc.Parent = track
                local ts = Instance.new("UIStroke") ts.Color = Aurora.Theme.Stroke ts.Parent = track
                local knob = Instance.new("Frame")
                knob.Size = UDim2.new(0, 14, 0, 14)
                knob.Position = toggle.Value and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
                knob.BackgroundColor3 = toggle.Value and Aurora.Theme.Accent or Aurora.Theme.DarkText
                knob.Parent = track
                local kc = Instance.new("UICorner") kc.CornerRadius = UDim.new(1, 0) kc.Parent = knob
                local function set(v)
                    toggle.Value = v
                    Aurora:Tween(knob, {0.3, Enum.EasingStyle.Quart}, {Position = v and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = v and Aurora.Theme.Accent or Aurora.Theme.DarkText})
                    Aurora:Tween(label, {0.3}, {TextColor3 = v and Aurora.Theme.Text or Aurora.Theme.DarkText})
                    data.Callback(v)
                end
                btn.MouseButton1Click:Connect(function() set(not toggle.Value) end)
                set(toggle.Value)
                if data.Tooltip then Aurora:CreateTooltip(btn, data.Tooltip) end
                return toggle
            end
            
            function Methods:CreateSlider(data)
                local slider = { Value = data.Default or 50 }
                local main = Instance.new("Frame")
                main.Size = UDim2.new(1, 0, 0, 48)
                main.BackgroundTransparency = 1
                main.Parent = ItemContainer
                local l = Instance.new("TextLabel")
                l.Size = UDim2.new(1, -70, 0, 25)
                l.Position = UDim2.new(0, 12, 0, 0)
                l.BackgroundTransparency = 1
                l.Text = data.Name or "Slider"
                l.TextColor3 = Aurora.Theme.Text
                l.Font = Enum.Font.Gotham
                l.TextSize = 14
                l.TextXAlignment = Enum.TextXAlignment.Left
                l.Parent = main
                local valStr = Instance.new("TextLabel")
                valStr.Size = UDim2.new(0, 70, 0, 25)
                valStr.Position = UDim2.new(1, -75, 0, 0)
                valStr.BackgroundTransparency = 1
                valStr.Text = tostring(slider.Value) .. (data.Suffix or "")
                valStr.TextColor3 = Aurora.Theme.Accent
                valStr.Font = Enum.Font.GothamMedium
                valStr.TextSize = 13
                valStr.Parent = main
                local bar = Instance.new("Frame")
                bar.Size = UDim2.new(1, -24, 0, 6)
                bar.Position = UDim2.new(0, 12, 0, 32)
                bar.BackgroundColor3 = Aurora.Theme.Element
                bar.Parent = main
                local bc = Instance.new("UICorner") bc.CornerRadius = UDim.new(1, 0) bc.Parent = bar
                local sFill = Instance.new("Frame")
                sFill.Size = UDim2.new((slider.Value - data.Min) / (data.Max - data.Min), 0, 1, 0)
                sFill.BackgroundColor3 = Aurora.Theme.Accent
                sFill.Parent = bar
                local fc = Instance.new("UICorner") fc.CornerRadius = UDim.new(1, 0) fc.Parent = sFill
                local function update(input)
                    local per = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    local v = math.floor(data.Min + (data.Max - data.Min) * per)
                    slider.Value = v
                    valStr.Text = tostring(v) .. (data.Suffix or "")
                    Aurora:Tween(sFill, {0.1}, {Size = UDim2.new(per, 0, 1, 0)})
                    data.Callback(v)
                end
                local dragging = false
                bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true update(i) end end)
                UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
                UserInputService.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then update(i) end end)
                if data.Tooltip then Aurora:CreateTooltip(main, data.Tooltip) end
                return slider
            end
            
            function Methods:CreateDropdown(data)
                local dropdown = { Value = data.Default or data.Options[1], Open = false, Options = data.Options }
                local main = Instance.new("Frame")
                main.Size = UDim2.new(1, 0, 0, 38)
                main.BackgroundTransparency = 1
                main.Parent = ItemContainer
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 1, 0)
                btn.BackgroundColor3 = Aurora.Theme.Element
                btn.Text = ""
                btn.Parent = main
                local bc = Instance.new("UICorner") bc.CornerRadius = UDim.new(0, 6) bc.Parent = btn
                local bs = Instance.new("UIStroke") bs.Color = Aurora.Theme.Stroke bs.Thickness = 1 bs.Parent = btn
                local l = Instance.new("TextLabel")
                l.Size = UDim2.new(1, -40, 1, 0)
                l.Position = UDim2.new(0, 12, 0, 0)
                l.BackgroundTransparency = 1
                l.Text = data.Name .. ": " .. tostring(dropdown.Value)
                l.TextColor3 = Aurora.Theme.Text
                l.Font = Enum.Font.Gotham
                l.TextSize = 14
                l.TextXAlignment = Enum.TextXAlignment.Left
                l.Parent = btn
                local list = Instance.new("Frame")
                list.Size = UDim2.new(1, 0, 0, 0)
                list.Position = UDim2.new(0, 0, 1, 5)
                list.BackgroundColor3 = Aurora.Theme.Element
                list.ClipsDescendants = true
                list.Visible = false
                list.ZIndex = 50
                list.Parent = main
                local lc = Instance.new("UICorner") lc.CornerRadius = UDim.new(0, 6) lc.Parent = list
                local scroll = Instance.new("ScrollingFrame")
                scroll.Size = UDim2.new(1, 0, 1, 0)
                scroll.BackgroundTransparency = 1
                scroll.BorderSizePixel = 0
                scroll.ScrollBarThickness = 2
                scroll.ScrollBarImageColor3 = Aurora.Theme.Accent
                scroll.ZIndex = 51
                scroll.Parent = list
                local sl = Instance.new("UIListLayout") sl.Padding = UDim.new(0, 2) sl.Parent = scroll
                local function updateList()
                    for _, child in ipairs(scroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
                    for _, opt in ipairs(dropdown.Options) do
                        local oBtn = Instance.new("TextButton")
                        oBtn.Size = UDim2.new(1, 0, 0, 32)
                        oBtn.BackgroundTransparency = 1
                        oBtn.Text = tostring(opt)
                        oBtn.TextColor3 = opt == dropdown.Value and Aurora.Theme.Accent or Aurora.Theme.DarkText
                        oBtn.Font = Enum.Font.GothamMedium
                        oBtn.TextSize = 13
                        oBtn.ZIndex = 52
                        oBtn.Parent = scroll
                        oBtn.MouseButton1Click:Connect(function()
                            dropdown.Value = opt
                            l.Text = data.Name .. ": " .. tostring(opt)
                            dropdown.Open = false
                            Aurora:Tween(list, {0.3, Enum.EasingStyle.Quart}, {Size = UDim2.new(1, 0, 0, 0)}).Completed:Connect(function() list.Visible = false main.Size = UDim2.new(1, 0, 0, 38) end)
                            data.Callback(opt)
                        end)
                    end
                    scroll.CanvasSize = UDim2.new(0, 0, 0, #dropdown.Options * 34)
                end
                btn.MouseButton1Click:Connect(function()
                    dropdown.Open = not dropdown.Open
                    if dropdown.Open then
                        updateList()
                        list.Visible = true
                        main.Size = UDim2.new(1, 0, 0, 43 + math.min(#dropdown.Options * 34, 170))
                        Aurora:Tween(list, {0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {Size = UDim2.new(1, 0, 0, math.min(#dropdown.Options * 34, 170))})
                    else
                        Aurora:Tween(list, {0.3, Enum.EasingStyle.Quart}, {Size = UDim2.new(1, 0, 0, 0)}).Completed:Connect(function() list.Visible = false main.Size = UDim2.new(1, 0, 0, 38) end)
                    end
                end)
                if data.Tooltip then Aurora:CreateTooltip(main, data.Tooltip) end
            end
            
            function Methods:CreateColorPicker(data)
                local h, s, v = (data.Default or Aurora.Theme.Accent):ToHSV()
                local picker = { Value = data.Default or Aurora.Theme.Accent, Open = false }
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 38)
                btn.BackgroundTransparency = 1
                btn.Text = ""
                btn.Parent = ItemContainer
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -45, 1, 0)
                label.Position = UDim2.new(0, 12, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = data.Name or "Color"
                label.TextColor3 = Aurora.Theme.Text
                label.Font = Enum.Font.Gotham
                label.TextSize = 14
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = btn
                local display = Instance.new("Frame")
                display.Size = UDim2.new(0, 36, 0, 20)
                display.Position = UDim2.new(1, -45, 0.5, -10)
                display.BackgroundColor3 = picker.Value
                display.Parent = btn
                local dc = Instance.new("UICorner") dc.CornerRadius = UDim.new(0, 4) dc.Parent = display
                local pickerFrame = Instance.new("Frame")
                pickerFrame.Size = UDim2.new(0, 200, 0, 180)
                pickerFrame.Position = UDim2.new(1, -210, 0.5, 20)
                pickerFrame.BackgroundColor3 = Aurora.Theme.Element
                pickerFrame.Visible = false
                pickerFrame.ZIndex = 110
                pickerFrame.Parent = btn
                local pfc = Instance.new("UICorner") pfc.CornerRadius = UDim.new(0, 6) pfc.Parent = pickerFrame
                local hueSlider = Instance.new("Frame")
                hueSlider.Size = UDim2.new(1, -20, 0, 15)
                hueSlider.Position = UDim2.new(0, 10, 0, 150)
                hueSlider.Parent = pickerFrame
                local hug = Instance.new("UIGradient") hug.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)), ColorSequenceKeypoint.new(1/6, Color3.fromHSV(1/6, 1, 1)), ColorSequenceKeypoint.new(2/6, Color3.fromHSV(2/6, 1, 1)), ColorSequenceKeypoint.new(3/6, Color3.fromHSV(3/6, 1, 1)), ColorSequenceKeypoint.new(4/6, Color3.fromHSV(4/6, 1, 1)), ColorSequenceKeypoint.new(5/6, Color3.fromHSV(5/6, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1))}) hug.Parent = hueSlider
                local hueKnob = Instance.new("Frame")
                hueKnob.Size = UDim2.new(0, 4, 1, 4)
                hueKnob.Position = UDim2.new(h, -2, 0, -2)
                hueKnob.BackgroundColor3 = Color3.white
                hueKnob.Parent = hueSlider
                local satMap = Instance.new("Frame")
                satMap.Size = UDim2.new(1, -20, 0, 130)
                satMap.Position = UDim2.new(0, 10, 0, 10)
                satMap.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                satMap.Parent = pickerFrame
                local knob = Instance.new("Frame")
                knob.Size = UDim2.new(0, 6, 0, 6)
                knob.Position = UDim2.new(s, -3, 1-v, -3)
                knob.BackgroundColor3 = Color3.white
                knob.Parent = satMap
                local function updateColor()
                    local c = Color3.fromHSV(h, s, v)
                    display.BackgroundColor3 = c
                    satMap.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    data.Callback(c)
                end
                local draggingHue, draggingSat = false, false
                hueSlider.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingHue = true end end)
                satMap.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingSat = true end end)
                UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingHue = false draggingSat = false end end)
                UserInputService.InputChanged:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseMovement then
                        if draggingHue then
                            h = math.clamp((i.Position.X - hueSlider.AbsolutePosition.X) / hueSlider.AbsoluteSize.X, 0, 1)
                            hueKnob.Position = UDim2.new(h, -2, 0, -2)
                            updateColor()
                        elseif draggingSat then
                            s = math.clamp((i.Position.X - satMap.AbsolutePosition.X) / satMap.AbsoluteSize.X, 0, 1)
                            v = 1 - math.clamp((i.Position.Y - satMap.AbsolutePosition.Y) / satMap.AbsoluteSize.Y, 0, 1)
                            knob.Position = UDim2.new(s, -3, 1-v, -3)
                            updateColor()
                        end
                    end
                end)
                btn.MouseButton1Click:Connect(function() picker.Open = not picker.Open pickerFrame.Visible = picker.Open end)
            end
            
            function Methods:CreateBind(data)
                local bind = { Value = data.Default or Enum.KeyCode.F, Binding = false }
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 38)
                btn.BackgroundTransparency = 1
                btn.Text = ""
                btn.Parent = ItemContainer
                local l = Instance.new("TextLabel")
                l.Size = UDim2.new(1, -85, 1, 0)
                l.Position = UDim2.new(0, 12, 0, 0)
                l.BackgroundTransparency = 1
                l.Text = data.Name or "Bind"
                l.TextColor3 = Aurora.Theme.Text
                l.Font = Enum.Font.Gotham
                l.TextSize = 14
                l.TextXAlignment = Enum.TextXAlignment.Left
                l.Parent = btn
                local box = Instance.new("Frame")
                box.Size = UDim2.new(0, 75, 0, 26)
                box.Position = UDim2.new(1, -85, 0.5, -13)
                box.BackgroundColor3 = Aurora.Theme.Element
                box.Parent = btn
                local bc = Instance.new("UICorner") bc.CornerRadius = UDim.new(0, 4) bc.Parent = box
                local bText = Instance.new("TextLabel")
                bText.Size = UDim2.new(1, 0, 1, 0)
                bText.BackgroundTransparency = 1
                bText.Text = bind.Value.Name:upper()
                bText.TextColor3 = Aurora.Theme.Accent
                bText.Font = Enum.Font.GothamMedium
                bText.TextSize = 12
                bText.Parent = box
                btn.MouseButton1Click:Connect(function() bind.Binding = true bText.Text = "..." end)
                UserInputService.InputBegan:Connect(function(input)
                    if bind.Binding and input.UserInputType == Enum.UserInputType.Keyboard then
                        bind.Value = input.KeyCode
                        bText.Text = input.KeyCode.Name:upper()
                        bind.Binding = false
                        data.Callback(input.KeyCode)
                    elseif not bind.Binding and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == bind.Value then
                        data.Callback(bind.Value)
                    end
                end)
                return bind
            end
            
            function Methods:CreateTextbox(data)
                local box = Instance.new("Frame")
                box.Size = UDim2.new(1, 0, 0, 38)
                box.BackgroundColor3 = Aurora.Theme.Element
                box.Parent = ItemContainer
                local bc = Instance.new("UICorner") bc.CornerRadius = UDim.new(0, 6) bc.Parent = box
                local input = Instance.new("TextBox")
                input.Size = UDim2.new(1, -24, 1, 0)
                input.Position = UDim2.new(0, 12, 0, 0)
                input.BackgroundTransparency = 1
                input.Text = data.Default or ""
                input.PlaceholderText = data.Placeholder or "Enter text..."
                input.PlaceholderColor3 = Aurora.Theme.DarkText
                input.TextColor3 = Aurora.Theme.Text
                input.Font = Enum.Font.Gotham
                input.TextSize = 14
                input.Parent = box
                input.FocusLost:Connect(function() data.Callback(input.Text) end)
            end
            
            return Methods
        end
        return Tab
    end
    
    function WindowInterface:SaveConfig(name, data)
        if writefile then writefile("Testimony_" .. name .. ".json", HttpService:JSONEncode(data)) Aurora:Notify({Title = "Config", Content = "Saved Successfully", Type = "Success"}) end
    end

    function WindowInterface:LoadConfig(name)
        if isfile and isfile("Testimony_" .. name .. ".json") then local data = HttpService:JSONDecode(readfile("Testimony_" .. name .. ".json")) Aurora:Notify({Title = "Config", Content = "Loaded Successfully", Type = "Success"}) return data end
        return nil
    end

    return WindowInterface
end

return Aurora
