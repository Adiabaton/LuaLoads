--[[
	═══════════════════════════════════════════════════════════════════════════════
	███████╗██╗  ██╗   ██╗███████╗██╗██╗   ██╗███╗   ███╗
	██╔════╝██║  ╚██╗ ██╔╝██╔════╝██║██║   ██║████╗ ████║
	█████╗  ██║   ╚████╔╝ ███████╗██║██║   ██║██╔████╔██║
	██╔══╝  ██║    ╚██╔╝  ╚════██║██║██║   ██║██║╚██╔╝██║
	███████╗███████╗██║   ███████║██║╚██████╔╝██║ ╚═╝ ██║
	╚══════╝╚══════╝╚═╝   ╚══════╝╚═╝ ╚═════╝ ╚═╝     ╚═╝
	═══════════════════════════════════════════════════════════════════════════════
	
	
	Features:
	✓ 20+ Components               ✓ 6 Premium Themes
	✓ Advanced Tab System          ✓ Notification System
	✓ Config Save/Load             ✓ Theme Switching
	✓ Draggable Interface          ✓ Smooth Animations
	✓ Search System                ✓ Color Picker (HSV/RGB/Hex)
	✓ Multi-Selection              ✓ Keybind System
	✓ Player List                  ✓ Dropdown Menus
	✓ Tooltips                     ✓ Context Menus
	✓ Progress Bars                ✓ Image Support
	✓ Rainbow Mode                 ✓ Particle Effects

	License: Proprietary
	═══════════════════════════════════════════════════════════════════════════════
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

local Elysium = {}
Elysium.__index = Elysium
Elysium.Version = "0.0.5"
Elysium.Build = "Alpha"
Elysium.Author = "Elysium Dev Team"

-- ═══════════════════════════════════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════════════════════════════════

local Services = {
	Players = game:GetService("Players"),
	TweenService = game:GetService("TweenService"),
	UserInputService = game:GetService("UserInputService"),
	RunService = game:GetService("RunService"),
	HttpService = game:GetService("HttpService"),
	CoreGui = game:GetService("CoreGui"),
	TextService = game:GetService("TextService"),
	GuiService = game:GetService("GuiService"),
	MarketplaceService = game:GetService("MarketplaceService"),
	Workspace = game:GetService("Workspace")
}

local LocalPlayer = Services.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ═══════════════════════════════════════════════════════════════════════════════
-- CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════════════════

local Config = {
	-- Window
	WindowSize = Vector2.new(920, 620),
	MinWindowSize = Vector2.new(700, 500),
	MaxWindowSize = Vector2.new(1400, 900),
	SidebarWidth = 230,
	HeaderHeight = 65,
	FooterHeight = 0,
	
	-- Components
	ComponentHeight = 52,
	SliderHeight = 68,
	CategoryHeight = 42,
	DividerHeight = 2,
	LabelHeight = 38,
	ButtonHeight = 52,
	ToggleHeight = 52,
	DropdownHeight = 52,
	ColorPickerHeight = 52,
	KeybindHeight = 52,
	TextBoxHeight = 52,
	
	-- Spacing
	Padding = 12,
	ComponentPadding = 12,
	SectionPadding = 8,
	
	-- Visual
	CornerRadius = 8,
	BorderSize = 1,
	ShadowSize = 20,
	GlowIntensity = 0.7,
	
	-- Animation
	AnimationSpeed = 0.25,
	FastAnimation = 0.15,
	SlowAnimation = 0.35,
	EasingStyle = Enum.EasingStyle.Quart,
	EasingDirection = Enum.EasingDirection.Out,
	
	-- Particles
	ParticleEnabled = true,
	ParticleRate = 0.6,
	ParticleLifetime = 2,
	
	-- Security
	AntiTamper = true,
	EncryptFlags = false,
	HideFromDevConsole = true,
	SecureMode = false
}

-- ═══════════════════════════════════════════════════════════════════════════════
-- THEME SYSTEM - 6 PREMIUM THEMES
-- ═══════════════════════════════════════════════════════════════════════════════

local Themes = {
	Explosive = {
		Name = "Explosive Pink",
		Primary = Color3.fromRGB(255, 0, 128),
		Secondary = Color3.fromRGB(180, 0, 255),
		Accent = Color3.fromRGB(255, 50, 150),
		Background = Color3.fromRGB(8, 8, 12),
		Sidebar = Color3.fromRGB(12, 12, 18),
		Content = Color3.fromRGB(16, 16, 24),
		Element = Color3.fromRGB(24, 24, 36),
		ElementHover = Color3.fromRGB(32, 32, 48),
		ElementActive = Color3.fromRGB(40, 40, 60),
		Text = Color3.fromRGB(255, 255, 255),
		TextDim = Color3.fromRGB(160, 160, 180),
		TextDark = Color3.fromRGB(100, 100, 120),
		Success = Color3.fromRGB(76, 175, 80),
		Warning = Color3.fromRGB(255, 152, 0),
		Error = Color3.fromRGB(244, 67, 54),
		Info = Color3.fromRGB(33, 150, 243),
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 128)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 0, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 200))
		})
	},
	
	Midnight = {
		Name = "Midnight Blue",
		Primary = Color3.fromRGB(64, 156, 255),
		Secondary = Color3.fromRGB(41, 98, 255),
		Accent = Color3.fromRGB(102, 187, 255),
		Background = Color3.fromRGB(10, 10, 20),
		Sidebar = Color3.fromRGB(15, 15, 28),
		Content = Color3.fromRGB(20, 20, 35),
		Element = Color3.fromRGB(25, 25, 42),
		ElementHover = Color3.fromRGB(30, 30, 50),
		ElementActive = Color3.fromRGB(35, 35, 58),
		Text = Color3.fromRGB(240, 245, 255),
		TextDim = Color3.fromRGB(170, 180, 200),
		TextDark = Color3.fromRGB(110, 120, 140),
		Success = Color3.fromRGB(76, 175, 80),
		Warning = Color3.fromRGB(255, 193, 7),
		Error = Color3.fromRGB(244, 67, 54),
		Info = Color3.fromRGB(33, 150, 243),
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 156, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(41, 98, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 70, 200))
		})
	},
	
	Toxic = {
		Name = "Toxic Green",
		Primary = Color3.fromRGB(57, 255, 20),
		Secondary = Color3.fromRGB(124, 252, 0),
		Accent = Color3.fromRGB(173, 255, 47),
		Background = Color3.fromRGB(8, 15, 8),
		Sidebar = Color3.fromRGB(12, 20, 12),
		Content = Color3.fromRGB(16, 25, 16),
		Element = Color3.fromRGB(20, 32, 20),
		ElementHover = Color3.fromRGB(24, 38, 24),
		ElementActive = Color3.fromRGB(28, 44, 28),
		Text = Color3.fromRGB(240, 255, 240),
		TextDim = Color3.fromRGB(180, 200, 180),
		TextDark = Color3.fromRGB(120, 140, 120),
		Success = Color3.fromRGB(76, 175, 80),
		Warning = Color3.fromRGB(255, 235, 59),
		Error = Color3.fromRGB(244, 67, 54),
		Info = Color3.fromRGB(76, 175, 80),
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(57, 255, 20)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(124, 252, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 205, 50))
		})
	},
	
	RedDevil = {
		Name = "Red Devil",
		Primary = Color3.fromRGB(255, 30, 30),
		Secondary = Color3.fromRGB(220, 20, 60),
		Accent = Color3.fromRGB(255, 69, 0),
		Background = Color3.fromRGB(15, 8, 8),
		Sidebar = Color3.fromRGB(20, 12, 12),
		Content = Color3.fromRGB(25, 16, 16),
		Element = Color3.fromRGB(32, 20, 20),
		ElementHover = Color3.fromRGB(38, 24, 24),
		ElementActive = Color3.fromRGB(44, 28, 28),
		Text = Color3.fromRGB(255, 240, 240),
		TextDim = Color3.fromRGB(200, 180, 180),
		TextDark = Color3.fromRGB(140, 120, 120),
		Success = Color3.fromRGB(76, 175, 80),
		Warning = Color3.fromRGB(255, 193, 7),
		Error = Color3.fromRGB(244, 67, 54),
		Info = Color3.fromRGB(255, 87, 34),
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 30, 30)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 20, 60)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 34, 34))
		})
	},
	
	Cyberpunk = {
		Name = "Cyberpunk",
		Primary = Color3.fromRGB(0, 255, 255),
		Secondary = Color3.fromRGB(255, 0, 255),
		Accent = Color3.fromRGB(138, 43, 226),
		Background = Color3.fromRGB(12, 8, 15),
		Sidebar = Color3.fromRGB(18, 12, 22),
		Content = Color3.fromRGB(24, 16, 30),
		Element = Color3.fromRGB(30, 20, 38),
		ElementHover = Color3.fromRGB(36, 24, 45),
		ElementActive = Color3.fromRGB(42, 28, 52),
		Text = Color3.fromRGB(240, 240, 255),
		TextDim = Color3.fromRGB(180, 180, 220),
		TextDark = Color3.fromRGB(120, 120, 160),
		Success = Color3.fromRGB(0, 255, 127),
		Warning = Color3.fromRGB(255, 215, 0),
		Error = Color3.fromRGB(255, 20, 147),
		Info = Color3.fromRGB(0, 255, 255),
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(138, 43, 226)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
		})
	},
	
	DarkMode = {
		Name = "Pure Dark",
		Primary = Color3.fromRGB(200, 200, 200),
		Secondary = Color3.fromRGB(150, 150, 150),
		Accent = Color3.fromRGB(100, 100, 100),
		Background = Color3.fromRGB(5, 5, 5),
		Sidebar = Color3.fromRGB(10, 10, 10),
		Content = Color3.fromRGB(15, 15, 15),
		Element = Color3.fromRGB(20, 20, 20),
		ElementHover = Color3.fromRGB(25, 25, 25),
		ElementActive = Color3.fromRGB(30, 30, 30),
		Text = Color3.fromRGB(240, 240, 240),
		TextDim = Color3.fromRGB(180, 180, 180),
		TextDark = Color3.fromRGB(120, 120, 120),
		Success = Color3.fromRGB(76, 175, 80),
		Warning = Color3.fromRGB(255, 193, 7),
		Error = Color3.fromRGB(244, 67, 54),
		Info = Color3.fromRGB(158, 158, 158),
		Gradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 150, 150)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 100))
		})
	}
}

local CurrentTheme = Themes.Explosive

-- ═══════════════════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

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
		Color = color or CurrentTheme.Primary,
		Thickness = thickness or Config.BorderSize,
		Transparency = transparency or 0.3,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = instance
	})
end

function Utils:CreateGradient(instance, colorSequence)
	return Utils:Create("UIGradient", {
		Color = colorSequence or CurrentTheme.Gradient,
		Parent = instance
	})
end

function Utils:CreateGlow(instance, color, intensity)
	intensity = intensity or Config.GlowIntensity
	
	local glow = Utils:Create("ImageLabel", {
		Name = "Glow",
		Size = UDim2.new(1, 30, 1, 30),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://5028857084",
		ImageColor3 = color or CurrentTheme.Primary,
		ImageTransparency = intensity,
		ZIndex = math.max((instance.ZIndex or 1) - 1, 0),
		Parent = instance
	})
	
	return glow
end

function Utils:CreateShadow(instance, size, transparency)
	size = size or Config.ShadowSize
	transparency = transparency or 0.8
	
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

function Utils:Ripple(button, x, y)
	task.spawn(function()
		local circle = Utils:Create("Frame", {
			Size = UDim2.fromOffset(0, 0),
			Position = UDim2.fromOffset(x, y),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = CurrentTheme.Primary,
			BackgroundTransparency = 0.5,
			ZIndex = button.ZIndex + 10,
			Parent = button
		})
		
		Utils:CreateCorner(circle, 999)
		
		local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
		
		Utils:Tween(circle, {
			Size = UDim2.fromOffset(size, size),
			BackgroundTransparency = 1
		}, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, function()
			circle:Destroy()
		end)
	end)
end

function Utils:GetTextBounds(text, font, size)
	local textService = Services.TextService
	local params = Instance.new("GetTextBoundsParams")
	params.Text = text
	params.Font = font
	params.Size = size
	params.Width = math.huge
	
	return textService:GetTextBoundsAsync(params)
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

-- ═══════════════════════════════════════════════════════════════════════════════
-- MAIN WINDOW CLASS
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium.new(options)
	options = options or {}
	
	local self = setmetatable({}, Elysium)
	
	-- Properties
	self.Name = options.Name or "Elysium"
	self.Flags = {}
	self.Tabs = {}
	self.Notifications = {}
	self.Connections = {}
	self.Elements = {}
	self.SelectedTab = nil
	self.Dragging = false
	self.Resizing = false
	self.Minimized = false
	self.Loaded = false
	
	-- Create protected ScreenGui
	local screenGuiName = Config.HideFromDevConsole and Utils:RandomString(16) or "ElysiumUI"
	
	self.ScreenGui = Utils:Create("ScreenGui", {
		Name = screenGuiName,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		IgnoreGuiInset = true,
		DisplayOrder = 999999,
		Parent = Services.CoreGui
	})
	
	-- Protection
	if Config.AntiTamper then
		self.ScreenGui.Name = Utils:RandomString(16)
		
		self.Connections.AntiTamper = self.ScreenGui.Changed:Connect(function(property)
			if property == "Parent" and self.ScreenGui.Parent ~= Services.CoreGui then
				self.ScreenGui.Parent = Services.CoreGui
			end
		end)
	end
	
	-- Build UI
	self:CreateMainFrame()
	self:CreateHeader()
	self:CreateSidebar()
	self:CreateContentArea()
	self:CreateNotificationContainer()
	self:SetupDragging()
	self:SetupParticles()
	self:SetupKeybinds()
	
	-- Mark as loaded
	self.Loaded = true
	
	return self
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- MAIN FRAME
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateMainFrame()
	self.MainFrame = Utils:Create("Frame", {
		Name = "MainFrame",
		Size = UDim2.fromOffset(Config.WindowSize.X, Config.WindowSize.Y),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = CurrentTheme.Background,
		BorderSizePixel = 0,
		ClipsDescendants = false,
		Visible = true,
		ZIndex = 1,
		Parent = self.ScreenGui
	})
	
	Utils:CreateCorner(self.MainFrame, Config.CornerRadius)
	Utils:CreateStroke(self.MainFrame, CurrentTheme.Primary, 2, 0)
	Utils:CreateShadow(self.MainFrame, 25, 0.85)
	Utils:CreateGlow(self.MainFrame, CurrentTheme.Primary, 0.75)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- HEADER
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateHeader()
	self.Header = Utils:Create("Frame", {
		Name = "Header",
		Size = UDim2.new(1, 0, 0, Config.HeaderHeight),
		BackgroundColor3 = CurrentTheme.Sidebar,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = self.MainFrame
	})
	
	Utils:CreateCorner(self.Header, Config.CornerRadius)
	Utils:CreateStroke(self.Header, CurrentTheme.Primary, 1, 0.5)
	
	-- Title
	self.TitleLabel = Utils:Create("TextLabel", {
		Name = "TitleLabel",
		Size = UDim2.new(0, 200, 1, 0),
		Position = UDim2.fromOffset(20, 0),
		BackgroundTransparency = 1,
		Text = self.Name:upper(),
		Font = Enum.Font.GothamBlack,
		TextSize = 32,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 3,
		Parent = self.Header
	})
	
	Utils:CreateGradient(self.TitleLabel, CurrentTheme.Gradient)
	
	-- Version badge
	self.VersionBadge = Utils:Create("Frame", {
		Size = UDim2.fromOffset(70, 28),
		Position = UDim2.new(0, 235, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = self.Header
	})
	
	Utils:CreateCorner(self.VersionBadge, 6)
	Utils:CreateStroke(self.VersionBadge, CurrentTheme.Primary, 1)
	
	Utils:Create("TextLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "v" .. self.Version,
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = CurrentTheme.Primary,
		ZIndex = 4,
		Parent = self.VersionBadge
	})
	
	-- Minimize button
	self.MinimizeButton = Utils:Create("TextButton", {
		Size = UDim2.fromOffset(45, 45),
		Position = UDim2.new(1, -110, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.Element,
		Text = "−",
		Font = Enum.Font.GothamBold,
		TextSize = 24,
		TextColor3 = CurrentTheme.Text,
		AutoButtonColor = false,
		ZIndex = 3,
		Parent = self.Header
	})
	
	Utils:CreateCorner(self.MinimizeButton, 8)
	
	self.MinimizeButton.MouseButton1Click:Connect(function()
		self:ToggleMinimize()
	end)
	
	-- Close button
	self.CloseButton = Utils:Create("TextButton", {
		Size = UDim2.fromOffset(45, 45),
		Position = UDim2.new(1, -55, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.Element,
		Text = "×",
		Font = Enum.Font.GothamBold,
		TextSize = 28,
		TextColor3 = CurrentTheme.Text,
		AutoButtonColor = false,
		ZIndex = 3,
		Parent = self.Header
	})
	
	Utils:CreateCorner(self.CloseButton, 8)
	
	self.CloseButton.MouseButton1Click:Connect(function()
		self:ToggleVisibility()
	end)
	
	-- Button hover effects
	for _, button in ipairs({self.MinimizeButton, self.CloseButton}) do
		button.MouseEnter:Connect(function()
			local color = button == self.CloseButton and CurrentTheme.Error or CurrentTheme.ElementHover
			Utils:Tween(button, {
				BackgroundColor3 = color,
				TextColor3 = Color3.fromRGB(255, 255, 255)
			}, Config.FastAnimation)
		end)
		
		button.MouseLeave:Connect(function()
			Utils:Tween(button, {
				BackgroundColor3 = CurrentTheme.Element,
				TextColor3 = CurrentTheme.Text
			}, Config.FastAnimation)
		end)
	end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- SIDEBAR
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateSidebar()
	self.Sidebar = Utils:Create("Frame", {
		Name = "Sidebar",
		Size = UDim2.new(0, Config.SidebarWidth, 1, -Config.HeaderHeight - 10),
		Position = UDim2.fromOffset(10, Config.HeaderHeight + 5),
		BackgroundColor3 = CurrentTheme.Sidebar,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = self.MainFrame
	})
	
	Utils:CreateCorner(self.Sidebar, Config.CornerRadius)
	Utils:CreateStroke(self.Sidebar, CurrentTheme.Primary, 1, 0.5)
	
	-- Tab container
	self.TabContainer = Utils:Create("ScrollingFrame", {
		Name = "TabContainer",
		Size = UDim2.new(1, -10, 1, -10),
		Position = UDim2.fromOffset(5, 5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 5,
		ScrollBarImageColor3 = CurrentTheme.Primary,
		ScrollBarImageTransparency = 0.3,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		ZIndex = 3,
		Parent = self.Sidebar
	})
	
	Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = self.TabContainer
	})
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- CONTENT AREA
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateContentArea()
	self.ContentArea = Utils:Create("Frame", {
		Name = "ContentArea",
		Size = UDim2.new(1, -Config.SidebarWidth - 30, 1, -Config.HeaderHeight - 15),
		Position = UDim2.fromOffset(Config.SidebarWidth + 20, Config.HeaderHeight + 5),
		BackgroundColor3 = CurrentTheme.Content,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = self.MainFrame
	})
	
	Utils:CreateCorner(self.ContentArea, Config.CornerRadius)
	Utils:CreateStroke(self.ContentArea, CurrentTheme.Primary, 1, 0.5)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- NOTIFICATION CONTAINER
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateNotificationContainer()
	self.NotificationContainer = Utils:Create("Frame", {
		Name = "NotificationContainer",
		Size = UDim2.fromOffset(360, 600),
		Position = UDim2.new(1, -380, 0, 20),
		BackgroundTransparency = 1,
		ZIndex = 100,
		Parent = self.ScreenGui
	})
	
	Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 12),
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		Parent = self.NotificationContainer
	})
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- DRAGGING
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:SetupDragging()
	local dragStart, startPos
	local dragging = false
	
	self.Header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = self.MainFrame.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	Services.UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			Utils:Tween(self.MainFrame, {
				Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
			}, 0.1)
		end
	end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- PARTICLES
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:SetupParticles()
	if not Config.ParticleEnabled then return end
	
	task.spawn(function()
		while self.MainFrame and self.MainFrame.Parent and self.Loaded do
			if math.random() > Config.ParticleRate then
				local particle = Utils:Create("Frame", {
					Size = UDim2.fromOffset(5, 5),
					BackgroundColor3 = CurrentTheme.Primary,
					BorderSizePixel = 0,
					Position = UDim2.new(math.random(), 0, math.random(), 0),
					ZIndex = 10,
					Parent = self.MainFrame
				})
				
				Utils:CreateCorner(particle, 10)
				
				local endPos = UDim2.new(math.random(), 0, math.random(), 0)
				Utils:Tween(particle, {
					Position = endPos,
					BackgroundTransparency = 1,
					Size = UDim2.fromOffset(2, 2)
				}, Config.ParticleLifetime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, function()
					particle:Destroy()
				end)
			end
			task.wait(0.5)
		end
	end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- KEYBINDS
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:SetupKeybinds()
	Services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
			self:ToggleVisibility()
		end
	end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- VISIBILITY CONTROLS
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:ToggleVisibility()
	self.MainFrame.Visible = not self.MainFrame.Visible
end

function Elysium:ToggleMinimize()
	self.Minimized = not self.Minimized
	
	if self.Minimized then
		Utils:Tween(self.MainFrame, {
			Size = UDim2.fromOffset(Config.WindowSize.X, Config.HeaderHeight)
		}, Config.AnimationSpeed)
		self.MinimizeButton.Text = "+"
	else
		Utils:Tween(self.MainFrame, {
			Size = UDim2.fromOffset(Config.WindowSize.X, Config.WindowSize.Y)
		}, Config.AnimationSpeed)
		self.MinimizeButton.Text = "−"
	end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- TAB SYSTEM - COMPLETELY FIXED
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:AddTab(name, icon)
	local tab = {
		Name = name,
		Icon = icon,
		LayoutOrder = #self.Tabs + 1,
		Elements = {}
	}
	
	-- Create tab button
	tab.Button = Utils:Create("TextButton", {
		Name = name .. "Tab",
		Size = UDim2.new(1, -10, 0, Config.ComponentHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false,
		LayoutOrder = tab.LayoutOrder,
		ZIndex = 4,
		Parent = self.TabContainer
	})
	
	Utils:CreateCorner(tab.Button, 7)
	
	-- Icon (if provided)
	if icon then
		tab.IconLabel = Utils:Create("ImageLabel", {
			Size = UDim2.fromOffset(28, 28),
			Position = UDim2.fromOffset(15, 12),
			BackgroundTransparency = 1,
			Image = icon,
			ImageColor3 = CurrentTheme.TextDim,
			ZIndex = 5,
			Parent = tab.Button
		})
	end
	
	-- Tab text
	tab.TextLabel = Utils:Create("TextLabel", {
		Size = UDim2.new(1, icon and -55 or -25, 1, 0),
		Position = UDim2.fromOffset(icon and 50 or 15, 0),
		BackgroundTransparency = 1,
		Text = name,
		Font = Enum.Font.GothamBold,
		TextSize = 17,
		TextColor3 = CurrentTheme.TextDim,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 5,
		Parent = tab.Button
	})
	
	-- Active indicator bar
	tab.ActiveBar = Utils:Create("Frame", {
		Name = "ActiveBar",
		Size = UDim2.new(0, 4, 0.7, 0),
		Position = UDim2.new(0, 0, 0.15, 0),
		BackgroundColor3 = CurrentTheme.Primary,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 6,
		Parent = tab.Button
	})
	
	Utils:CreateCorner(tab.ActiveBar, 4)
	
	-- Create content page
	tab.Page = Utils:Create("ScrollingFrame", {
		Name = name .. "Page",
		Size = UDim2.new(1, -20, 1, -20),
		Position = UDim2.fromOffset(10, 10),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 5,
		ScrollBarImageColor3 = CurrentTheme.Primary,
		ScrollBarImageTransparency = 0.3,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = false,
		ZIndex = 3,
		Parent = self.ContentArea
	})
	
	Utils:Create("UIListLayout", {
		Padding = UDim.new(0, Config.ComponentPadding),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = tab.Page
	})
	
	-- Button interactions
	tab.Button.MouseButton1Click:Connect(function()
		self:SelectTab(tab)
	end)
	
	tab.Button.MouseEnter:Connect(function()
		if tab ~= self.SelectedTab then
			Utils:Tween(tab.Button, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
			Utils:Tween(tab.TextLabel, {TextColor3 = CurrentTheme.Text}, Config.FastAnimation)
			if tab.IconLabel then
				Utils:Tween(tab.IconLabel, {ImageColor3 = CurrentTheme.Text}, Config.FastAnimation)
			end
		end
	end)
	
	tab.Button.MouseLeave:Connect(function()
		if tab ~= self.SelectedTab then
			Utils:Tween(tab.Button, {BackgroundColor3 = CurrentTheme.Element}, Config.FastAnimation)
			Utils:Tween(tab.TextLabel, {TextColor3 = CurrentTheme.TextDim}, Config.FastAnimation)
			if tab.IconLabel then
				Utils:Tween(tab.IconLabel, {ImageColor3 = CurrentTheme.TextDim}, Config.FastAnimation)
			end
		end
	end)
	
	-- Add to tabs table
	table.insert(self.Tabs, tab)
	
	-- CRITICAL FIX: Auto select first tab using task.defer
	if #self.Tabs == 1 then
		task.defer(function()
			self:SelectTab(tab)
		end)
	end
	
	return tab.Page
end

function Elysium:SelectTab(tab)
	if not tab then return end
	
	-- Deselect previous tab
	if self.SelectedTab then
		self.SelectedTab.Page.Visible = false
		self.SelectedTab.ActiveBar.Visible = false
		Utils:Tween(self.SelectedTab.Button, {BackgroundColor3 = CurrentTheme.Element}, Config.AnimationSpeed)
		Utils:Tween(self.SelectedTab.TextLabel, {TextColor3 = CurrentTheme.TextDim}, Config.AnimationSpeed)
		if self.SelectedTab.IconLabel then
			Utils:Tween(self.SelectedTab.IconLabel, {ImageColor3 = CurrentTheme.TextDim}, Config.AnimationSpeed)
		end
		
		-- Remove glow
		local oldGlow = self.SelectedTab.Button:FindFirstChild("Glow")
		if oldGlow then oldGlow:Destroy() end
	end
	
	-- Select new tab
	self.SelectedTab = tab
	tab.Page.Visible = true
	tab.ActiveBar.Visible = true
	Utils:Tween(tab.Button, {BackgroundColor3 = CurrentTheme.ElementActive}, Config.AnimationSpeed)
	Utils:Tween(tab.TextLabel, {TextColor3 = CurrentTheme.Primary}, Config.AnimationSpeed)
	if tab.IconLabel then
		Utils:Tween(tab.IconLabel, {ImageColor3 = CurrentTheme.Primary}, Config.AnimationSpeed)
	end
	
	-- Add glow effect
	Utils:CreateGlow(tab.Button, CurrentTheme.Primary, 0.6)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMPONENT: CATEGORY
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateCategory(parent, name)
	local category = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 0, Config.CategoryHeight),
		BackgroundTransparency = 1,
		ZIndex = 3,
		Parent = parent
	})
	
	-- Left accent bar
	local accentBar = Utils:Create("Frame", {
		Size = UDim2.new(0, 5, 0.75, 0),
		Position = UDim2.new(0, 0, 0.125, 0),
		BackgroundColor3 = CurrentTheme.Primary,
		BorderSizePixel = 0,
		ZIndex = 4,
		Parent = category
	})
	
	Utils:CreateCorner(accentBar, 3)
	Utils:CreateGlow(accentBar, CurrentTheme.Primary, 0.5)
	
	-- Label
	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -20, 1, 0),
		Position = UDim2.fromOffset(18, 0),
		BackgroundTransparency = 1,
		Text = name:upper(),
		Font = Enum.Font.GothamBlack,
		TextSize = 18,
		TextColor3 = CurrentTheme.Primary,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = category
	})
	
	Utils:CreateGradient(label, CurrentTheme.Gradient)
	
	return category
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMPONENT: DIVIDER
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateDivider(parent)
	local divider = Utils:Create("Frame", {
		Size = UDim2.new(1, -40, 0, Config.DividerHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})
	
	Utils:CreateGradient(divider, CurrentTheme.Gradient)
	
	return divider
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMPONENT: LABEL
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateLabel(parent, text, options)
	options = options or {}
	
	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 0, options.Height or Config.LabelHeight),
		BackgroundTransparency = 1,
		ZIndex = 3,
		Parent = parent
	})
	
	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -10, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = options.Font or Enum.Font.Gotham,
		TextSize = options.TextSize or 14,
		TextColor3 = options.Color or CurrentTheme.TextDim,
		TextXAlignment = options.Alignment or Enum.TextXAlignment.Left,
		TextWrapped = true,
		ZIndex = 4,
		Parent = frame
	})
	
	return label
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMPONENT: TOGGLE
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateToggle(parent, text, flag, default, callback)
	default = default or false
	self.Flags[flag] = default
	
	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 0, Config.ToggleHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})
	
	Utils:CreateCorner(frame, 7)
	
	local strokeObj = Utils:CreateStroke(frame, default and CurrentTheme.Primary or CurrentTheme.Element, 1)
	
	-- Label
	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -90, 1, 0),
		Position = UDim2.fromOffset(18, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})
	
	-- Toggle switch background
	local toggleBg = Utils:Create("Frame", {
		Size = UDim2.fromOffset(56, 30),
		Position = UDim2.new(1, -68, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = default and CurrentTheme.Primary or CurrentTheme.ElementHover,
		BorderSizePixel = 0,
		ZIndex = 4,
		Parent = frame
	})
	
	Utils:CreateCorner(toggleBg, 15)
	
	-- Toggle circle
	local toggleCircle = Utils:Create("Frame", {
		Size = UDim2.fromOffset(24, 24),
		Position = default and UDim2.new(1, -27, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 5,
		Parent = toggleBg
	})
	
	Utils:CreateCorner(toggleCircle, 12)
	
	if default then
		Utils:CreateGlow(toggleBg, CurrentTheme.Primary, 0.5)
	end
	
	-- Button
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
			Utils:Tween(toggleCircle, {Position = UDim2.new(1, -27, 0.5, 0)}, Config.FastAnimation)
			Utils:Tween(toggleBg, {BackgroundColor3 = CurrentTheme.Primary}, Config.FastAnimation)
			Utils:CreateGlow(toggleBg, CurrentTheme.Primary, 0.5)
			strokeObj.Color = CurrentTheme.Primary
		else
			Utils:Tween(toggleCircle, {Position = UDim2.new(0, 3, 0.5, 0)}, Config.FastAnimation)
			Utils:Tween(toggleBg, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
			local glow = toggleBg:FindFirstChild("Glow")
			if glow then glow:Destroy() end
			strokeObj.Color = CurrentTheme.Element
		end
		
		Utils:Ripple(button, Mouse.X - button.AbsolutePosition.X, Mouse.Y - button.AbsolutePosition.Y)
		
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

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMPONENT: SLIDER
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateSlider(parent, text, min, max, default, decimals, flag, callback)
	default = default or min
	decimals = decimals or 0
	self.Flags[flag] = default
	
	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 0, Config.SliderHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})
	
	Utils:CreateCorner(frame, 7)
	
	-- Label
	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -80, 0, 22),
		Position = UDim2.fromOffset(18, 10),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})
	
	-- Value display
	local valueLabel = Utils:Create("TextLabel", {
		Size = UDim2.fromOffset(65, 22),
		Position = UDim2.new(1, -75, 0, 10),
		BackgroundColor3 = CurrentTheme.ElementHover,
		Text = tostring(default),
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = CurrentTheme.Primary,
		ZIndex = 4,
		Parent = frame
	})
	
	Utils:CreateCorner(valueLabel, 5)
	
	-- Slider background
	local sliderBg = Utils:Create("Frame", {
		Size = UDim2.new(1, -36, 0, 10),
		Position = UDim2.fromOffset(18, 44),
		BackgroundColor3 = CurrentTheme.ElementHover,
		BorderSizePixel = 0,
		ZIndex = 4,
		Parent = frame
	})
	
	Utils:CreateCorner(sliderBg, 5)
	
	-- Slider fill
	local sliderFill = Utils:Create("Frame", {
		Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
		BackgroundColor3 = CurrentTheme.Primary,
		BorderSizePixel = 0,
		ZIndex = 5,
		Parent = sliderBg
	})
	
	Utils:CreateCorner(sliderFill, 5)
	Utils:CreateGradient(sliderFill, CurrentTheme.Gradient)
	Utils:CreateGlow(sliderFill, CurrentTheme.Primary, 0.5)
	
	-- Slider knob
	local sliderKnob = Utils:Create("Frame", {
		Size = UDim2.fromOffset(20, 20),
		Position = UDim2.new((default - min) / (max - min), -10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 6,
		Parent = sliderBg
	})
	
	Utils:CreateCorner(sliderKnob, 10)
	Utils:CreateGlow(sliderKnob, CurrentTheme.Primary, 0.6)
	Utils:CreateStroke(sliderKnob, CurrentTheme.Primary, 2)
	
	-- Dragging logic
	local dragging = false
	
	local function updateSlider(input)
		local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
		local value = min + (max - min) * pos
		
		if decimals == 0 then
			value = math.floor(value + 0.5)
		else
			value = math.floor(value * (10 ^ decimals) + 0.5) / (10 ^ decimals)
		end
		
		self.Flags[flag] = value
		valueLabel.Text = tostring(value)
		
		Utils:Tween(sliderFill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.1)
		Utils:Tween(sliderKnob, {Position = UDim2.new(pos, -10, 0.5, 0)}, 0.1)
		
		if callback then
			task.spawn(callback, value)
		end
	end
	
	sliderBg.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			updateSlider(input)
		end
	end)
	
	sliderBg.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	
	Services.UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			updateSlider(input)
		end
	end)
	
	frame.MouseEnter:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
	end)
	
	frame.MouseLeave:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.Element}, Config.FastAnimation)
	end)
	
	return frame
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMPONENT: BUTTON
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateButton(parent, text, callback)
	local button = Utils:Create("TextButton", {
		Size = UDim2.new(1, -20, 0, Config.ButtonHeight),
		BackgroundColor3 = CurrentTheme.Primary,
		BorderSizePixel = 0,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 16,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		AutoButtonColor = false,
		ZIndex = 3,
		Parent = parent
	})
	
	Utils:CreateCorner(button, 7)
	Utils:CreateGradient(button, CurrentTheme.Gradient)
	Utils:CreateGlow(button, CurrentTheme.Primary, 0.6)
	
	button.MouseButton1Click:Connect(function()
		-- Click animation
		Utils:Tween(button, {Size = UDim2.new(1, -20, 0, Config.ButtonHeight - 3)}, 0.1)
		Utils:Ripple(button, Mouse.X - button.AbsolutePosition.X, Mouse.Y - button.AbsolutePosition.Y)
		task.wait(0.1)
		Utils:Tween(button, {Size = UDim2.new(1, -20, 0, Config.ButtonHeight)}, 0.1)
		
		if callback then
			task.spawn(callback)
		end
	end)
	
	button.MouseEnter:Connect(function()
		Utils:Tween(button, {BackgroundColor3 = CurrentTheme.Secondary}, Config.FastAnimation)
	end)
	
	button.MouseLeave:Connect(function()
		Utils:Tween(button, {BackgroundColor3 = CurrentTheme.Primary}, Config.FastAnimation)
	end)
	
	return button
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMPONENT: DROPDOWN
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateDropdown(parent, text, options, default, flag, callback)
	default = default or options[1]
	self.Flags[flag] = default
	
	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 0, Config.DropdownHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})
	
	Utils:CreateCorner(frame, 7)
	
	-- Label
	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(0.45, -20, 1, 0),
		Position = UDim2.fromOffset(18, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})
	
	-- Selected value display
	local valueLabel = Utils:Create("TextLabel", {
		Size = UDim2.new(0.55, -90, 0, 34),
		Position = UDim2.new(0.45, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.ElementHover,
		Text = default,
		Font = Enum.Font.Gotham,
		TextSize = 14,
		TextColor3 = CurrentTheme.Primary,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ZIndex = 4,
		Parent = frame
	})
	
	Utils:CreateCorner(valueLabel, 5)
	
	-- Arrow icon
	local arrow = Utils:Create("TextLabel", {
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.new(1, -40, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = "▼",
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = CurrentTheme.TextDim,
		ZIndex = 4,
		Parent = frame
	})
	
	-- Dropdown list
	local dropdownOpen = false
	local dropdownList = Utils:Create("Frame", {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0, 0, 1, 5),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 50,
		ClipsDescendants = true,
		Parent = frame
	})
	
	Utils:CreateCorner(dropdownList, 7)
	Utils:CreateStroke(dropdownList, CurrentTheme.Primary, 1)
	Utils:CreateGlow(dropdownList, CurrentTheme.Primary, 0.6)
	
	local listLayout = Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 3),
		Parent = dropdownList
	})
	
	-- Create option buttons
	for _, option in ipairs(options) do
		local optionBtn = Utils:Create("TextButton", {
			Size = UDim2.new(1, -12, 0, 38),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = option == default and CurrentTheme.ElementActive or CurrentTheme.ElementHover,
			Text = option,
			Font = Enum.Font.Gotham,
			TextSize = 14,
			TextColor3 = option == default and CurrentTheme.Primary or CurrentTheme.Text,
			AutoButtonColor = false,
			ZIndex = 51,
			Parent = dropdownList
		})
		
		Utils:CreateCorner(optionBtn, 5)
		
		optionBtn.MouseButton1Click:Connect(function()
			self.Flags[flag] = option
			valueLabel.Text = option
			dropdownOpen = false
			
			Utils:Tween(dropdownList, {Size = UDim2.new(1, -10, 0, 0)}, Config.AnimationSpeed)
			task.wait(Config.AnimationSpeed)
			dropdownList.Visible = false
			Utils:Tween(arrow, {Rotation = 0}, Config.AnimationSpeed)
			
			-- Update all option colors
			for _, btn in ipairs(dropdownList:GetChildren()) do
				if btn:IsA("TextButton") then
					if btn.Text == option then
						Utils:Tween(btn, {
							BackgroundColor3 = CurrentTheme.ElementActive,
							TextColor3 = CurrentTheme.Primary
						}, Config.FastAnimation)
					else
						Utils:Tween(btn, {
							BackgroundColor3 = CurrentTheme.ElementHover,
							TextColor3 = CurrentTheme.Text
						}, Config.FastAnimation)
					end
				end
			end
			
			if callback then
				task.spawn(callback, option)
			end
		end)
		
		optionBtn.MouseEnter:Connect(function()
			if option ~= self.Flags[flag] then
				Utils:Tween(optionBtn, {BackgroundColor3 = CurrentTheme.ElementActive}, Config.FastAnimation)
			end
		end)
		
		optionBtn.MouseLeave:Connect(function()
			if option ~= self.Flags[flag] then
				Utils:Tween(optionBtn, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
			end
		end)
	end
	
	-- Toggle button
	local toggleButton = Utils:Create("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 49,
		Parent = frame
	})
	
	toggleButton.MouseButton1Click:Connect(function()
		dropdownOpen = not dropdownOpen
		
		if dropdownOpen then
			dropdownList.Visible = true
			local listHeight = math.min(#options * 41, 220)
			Utils:Tween(dropdownList, {Size = UDim2.new(1, -10, 0, listHeight)}, Config.AnimationSpeed)
			Utils:Tween(arrow, {Rotation = 180}, Config.AnimationSpeed)
		else
			Utils:Tween(dropdownList, {Size = UDim2.new(1, -10, 0, 0)}, Config.AnimationSpeed)
			Utils:Tween(arrow, {Rotation = 0}, Config.AnimationSpeed)
			task.wait(Config.AnimationSpeed)
			dropdownList.Visible = false
		end
	end)
	
	frame.MouseEnter:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
	end)
	
	frame.MouseLeave:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.Element}, Config.FastAnimation)
	end)
	
	return frame
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMPONENT: KEYBIND
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateKeybind(parent, text, defaultKey, flag, callback)
	defaultKey = defaultKey or Enum.KeyCode.E
	self.Flags[flag] = defaultKey
	
	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 0, Config.KeybindHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})
	
	Utils:CreateCorner(frame, 7)
	
	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(0.55, -20, 1, 0),
		Position = UDim2.fromOffset(18, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})
	
	local keybindBtn = Utils:Create("TextButton", {
		Size = UDim2.new(0.45, -35, 0, 34),
		Position = UDim2.new(0.55, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.ElementHover,
		Text = defaultKey.Name,
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = CurrentTheme.Primary,
		AutoButtonColor = false,
		ZIndex = 4,
		Parent = frame
	})
	
	Utils:CreateCorner(keybindBtn, 5)
	Utils:CreateStroke(keybindBtn, CurrentTheme.Primary, 1)
	
	local binding = false
	
	keybindBtn.MouseButton1Click:Connect(function()
		binding = true
		keybindBtn.Text = "..."
		Utils:Tween(keybindBtn, {
			BackgroundColor3 = CurrentTheme.Primary,
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}, Config.FastAnimation)
	end)
	
	Services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if binding and not gameProcessed then
			if input.UserInputType == Enum.UserInputType.Keyboard then
				binding = false
				self.Flags[flag] = input.KeyCode
				keybindBtn.Text = input.KeyCode.Name
				Utils:Tween(keybindBtn, {
					BackgroundColor3 = CurrentTheme.ElementHover,
					TextColor3 = CurrentTheme.Primary
				}, Config.FastAnimation)
				
				if callback then
					task.spawn(callback, input.KeyCode)
				end
			end
		end
	end)
	
	frame.MouseEnter:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
	end)
	
	frame.MouseLeave:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.Element}, Config.FastAnimation)
	end)
	
	return frame
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMPONENT: TEXTBOX
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateTextBox(parent, text, placeholder, flag, callback)
	self.Flags[flag] = ""
	
	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 0, Config.TextBoxHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})
	
	Utils:CreateCorner(frame, 7)
	
	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(0.35, -20, 1, 0),
		Position = UDim2.fromOffset(18, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})
	
	local textBox = Utils:Create("TextBox", {
		Size = UDim2.new(0.65, -35, 0, 34),
		Position = UDim2.new(0.35, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.ElementHover,
		PlaceholderText = placeholder or "Enter text...",
		PlaceholderColor3 = CurrentTheme.TextDark,
		Text = "",
		Font = Enum.Font.Gotham,
		TextSize = 14,
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
	
	textBox.Focused:Connect(function()
		Utils:CreateStroke(frame, CurrentTheme.Primary, 1)
	end)
	
	textBox.FocusLost:Connect(function()
		local stroke = frame:FindFirstChild("UIStroke")
		if stroke then stroke:Destroy() end
	end)
	
	frame.MouseEnter:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
	end)
	
	frame.MouseLeave:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.Element}, Config.FastAnimation)
	end)
	
	return textBox
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMPONENT: COLOR PICKER (ADVANCED WITH HSV/RGB/HEX)
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateColorPicker(parent, text, default, flag, callback)
	default = default or Color3.fromRGB(255, 0, 128)
	self.Flags[flag] = default
	
	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 0, Config.ColorPickerHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})
	
	Utils:CreateCorner(frame, 7)
	
	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -80, 1, 0),
		Position = UDim2.fromOffset(18, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})
	
	local colorDisplay = Utils:Create("TextButton", {
		Size = UDim2.fromOffset(60, 30),
		Position = UDim2.new(1, -70, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = default,
		Text = "",
		ZIndex = 4,
		Parent = frame
	})
	
	Utils:CreateCorner(colorDisplay, 5)
	Utils:CreateGlow(colorDisplay, default, 0.5)
	Utils:CreateStroke(colorDisplay, default, 2)
	
	-- Color picker popup
	local pickerOpen = false
	local picker = Utils:Create("Frame", {
		Size = UDim2.fromOffset(300, 350),
		Position = UDim2.new(0.5, -150, 0.5, -175),
		BackgroundColor3 = CurrentTheme.Sidebar,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 150,
		Parent = self.ScreenGui
	})
	
	Utils:CreateCorner(picker, 8)
	Utils:CreateStroke(picker, CurrentTheme.Primary, 2)
	Utils:CreateGlow(picker, CurrentTheme.Primary, 0.8)
	
	local pickerTitle = Utils:Create("TextLabel", {
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundTransparency = 1,
		Text = "Color Picker",
		Font = Enum.Font.GothamBold,
		TextSize = 18,
		TextColor3 = CurrentTheme.Primary,
		ZIndex = 151,
		Parent = picker
	})
	
	Utils:CreateGradient(pickerTitle, CurrentTheme.Gradient)
	
	-- SV Box
	local svBox = Utils:Create("ImageButton", {
		Size = UDim2.fromOffset(240, 200),
		Position = UDim2.fromOffset(10, 50),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Image = "rbxassetid://4155801252",
		ZIndex = 151,
		Parent = picker
	})
	
	Utils:CreateCorner(svBox, 5)
	
	-- Hue Slider
	local hueSlider = Utils:Create("ImageButton", {
		Size = UDim2.fromOffset(35, 200),
		Position = UDim2.fromOffset(255, 50),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Image = "rbxassetid://3641079629",
		ZIndex = 151,
		Parent = picker
	})
	
	Utils:CreateCorner(hueSlider, 5)
	
	-- Indicator
	local indicator = Utils:Create("Frame", {
		Size = UDim2.fromOffset(12, 12),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 2,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		ZIndex = 152,
		Parent = svBox
	})
	
	Utils:CreateCorner(indicator, 6)
	
	-- RGB Inputs
	local rgbFrame = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 0, 40),
		Position = UDim2.fromOffset(10, 260),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 151,
		Parent = picker
	})
	
	Utils:CreateCorner(rgbFrame, 5)
	
	local function createRGBInput(name, position)
		local input = Utils:Create("TextBox", {
			Size = UDim2.fromOffset(65, 30),
			Position = position,
			BackgroundColor3 = CurrentTheme.ElementHover,
			PlaceholderText = name,
			Text = "",
			Font = Enum.Font.Gotham,
			TextSize = 13,
			TextColor3 = CurrentTheme.Text,
			ZIndex = 152,
			Parent = rgbFrame
		})
		
		Utils:CreateCorner(input, 4)
		return input
	end
	
	local rInput = createRGBInput("R", UDim2.fromOffset(10, 5))
	local gInput = createRGBInput("G", UDim2.fromOffset(85, 5))
	local bInput = createRGBInput("B", UDim2.fromOffset(160, 5))
	
	local hexInput = Utils:Create("TextBox", {
		Size = UDim2.fromOffset(90, 30),
		Position = UDim2.fromOffset(235, 5),
		BackgroundColor3 = CurrentTheme.ElementHover,
		PlaceholderText = "#HEX",
		Text = "",
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = CurrentTheme.Text,
		ZIndex = 152,
		Parent = rgbFrame
	})
	
	Utils:CreateCorner(hexInput, 4)
	
	-- Close button
	local closeBtn = Utils:Create("TextButton", {
		Size = UDim2.fromOffset(120, 35),
		Position = UDim2.new(0.5, -60, 1, -45),
		BackgroundColor3 = CurrentTheme.Primary,
		Text = "Done",
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		ZIndex = 151,
		Parent = picker
	})
	
	Utils:CreateCorner(closeBtn, 5)
	Utils:CreateGradient(closeBtn, CurrentTheme.Gradient)
	
	closeBtn.MouseButton1Click:Connect(function()
		pickerOpen = false
		picker.Visible = false
	end)
	
	local h, s, v = default:ToHSV()
	
	local function updateColor(fromRGB)
		local color
		if fromRGB then
			color = Color3.fromRGB(
				tonumber(rInput.Text) or 255,
				tonumber(gInput.Text) or 0,
				tonumber(bInput.Text) or 128
			)
			h, s, v = color:ToHSV()
		else
			color = Color3.fromHSV(h, s, v)
		end
		
		self.Flags[flag] = color
		colorDisplay.BackgroundColor3 = color
		svBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
		
		rInput.Text = tostring(math.floor(color.R * 255))
		gInput.Text = tostring(math.floor(color.G * 255))
		bInput.Text = tostring(math.floor(color.B * 255))
		
		hexInput.Text = string.format("#%02X%02X%02X",
			math.floor(color.R * 255),
			math.floor(color.G * 255),
			math.floor(color.B * 255)
		)
		
		local glow = colorDisplay:FindFirstChild("Glow")
		if glow then glow.ImageColor3 = color end
		
		local stroke = colorDisplay:FindFirstChild("UIStroke")
		if stroke then stroke.Color = color end
		
		if callback then task.spawn(callback, color) end
	end
	
	-- SV Logic
	local svDragging = false
	svBox.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			svDragging = true
		end
	end)
	
	local function updateSV(input)
		local posX = math.clamp((input.Position.X - svBox.AbsolutePosition.X) / svBox.AbsoluteSize.X, 0, 1)
		local posY = math.clamp((input.Position.Y - svBox.AbsolutePosition.Y) / svBox.AbsoluteSize.Y, 0, 1)
		s = posX
		v = 1 - posY
		indicator.Position = UDim2.new(posX, -6, posY, -6)
		updateColor()
	end
	
	svBox.InputChanged:Connect(function(input)
		if svDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			updateSV(input)
		end
	end)
	
	-- Hue Logic
	local hueDragging = false
	hueSlider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			hueDragging = true
		end
	end)
	
	local function updateHue(input)
		local posY = math.clamp((input.Position.Y - hueSlider.AbsolutePosition.Y) / hueSlider.AbsoluteSize.Y, 0, 1)
		h = posY
		updateColor()
	end
	
	hueSlider.InputChanged:Connect(function(input)
		if hueDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			updateHue(input)
		end
	end)
	
	Services.UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			svDragging = false
			hueDragging = false
		end
	end)
	
	-- RGB input handling
	for _, input in ipairs({rInput, gInput, bInput}) do
		input.FocusLost:Connect(function()
			updateColor(true)
		end)
	end
	
	-- Hex input handling
	hexInput.FocusLost:Connect(function()
		local hex = hexInput.Text:gsub("#", "")
		if #hex == 6 then
			local r = tonumber(hex:sub(1, 2), 16)
			local g = tonumber(hex:sub(3, 4), 16)
			local b = tonumber(hex:sub(5, 6), 16)
			if r and g and b then
				rInput.Text = tostring(r)
				gInput.Text = tostring(g)
				bInput.Text = tostring(b)
				updateColor(true)
			end
		end
	end)
	
	-- Toggle picker
	colorDisplay.MouseButton1Click:Connect(function()
		pickerOpen = not pickerOpen
		picker.Visible = pickerOpen
		if pickerOpen then
			updateColor()
		end
	end)
	
	frame.MouseEnter:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
	end)
	
	frame.MouseLeave:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.Element}, Config.FastAnimation)
	end)
	
	return frame
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMPONENT: MULTI-DROPDOWN (WITH CHECKBOXES)
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateMultiDropdown(parent, text, options, defaults, flag, callback)
	defaults = defaults or {}
	self.Flags[flag] = defaults
	
	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 0, Config.DropdownHeight),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})
	
	Utils:CreateCorner(frame, 7)
	
	local label = Utils:Create("TextLabel", {
		Size = UDim2.new(0.45, -20, 1, 0),
		Position = UDim2.fromOffset(18, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4,
		Parent = frame
	})
	
	local countLabel = Utils:Create("TextLabel", {
		Size = UDim2.new(0.55, -90, 0, 34),
		Position = UDim2.new(0.45, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.ElementHover,
		Text = #defaults .. " selected",
		Font = Enum.Font.Gotham,
		TextSize = 14,
		TextColor3 = CurrentTheme.Primary,
		ZIndex = 4,
		Parent = frame
	})
	
	Utils:CreateCorner(countLabel, 5)
	
	local arrow = Utils:Create("TextLabel", {
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.new(1, -40, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = "▼",
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = CurrentTheme.TextDim,
		ZIndex = 4,
		Parent = frame
	})
	
	local dropdownOpen = false
	local dropdownList = Utils:Create("Frame", {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0, 0, 1, 5),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 50,
		ClipsDescendants = true,
		Parent = frame
	})
	
	Utils:CreateCorner(dropdownList, 7)
	Utils:CreateStroke(dropdownList, CurrentTheme.Primary, 1)
	Utils:CreateGlow(dropdownList, CurrentTheme.Primary, 0.6)
	
	Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 3),
		Parent = dropdownList
	})
	
	local function isSelected(option)
		for _, selected in ipairs(self.Flags[flag]) do
			if selected == option then return true end
		end
		return false
	end
	
	local function updateCount()
		countLabel.Text = #self.Flags[flag] .. " selected"
	end
	
	for _, option in ipairs(options) do
		local optionFrame = Utils:Create("Frame", {
			Size = UDim2.new(1, -12, 0, 38),
			Position = UDim2.fromOffset(6, 0),
			BackgroundColor3 = CurrentTheme.ElementHover,
			BorderSizePixel = 0,
			ZIndex = 51,
			Parent = dropdownList
		})
		
		Utils:CreateCorner(optionFrame, 5)
		
		local checkbox = Utils:Create("Frame", {
			Size = UDim2.fromOffset(20, 20),
			Position = UDim2.fromOffset(10, 9),
			BackgroundColor3 = isSelected(option) and CurrentTheme.Primary or CurrentTheme.ElementActive,
			BorderSizePixel = 0,
			ZIndex = 52,
			Parent = optionFrame
		})
		
		Utils:CreateCorner(checkbox, 4)
		
		if isSelected(option) then
			Utils:Create("TextLabel", {
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = "✓",
				Font = Enum.Font.GothamBold,
				TextSize = 16,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				ZIndex = 53,
				Parent = checkbox
			})
		end
		
		local optionText = Utils:Create("TextLabel", {
			Size = UDim2.new(1, -45, 1, 0),
			Position = UDim2.fromOffset(38, 0),
			BackgroundTransparency = 1,
			Text = option,
			Font = Enum.Font.Gotham,
			TextSize = 14,
			TextColor3 = CurrentTheme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 52,
			Parent = optionFrame
		})
		
		local optionBtn = Utils:Create("TextButton", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = "",
			ZIndex = 54,
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
				if checkmark then checkmark:Destroy() end
			else
				table.insert(self.Flags[flag], option)
				Utils:Tween(checkbox, {BackgroundColor3 = CurrentTheme.Primary}, Config.FastAnimation)
				Utils:Create("TextLabel", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text = "✓",
					Font = Enum.Font.GothamBold,
					TextSize = 16,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					ZIndex = 53,
					Parent = checkbox
				})
			end
			
			updateCount()
			
			if callback then
				task.spawn(callback, self.Flags[flag])
			end
		end)
		
		optionBtn.MouseEnter:Connect(function()
			Utils:Tween(optionFrame, {BackgroundColor3 = CurrentTheme.ElementActive}, Config.FastAnimation)
		end)
		
		optionBtn.MouseLeave:Connect(function()
			Utils:Tween(optionFrame, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
		end)
	end
	
	local toggleButton = Utils:Create("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 49,
		Parent = frame
	})
	
	toggleButton.MouseButton1Click:Connect(function()
		dropdownOpen = not dropdownOpen
		
		if dropdownOpen then
			dropdownList.Visible = true
			local listHeight = math.min(#options * 41, 220)
			Utils:Tween(dropdownList, {Size = UDim2.new(1, -10, 0, listHeight)}, Config.AnimationSpeed)
			Utils:Tween(arrow, {Rotation = 180}, Config.AnimationSpeed)
		else
			Utils:Tween(dropdownList, {Size = UDim2.new(1, -10, 0, 0)}, Config.AnimationSpeed)
			Utils:Tween(arrow, {Rotation = 0}, Config.AnimationSpeed)
			task.wait(Config.AnimationSpeed)
			dropdownList.Visible = false
		end
	end)
	
	frame.MouseEnter:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
	end)
	
	frame.MouseLeave:Connect(function()
		Utils:Tween(frame, {BackgroundColor3 = CurrentTheme.Element}, Config.FastAnimation)
	end)
	
	return frame
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:Notify(title, message, type, duration)
	type = type or "info"
	duration = duration or 3
	
	local typeColors = {
		info = CurrentTheme.Info,
		success = CurrentTheme.Success,
		warning = CurrentTheme.Warning,
		error = CurrentTheme.Error
	}
	
	local color = typeColors[type] or CurrentTheme.Primary
	
	local notification = Utils:Create("Frame", {
		Size = UDim2.fromOffset(340, 0),
		BackgroundColor3 = CurrentTheme.Sidebar,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 101,
		Parent = self.NotificationContainer
	})
	
	Utils:CreateCorner(notification, 7)
	Utils:CreateGlow(notification, color, 0.7)
	Utils:CreateStroke(notification, color, 2)
	
	local accentBar = Utils:Create("Frame", {
		Size = UDim2.new(0, 5, 1, 0),
		BackgroundColor3 = color,
		BorderSizePixel = 0,
		ZIndex = 102,
		Parent = notification
	})
	
	Utils:CreateCorner(accentBar, 7)
	
	local titleLabel = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -70, 0, 22),
		Position = UDim2.fromOffset(18, 10),
		BackgroundTransparency = 1,
		Text = title,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = color,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 103,
		Parent = notification
	})
	
	local messageLabel = Utils:Create("TextLabel", {
		Size = UDim2.new(1, -70, 0, 18),
		Position = UDim2.fromOffset(18, 32),
		BackgroundTransparency = 1,
		Text = message,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		ZIndex = 103,
		Parent = notification
	})
	
	local closeBtn = Utils:Create("TextButton", {
		Size = UDim2.fromOffset(28, 28),
		Position = UDim2.new(1, -38, 0, 10),
		BackgroundColor3 = CurrentTheme.Element,
		Text = "×",
		Font = Enum.Font.GothamBold,
		TextSize = 18,
		TextColor3 = CurrentTheme.TextDim,
		ZIndex = 103,
		Parent = notification
	})
	
	Utils:CreateCorner(closeBtn, 5)
	
	local progressBg = Utils:Create("Frame", {
		Size = UDim2.new(1, -26, 0, 4),
		Position = UDim2.new(0, 13, 1, -10),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 102,
		Parent = notification
	})
	
	Utils:CreateCorner(progressBg, 2)
	
	local progressFill = Utils:Create("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = color,
		BorderSizePixel = 0,
		ZIndex = 103,
		Parent = progressBg
	})
	
	Utils:CreateCorner(progressFill, 2)
	
	Utils:Tween(notification, {Size = UDim2.fromOffset(340, 65)}, 0.3, Enum.EasingStyle.Back)
	Utils:Tween(progressFill, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)
	
	local function closeNotification()
		Utils:Tween(notification, {Size = UDim2.fromOffset(340, 0)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, function()
			notification:Destroy()
		end)
	end
	
	closeBtn.MouseButton1Click:Connect(closeNotification)
	
	task.delay(duration, closeNotification)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- THEME SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:SetTheme(themeName)
	if not Themes[themeName] then
		warn("[Elysium] Theme '" .. themeName .. "' not found")
		return false
	end
	
	CurrentTheme = Themes[themeName]
	self:RefreshTheme()
	self:Notify("Theme", "Changed to " .. CurrentTheme.Name, "success", 2)
	return true
end

function Elysium:RefreshTheme()
	if not self.Loaded then return end
	
	-- Update main frame
	if self.MainFrame then
		Utils:Tween(self.MainFrame, {BackgroundColor3 = CurrentTheme.Background}, Config.AnimationSpeed)
		local stroke = self.MainFrame:FindFirstChild("UIStroke")
		if stroke then stroke.Color = CurrentTheme.Primary end
		local glow = self.MainFrame:FindFirstChild("Glow")
		if glow then glow.ImageColor3 = CurrentTheme.Primary end
	end
	
	-- Update header
	if self.Header then
		Utils:Tween(self.Header, {BackgroundColor3 = CurrentTheme.Sidebar}, Config.AnimationSpeed)
	end
	
	-- Update sidebar
	if self.Sidebar then
		Utils:Tween(self.Sidebar, {BackgroundColor3 = CurrentTheme.Sidebar}, Config.AnimationSpeed)
	end
	
	-- Update content area
	if self.ContentArea then
		Utils:Tween(self.ContentArea, {BackgroundColor3 = CurrentTheme.Content}, Config.AnimationSpeed)
	end
	
	-- Update tabs
	for _, tab in ipairs(self.Tabs) do
		if tab ~= self.SelectedTab then
			Utils:Tween(tab.Button, {BackgroundColor3 = CurrentTheme.Element}, Config.AnimationSpeed)
		end
	end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- CONFIG SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:SaveConfig(name)
	local config = {}
	for flag, value in pairs(self.Flags) do
		if typeof(value) == "Color3" then
			config[flag] = {R = value.R, G = value.G, B = value.B}
		elseif typeof(value) == "EnumItem" then
			config[flag] = tostring(value)
		elseif typeof(value) == "table" then
			config[flag] = value
		else
			config[flag] = value
		end
	end
	
	return Services.HttpService:JSONEncode(config)
end

function Elysium:LoadConfig(configString)
	local success, config = pcall(function()
		return Services.HttpService:JSONDecode(configString)
	end)
	
	if not success then
		warn("[Elysium] Failed to load config")
		return false
	end
	
	for flag, value in pairs(config) do
		if typeof(value) == "table" and value.R then
			self.Flags[flag] = Color3.new(value.R, value.G, value.B)
		else
			self.Flags[flag] = value
		end
	end
	
	return true
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- SEARCH COMPONENT
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreateSearch(parent, placeholder, callback)
	local frame = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 0, 55),
		BackgroundColor3 = CurrentTheme.Element,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = parent
	})
	
	Utils:CreateCorner(frame, 7)
	Utils:CreateStroke(frame, CurrentTheme.Primary, 1)
	
	local icon = Utils:Create("ImageLabel", {
		Size = UDim2.fromOffset(26, 26),
		Position = UDim2.fromOffset(18, 14.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(964, 324),
		ImageRectSize = Vector2.new(36, 36),
		ImageColor3 = CurrentTheme.Primary,
		ZIndex = 4,
		Parent = frame
	})
	
	local textBox = Utils:Create("TextBox", {
		Size = UDim2.new(1, -110, 1, 0),
		Position = UDim2.fromOffset(55, 0),
		BackgroundTransparency = 1,
		PlaceholderText = placeholder or "Search...",
		PlaceholderColor3 = CurrentTheme.TextDark,
		Text = "",
		Font = Enum.Font.GothamBold,
		TextSize = 16,
		TextColor3 = CurrentTheme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		ZIndex = 4,
		Parent = frame
	})
	
	local clearBtn = Utils:Create("TextButton", {
		Size = UDim2.fromOffset(40, 40),
		Position = UDim2.new(1, -48, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CurrentTheme.ElementHover,
		Text = "×",
		Font = Enum.Font.GothamBold,
		TextSize = 20,
		TextColor3 = CurrentTheme.TextDim,
		Visible = false,
		ZIndex = 4,
		Parent = frame
	})
	
	Utils:CreateCorner(clearBtn, 5)
	
	textBox:GetPropertyChangedSignal("Text"):Connect(function()
		clearBtn.Visible = textBox.Text ~= ""
		if callback then
			task.spawn(callback, textBox.Text)
		end
	end)
	
	clearBtn.MouseButton1Click:Connect(function()
		textBox.Text = ""
	end)
	
	clearBtn.MouseEnter:Connect(function()
		Utils:Tween(clearBtn, {
			BackgroundColor3 = CurrentTheme.Error,
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}, Config.FastAnimation)
	end)
	
	clearBtn.MouseLeave:Connect(function()
		Utils:Tween(clearBtn, {
			BackgroundColor3 = CurrentTheme.ElementHover,
			TextColor3 = CurrentTheme.TextDim
		}, Config.FastAnimation)
	end)
	
	textBox.Focused:Connect(function()
		Utils:CreateGlow(frame, CurrentTheme.Primary, 0.6)
	end)
	
	textBox.FocusLost:Connect(function()
		local glow = frame:FindFirstChild("Glow")
		if glow and glow.Name == "Glow" and glow.Parent == frame then
			glow:Destroy()
		end
	end)
	
	return textBox
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- PLAYER LIST COMPONENT
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:CreatePlayerList(parent)
	local container = Utils:Create("Frame", {
		Size = UDim2.new(1, -20, 1, -80),
		BackgroundTransparency = 1,
		ZIndex = 3,
		Parent = parent
	})
	
	local searchBox = self:CreateSearch(container, "Search players...")
	
	local listFrame = Utils:Create("ScrollingFrame", {
		Size = UDim2.new(1, 0, 1, -65),
		Position = UDim2.fromOffset(0, 65),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 5,
		ScrollBarImageColor3 = CurrentTheme.Primary,
		ScrollBarImageTransparency = 0.3,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ZIndex = 3,
		Parent = container
	})
	
	Utils:Create("UIListLayout", {
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.Name,
		Parent = listFrame
	})
	
	local function createPlayerEntry(player)
		local entry = Utils:Create("Frame", {
			Name = player.Name,
			Size = UDim2.new(1, -10, 0, 75),
			BackgroundColor3 = CurrentTheme.Element,
			BorderSizePixel = 0,
			ZIndex = 4,
			Parent = listFrame
		})
		
		Utils:CreateCorner(entry, 7)
		Utils:CreateStroke(entry, CurrentTheme.Primary, 1)
		
		local avatar = Utils:Create("ImageLabel", {
			Size = UDim2.fromOffset(55, 55),
			Position = UDim2.fromOffset(10, 10),
			BackgroundColor3 = CurrentTheme.ElementHover,
			Image = Services.Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48),
			ZIndex = 5,
			Parent = entry
		})
		
		Utils:CreateCorner(avatar, 7)
		Utils:CreateStroke(avatar, CurrentTheme.Primary, 2)
		
		local nameLabel = Utils:Create("TextLabel", {
			Size = UDim2.new(1, -200, 0, 24),
			Position = UDim2.fromOffset(75, 12),
			BackgroundTransparency = 1,
			Text = player.Name,
			Font = Enum.Font.GothamBold,
			TextSize = 15,
			TextColor3 = CurrentTheme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 5,
			Parent = entry
		})
		
		local displayLabel = Utils:Create("TextLabel", {
			Size = UDim2.new(1, -200, 0, 20),
			Position = UDim2.fromOffset(75, 38),
			BackgroundTransparency = 1,
			Text = "@" .. player.DisplayName,
			Font = Enum.Font.Gotham,
			TextSize = 13,
			TextColor3 = CurrentTheme.TextDim,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 5,
			Parent = entry
		})
		
		local function createActionBtn(text, position, color, callback)
			local btn = Utils:Create("TextButton", {
				Size = UDim2.fromOffset(75, 32),
				Position = position,
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundColor3 = color,
				Text = text,
				Font = Enum.Font.GothamBold,
				TextSize = 13,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				ZIndex = 5,
				Parent = entry
			})
			
			Utils:CreateCorner(btn, 5)
			Utils:CreateGlow(btn, color, 0.5)
			
			btn.MouseButton1Click:Connect(callback)
			
			btn.MouseEnter:Connect(function()
				Utils:Tween(btn, {BackgroundColor3 = CurrentTheme.Secondary}, Config.FastAnimation)
			end)
			
			btn.MouseLeave:Connect(function()
				Utils:Tween(btn, {BackgroundColor3 = color}, Config.FastAnimation)
			end)
			
			return btn
		end
		
		createActionBtn("TP", UDim2.new(1, -165, 0.5, 0), CurrentTheme.Primary, function()
			if player.Character and LocalPlayer.Character then
				LocalPlayer.Character:SetPrimaryPartCFrame(player.Character.PrimaryPart.CFrame)
			end
		end)
		
		createActionBtn("View", UDim2.new(1, -85, 0.5, 0), CurrentTheme.Secondary, function()
			Services.Workspace.CurrentCamera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid")
		end)
		
		entry.MouseEnter:Connect(function()
			Utils:Tween(entry, {BackgroundColor3 = CurrentTheme.ElementHover}, Config.FastAnimation)
		end)
		
		entry.MouseLeave:Connect(function()
			Utils:Tween(entry, {BackgroundColor3 = CurrentTheme.Element}, Config.FastAnimation)
		end)
		
		return entry
	end
	
	for _, player in ipairs(Services.Players:GetPlayers()) do
		if player ~= LocalPlayer then
			createPlayerEntry(player)
		end
	end
	
	Services.Players.PlayerAdded:Connect(function(player)
		createPlayerEntry(player)
	end)
	
	Services.Players.PlayerRemoving:Connect(function(player)
		local entry = listFrame:FindFirstChild(player.Name)
		if entry then entry:Destroy() end
	end)
	
	searchBox:GetPropertyChangedSignal("Text"):Connect(function()
		local query = searchBox.Text:lower()
		for _, entry in ipairs(listFrame:GetChildren()) do
			if entry:IsA("Frame") then
				entry.Visible = query == "" or entry.Name:lower():find(query) ~= nil
			end
		end
	end)
	
	return container
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- CLEANUP
-- ═══════════════════════════════════════════════════════════════════════════════

function Elysium:Destroy()
	if self.ScreenGui then
		self.ScreenGui:Destroy()
	end
	
	for _, connection in pairs(self.Connections) do
		if connection then
			connection:Disconnect()
		end
	end
	
	self.Loaded = false
end

return Elysium
