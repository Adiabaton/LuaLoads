local Elysium = {}
Elysium.__index = Elysium

-- <CORE>

local Services = {
	Players = game:GetService("Players"),
	RunService = game:GetService("RunService"),
	TweenService = game:GetService("TweenService"),
	UserInputService = game:GetService("UserInputService"),
	TextService = game:GetService("TextService"),
	Workspace = game:GetService("Workspace"),
	Stats = game:GetService("Stats")
}

local LocalPlayer = Services.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Config = {
	WindowSize = Vector2.new(980, 650),
	MinWindowSize = Vector2.new(780, 520),
	MaxWindowSize = Vector2.new(1400, 920),
	TopBarHeight = 58,
	SidebarWidth = 260,
	ContentPadding = 14,
	ComponentHeight = 48,
	SliderHeight = 64,
	ButtonHeight = 46,
	ToggleHeight = 46,
	DropdownHeight = 46,
	ColorPickerHeight = 46,
	KeybindHeight = 46,
	TextBoxHeight = 46,
	LabelHeight = 32,
	DividerHeight = 2,
	CornerRadius = 8,
	BorderSize = 1,
	ShadowSize = 22,
	DropdownMaxHeight = 220,
	DropdownZIndex = 120,
	FloatingZIndex = 140,
	AnimationSpeed = 0.2,
	FastAnimation = 0.12,
	SlowAnimation = 0.32,
	EasingStyle = Enum.EasingStyle.Quad,
	EasingDirection = Enum.EasingDirection.Out
}

local Themes = {
	Ash = {
		Name = "Ash",
		Primary = Color3.fromRGB(200, 200, 200),
		Secondary = Color3.fromRGB(165, 165, 165),
		Accent = Color3.fromRGB(120, 120, 120),
		Background = Color3.fromRGB(11, 11, 11),
		TopBar = Color3.fromRGB(16, 16, 16),
		Sidebar = Color3.fromRGB(17, 17, 17),
		Content = Color3.fromRGB(20, 20, 20),
		Element = Color3.fromRGB(25, 25, 25),
		ElementHover = Color3.fromRGB(30, 30, 30),
		ElementActive = Color3.fromRGB(36, 36, 36),
		Text = Color3.fromRGB(235, 235, 235),
		TextDim = Color3.fromRGB(175, 175, 175),
		TextDark = Color3.fromRGB(120, 120, 120),
		Success = Color3.fromRGB(120, 185, 120),
		Warning = Color3.fromRGB(200, 170, 80),
		Error = Color3.fromRGB(200, 80, 80),
		Info = Color3.fromRGB(140, 160, 190)
	},
	Slate = {
		Name = "Slate",
		Primary = Color3.fromRGB(180, 190, 200),
		Secondary = Color3.fromRGB(150, 160, 170),
		Accent = Color3.fromRGB(110, 120, 130),
		Background = Color3.fromRGB(12, 14, 16),
		TopBar = Color3.fromRGB(18, 20, 22),
		Sidebar = Color3.fromRGB(20, 22, 24),
		Content = Color3.fromRGB(22, 24, 26),
		Element = Color3.fromRGB(28, 30, 32),
		ElementHover = Color3.fromRGB(34, 36, 38),
		ElementActive = Color3.fromRGB(40, 42, 44),
		Text = Color3.fromRGB(230, 235, 240),
		TextDim = Color3.fromRGB(175, 182, 190),
		TextDark = Color3.fromRGB(120, 125, 130),
		Success = Color3.fromRGB(120, 185, 120),
		Warning = Color3.fromRGB(200, 170, 80),
		Error = Color3.fromRGB(200, 80, 80),
		Info = Color3.fromRGB(150, 170, 200)
	},
	Mono = {
		Name = "Mono",
		Primary = Color3.fromRGB(210, 210, 210),
		Secondary = Color3.fromRGB(170, 170, 170),
		Accent = Color3.fromRGB(130, 130, 130),
		Background = Color3.fromRGB(9, 9, 9),
		TopBar = Color3.fromRGB(14, 14, 14),
		Sidebar = Color3.fromRGB(16, 16, 16),
		Content = Color3.fromRGB(18, 18, 18),
		Element = Color3.fromRGB(24, 24, 24),
		ElementHover = Color3.fromRGB(30, 30, 30),
		ElementActive = Color3.fromRGB(36, 36, 36),
		Text = Color3.fromRGB(240, 240, 240),
		TextDim = Color3.fromRGB(180, 180, 180),
		TextDark = Color3.fromRGB(125, 125, 125),
		Success = Color3.fromRGB(120, 185, 120),
		Warning = Color3.fromRGB(200, 170, 80),
		Error = Color3.fromRGB(200, 80, 80),
		Info = Color3.fromRGB(150, 170, 200)
	}
}

local CurrentTheme = Themes.Ash

local Utils = {}

function Utils:Create(className, properties)
	local instance = Instance.new(className)
	for property, value in pairs(properties) do
		if property ~= "Parent" then
			pcall(function()
				instance[property] = value
			end)
		end
	end
	if properties.Parent then
		instance.Parent = properties.Parent
	end
	return instance
end

function Utils:Tween(instance, properties, duration, style, direction, callback)
	duration = duration or Config.AnimationSpeed
	style = style or Config.EasingStyle
	direction = direction or Config.EasingDirection

	local tweenInfo = TweenInfo.new(duration, style, direction)
	local tween = Services.TweenService:Create(instance, tweenInfo, properties)

	if callback then
		tween.Completed:Connect(callback)
	end

	tween:Play()
	return tween
end

function Utils:CreateCorner(instance, radius)
	return Utils:Create("UICorner", {
		CornerRadius = UDim.new(0, radius or Config.CornerRadius),
		Parent = instance
	})
end

function Utils:CreateStroke(instance, color, thickness, transparency)
	return Utils:Create("UIStroke", {
		Color = color or CurrentTheme.Accent,
		Thickness = thickness or Config.BorderSize,
		Transparency = transparency or 0.5,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = instance
	})
end

function Utils:CreateShadow(instance, size, transparency)
	size = size or Config.ShadowSize
	transparency = transparency or 0.85

	local shadow = Utils:Create("ImageLabel", {
		Name = "Shadow",
		Size = UDim2.new(1, size * 2, 1, size * 2),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://5028857084",
		ImageColor3 = Color3.fromRGB(0, 0, 0),
		ImageTransparency = transparency,
		ZIndex = math.max((instance.ZIndex or 1) - 1, 0),
		Parent = instance
	})

	return shadow
end

function Utils:GetTextBounds(text, font, size)
	local params = Instance.new("GetTextBoundsParams")
	params.Text = text
	params.Font = font
	params.Size = size
	params.Width = math.huge

	return Services.TextService:GetTextBoundsAsync(params)
end

function Utils:RandomString(length)
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	local result = ""
	for i = 1, length do
		local rand = math.random(1, #chars)
		result = result .. chars:sub(rand, rand)
	end
	return result
end

local function clamp(value, min, max)
	if value < min then
		return min
	end
	if value > max then
		return max
	end
	return value
end

-- <WINDOW>

function Elysium.new(options)
	options = options or {}

	local self = setmetatable({}, Elysium)
	self.Name = options.Name or "Elysium"
	self.Version = options.Version or "1.0"
	self.Flags = {}
	self.Tabs = {}
	self.Notifications = {}
	self.Connections = {}
	self.PageToTab = {}
	self.SelectedTab = nil
	self.Minimized = false

	local screenGuiName = Utils:RandomString(16)
	self.ScreenGui = Utils:Create("ScreenGui", {
		Name = screenGuiName,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent = game:GetService("CoreGui")
	})

	self.MainFrame = Utils:Create("Frame", {
		Size = UDim2.fromOffset(Config.WindowSize.X, Config.WindowSize.Y),
		Position = UDim2.new(0.5, -Config.WindowSize.X / 2, 0.5, -Config.WindowSize.Y / 2),
		BackgroundColor3 = CurrentTheme.Background,
		BorderSizePixel = 0,
		ZIndex = 1,
		Parent = self.ScreenGui
	})

	Utils:CreateCorner(self.MainFrame, Config.CornerRadius)
	Utils:CreateStroke(self.MainFrame, CurrentTheme.Accent, 1, 0.6)
	Utils:CreateShadow(self.MainFrame, 24, 0.88)

	self:CreateTopBar()
	self:CreateBody()
	self:CreateNotificationArea()
	self:SetupDrag()
	self:CreateWatermark({Text = self.Name .. " | v" .. self.Version})
	self:CreatePreviewPanel({Title = self.Name, Subtitle = "Preview"})

	return self
end

function Elysium:CreateTopBar()
	self.TopBar = Utils:Create("Frame", {
		Size = UDim2.new(1, 0, 0, Config.TopBarHeight),
		BackgroundColor3 = CurrentTheme.TopBar,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = self.MainFrame
	})

	Utils:CreateCorner(self.TopBar, Config.CornerRadius)
	Utils:CreateStroke(self.TopBar, CurrentTheme.Accent, 1, 0.6)

	self.TitleLabel = Utils:Create("TextLabel", {
		Size = UDim2.new(0, 220, 1, 0),
		Position = UDim2.fromOffset(18, 0),
		BackgroundTransparency = 1,
		Text = self.Name,
		Font = Enum.Font.GothamBold,
		TextSize = 20,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 3,
		Parent = self.TopBar
	})

	self.VersionBadge = Utils:Create("TextLabel", {
		Size = UDim2.fromOffset(72, 22),
		Position = UDim2.new(0, 230, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		Text = "v" .. self.Version,
		Font = Enum.Font.GothamMedium,
		TextSize = 12,
		TextColor3 = CurrentTheme.TextDim,
		ZIndex = 3,
		Parent = self.TopBar
	})

	Utils:CreateCorner(self.VersionBadge, 6)
	Utils:CreateStroke(self.VersionBadge, CurrentTheme.Accent, 1, 0.6)

	self.TabStrip = Utils:Create("ScrollingFrame", {
		Name = "TabStrip",
		Size = UDim2.new(1, -380, 1, -16),
		Position = UDim2.new(0, 320, 0, 8),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = CurrentTheme.Accent,
		ScrollBarImageTransparency = 0.5,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.X,
		ScrollingDirection = Enum.ScrollingDirection.X,
		ZIndex = 3,
		Parent = self.TopBar
	})

	Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 10),
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = self.TabStrip
	})

	self.MinimizeButton = Utils:Create("TextButton", {
		Size = UDim2.fromOffset(34, 30),
		Position = UDim2.new(1, -84, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.Element,
		Text = "—",
		Font = Enum.Font.GothamBold,
		TextSize = 18,
		TextColor3 = CurrentTheme.Text,
		AutoButtonColor = false,
		ZIndex = 3,
		Parent = self.TopBar
	})

	Utils:CreateCorner(self.MinimizeButton, 6)
	Utils:CreateStroke(self.MinimizeButton, CurrentTheme.Accent, 1, 0.6)

	self.CloseButton = Utils:Create("TextButton", {
		Size = UDim2.fromOffset(34, 30),
		Position = UDim2.new(1, -44, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.Element,
		Text = "×",
		Font = Enum.Font.GothamBold,
		TextSize = 18,
		TextColor3 = CurrentTheme.Text,
		AutoButtonColor = false,
		ZIndex = 3,
		Parent = self.TopBar
	})

	Utils:CreateCorner(self.CloseButton, 6)
	Utils:CreateStroke(self.CloseButton, CurrentTheme.Accent, 1, 0.6)

	self.MinimizeButton.MouseButton1Click:Connect(function()
		self:ToggleMinimize()
	end)

	self.CloseButton.MouseButton1Click:Connect(function()
		self:ToggleVisibility()
	end)

	for _, button in ipairs({self.MinimizeButton, self.CloseButton}) do
		button.MouseEnter:Connect(function()
			local color = button == self.CloseButton and CurrentTheme.Error or CurrentTheme.ElementHover
			Utils:Tween(button, {BackgroundColor3 = color, TextColor3 = CurrentTheme.Text}, Config.FastAnimation)
		end)

		button.MouseLeave:Connect(function()
			Utils:Tween(button, {BackgroundColor3 = CurrentTheme.Element, TextColor3 = CurrentTheme.Text}, Config.FastAnimation)
		end)
	end
end

function Elysium:CreateBody()
	self.Body = Utils:Create("Frame", {
		Size = UDim2.new(1, -16, 1, -Config.TopBarHeight - 16),
		Position = UDim2.fromOffset(8, Config.TopBarHeight + 8),
		BackgroundTransparency = 1,
		ZIndex = 2,
		Parent = self.MainFrame
	})

	self.Sidebar = Utils:Create("Frame", {
		Size = UDim2.new(0, Config.SidebarWidth, 1, 0),
		BackgroundColor3 = CurrentTheme.Sidebar,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = self.Body
	})

	Utils:CreateCorner(self.Sidebar, Config.CornerRadius)
	Utils:CreateStroke(self.Sidebar, CurrentTheme.Accent, 1, 0.6)

	self.SidebarHeader = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 26),
		Position = UDim2.fromOffset(12, 12),
		BackgroundTransparency = 1,
		Text = "SECTIONS",
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = CurrentTheme.TextDim,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 3,
		Parent = self.Sidebar
	})

	self.Content = Utils:Create("Frame", {
		Size = UDim2.new(1, -Config.SidebarWidth - 12, 1, 0),
		Position = UDim2.fromOffset(Config.SidebarWidth + 12, 0),
		BackgroundColor3 = CurrentTheme.Content,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = self.Body
	})

	Utils:CreateCorner(self.Content, Config.CornerRadius)
	Utils:CreateStroke(self.Content, CurrentTheme.Accent, 1, 0.6)
end

function Elysium:CreateNotificationArea()
	self.NotificationContainer = Utils:Create("Frame", {
		Size = UDim2.new(0, 340, 1, -80),
		Position = UDim2.new(1, -360, 0, 60),
		BackgroundTransparency = 1,
		ZIndex = 90,
		Parent = self.ScreenGui
	})

	Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Top,
		Parent = self.NotificationContainer
	})
end

function Elysium:SetupDrag()
	local dragging = false
	local dragStart
	local startPos

	self.TopBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = self.MainFrame.Position
		end
	end)

	self.TopBar.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	Services.UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			self.MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

function Elysium:ToggleVisibility()
	self.MainFrame.Visible = not self.MainFrame.Visible
end

function Elysium:ToggleMinimize()
	self.Minimized = not self.Minimized
	self.Body.Visible = not self.Minimized

	if self.Minimized then
		Utils:Tween(self.MainFrame, {Size = UDim2.fromOffset(Config.WindowSize.X, Config.TopBarHeight + 16)}, Config.AnimationSpeed)
		self.MinimizeButton.Text = "+"
	else
		Utils:Tween(self.MainFrame, {Size = UDim2.fromOffset(Config.WindowSize.X, Config.WindowSize.Y)}, Config.AnimationSpeed)
		self.MinimizeButton.Text = "—"
	end
end

function Elysium:AddTab(name, icon)
	local tab = {
		Name = name,
		Icon = icon,
		LayoutOrder = #self.Tabs + 1,
		Sections = {}
	}

	tab.Button = Utils:Create("TextButton", {
		Name = name .. "Tab",
		Size = UDim2.fromOffset(130, 36),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		Text = name,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = CurrentTheme.TextDim,
		AutoButtonColor = false,
		LayoutOrder = tab.LayoutOrder,
		ZIndex = 4,
		Parent = self.TabStrip
	})

	Utils:CreateCorner(tab.Button, 6)
	Utils:CreateStroke(tab.Button, CurrentTheme.Accent, 1, 0.7)

	tab.Page = Utils:Create("ScrollingFrame", {
		Name = name .. "Page",
		Size = UDim2.new(1, -Config.ContentPadding * 2, 1, -Config.ContentPadding * 2),
		Position = UDim2.fromOffset(Config.ContentPadding, Config.ContentPadding),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 5,
		ScrollBarImageColor3 = CurrentTheme.Accent,
		ScrollBarImageTransparency = 0.4,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = false,
		ZIndex = 3,
		Parent = self.Content
	})

	Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = tab.Page
	})

	tab.Sidebar = Utils:Create("ScrollingFrame", {
		Name = name .. "Sidebar",
		Size = UDim2.new(1, -16, 1, -50),
		Position = UDim2.fromOffset(8, 40),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 5,
		ScrollBarImageColor3 = CurrentTheme.Accent,
		ScrollBarImageTransparency = 0.4,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = false,
		ZIndex = 3,
		Parent = self.Sidebar
	})

	Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = tab.Sidebar
	})

	tab.Button.MouseButton1Click:Connect(function()
		self:SelectTab(tab)
	end)

	tab.Button.MouseEnter:Connect(function()
		if tab ~= self.SelectedTab then
			Utils:Tween(tab.Button, {BackgroundColor3 = CurrentTheme.ElementHover, TextColor3 = CurrentTheme.Text}, Config.FastAnimation)
		end
	end)

	tab.Button.MouseLeave:Connect(function()
		if tab ~= self.SelectedTab then
			Utils:Tween(tab.Button, {BackgroundColor3 = CurrentTheme.Element, TextColor3 = CurrentTheme.TextDim}, Config.FastAnimation)
		end
	end)

	self.PageToTab[tab.Page] = tab
	table.insert(self.Tabs, tab)

	if #self.Tabs == 1 then
		task.defer(function()
			self:SelectTab(tab)
		end)
	end

	return tab.Page
end

function Elysium:SelectTab(tab)
	if not tab then
		return
	end

	if self.SelectedTab then
		self.SelectedTab.Page.Visible = false
		self.SelectedTab.Sidebar.Visible = false
		Utils:Tween(self.SelectedTab.Button, {BackgroundColor3 = CurrentTheme.Element, TextColor3 = CurrentTheme.TextDim}, Config.AnimationSpeed)
	end

	self.SelectedTab = tab
	tab.Page.Visible = true
	tab.Sidebar.Visible = true
	Utils:Tween(tab.Button, {BackgroundColor3 = CurrentTheme.ElementActive, TextColor3 = CurrentTheme.Text}, Config.AnimationSpeed)
end

-- <COMPONENTS>

function Elysium:CreateCategory(parent, name)
	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -10, 0, 26),
		BackgroundTransparency = 1,
		ZIndex = 3,
		Parent = parent
	})

	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = name:upper(),
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = CurrentTheme.TextDim,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})

	return label
end

function Elysium:CreateSection(parent, name)
	local section = Utils:Create("Frame", {
		Size = UDim2.new(1, -10, 0, 0),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})

	Utils:CreateCorner(section, 8)
	Utils:CreateStroke(section, CurrentTheme.Accent, 1, 0.7)

	local header = Utils:Create("Frame", {
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundTransparency = 1,
		ZIndex = 4,
		Parent = section
	})

	local title = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -60, 1, 0),
		Position = UDim2.fromOffset(14, 0),
		BackgroundTransparency = 1,
		Text = name,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 5,
		Parent = header
	})

	local toggle = Utils:Create("TextButton", {
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.new(1, -32, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = "▾",
		Font = Enum.Font.GothamBold,
		TextSize = 16,
		TextColor3 = CurrentTheme.TextDim,
		ZIndex = 5,
		Parent = header
	})

	local content = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 0, 0),
		Position = UDim2.fromOffset(10, 46),
		BackgroundTransparency = 1,
		ZIndex = 4,
		Parent = section
	})

	local layout = Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = content
	})

	local expanded = true

	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if expanded then
			content.Size = UDim2.new(1, -20, 0, layout.AbsoluteContentSize.Y)
			section.Size = UDim2.new(1, -10, 0, layout.AbsoluteContentSize.Y + 56)
		end
	end)

	toggle.MouseButton1Click:Connect(function()
		expanded = not expanded
		toggle.Text = expanded and "▾" or "▸"
		if expanded then
			Utils:Tween(content, {Size = UDim2.new(1, -20, 0, layout.AbsoluteContentSize.Y)}, Config.AnimationSpeed)
			Utils:Tween(section, {Size = UDim2.new(1, -10, 0, layout.AbsoluteContentSize.Y + 56)}, Config.AnimationSpeed)
		else
			Utils:Tween(content, {Size = UDim2.new(1, -20, 0, 0)}, Config.AnimationSpeed)
			Utils:Tween(section, {Size = UDim2.new(1, -10, 0, 40)}, Config.AnimationSpeed)
		end
	end)

	return content
end

function Elysium:CreateDivider(parent)
	local divider = Utils:Create("Frame", {
		Size = UDim2.new(1, -10, 0, Config.DividerHeight),
		BackgroundColor3 = CurrentTheme.ElementHover,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})

	return divider
end

function Elysium:CreateLabel(parent, text, options)
	options = options or {}

	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -10, 0, options.Height or Config.LabelHeight),
		BackgroundTransparency = 1,
		ZIndex = 3,
		Parent = parent
	})

	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = options.Font or Enum.Font.Gotham,
		TextSize = options.TextSize or 13,
		TextColor3 = options.Color or CurrentTheme.TextDim,
		TextXAlignment = options.Alignment or Enum.TextXAlignment.Left,
		TextWrapped = true,
		ZIndex = 4,
		Parent = frame
	})

	return label
end

function Elysium:CreateToggle(parent, text, flag, default, callback)
	default = default or false
	self.Flags[flag] = default

	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -10, 0, Config.ToggleHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})

	Utils:CreateCorner(frame, 7)
	Utils:CreateStroke(frame, CurrentTheme.Accent, 1, 0.7)

	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -90, 1, 0),
		Position = UDim2.fromOffset(14, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamMedium,
		TextSize = 14,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})

	local toggleBg = Utils:Create("Frame", {
		Size = UDim2.fromOffset(52, 26),
		Position = UDim2.new(1, -62, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = default and CurrentTheme.Primary or CurrentTheme.ElementHover,
		BorderSizePixel = 0,
		ZIndex = 4,
		Parent = frame
	})

	Utils:CreateCorner(toggleBg, 14)

	local toggleCircle = Utils:Create("Frame", {
		Size = UDim2.fromOffset(20, 20),
		Position = default and UDim2.new(1, -24, 0.5, 0) or UDim2.new(0, 4, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.Text,
		BorderSizePixel = 0,
		ZIndex = 5,
		Parent = toggleBg
	})

	Utils:CreateCorner(toggleCircle, 10)

	local button = Utils:Create("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 6,
		Parent = frame
	})

	button.MouseButton1Click:Connect(function()
		self.Flags[flag] = not self.Flags[flag]

		if self.Flags[flag] then
			Utils:Tween(toggleCircle, {Position = UDim2.new(1, -24, 0.5, 0)}, Config.FastAnimation)
			Utils:Tween(toggleBg, {BackgroundColor3 = CurrentTheme.Primary}, Config.FastAnimation)
		else
			Utils:Tween(toggleCircle, {Position = UDim2.new(0, 4, 0.5, 0)}, Config.FastAnimation)
			Utils:Tween(toggleBg, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
		end

		if callback then
			task.spawn(callback, self.Flags[flag])
		end
	end)

	button.MouseEnter:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
	end)

	button.MouseLeave:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.Element}, Config.FastAnimation)
	end)

	return frame
end

function Elysium:CreateButton(parent, text, callback)
	local button = Utils:Create("TextButton", {
		Size = UDim2.new(1, -10, 0, Config.ButtonHeight),
		BackgroundColor3 = CurrentTheme.ElementActive,
		BorderSizePixel = 0,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = CurrentTheme.Text,
		AutoButtonColor = false,
		ZIndex = 3,
		Parent = parent
	})

	Utils:CreateCorner(button, 7)
	Utils:CreateStroke(button, CurrentTheme.Accent, 1, 0.7)

	button.MouseButton1Click:Connect(function()
		Utils:Tween(button, {BackgroundColor3 = CurrentTheme.ElementHover}, 0.08)
		task.wait(0.08)
		Utils:Tween(button, {BackgroundColor3 = CurrentTheme.ElementActive}, 0.08)

		if callback then
			task.spawn(callback)
		end
	end)

	button.MouseEnter:Connect(function()
		Utils:Tween(button, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
	end)

	button.MouseLeave:Connect(function()
		Utils:Tween(button, {BackgroundColor3 = CurrentTheme.ElementActive}, Config.FastAnimation)
	end)

	return button
end

function Elysium:CreateSlider(parent, text, min, max, default, decimals, flag, callback)
	default = default or min
	decimals = decimals or 0
	self.Flags[flag] = default

	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -10, 0, Config.SliderHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})

	Utils:CreateCorner(frame, 7)
	Utils:CreateStroke(frame, CurrentTheme.Accent, 1, 0.7)

	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -80, 0, 20),
		Position = UDim2.fromOffset(14, 8),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})

	local valueLabel = Utils:Create("TextLabel", {
		Size = UDim2.fromOffset(58, 20),
		Position = UDim2.new(1, -66, 0, 8),
		BackgroundColor3 = CurrentTheme.ElementHover,
		Text = tostring(default),
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = CurrentTheme.TextDim,
		ZIndex = 4,
		Parent = frame
	})

	Utils:CreateCorner(valueLabel, 5)

	local sliderBg = Utils:Create("Frame", {
		Size = UDim2.new(1, -28, 0, 8),
		Position = UDim2.fromOffset(14, 36),
		BackgroundColor3 = CurrentTheme.ElementHover,
		BorderSizePixel = 0,
		ZIndex = 4,
		Parent = frame
	})

	Utils:CreateCorner(sliderBg, 4)

	local sliderFill = Utils:Create("Frame", {
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = CurrentTheme.Primary,
		BorderSizePixel = 0,
		ZIndex = 5,
		Parent = sliderBg
	})

	Utils:CreateCorner(sliderFill, 4)

	local knob = Utils:Create("Frame", {
		Size = UDim2.fromOffset(12, 12),
		Position = UDim2.new(0, -6, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = CurrentTheme.Text,
		BorderSizePixel = 0,
		ZIndex = 6,
		Parent = sliderBg
	})

	Utils:CreateCorner(knob, 6)

	local dragging = false

	local function updateValue(inputX)
		local pos = clamp((inputX - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
		local value = min + (max - min) * pos
		local mult = 10 ^ decimals
		value = math.floor(value * mult + 0.5) / mult

		sliderFill.Size = UDim2.new(pos, 0, 1, 0)
		knob.Position = UDim2.new(pos, 0, 0.5, 0)
		valueLabel.Text = tostring(value)
		self.Flags[flag] = value

		if callback then
			task.spawn(callback, value)
		end
	end

	sliderBg.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			updateValue(input.Position.X)
		end
	end)

	Services.UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	Services.UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			updateValue(input.Position.X)
		end
	end)

	updateValue(sliderBg.AbsolutePosition.X + sliderBg.AbsoluteSize.X * ((default - min) / (max - min)))

	return frame
end


function Elysium:CreateDropdown(parent, text, options, default, flag, callback)
	options = options or {}
	default = default or options[1]
	self.Flags[flag] = default

	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -10, 0, Config.DropdownHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})

	Utils:CreateCorner(frame, 7)
	Utils:CreateStroke(frame, CurrentTheme.Accent, 1, 0.7)

	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(0.45, -10, 1, 0),
		Position = UDim2.fromOffset(14, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})

	local valueLabel = Utils:Create("TextLabel", {
		Size = UDim2.new(0.55, -64, 0, 30),
		Position = UDim2.new(0.45, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.ElementHover,
		Text = tostring(default),
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = CurrentTheme.TextDim,
		ZIndex = 4,
		Parent = frame
	})

	Utils:CreateCorner(valueLabel, 5)

	local arrow = Utils:Create("TextLabel", {
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.new(1, -36, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = "▾",
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = CurrentTheme.TextDim,
		ZIndex = 4,
		Parent = frame
	})

	local dropdownOpen = false
	local dropdownList = Utils:Create("Frame", {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0, 0, 1, 6),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = Config.DropdownZIndex,
		ClipsDescendants = true,
		Parent = self.ScreenGui
	})

	Utils:CreateCorner(dropdownList, 7)
	Utils:CreateStroke(dropdownList, CurrentTheme.Accent, 1, 0.7)

	Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 3),
		Parent = dropdownList
	})

	local optionButtons = {}

	for _, option in ipairs(options) do
		local optionBtn = Utils:Create("TextButton", {
			Size = UDim2.new(1, -12, 0, 36),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = option == default and CurrentTheme.ElementActive or CurrentTheme.ElementHover,
			Text = option,
			Font = Enum.Font.Gotham,
			TextSize = 13,
			TextColor3 = option == default and CurrentTheme.Text or CurrentTheme.TextDim,
			AutoButtonColor = false,
			ZIndex = Config.DropdownZIndex + 1,
			Parent = dropdownList
		})

		Utils:CreateCorner(optionBtn, 5)
		table.insert(optionButtons, optionBtn)

		optionBtn.MouseButton1Click:Connect(function()
			self.Flags[flag] = option
			valueLabel.Text = option
			dropdownOpen = false

			Utils:Tween(dropdownList, {Size = UDim2.new(0, dropdownList.AbsoluteSize.X, 0, 0)}, Config.AnimationSpeed)
			task.wait(Config.AnimationSpeed)
			dropdownList.Visible = false
			Utils:Tween(arrow, {Rotation = 0}, Config.AnimationSpeed)

			for _, btn in ipairs(optionButtons) do
				if btn.Text == option then
					Utils:Tween(btn, {BackgroundColor3 = CurrentTheme.ElementActive, TextColor3 = CurrentTheme.Text}, Config.FastAnimation)
				else
					Utils:Tween(btn, {BackgroundColor3 = CurrentTheme.ElementHover, TextColor3 = CurrentTheme.TextDim}, Config.FastAnimation)
				end
			end

			if callback then
				task.spawn(callback, option)
			end
		end)
	end

	local toggleButton = Utils:Create("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 49,
		Parent = frame
	})

	local function updateDropdownPosition()
		dropdownList.Position = UDim2.new(0, frame.AbsolutePosition.X, 0, frame.AbsolutePosition.Y + frame.AbsoluteSize.Y + 6)
		local width = frame.AbsoluteSize.X
		dropdownList.Size = UDim2.new(0, width, 0, dropdownList.AbsoluteSize.Y)
	end

	local function closeDropdown()
		dropdownOpen = false
		Utils:Tween(dropdownList, {Size = UDim2.new(0, dropdownList.AbsoluteSize.X, 0, 0)}, Config.AnimationSpeed)
		Utils:Tween(arrow, {Rotation = 0}, Config.AnimationSpeed)
		task.wait(Config.AnimationSpeed)
		dropdownList.Visible = false
	end

	toggleButton.MouseButton1Click:Connect(function()
		dropdownOpen = not dropdownOpen
		if dropdownOpen then
			dropdownList.Visible = true
			updateDropdownPosition()
			local listHeight = math.min(#options * 39, Config.DropdownMaxHeight)
			Utils:Tween(dropdownList, {Size = UDim2.new(0, frame.AbsoluteSize.X, 0, listHeight)}, Config.AnimationSpeed)
			Utils:Tween(arrow, {Rotation = 180}, Config.AnimationSpeed)
		else
			closeDropdown()
		end
	end)

	Services.UserInputService.InputBegan:Connect(function(input, processed)
		if processed then
			return
		end
		if dropdownOpen and input.UserInputType == Enum.UserInputType.MouseButton1 then
			local mousePos = Services.UserInputService:GetMouseLocation()
			local insideFrame = mousePos.X >= frame.AbsolutePosition.X and mousePos.X <= frame.AbsolutePosition.X + frame.AbsoluteSize.X
				and mousePos.Y >= frame.AbsolutePosition.Y and mousePos.Y <= frame.AbsolutePosition.Y + frame.AbsoluteSize.Y
			local insideDropdown = mousePos.X >= dropdownList.AbsolutePosition.X and mousePos.X <= dropdownList.AbsolutePosition.X + dropdownList.AbsoluteSize.X
				and mousePos.Y >= dropdownList.AbsolutePosition.Y and mousePos.Y <= dropdownList.AbsolutePosition.Y + dropdownList.AbsoluteSize.Y
			if not insideFrame and not insideDropdown then
				closeDropdown()
			end
		end
	end)

	return frame
end

function Elysium:CreateMultiDropdown(parent, text, options, defaults, flag, callback)
	defaults = defaults or {}
	self.Flags[flag] = defaults

	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -10, 0, Config.DropdownHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})

	Utils:CreateCorner(frame, 7)
	Utils:CreateStroke(frame, CurrentTheme.Accent, 1, 0.7)

	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(0.45, -10, 1, 0),
		Position = UDim2.fromOffset(14, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})

	local countLabel = Utils:Create("TextLabel", {
		Size = UDim2.new(0.55, -64, 0, 30),
		Position = UDim2.new(0.45, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.ElementHover,
		Text = #defaults .. " selected",
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = CurrentTheme.TextDim,
		ZIndex = 4,
		Parent = frame
	})

	Utils:CreateCorner(countLabel, 5)

	local arrow = Utils:Create("TextLabel", {
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.new(1, -36, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = "▾",
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = CurrentTheme.TextDim,
		ZIndex = 4,
		Parent = frame
	})

	local dropdownOpen = false
	local dropdownList = Utils:Create("Frame", {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0, 0, 1, 6),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = Config.DropdownZIndex,
		ClipsDescendants = true,
		Parent = self.ScreenGui
	})

	Utils:CreateCorner(dropdownList, 7)
	Utils:CreateStroke(dropdownList, CurrentTheme.Accent, 1, 0.7)

	Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 3),
		Parent = dropdownList
	})

	local function isSelected(option)
		for _, selected in ipairs(self.Flags[flag]) do
			if selected == option then
				return true
			end
		end
		return false
	end

	local function updateCount()
		countLabel.Text = #self.Flags[flag] .. " selected"
	end

	for _, option in ipairs(options) do
		local optionFrame = Utils:Create("Frame", {
			Size = UDim2.new(1, -12, 0, 36),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = CurrentTheme.ElementHover,
			BorderSizePixel = 0,
			ZIndex = Config.DropdownZIndex + 1,
			Parent = dropdownList
		})

		Utils:CreateCorner(optionFrame, 5)

		local checkbox = Utils:Create("Frame", {
			Size = UDim2.fromOffset(18, 18),
			Position = UDim2.fromOffset(10, 9),
			BackgroundColor3 = isSelected(option) and CurrentTheme.Primary or CurrentTheme.ElementActive,
			BorderSizePixel = 0,
			ZIndex = Config.DropdownZIndex + 2,
			Parent = optionFrame
		})

		Utils:CreateCorner(checkbox, 4)

		if isSelected(option) then
			Utils:Create("TextLabel", {
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = "✓",
				Font = Enum.Font.GothamBold,
				TextSize = 14,
				TextColor3 = CurrentTheme.Text,
				ZIndex = Config.DropdownZIndex + 3,
				Parent = checkbox
			})
		end

		local optionText = Utils:Create("TextLabel", {
			Size = UDim2.new(1, -45, 1, 0),
			Position = UDim2.fromOffset(36, 0),
			BackgroundTransparency = 1,
			Text = option,
			Font = Enum.Font.Gotham,
			TextSize = 13,
			TextColor3 = CurrentTheme.TextDim,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = Config.DropdownZIndex + 2,
			Parent = optionFrame
		})

		local optionBtn = Utils:Create("TextButton", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = "",
			ZIndex = Config.DropdownZIndex + 4,
			Parent = optionFrame
		})

		optionBtn.MouseButton1Click:Connect(function()
			if isSelected(option) then
				for i, selected in ipairs(self.Flags[flag]) do
					if selected == option then
						table.remove(self.Flags[flag], i)
						break
					end
				end
				Utils:Tween(checkbox, {BackgroundColor3 = CurrentTheme.ElementActive}, Config.FastAnimation)
				local checkmark = checkbox:FindFirstChild("TextLabel")
				if checkmark then
					checkmark:Destroy()
				end
			else
				table.insert(self.Flags[flag], option)
				Utils:Tween(checkbox, {BackgroundColor3 = CurrentTheme.Primary}, Config.FastAnimation)
				Utils:Create("TextLabel", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text = "✓",
					Font = Enum.Font.GothamBold,
					TextSize = 14,
					TextColor3 = CurrentTheme.Text,
					ZIndex = Config.DropdownZIndex + 3,
					Parent = checkbox
				})
			end

			updateCount()

			if callback then
				task.spawn(callback, self.Flags[flag])
			end
		end)
	end

	local toggleButton = Utils:Create("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 49,
		Parent = frame
	})

	local function updateDropdownPosition()
		dropdownList.Position = UDim2.new(0, frame.AbsolutePosition.X, 0, frame.AbsolutePosition.Y + frame.AbsoluteSize.Y + 6)
		local width = frame.AbsoluteSize.X
		dropdownList.Size = UDim2.new(0, width, 0, dropdownList.AbsoluteSize.Y)
	end

	local function closeDropdown()
		dropdownOpen = false
		Utils:Tween(dropdownList, {Size = UDim2.new(0, dropdownList.AbsoluteSize.X, 0, 0)}, Config.AnimationSpeed)
		Utils:Tween(arrow, {Rotation = 0}, Config.AnimationSpeed)
		task.wait(Config.AnimationSpeed)
		dropdownList.Visible = false
	end

	toggleButton.MouseButton1Click:Connect(function()
		dropdownOpen = not dropdownOpen
		if dropdownOpen then
			dropdownList.Visible = true
			updateDropdownPosition()
			local listHeight = math.min(#options * 39, Config.DropdownMaxHeight)
			Utils:Tween(dropdownList, {Size = UDim2.new(0, frame.AbsoluteSize.X, 0, listHeight)}, Config.AnimationSpeed)
			Utils:Tween(arrow, {Rotation = 180}, Config.AnimationSpeed)
		else
			closeDropdown()
		end
	end)

	Services.UserInputService.InputBegan:Connect(function(input, processed)
		if processed then
			return
		end
		if dropdownOpen and input.UserInputType == Enum.UserInputType.MouseButton1 then
			local mousePos = Services.UserInputService:GetMouseLocation()
			local insideFrame = mousePos.X >= frame.AbsolutePosition.X and mousePos.X <= frame.AbsolutePosition.X + frame.AbsoluteSize.X
				and mousePos.Y >= frame.AbsolutePosition.Y and mousePos.Y <= frame.AbsolutePosition.Y + frame.AbsoluteSize.Y
			local insideDropdown = mousePos.X >= dropdownList.AbsolutePosition.X and mousePos.X <= dropdownList.AbsolutePosition.X + dropdownList.AbsoluteSize.X
				and mousePos.Y >= dropdownList.AbsolutePosition.Y and mousePos.Y <= dropdownList.AbsolutePosition.Y + dropdownList.AbsoluteSize.Y
			if not insideFrame and not insideDropdown then
				closeDropdown()
			end
		end
	end)

	return frame
end

function Elysium:CreateTextBox(parent, text, placeholder, flag, callback)
	self.Flags[flag] = ""

	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -10, 0, Config.TextBoxHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})

	Utils:CreateCorner(frame, 7)
	Utils:CreateStroke(frame, CurrentTheme.Accent, 1, 0.7)

	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(0.35, -10, 1, 0),
		Position = UDim2.fromOffset(14, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})

	local textBox = Utils:Create("TextBox", {
		Size = UDim2.new(0.65, -28, 0, 30),
		Position = UDim2.new(0.35, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.ElementHover,
		PlaceholderText = placeholder or "Enter text",
		PlaceholderColor3 = CurrentTheme.TextDark,
		Text = "",
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = CurrentTheme.Text,
		ClearTextOnFocus = false,
		ZIndex = 4,
		Parent = frame
	})

	Utils:CreateCorner(textBox, 5)

	textBox:GetPropertyChangedSignal("Text"):Connect(function()
		self.Flags[flag] = textBox.Text
		if callback then
			task.spawn(callback, textBox.Text)
		end
	end)

	return textBox
end

function Elysium:CreateKeybind(parent, text, defaultKey, flag, callback)
	defaultKey = defaultKey or Enum.KeyCode.E
	self.Flags[flag] = defaultKey

	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -10, 0, Config.KeybindHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})

	Utils:CreateCorner(frame, 7)
	Utils:CreateStroke(frame, CurrentTheme.Accent, 1, 0.7)

	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(0.6, -10, 1, 0),
		Position = UDim2.fromOffset(14, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})

	local keyLabel = Utils:Create("TextButton", {
		Size = UDim2.new(0.4, -24, 0, 28),
		Position = UDim2.new(0.6, 6, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.ElementHover,
		Text = defaultKey.Name,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = CurrentTheme.TextDim,
		AutoButtonColor = false,
		ZIndex = 4,
		Parent = frame
	})

	Utils:CreateCorner(keyLabel, 5)

	keyLabel.MouseButton1Click:Connect(function()
		keyLabel.Text = "..."
		local connection
		connection = Services.UserInputService.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Keyboard then
				self.Flags[flag] = input.KeyCode
				keyLabel.Text = input.KeyCode.Name
				if callback then
					task.spawn(callback, input.KeyCode)
				end
				connection:Disconnect()
			end
		end)
	end)

	return frame
end

function Elysium:CreateColorPicker(parent, text, default, flag, callback)
	default = default or Color3.fromRGB(255, 255, 255)
	self.Flags[flag] = default

	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -10, 0, Config.ColorPickerHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})

	Utils:CreateCorner(frame, 7)
	Utils:CreateStroke(frame, CurrentTheme.Accent, 1, 0.7)

	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -140, 1, 0),
		Position = UDim2.fromOffset(14, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})

	local preview = Utils:Create("Frame", {
		Size = UDim2.fromOffset(42, 26),
		Position = UDim2.new(1, -108, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = default,
		BorderSizePixel = 0,
		ZIndex = 4,
		Parent = frame
	})

	Utils:CreateCorner(preview, 5)
	Utils:CreateStroke(preview, CurrentTheme.ElementHover, 1)

	local colorDisplay = Utils:Create("TextButton", {
		Size = UDim2.fromOffset(56, 26),
		Position = UDim2.new(1, -62, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = default,
		Text = "",
		ZIndex = 4,
		Parent = frame
	})

	Utils:CreateCorner(colorDisplay, 5)

	local pickerOpen = false
	local picker = Utils:Create("Frame", {
		Size = UDim2.fromOffset(240, 260),
		Position = UDim2.new(0.5, -120, 0.5, -130),
		BackgroundColor3 = CurrentTheme.Sidebar,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = Config.FloatingZIndex,
		Parent = self.ScreenGui
	})

	Utils:CreateCorner(picker, 8)
	Utils:CreateStroke(picker, CurrentTheme.Accent, 1, 0.7)

	local hue = 0
	local sat = 1
	local val = 1

	local svBox = Utils:Create("Frame", {
		Size = UDim2.fromOffset(160, 160),
		Position = UDim2.fromOffset(16, 16),
		BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
		BorderSizePixel = 0,
		ZIndex = Config.FloatingZIndex + 1,
		Parent = picker
	})

	Utils:CreateCorner(svBox, 6)

	local hueSlider = Utils:Create("Frame", {
		Size = UDim2.fromOffset(20, 160),
		Position = UDim2.fromOffset(188, 16),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = Config.FloatingZIndex + 1,
		Parent = picker
	})

	Utils:CreateCorner(hueSlider, 6)
	Utils:Create("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
		}),
		Rotation = 90,
		Parent = hueSlider
	})

	local function updateColor()
		local color = Color3.fromHSV(hue, sat, val)
		self.Flags[flag] = color
		colorDisplay.BackgroundColor3 = color
		preview.BackgroundColor3 = color
		svBox.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
		if callback then
			task.spawn(callback, color)
		end
	end

	local draggingHue = false
	local draggingSV = false

	hueSlider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingHue = true
		end
	end)

	svBox.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingSV = true
		end
	end)

	Services.UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingHue = false
			draggingSV = false
		end
	end)

	Services.UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end

		if draggingHue then
			local pos = clamp((input.Position.Y - hueSlider.AbsolutePosition.Y) / hueSlider.AbsoluteSize.Y, 0, 1)
			hue = 1 - pos
			updateColor()
		end

		if draggingSV then
			local posX = clamp((input.Position.X - svBox.AbsolutePosition.X) / svBox.AbsoluteSize.X, 0, 1)
			local posY = clamp((input.Position.Y - svBox.AbsolutePosition.Y) / svBox.AbsoluteSize.Y, 0, 1)
			sat = posX
			val = 1 - posY
			updateColor()
		end
	end)

	local function positionPicker()
		local viewport = Services.Workspace.CurrentCamera and Services.Workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
		picker.Position = UDim2.new(0, clamp(frame.AbsolutePosition.X, 20, viewport.X - picker.AbsoluteSize.X - 20), 0, clamp(frame.AbsolutePosition.Y - picker.AbsoluteSize.Y - 10, 20, viewport.Y - picker.AbsoluteSize.Y - 20))
	end

	colorDisplay.MouseButton1Click:Connect(function()
		pickerOpen = not pickerOpen
		picker.Visible = pickerOpen
		if pickerOpen then
			positionPicker()
			updateColor()
		end
	end)

	return frame
end

function Elysium:CreateSearch(parent, placeholder, callback)
	local box = Utils:Create("TextBox", {
		Size = UDim2.new(1, -10, 0, 32),
		Position = UDim2.fromOffset(0, 0),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		PlaceholderText = placeholder or "Search",
		PlaceholderColor3 = CurrentTheme.TextDark,
		Text = "",
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = CurrentTheme.Text,
		ClearTextOnFocus = false,
		ZIndex = 4,
		Parent = parent
	})

	Utils:CreateCorner(box, 6)
	Utils:CreateStroke(box, CurrentTheme.Accent, 1, 0.7)

	if callback then
		box:GetPropertyChangedSignal("Text"):Connect(function()
			callback(box.Text)
		end)
	end

	return box
end

function Elysium:CreateWatermark(options)
	options = options or {}
	local text = options.Text or self.Name
	local position = options.Position or UDim2.new(0, 18, 0, 18)

	local watermark = Utils:Create("Frame", {
		Size = UDim2.fromOffset(220, 34),
		Position = position,
		BackgroundColor3 = CurrentTheme.TopBar,
		BorderSizePixel = 0,
		ZIndex = 90,
		Parent = self.ScreenGui
	})

	Utils:CreateCorner(watermark, 8)
	Utils:CreateStroke(watermark, CurrentTheme.Accent, 1, 0.7)

	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -16, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 91,
		Parent = watermark
	})

	self.Watermark = {
		Frame = watermark,
		Label = label
	}

	return watermark
end

function Elysium:CreatePreviewPanel(options)
	options = options or {}
	local title = options.Title or self.Name
	local subtitle = options.Subtitle or "Preview"

	local panel = Utils:Create("Frame", {
		Size = UDim2.fromOffset(260, 150),
		Position = UDim2.new(1, -280, 1, -170),
		BackgroundColor3 = CurrentTheme.Content,
		BorderSizePixel = 0,
		ZIndex = 90,
		Parent = self.ScreenGui
	})

	Utils:CreateCorner(panel, 10)
	Utils:CreateStroke(panel, CurrentTheme.Accent, 1, 0.7)

	local header = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 22),
		Position = UDim2.fromOffset(12, 10),
		BackgroundTransparency = 1,
		Text = title,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 91,
		Parent = panel
	})

	local sub = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 18),
		Position = UDim2.fromOffset(12, 30),
		BackgroundTransparency = 1,
		Text = subtitle,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = CurrentTheme.TextDim,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 91,
		Parent = panel
	})

	local stats = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 90),
		Position = UDim2.fromOffset(12, 52),
		BackgroundTransparency = 1,
		Text = "",
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = CurrentTheme.TextDim,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextWrapped = true,
		ZIndex = 91,
		Parent = panel
	})

	self.PreviewPanel = {
		Frame = panel,
		Header = header,
		Subtitle = sub,
		Stats = stats
	}

	self:StartStatsUpdater()

	return panel
end

function Elysium:CreatePlayerList(parent)
	local container = Utils:Create("Frame", {
		Size = UDim2.new(1, -10, 0, 260),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})

	Utils:CreateCorner(container, 8)
	Utils:CreateStroke(container, CurrentTheme.Accent, 1, 0.7)

	local header = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 26),
		Position = UDim2.fromOffset(12, 10),
		BackgroundTransparency = 1,
		Text = "PLAYERS",
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = CurrentTheme.TextDim,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = container
	})

	local list = Utils:Create("ScrollingFrame", {
		Size = UDim2.new(1, -20, 1, -44),
		Position = UDim2.fromOffset(10, 36),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = CurrentTheme.Accent,
		ScrollBarImageTransparency = 0.4,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ZIndex = 4,
		Parent = container
	})

	Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = list
	})

	local function addPlayer(player)
		local row = Utils:Create("Frame", {
			Size = UDim2.new(1, 0, 0, 32),
			BackgroundColor3 = CurrentTheme.ElementHover,
			BorderSizePixel = 0,
			ZIndex = 5,
			Parent = list
		})

		Utils:CreateCorner(row, 6)

		local nameLabel = Utils:Create("TextLabel", {
			Size = UDim2.new(1, -40, 1, 0),
			Position = UDim2.fromOffset(12, 0),
			BackgroundTransparency = 1,
			Text = player.Name,
			Font = Enum.Font.GothamMedium,
			TextSize = 12,
			TextColor3 = CurrentTheme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 6,
			Parent = row
		})

		row.Name = player.Name
		return row
	end

	for _, player in ipairs(Services.Players:GetPlayers()) do
		addPlayer(player)
	end

	Services.Players.PlayerAdded:Connect(function(player)
		addPlayer(player)
	end)

	Services.Players.PlayerRemoving:Connect(function(player)
		local row = list:FindFirstChild(player.Name)
		if row then
			row:Destroy()
		end
	end)

	return container
end

function Elysium:Notify(title, message, level, duration)
	local text = title
	if message then
		text = tostring(title) .. " - " .. tostring(message)
	end
	if type(title) == "table" then
		text = title.Text or ""
		duration = title.Duration
	end

	duration = duration or 3

	local notification = Utils:Create("Frame", {
		Size = UDim2.new(1, 0, 0, 48),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 91,
		Parent = self.NotificationContainer
	})

	Utils:CreateCorner(notification, 8)
	Utils:CreateStroke(notification, CurrentTheme.Accent, 1, 0.7)

	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -16, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = CurrentTheme.Text,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 92,
		Parent = notification
	})

	Utils:Tween(notification, {BackgroundColor3 = CurrentTheme.ElementHover}, 0.12)
	task.delay(duration, function()
		Utils:Tween(notification, {BackgroundTransparency = 1}, 0.2, nil, nil, function()
			notification:Destroy()
		end)
	end)

	return notification
end

function Elysium:StartStatsUpdater()
	if self.StatsConnection then
		return
	end

	local lastTime = os.clock()
	local frames = 0

	self.StatsConnection = Services.RunService.RenderStepped:Connect(function()
		frames += 1
		local now = os.clock()
		if now - lastTime >= 1 then
			local fps = math.floor(frames / (now - lastTime))
			frames = 0
			lastTime = now

			local ping = 0
			pcall(function()
				ping = math.floor(Services.Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
			end)

			local timeString = os.date("%H:%M:%S")
			local gameName = game.Name
			local placeId = game.PlaceId
			local playerName = LocalPlayer and LocalPlayer.Name or "Player"
			local playerCount = #Services.Players:GetPlayers()
			local maxPlayers = Services.Players.MaxPlayers
			local serverInfo = string.format("%d/%d", playerCount, maxPlayers)
			local version = game.GameId

			if self.PreviewPanel then
				self.PreviewPanel.Stats.Text = string.format("FPS: %d\nPing: %dms\nTime: %s\nPlayer: %s\nServer: %s\nGame: %s\nPlaceId: %d\nGameId: %d", fps, ping, timeString, playerName, serverInfo, gameName, placeId, version)
			end
			if self.Watermark then
				self.Watermark.Label.Text = string.format("%s | FPS %d | %dms | %s", self.Name, fps, ping, serverInfo)
			end
		end
	end)
end

return Elysium
