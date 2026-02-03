-- ═══════════════════════════════════════════════════════════════════════════════
-- ELYSIUM UI v0.0.5 ALPHA - OFFICIAL RELEASE
-- ═══════════════════════════════════════════════════════════════════════════════
-- GTA V Explosive Menu - 1:1 Recreation for Roblox
-- Professional Grade UI Library with Zero Compromises
--
-- Features:
--   ✓ 6 Premium Themes          ✓ Advanced Component System
--   ✓ Smooth Animations         ✓ Perfect Alignment (OCD-Friendly)
--   ✓ Config Save/Load System   ✓ Player List with Search
--   ✓ Color Picker (RGB/Hex)    ✓ Multi-Dropdown Support
--   ✓ Notification System       ✓ Draggable Interface
-- ═══════════════════════════════════════════════════════════════════════════════

local Elysium = {}
Elysium.__index = Elysium
Elysium.Version = "0.0.5"
Elysium.Build = "Alpha"
Elysium.Flags = {}
Elysium.CurrentTheme = "Explosive"

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- ========================================
-- THEME SYSTEM
-- ========================================

Elysium.Themes = {
	Explosive = {
		Name = "Explosive Pink",
		Background = Color3.fromRGB(8, 8, 12),
		Sidebar = Color3.fromRGB(12, 12, 18),
		Content = Color3.fromRGB(16, 16, 24),
		Element = Color3.fromRGB(24, 24, 36),
		ElementHover = Color3.fromRGB(32, 32, 48),
		ElementActive = Color3.fromRGB(40, 40, 60),
		Primary = Color3.fromRGB(255, 0, 128),
		Secondary = Color3.fromRGB(180, 0, 255),
		Accent = Color3.fromRGB(255, 50, 150),
		Success = Color3.fromRGB(76, 175, 80),
		Warning = Color3.fromRGB(255, 152, 0),
		Error = Color3.fromRGB(244, 67, 54),
		Text = Color3.fromRGB(255, 255, 255),
		TextDim = Color3.fromRGB(160, 160, 180),
		TextDark = Color3.fromRGB(100, 100, 120),
		HeaderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 128)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 0, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 200))
		})
	},
	
	Midnight = {
		Name = "Midnight Blue",
		Background = Color3.fromRGB(10, 10, 20),
		Sidebar = Color3.fromRGB(15, 15, 28),
		Content = Color3.fromRGB(20, 20, 35),
		Element = Color3.fromRGB(25, 25, 42),
		ElementHover = Color3.fromRGB(30, 30, 50),
		ElementActive = Color3.fromRGB(35, 35, 58),
		Primary = Color3.fromRGB(64, 156, 255),
		Secondary = Color3.fromRGB(41, 98, 255),
		Accent = Color3.fromRGB(102, 187, 255),
		Success = Color3.fromRGB(76, 175, 80),
		Warning = Color3.fromRGB(255, 193, 7),
		Error = Color3.fromRGB(244, 67, 54),
		Text = Color3.fromRGB(240, 245, 255),
		TextDim = Color3.fromRGB(170, 180, 200),
		TextDark = Color3.fromRGB(110, 120, 140),
		HeaderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 156, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(41, 98, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 70, 200))
		})
	},
	
	Toxic = {
		Name = "Toxic Green",
		Background = Color3.fromRGB(8, 15, 8),
		Sidebar = Color3.fromRGB(12, 20, 12),
		Content = Color3.fromRGB(16, 25, 16),
		Element = Color3.fromRGB(20, 32, 20),
		ElementHover = Color3.fromRGB(24, 38, 24),
		ElementActive = Color3.fromRGB(28, 44, 28),
		Primary = Color3.fromRGB(57, 255, 20),
		Secondary = Color3.fromRGB(124, 252, 0),
		Accent = Color3.fromRGB(173, 255, 47),
		Success = Color3.fromRGB(76, 175, 80),
		Warning = Color3.fromRGB(255, 235, 59),
		Error = Color3.fromRGB(244, 67, 54),
		Text = Color3.fromRGB(240, 255, 240),
		TextDim = Color3.fromRGB(180, 200, 180),
		TextDark = Color3.fromRGB(120, 140, 120),
		HeaderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(57, 255, 20)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(124, 252, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 205, 50))
		})
	},
	
	RedDevil = {
		Name = "Red Devil",
		Background = Color3.fromRGB(15, 8, 8),
		Sidebar = Color3.fromRGB(20, 12, 12),
		Content = Color3.fromRGB(25, 16, 16),
		Element = Color3.fromRGB(32, 20, 20),
		ElementHover = Color3.fromRGB(38, 24, 24),
		ElementActive = Color3.fromRGB(44, 28, 28),
		Primary = Color3.fromRGB(255, 30, 30),
		Secondary = Color3.fromRGB(220, 20, 60),
		Accent = Color3.fromRGB(255, 69, 0),
		Success = Color3.fromRGB(76, 175, 80),
		Warning = Color3.fromRGB(255, 193, 7),
		Error = Color3.fromRGB(244, 67, 54),
		Text = Color3.fromRGB(255, 240, 240),
		TextDim = Color3.fromRGB(200, 180, 180),
		TextDark = Color3.fromRGB(140, 120, 120),
		HeaderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 30, 30)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 20, 60)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 34, 34))
		})
	},
	
	Cyberpunk = {
		Name = "Cyberpunk",
		Background = Color3.fromRGB(12, 8, 15),
		Sidebar = Color3.fromRGB(18, 12, 22),
		Content = Color3.fromRGB(24, 16, 30),
		Element = Color3.fromRGB(30, 20, 38),
		ElementHover = Color3.fromRGB(36, 24, 45),
		ElementActive = Color3.fromRGB(42, 28, 52),
		Primary = Color3.fromRGB(0, 255, 255),
		Secondary = Color3.fromRGB(255, 0, 255),
		Accent = Color3.fromRGB(138, 43, 226),
		Success = Color3.fromRGB(0, 255, 127),
		Warning = Color3.fromRGB(255, 215, 0),
		Error = Color3.fromRGB(255, 20, 147),
		Text = Color3.fromRGB(240, 240, 255),
		TextDim = Color3.fromRGB(180, 180, 220),
		TextDark = Color3.fromRGB(120, 120, 160),
		HeaderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(138, 43, 226)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
		})
	},
	
	DarkMode = {
		Name = "Pure Dark",
		Background = Color3.fromRGB(5, 5, 5),
		Sidebar = Color3.fromRGB(10, 10, 10),
		Content = Color3.fromRGB(15, 15, 15),
		Element = Color3.fromRGB(20, 20, 20),
		ElementHover = Color3.fromRGB(25, 25, 25),
		ElementActive = Color3.fromRGB(30, 30, 30),
		Primary = Color3.fromRGB(200, 200, 200),
		Secondary = Color3.fromRGB(150, 150, 150),
		Accent = Color3.fromRGB(100, 100, 100),
		Success = Color3.fromRGB(76, 175, 80),
		Warning = Color3.fromRGB(255, 193, 7),
		Error = Color3.fromRGB(244, 67, 54),
		Text = Color3.fromRGB(240, 240, 240),
		TextDim = Color3.fromRGB(180, 180, 180),
		TextDark = Color3.fromRGB(120, 120, 120),
		HeaderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 150, 150)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 100))
		})
	}
}

local Theme = Elysium.Themes.Explosive

function Elysium:SetTheme(themeName)
	if self.Themes[themeName] then
		Theme = self.Themes[themeName]
		self.CurrentTheme = themeName
		
		-- Update all UI elements with new theme
		if self.ScreenGui then
			self:RefreshTheme()
		end
		
		self:Notify("Theme", "Changed to " .. Theme.Name, "success", 2)
		return true
	end
	return false
end

function Elysium:RefreshTheme()
	-- Update main window colors
	if self.MainFrame then
		self.MainFrame.BackgroundColor3 = Theme.Background
	end
	if self.Sidebar then
		self.Sidebar.BackgroundColor3 = Theme.Sidebar
	end
	if self.ContentArea then
		self.ContentArea.BackgroundColor3 = Theme.Content
	end
	
	-- Update all elements recursively
	local function updateElement(element)
		if element:IsA("Frame") and element.Name:find("Element") then
			element.BackgroundColor3 = Theme.Element
		elseif element:IsA("TextLabel") or element:IsA("TextButton") then
			if element.Name:find("Title") or element.Name:find("Header") then
				element.TextColor3 = Theme.Primary
			else
				element.TextColor3 = Theme.Text
			end
		end
		
		for _, child in ipairs(element:GetChildren()) do
			updateElement(child)
		end
	end
	
	if self.ScreenGui then
		updateElement(self.ScreenGui)
	end
end

-- ========================================
-- UTILITY FUNCTIONS
-- ========================================

local function Create(instanceType, properties)
	local instance = Instance.new(instanceType)
	for property, value in pairs(properties) do
		instance[property] = value
	end
	return instance
end

local function Tween(instance, properties, duration, style, direction)
	duration = duration or Theme.AnimationSpeed or 0.2
	style = style or Enum.EasingStyle.Quad
	direction = direction or Enum.EasingDirection.Out
	
	local tween = TweenService:Create(instance, TweenInfo.new(duration, style, direction), properties)
	tween:Play()
	return tween
end

local function CreateGradient(instance, gradient)
	local gradientObj = Create("UIGradient", {
		Color = gradient,
		Parent = instance
	})
	return gradientObj
end

local function CreateGlow(instance, color, transparency)
	transparency = transparency or 0.5
	
	local glow = Create("ImageLabel", {
		Name = "Glow",
		Size = UDim2.new(1, 30, 1, 30),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://5028857084",
		ImageColor3 = color,
		ImageTransparency = transparency,
		ZIndex = instance.ZIndex - 1,
		Parent = instance
	})
	
	return glow
end

local function CreateStroke(instance, color, thickness)
	local stroke = Create("UIStroke", {
		Color = color or Theme.Primary,
		Thickness = thickness or 1,
		Transparency = 0.3,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = instance
	})
	return stroke
end

local function CreateParticle(parent, color)
	local particle = Create("Frame", {
		Size = UDim2.fromOffset(4, 4),
		BackgroundColor3 = color or Theme.Primary,
		BorderSizePixel = 0,
		Position = UDim2.new(math.random(), 0, math.random(), 0),
		ZIndex = 10,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = particle
	})
	
	-- Animate
	local tween = Tween(particle, {
		Position = UDim2.new(math.random(), 0, math.random(), 0),
		BackgroundTransparency = 1
	}, 2, Enum.EasingStyle.Linear)
	
	tween.Completed:Connect(function()
		particle:Destroy()
	end)
end

-- ========================================
-- MAIN WINDOW CREATION
-- ========================================

function Elysium.new()
	local self = setmetatable({}, Elysium)
	self.Flags = {}
	self.Tabs = {}
	self.Notifications = {}
	
	-- Create ScreenGui
	self.ScreenGui = Create("ScreenGui", {
		Name = "ElysiumUI",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent = game:GetService("CoreGui")
	})
	
	-- Main Frame (Perfect GTA V proportions - 900x600 for better visibility)
	self.MainFrame = Create("Frame", {
		Name = "MainFrame",
		Size = UDim2.fromOffset(900, 600),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Theme.Background,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Visible = true,
		Parent = self.ScreenGui
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = self.MainFrame
	})
	
	CreateGlow(self.MainFrame, Theme.Primary, 0.7)
	CreateStroke(self.MainFrame, Theme.Primary, 2)
	
	-- Dragging functionality
	self:MakeDraggable(self.MainFrame)
	
	-- Add particles effect
	spawn(function()
		while self.MainFrame and self.MainFrame.Parent do
			if math.random() > 0.7 then
				CreateParticle(self.MainFrame, Theme.Primary)
			end
			wait(0.5)
		end
	end)
	
	-- Create header
	self:CreateHeader()
	
	-- Create sidebar
	self:CreateSidebar()
	
	-- Create content area
	self:CreateContentArea()
	
	-- Create notification container
	self:CreateNotificationContainer()
	
	-- Toggle keybind (INSERT)
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
			self.MainFrame.Visible = not self.MainFrame.Visible
		end
	end)
	
	return self
end

-- ========================================
-- DRAGGABLE FUNCTIONALITY
-- ========================================

function Elysium:MakeDraggable(frame)
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		Tween(frame, {
			Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		}, 0.1)
	end
	
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

-- ========================================
-- HEADER CREATION
-- ========================================

function Elysium:CreateHeader()
	local header = Create("Frame", {
		Name = "Header",
		Size = UDim2.new(1, 0, 0, 60),
		BackgroundColor3 = Theme.Sidebar,
		BorderSizePixel = 0,
		Parent = self.MainFrame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = header
	})
	
	CreateStroke(header, Theme.Primary, 1)
	
	-- Logo/Title
	local title = Create("TextLabel", {
		Name = "Title",
		Size = UDim2.new(0, 200, 1, 0),
		Position = UDim2.fromOffset(20, 0),
		BackgroundTransparency = 1,
		Text = "ELYSIUM",
		Font = Enum.Font.GothamBlack,
		TextSize = 28,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = header
	})
	
	CreateGradient(title, Theme.HeaderGradient)
	
	-- Version badge
	local versionBadge = Create("Frame", {
		Size = UDim2.fromOffset(60, 24),
		Position = UDim2.new(0, 230, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = header
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = versionBadge
	})
	
	CreateStroke(versionBadge, Theme.Primary, 1)
	
	local versionText = Create("TextLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "v" .. self.Version,
		Font = Enum.Font.GothamBold,
		TextSize = 11,
		TextColor3 = Theme.Primary,
		Parent = versionBadge
	})
	
	-- Close button
	local closeBtn = Create("TextButton", {
		Name = "CloseButton",
		Size = UDim2.fromOffset(40, 40),
		Position = UDim2.new(1, -50, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.Element,
		Text = "×",
		Font = Enum.Font.GothamBold,
		TextSize = 24,
		TextColor3 = Theme.Text,
		Parent = header
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = closeBtn
	})
	
	closeBtn.MouseButton1Click:Connect(function()
		self.MainFrame.Visible = false
	end)
	
	closeBtn.MouseEnter:Connect(function()
		Tween(closeBtn, {BackgroundColor3 = Theme.Error, TextColor3 = Color3.fromRGB(255, 255, 255)})
	end)
	
	closeBtn.MouseLeave:Connect(function()
		Tween(closeBtn, {BackgroundColor3 = Theme.Element, TextColor3 = Theme.Text})
	end)
	
	self.Header = header
end

-- ========================================
-- SIDEBAR CREATION
-- ========================================

function Elysium:CreateSidebar()
	self.Sidebar = Create("Frame", {
		Name = "Sidebar",
		Size = UDim2.new(0, 220, 1, -70),
		Position = UDim2.fromOffset(10, 65),
		BackgroundColor3 = Theme.Sidebar,
		BorderSizePixel = 0,
		Parent = self.MainFrame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = self.Sidebar
	})
	
	CreateStroke(self.Sidebar, Theme.Primary, 1)
	
	-- Tab container with scroll
	local tabContainer = Create("ScrollingFrame", {
		Name = "TabContainer",
		Size = UDim2.new(1, -10, 1, -10),
		Position = UDim2.fromOffset(5, 5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = Theme.Primary,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Parent = self.Sidebar
	})
	
	local tabLayout = Create("UIListLayout", {
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = tabContainer
	})
	
	self.TabContainer = tabContainer
end

-- ========================================
-- CONTENT AREA CREATION
-- ========================================

function Elysium:CreateContentArea()
	self.ContentArea = Create("Frame", {
		Name = "ContentArea",
		Size = UDim2.new(1, -250, 1, -70),
		Position = UDim2.fromOffset(240, 65),
		BackgroundColor3 = Theme.Content,
		BorderSizePixel = 0,
		Parent = self.MainFrame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = self.ContentArea
	})
	
	CreateStroke(self.ContentArea, Theme.Primary, 1)
	
	self.ContentPages = {}
end

-- ========================================
-- NOTIFICATION CONTAINER
-- ========================================

function Elysium:CreateNotificationContainer()
	self.NotificationContainer = Create("Frame", {
		Name = "NotificationContainer",
		Size = UDim2.fromOffset(350, 500),
		Position = UDim2.new(1, -370, 0, 20),
		BackgroundTransparency = 1,
		Parent = self.ScreenGui
	})
	
	Create("UIListLayout", {
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		Parent = self.NotificationContainer
	})
end

-- ========================================
-- TAB SYSTEM
-- ========================================

function Elysium:AddTab(name, icon)
	local tab = {}
	tab.Name = name
	tab.Button = Create("TextButton", {
		Name = name,
		Size = UDim2.new(1, -10, 0, 50),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false,
		Parent = self.TabContainer
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = tab.Button
	})
	
	-- Icon (if provided)
	if icon then
		local iconLabel = Create("ImageLabel", {
			Size = UDim2.fromOffset(24, 24),
			Position = UDim2.fromOffset(12, 10.5),
			BackgroundTransparency = 1,
			Image = icon,
			ImageColor3 = Theme.TextDim,
			Parent = tab.Button
		})
		tab.Icon = iconLabel
	end
	
	-- Tab text
	local tabText = Create("TextLabel", {
		Size = UDim2.new(1, icon and -50 or -20, 1, 0),
		Position = UDim2.fromOffset(icon and 45 or 15, 0),
		BackgroundTransparency = 1,
		Text = name,
		Font = Enum.Font.GothamBold,
		TextSize = 16,
		TextColor3 = Theme.TextDim,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = tab.Button
	})
	
	tab.Text = tabText
	
	-- Active indicator
	local activeBar = Create("Frame", {
		Name = "ActiveBar",
		Size = UDim2.new(0, 3, 0.7, 0),
		Position = UDim2.new(0, 0, 0.15, 0),
		BackgroundColor3 = Theme.Primary,
		BorderSizePixel = 0,
		Visible = false,
		Parent = tab.Button
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = activeBar
	})
	
	tab.ActiveBar = activeBar
	
	-- Content page
	local page = Create("ScrollingFrame", {
		Name = name .. "Page",
		Size = UDim2.new(1, -20, 1, -20),
		Position = UDim2.fromOffset(10, 10),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = Theme.Primary,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = false,
		Parent = self.ContentArea
	})
	
	Create("UIListLayout", {
		Padding = UDim.new(0, 12),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = page
	})
	
	tab.Page = page
	
	-- Button click
	tab.Button.MouseButton1Click:Connect(function()
		self:SelectTab(tab)
	end)
	
	-- Hover effects
	tab.Button.MouseEnter:Connect(function()
		if tab ~= self.SelectedTab then
			Tween(tab.Button, {BackgroundColor3 = Theme.ElementHover})
			Tween(tabText, {TextColor3 = Theme.Text})
			if tab.Icon then
				Tween(tab.Icon, {ImageColor3 = Theme.Text})
			end
		end
	end)
	
	tab.Button.MouseLeave:Connect(function()
		if tab ~= self.SelectedTab then
			Tween(tab.Button, {BackgroundColor3 = Theme.Element})
			Tween(tabText, {TextColor3 = Theme.TextDim})
			if tab.Icon then
				Tween(tab.Icon, {ImageColor3 = Theme.TextDim})
			end
		end
	end)
	
	table.insert(self.Tabs, tab)
	
	-- CRITICAL FIX: Auto select first tab without task.wait() - this was causing all tabs except first to not show
	if #self.Tabs == 1 then
		-- Use RunService.Heartbeat to ensure proper initialization
		RunService.Heartbeat:Wait()
		self:SelectTab(tab)
	end
	
	return page
end

function Elysium:SelectTab(tab)
	-- Deselect current tab
	if self.SelectedTab then
		self.SelectedTab.Page.Visible = false
		self.SelectedTab.ActiveBar.Visible = false
		Tween(self.SelectedTab.Button, {BackgroundColor3 = Theme.Element})
		Tween(self.SelectedTab.Text, {TextColor3 = Theme.TextDim})
		if self.SelectedTab.Icon then
			Tween(self.SelectedTab.Icon, {ImageColor3 = Theme.TextDim})
		end
	end
	
	-- Select new tab
	self.SelectedTab = tab
	tab.Page.Visible = true
	tab.ActiveBar.Visible = true
	Tween(tab.Button, {BackgroundColor3 = Theme.ElementActive})
	Tween(tab.Text, {TextColor3 = Theme.Primary})
	if tab.Icon then
		Tween(tab.Icon, {ImageColor3 = Theme.Primary})
	end
	
	CreateGlow(tab.Button, Theme.Primary, 0.6)
end

-- ========================================
-- COMPONENT: CATEGORY
-- ========================================

function Elysium:CreateCategory(parent, name)
	local category = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 40),
		BackgroundTransparency = 1,
		Parent = parent
	})
	
	-- Pink left bar
	local bar = Create("Frame", {
		Size = UDim2.new(0, 4, 0.75, 0),
		Position = UDim2.new(0, 0, 0.125, 0),
		BackgroundColor3 = Theme.Primary,
		BorderSizePixel = 0,
		Parent = category
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = bar
	})
	
	CreateGlow(bar, Theme.Primary, 0.4)
	
	local label = Create("TextLabel", {
		Size = UDim2.new(1, -20, 1, 0),
		Position = UDim2.fromOffset(15, 0),
		BackgroundTransparency = 1,
		Text = name:upper(),
		Font = Enum.Font.GothamBlack,
		TextSize = 17,
		TextColor3 = Theme.Primary,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = category
	})
	
	CreateGradient(label, Theme.HeaderGradient)
	
	return category
end

-- ========================================
-- COMPONENT: DIVIDER
-- ========================================

function Elysium:CreateDivider(parent)
	local divider = Create("Frame", {
		Size = UDim2.new(1, -40, 0, 2),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = parent
	})
	
	CreateGradient(divider, Theme.HeaderGradient)
	
	return divider
end

-- ========================================
-- COMPONENT: INFO LABEL
-- ========================================

function Elysium:CreateLabel(parent, text)
	local frame = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 35),
		BackgroundTransparency = 1,
		Parent = parent
	})
	
	local label = Create("TextLabel", {
		Size = UDim2.new(1, -10, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = Theme.TextDim,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		Parent = frame
	})
	
	return label
end

-- ========================================
-- COMPONENT: TOGGLE
-- ========================================

function Elysium:CreateToggle(parent, text, flag, default, callback)
	default = default or false
	self.Flags[flag] = default
	
	local frame = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 50),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = frame
	})
	
	CreateStroke(frame, default and Theme.Primary or Theme.Element, 1)
	
	-- Label
	local label = Create("TextLabel", {
		Size = UDim2.new(1, -80, 1, 0),
		Position = UDim2.fromOffset(15, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame
	})
	
	-- Toggle switch
	local toggleBg = Create("Frame", {
		Size = UDim2.fromOffset(50, 26),
		Position = UDim2.new(1, -60, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = default and Theme.Primary or Theme.ElementHover,
		BorderSizePixel = 0,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = toggleBg
	})
	
	local toggleCircle = Create("Frame", {
		Size = UDim2.fromOffset(20, 20),
		Position = default and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Parent = toggleBg
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = toggleCircle
	})
	
	if default then
		CreateGlow(toggleBg, Theme.Primary, 0.5)
	end
	
	-- Button
	local button = Create("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		Parent = frame
	})
	
	button.MouseButton1Click:Connect(function()
		self.Flags[flag] = not self.Flags[flag]
		
		if self.Flags[flag] then
			Tween(toggleCircle, {Position = UDim2.new(1, -23, 0.5, 0)})
			Tween(toggleBg, {BackgroundColor3 = Theme.Primary})
			CreateGlow(toggleBg, Theme.Primary, 0.5)
			CreateStroke(frame, Theme.Primary, 1)
		else
			Tween(toggleCircle, {Position = UDim2.new(0, 3, 0.5, 0)})
			Tween(toggleBg, {BackgroundColor3 = Theme.ElementHover})
			local glow = toggleBg:FindFirstChild("Glow")
			if glow then glow:Destroy() end
			CreateStroke(frame, Theme.Element, 1)
		end
		
		if callback then
			callback(self.Flags[flag])
		end
	end)
	
	button.MouseEnter:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.ElementHover})
	end)
	
	button.MouseLeave:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.Element})
	end)
	
	return frame
end

-- ========================================
-- COMPONENT: SLIDER
-- ========================================

function Elysium:CreateSlider(parent, text, min, max, default, decimals, flag, callback)
	default = default or min
	decimals = decimals or 0
	self.Flags[flag] = default
	
	local frame = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 65),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = frame
	})
	
	-- Label
	local label = Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 20),
		Position = UDim2.fromOffset(15, 8),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame
	})
	
	-- Value display
	local valueLabel = Create("TextLabel", {
		Size = UDim2.fromOffset(60, 20),
		Position = UDim2.new(1, -70, 0, 8),
		BackgroundColor3 = Theme.ElementHover,
		Text = tostring(default),
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = Theme.Primary,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = valueLabel
	})
	
	-- Slider background
	local sliderBg = Create("Frame", {
		Size = UDim2.new(1, -30, 0, 8),
		Position = UDim2.fromOffset(15, 38),
		BackgroundColor3 = Theme.ElementHover,
		BorderSizePixel = 0,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = sliderBg
	})
	
	-- Slider fill
	local sliderFill = Create("Frame", {
		Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
		BackgroundColor3 = Theme.Primary,
		BorderSizePixel = 0,
		Parent = sliderBg
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = sliderFill
	})
	
	CreateGradient(sliderFill, Theme.HeaderGradient)
	CreateGlow(sliderFill, Theme.Primary, 0.5)
	
	-- Slider knob
	local sliderKnob = Create("Frame", {
		Size = UDim2.fromOffset(18, 18),
		Position = UDim2.new((default - min) / (max - min), -9, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Parent = sliderBg
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = sliderKnob
	})
	
	CreateGlow(sliderKnob, Theme.Primary, 0.6)
	CreateStroke(sliderKnob, Theme.Primary, 2)
	
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
		
		Tween(sliderFill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.1)
		Tween(sliderKnob, {Position = UDim2.new(pos, -9, 0.5, 0)}, 0.1)
		
		if callback then
			callback(value)
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
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			updateSlider(input)
		end
	end)
	
	frame.MouseEnter:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.ElementHover})
	end)
	
	frame.MouseLeave:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.Element})
	end)
	
	return frame
end

-- ========================================
-- COMPONENT: BUTTON
-- ========================================

function Elysium:CreateButton(parent, text, callback)
	local button = Create("TextButton", {
		Size = UDim2.new(1, -20, 0, 50),
		BackgroundColor3 = Theme.Primary,
		BorderSizePixel = 0,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		AutoButtonColor = false,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = button
	})
	
	CreateGradient(button, Theme.HeaderGradient)
	CreateGlow(button, Theme.Primary, 0.6)
	
	button.MouseButton1Click:Connect(function()
		-- Click animation
		Tween(button, {Size = UDim2.new(1, -20, 0, 47)}, 0.1)
		wait(0.1)
		Tween(button, {Size = UDim2.new(1, -20, 0, 50)}, 0.1)
		
		if callback then
			callback()
		end
	end)
	
	button.MouseEnter:Connect(function()
		Tween(button, {BackgroundColor3 = Theme.Secondary})
	end)
	
	button.MouseLeave:Connect(function()
		Tween(button, {BackgroundColor3 = Theme.Primary})
	end)
	
	return button
end

-- ========================================
-- COMPONENT: DROPDOWN
-- ========================================

function Elysium:CreateDropdown(parent, text, options, default, flag, callback)
	default = default or options[1]
	self.Flags[flag] = default
	
	local frame = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 50),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = frame
	})
	
	-- Label
	local label = Create("TextLabel", {
		Size = UDim2.new(0.5, -20, 1, 0),
		Position = UDim2.fromOffset(15, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame
	})
	
	-- Selected value
	local valueLabel = Create("TextLabel", {
		Size = UDim2.new(0.5, -80, 0, 30),
		Position = UDim2.new(0.5, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.ElementHover,
		Text = default,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = Theme.Primary,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = valueLabel
	})
	
	-- Arrow icon
	local arrow = Create("TextLabel", {
		Size = UDim2.fromOffset(20, 20),
		Position = UDim2.new(1, -35, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = "▼",
		Font = Enum.Font.GothamBold,
		TextSize = 10,
		TextColor3 = Theme.TextDim,
		Parent = frame
	})
	
	-- Dropdown list
	local dropdownOpen = false
	local dropdownList = Create("Frame", {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0.5, 0, 1, 5),
		AnchorPoint = Vector2.new(0, 0),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 100,
		ClipsDescendants = true,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = dropdownList
	})
	
	CreateStroke(dropdownList, Theme.Primary, 1)
	CreateGlow(dropdownList, Theme.Primary, 0.6)
	
	local listLayout = Create("UIListLayout", {
		Padding = UDim.new(0, 2),
		Parent = dropdownList
	})
	
	-- Create options
	for _, option in ipairs(options) do
		local optionBtn = Create("TextButton", {
			Size = UDim2.new(1, -10, 0, 35),
			Position = UDim2.fromOffset(5, 0),
			BackgroundColor3 = option == default and Theme.ElementActive or Theme.ElementHover,
			Text = option,
			Font = Enum.Font.Gotham,
			TextSize = 13,
			TextColor3 = option == default and Theme.Primary or Theme.Text,
			Parent = dropdownList
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 4),
			Parent = optionBtn
		})
		
		optionBtn.MouseButton1Click:Connect(function()
			self.Flags[flag] = option
			valueLabel.Text = option
			dropdownOpen = false
			
			Tween(dropdownList, {Size = UDim2.new(1, -10, 0, 0)}, 0.2)
			wait(0.2)
			dropdownList.Visible = false
			Tween(arrow, {Rotation = 0}, 0.2)
			
			-- Update all option colors
			for _, btn in ipairs(dropdownList:GetChildren()) do
				if btn:IsA("TextButton") then
					if btn.Text == option then
						Tween(btn, {BackgroundColor3 = Theme.ElementActive, TextColor3 = Theme.Primary})
					else
						Tween(btn, {BackgroundColor3 = Theme.ElementHover, TextColor3 = Theme.Text})
					end
				end
			end
			
			if callback then
				callback(option)
			end
		end)
		
		optionBtn.MouseEnter:Connect(function()
			if option ~= self.Flags[flag] then
				Tween(optionBtn, {BackgroundColor3 = Theme.ElementActive})
			end
		end)
		
		optionBtn.MouseLeave:Connect(function()
			if option ~= self.Flags[flag] then
				Tween(optionBtn, {BackgroundColor3 = Theme.ElementHover})
			end
		end)
	end
	
	-- Toggle dropdown
	local button = Create("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 50,
		Parent = frame
	})
	
	button.MouseButton1Click:Connect(function()
		dropdownOpen = not dropdownOpen
		
		if dropdownOpen then
			dropdownList.Visible = true
			local listHeight = math.min(#options * 37, 200)
			Tween(dropdownList, {Size = UDim2.new(1, -10, 0, listHeight)}, 0.2)
			Tween(arrow, {Rotation = 180}, 0.2)
		else
			Tween(dropdownList, {Size = UDim2.new(1, -10, 0, 0)}, 0.2)
			Tween(arrow, {Rotation = 0}, 0.2)
			wait(0.2)
			dropdownList.Visible = false
		end
	end)
	
	frame.MouseEnter:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.ElementHover})
	end)
	
	frame.MouseLeave:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.Element})
	end)
	
	return frame
end

-- ========================================
-- COMPONENT: KEYBIND
-- ========================================

function Elysium:CreateKeybind(parent, text, defaultKey, flag, callback)
	defaultKey = defaultKey or Enum.KeyCode.E
	self.Flags[flag] = defaultKey
	
	local frame = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 50),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = frame
	})
	
	-- Label
	local label = Create("TextLabel", {
		Size = UDim2.new(0.6, -20, 1, 0),
		Position = UDim2.fromOffset(15, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame
	})
	
	-- Keybind button
	local keybindBtn = Create("TextButton", {
		Size = UDim2.new(0.4, -30, 0, 30),
		Position = UDim2.new(0.6, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.ElementHover,
		Text = defaultKey.Name,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = Theme.Primary,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = keybindBtn
	})
	
	CreateStroke(keybindBtn, Theme.Primary, 1)
	
	local binding = false
	
	keybindBtn.MouseButton1Click:Connect(function()
		binding = true
		keybindBtn.Text = "..."
		Tween(keybindBtn, {BackgroundColor3 = Theme.Primary, TextColor3 = Color3.fromRGB(255, 255, 255)})
	end)
	
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if binding and not gameProcessed then
			if input.UserInputType == Enum.UserInputType.Keyboard then
				binding = false
				self.Flags[flag] = input.KeyCode
				keybindBtn.Text = input.KeyCode.Name
				Tween(keybindBtn, {BackgroundColor3 = Theme.ElementHover, TextColor3 = Theme.Primary})
				
				if callback then
					callback(input.KeyCode)
				end
			end
		end
	end)
	
	frame.MouseEnter:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.ElementHover})
	end)
	
	frame.MouseLeave:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.Element})
	end)
	
	return frame
end

-- ========================================
-- COMPONENT: TEXTBOX
-- ========================================

function Elysium:CreateTextBox(parent, text, placeholder, flag, callback)
	self.Flags[flag] = ""
	
	local frame = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 50),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = frame
	})
	
	-- Label
	local label = Create("TextLabel", {
		Size = UDim2.new(0.4, -20, 1, 0),
		Position = UDim2.fromOffset(15, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame
	})
	
	-- TextBox
	local textBox = Create("TextBox", {
		Size = UDim2.new(0.6, -30, 0, 30),
		Position = UDim2.new(0.4, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.ElementHover,
		PlaceholderText = placeholder or "Enter text...",
		PlaceholderColor3 = Theme.TextDark,
		Text = "",
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = Theme.Text,
		ClearTextOnFocus = false,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = textBox
	})
	
	textBox:GetPropertyChangedSignal("Text"):Connect(function()
		self.Flags[flag] = textBox.Text
		if callback then
			callback(textBox.Text)
		end
	end)
	
	textBox.Focused:Connect(function()
		CreateStroke(frame, Theme.Primary, 1)
	end)
	
	textBox.FocusLost:Connect(function()
		local stroke = frame:FindFirstChild("UIStroke")
		if stroke then stroke:Destroy() end
	end)
	
	frame.MouseEnter:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.ElementHover})
	end)
	
	frame.MouseLeave:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.Element})
	end)
	
	return textBox
end

-- ========================================
-- COMPONENT: ENHANCED COLOR PICKER
-- ========================================

function Elysium:CreateColorPicker(parent, text, default, flag, callback)
	default = default or Color3.fromRGB(255, 0, 128)
	self.Flags[flag] = default
	
	local frame = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 50),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = frame
	})
	
	-- Label
	local label = Create("TextLabel", {
		Size = UDim2.new(1, -80, 1, 0),
		Position = UDim2.fromOffset(15, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame
	})
	
	-- Color Display Button
	local colorDisplay = Create("TextButton", {
		Size = UDim2.fromOffset(60, 30),
		Position = UDim2.new(1, -70, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = default,
		Text = "",
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = colorDisplay
	})
	
	CreateGlow(colorDisplay, default, 0.5)
	CreateStroke(colorDisplay, default, 2)
	
	-- Color Picker Popup
	local pickerOpen = false
	local picker = Create("Frame", {
		Size = UDim2.fromOffset(280, 320),
		Position = UDim2.new(0.5, -140, 0.5, -160),
		AnchorPoint = Vector2.new(0, 0),
		BackgroundColor3 = Theme.Sidebar,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 150,
		Parent = self.ScreenGui
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = picker
	})
	
	CreateGlow(picker, Theme.Primary, 0.8)
	CreateStroke(picker, Theme.Primary, 2)
	
	-- Picker Title
	local pickerTitle = Create("TextLabel", {
		Size = UDim2.new(1, 0, 0, 35),
		BackgroundTransparency = 1,
		Text = "Color Picker",
		Font = Enum.Font.GothamBold,
		TextSize = 16,
		TextColor3 = Theme.Primary,
		Parent = picker
	})
	
	CreateGradient(pickerTitle, Theme.HeaderGradient)
	
	-- Saturation/Value Box
	local svBox = Create("ImageButton", {
		Size = UDim2.fromOffset(220, 180),
		Position = UDim2.fromOffset(10, 45),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Image = "rbxassetid://4155801252",
		Parent = picker
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = svBox
	})
	
	-- Hue Slider
	local hueSlider = Create("ImageButton", {
		Size = UDim2.fromOffset(30, 180),
		Position = UDim2.fromOffset(240, 45),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Image = "rbxassetid://3641079629",
		Parent = picker
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = hueSlider
	})
	
	-- Color Indicator
	local indicator = Create("Frame", {
		Size = UDim2.fromOffset(10, 10),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 2,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		ZIndex = 151,
		Parent = svBox
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = indicator
	})
	
	-- RGB Input Fields
	local rgbFrame = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 35),
		Position = UDim2.fromOffset(10, 235),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = picker
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = rgbFrame
	})
	
	local function createRGBInput(name, position)
		local input = Create("TextBox", {
			Size = UDim2.fromOffset(60, 25),
			Position = position,
			BackgroundColor3 = Theme.ElementHover,
			PlaceholderText = name,
			Text = "",
			Font = Enum.Font.Gotham,
			TextSize = 12,
			TextColor3 = Theme.Text,
			Parent = rgbFrame
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 3),
			Parent = input
		})
		
		return input
	end
	
	local rInput = createRGBInput("R", UDim2.fromOffset(10, 5))
	local gInput = createRGBInput("G", UDim2.fromOffset(80, 5))
	local bInput = createRGBInput("B", UDim2.fromOffset(150, 5))
	
	-- Hex Input
	local hexInput = Create("TextBox", {
		Size = UDim2.fromOffset(80, 25),
		Position = UDim2.fromOffset(220, 5),
		BackgroundColor3 = Theme.ElementHover,
		PlaceholderText = "#HEX",
		Text = "",
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = Theme.Text,
		Parent = rgbFrame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 3),
		Parent = hexInput
	})
	
	-- Close button
	local closeBtn = Create("TextButton", {
		Size = UDim2.fromOffset(100, 30),
		Position = UDim2.new(0.5, -50, 1, -40),
		BackgroundColor3 = Theme.Primary,
		Text = "Done",
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Parent = picker
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = closeBtn
	})
	
	CreateGradient(closeBtn, Theme.HeaderGradient)
	
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
		
		-- Update RGB inputs
		rInput.Text = tostring(math.floor(color.R * 255))
		gInput.Text = tostring(math.floor(color.G * 255))
		bInput.Text = tostring(math.floor(color.B * 255))
		
		-- Update hex
		hexInput.Text = string.format("#%02X%02X%02X", 
			math.floor(color.R * 255),
			math.floor(color.G * 255),
			math.floor(color.B * 255)
		)
		
		-- Update glow
		local glow = colorDisplay:FindFirstChild("Glow")
		if glow then glow.ImageColor3 = color end
		
		local stroke = colorDisplay:FindFirstChild("UIStroke")
		if stroke then stroke.Color = color end
		
		if callback then callback(color) end
	end
	
	-- SV Box Logic
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
		indicator.Position = UDim2.new(posX, -5, posY, -5)
		updateColor()
	end
	
	svBox.InputChanged:Connect(function(input)
		if svDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			updateSV(input)
		end
	end)
	
	-- Hue Slider Logic
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
	
	UserInputService.InputEnded:Connect(function(input)
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
	
	-- Toggle Picker
	colorDisplay.MouseButton1Click:Connect(function()
		pickerOpen = not pickerOpen
		picker.Visible = pickerOpen
		if pickerOpen then
			updateColor()
		end
	end)
	
	frame.MouseEnter:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.ElementHover})
	end)
	
	frame.MouseLeave:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.Element})
	end)
	
	return frame
end

-- ========================================
-- COMPONENT: MULTI-DROPDOWN
-- ========================================

function Elysium:CreateMultiDropdown(parent, text, options, defaults, flag, callback)
	defaults = defaults or {}
	self.Flags[flag] = defaults
	
	local frame = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 50),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = frame
	})
	
	-- Label
	local label = Create("TextLabel", {
		Size = UDim2.new(0.5, -20, 1, 0),
		Position = UDim2.fromOffset(15, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame
	})
	
	-- Selected count
	local countLabel = Create("TextLabel", {
		Size = UDim2.new(0.5, -80, 0, 30),
		Position = UDim2.new(0.5, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.ElementHover,
		Text = #defaults .. " selected",
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = Theme.Primary,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = countLabel
	})
	
	-- Arrow icon
	local arrow = Create("TextLabel", {
		Size = UDim2.fromOffset(20, 20),
		Position = UDim2.new(1, -35, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = "▼",
		Font = Enum.Font.GothamBold,
		TextSize = 10,
		TextColor3 = Theme.TextDim,
		Parent = frame
	})
	
	-- Dropdown list
	local dropdownOpen = false
	local dropdownList = Create("Frame", {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0.5, 0, 1, 5),
		AnchorPoint = Vector2.new(0, 0),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 100,
		ClipsDescendants = true,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = dropdownList
	})
	
	CreateStroke(dropdownList, Theme.Primary, 1)
	CreateGlow(dropdownList, Theme.Primary, 0.6)
	
	Create("UIListLayout", {
		Padding = UDim.new(0, 2),
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
	
	-- Create options with checkboxes
	for _, option in ipairs(options) do
		local optionFrame = Create("Frame", {
			Size = UDim2.new(1, -10, 0, 35),
			Position = UDim2.fromOffset(5, 0),
			BackgroundColor3 = Theme.ElementHover,
			BorderSizePixel = 0,
			Parent = dropdownList
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 4),
			Parent = optionFrame
		})
		
		-- Checkbox
		local checkbox = Create("Frame", {
			Size = UDim2.fromOffset(18, 18),
			Position = UDim2.fromOffset(10, 8.5),
			BackgroundColor3 = isSelected(option) and Theme.Primary or Theme.ElementActive,
			BorderSizePixel = 0,
			Parent = optionFrame
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 3),
			Parent = checkbox
		})
		
		if isSelected(option) then
			local checkmark = Create("TextLabel", {
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = "✓",
				Font = Enum.Font.GothamBold,
				TextSize = 14,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Parent = checkbox
			})
		end
		
		-- Option text
		local optionText = Create("TextLabel", {
			Size = UDim2.new(1, -40, 1, 0),
			Position = UDim2.fromOffset(35, 0),
			BackgroundTransparency = 1,
			Text = option,
			Font = Enum.Font.Gotham,
			TextSize = 13,
			TextColor3 = Theme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = optionFrame
		})
		
		local optionBtn = Create("TextButton", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = "",
			Parent = optionFrame
		})
		
		optionBtn.MouseButton1Click:Connect(function()
			if isSelected(option) then
				-- Remove
				for i, selected in ipairs(self.Flags[flag]) do
					if selected == option then
						table.remove(self.Flags[flag], i)
						break
					end
				end
				Tween(checkbox, {BackgroundColor3 = Theme.ElementActive})
				local checkmark = checkbox:FindFirstChild("TextLabel")
				if checkmark then checkmark:Destroy() end
			else
				-- Add
				table.insert(self.Flags[flag], option)
				Tween(checkbox, {BackgroundColor3 = Theme.Primary})
				Create("TextLabel", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text = "✓",
					Font = Enum.Font.GothamBold,
					TextSize = 14,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					Parent = checkbox
				})
			end
			
			updateCount()
			
			if callback then
				callback(self.Flags[flag])
			end
		end)
		
		optionBtn.MouseEnter:Connect(function()
			Tween(optionFrame, {BackgroundColor3 = Theme.ElementActive})
		end)
		
		optionBtn.MouseLeave:Connect(function()
			Tween(optionFrame, {BackgroundColor3 = Theme.ElementHover})
		end)
	end
	
	-- Toggle dropdown
	local button = Create("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 50,
		Parent = frame
	})
	
	button.MouseButton1Click:Connect(function()
		dropdownOpen = not dropdownOpen
		
		if dropdownOpen then
			dropdownList.Visible = true
			local listHeight = math.min(#options * 37, 200)
			Tween(dropdownList, {Size = UDim2.new(1, -10, 0, listHeight)}, 0.2)
			Tween(arrow, {Rotation = 180}, 0.2)
		else
			Tween(dropdownList, {Size = UDim2.new(1, -10, 0, 0)}, 0.2)
			Tween(arrow, {Rotation = 0}, 0.2)
			wait(0.2)
			dropdownList.Visible = false
		end
	end)
	
	frame.MouseEnter:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.ElementHover})
	end)
	
	frame.MouseLeave:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.Element})
	end)
	
	return frame
end

-- ========================================
-- NOTIFICATION SYSTEM
-- ========================================

function Elysium:Notify(title, message, type, duration)
	type = type or "info"
	duration = duration or 3
	
	local typeColors = {
		info = Theme.Primary,
		success = Theme.Success,
		warning = Theme.Warning,
		error = Theme.Error
	}
	
	local color = typeColors[type] or Theme.Primary
	
	local notification = Create("Frame", {
		Size = UDim2.fromOffset(330, 0),
		BackgroundColor3 = Theme.Sidebar,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = self.NotificationContainer
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = notification
	})
	
	CreateGlow(notification, color, 0.7)
	CreateStroke(notification, color, 2)
	
	-- Left accent bar
	local accentBar = Create("Frame", {
		Size = UDim2.new(0, 4, 1, 0),
		BackgroundColor3 = color,
		BorderSizePixel = 0,
		Parent = notification
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = accentBar
	})
	
	-- Title
	local titleLabel = Create("TextLabel", {
		Size = UDim2.new(1, -60, 0, 20),
		Position = UDim2.fromOffset(15, 8),
		BackgroundTransparency = 1,
		Text = title,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = color,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = notification
	})
	
	-- Message
	local messageLabel = Create("TextLabel", {
		Size = UDim2.new(1, -60, 0, 16),
		Position = UDim2.fromOffset(15, 28),
		BackgroundTransparency = 1,
		Text = message,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		Parent = notification
	})
	
	-- Close button
	local closeBtn = Create("TextButton", {
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.new(1, -32, 0, 8),
		BackgroundColor3 = Theme.Element,
		Text = "×",
		Font = Enum.Font.GothamBold,
		TextSize = 16,
		TextColor3 = Theme.TextDim,
		Parent = notification
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = closeBtn
	})
	
	-- Progress bar
	local progressBg = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 3),
		Position = UDim2.new(0, 10, 1, -8),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = notification
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = progressBg
	})
	
	local progressFill = Create("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = color,
		BorderSizePixel = 0,
		Parent = progressBg
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = progressFill
	})
	
	-- Animate in
	Tween(notification, {Size = UDim2.fromOffset(330, 55)}, 0.3, Enum.EasingStyle.Back)
	
	-- Progress animation
	Tween(progressFill, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)
	
	-- Close button functionality
	local function closeNotification()
		Tween(notification, {Size = UDim2.fromOffset(330, 0)}, 0.2)
		wait(0.2)
		notification:Destroy()
	end
	
	closeBtn.MouseButton1Click:Connect(closeNotification)
	
	-- Auto close
	delay(duration, closeNotification)
end

-- ========================================
-- SEARCH COMPONENT
-- ========================================

function Elysium:CreateSearch(parent, placeholder, callback)
	local frame = Create("Frame", {
		Size = UDim2.new(1, -20, 0, 50),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = frame
	})
	
	CreateStroke(frame, Theme.Primary, 1)
	
	-- Search Icon
	local icon = Create("ImageLabel", {
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.fromOffset(15, 13),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(964, 324),
		ImageRectSize = Vector2.new(36, 36),
		ImageColor3 = Theme.Primary,
		Parent = frame
	})
	
	-- Text Box
	local textBox = Create("TextBox", {
		Size = UDim2.new(1, -100, 1, 0),
		Position = UDim2.fromOffset(50, 0),
		BackgroundTransparency = 1,
		PlaceholderText = placeholder or "Search...",
		PlaceholderColor3 = Theme.TextDark,
		Text = "",
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Parent = frame
	})
	
	-- Clear Button
	local clearBtn = Create("TextButton", {
		Size = UDim2.fromOffset(35, 35),
		Position = UDim2.new(1, -45, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.ElementHover,
		Text = "×",
		Font = Enum.Font.GothamBold,
		TextSize = 18,
		TextColor3 = Theme.TextDim,
		Visible = false,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = clearBtn
	})
	
	textBox:GetPropertyChangedSignal("Text"):Connect(function()
		clearBtn.Visible = textBox.Text ~= ""
		if callback then callback(textBox.Text) end
	end)
	
	clearBtn.MouseButton1Click:Connect(function()
		textBox.Text = ""
	end)
	
	clearBtn.MouseEnter:Connect(function()
		Tween(clearBtn, {BackgroundColor3 = Theme.Error, TextColor3 = Color3.fromRGB(255, 255, 255)})
	end)
	
	clearBtn.MouseLeave:Connect(function()
		Tween(clearBtn, {BackgroundColor3 = Theme.ElementHover, TextColor3 = Theme.TextDim})
	end)
	
	textBox.Focused:Connect(function()
		CreateGlow(frame, Theme.Primary, 0.6)
	end)
	
	textBox.FocusLost:Connect(function()
		local glow = frame:FindFirstChild("Glow")
		if glow then glow:Destroy() end
	end)
	
	return textBox
end

-- ========================================
-- PLAYER LIST COMPONENT
-- ========================================

function Elysium:CreatePlayerList(parent)
	local container = Create("Frame", {
		Size = UDim2.new(1, -20, 1, -70),
		BackgroundTransparency = 1,
		Parent = parent
	})
	
	-- Search
	local searchBox = self:CreateSearch(container, "Search players...")
	
	-- Player List Frame
	local listFrame = Create("ScrollingFrame", {
		Size = UDim2.new(1, 0, 1, -60),
		Position = UDim2.fromOffset(0, 60),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = Theme.Primary,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Parent = container
	})
	
	Create("UIListLayout", {
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.Name,
		Parent = listFrame
	})
	
	local function createPlayerEntry(player)
		local entry = Create("Frame", {
			Name = player.Name,
			Size = UDim2.new(1, -10, 0, 70),
			BackgroundColor3 = Theme.Element,
			BorderSizePixel = 0,
			Parent = listFrame
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 6),
			Parent = entry
		})
		
		CreateStroke(entry, Theme.Primary, 1)
		
		-- Avatar
		local avatar = Create("ImageLabel", {
			Size = UDim2.fromOffset(50, 50),
			Position = UDim2.fromOffset(10, 10),
			BackgroundColor3 = Theme.ElementHover,
			Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48),
			Parent = entry
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 6),
			Parent = avatar
		})
		
		CreateStroke(avatar, Theme.Primary, 2)
		
		-- Name
		local nameLabel = Create("TextLabel", {
			Size = UDim2.new(1, -180, 0, 22),
			Position = UDim2.fromOffset(70, 12),
			BackgroundTransparency = 1,
			Text = player.Name,
			Font = Enum.Font.GothamBold,
			TextSize = 14,
			TextColor3 = Theme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = entry
		})
		
		-- Display Name
		local displayLabel = Create("TextLabel", {
			Size = UDim2.new(1, -180, 0, 18),
			Position = UDim2.fromOffset(70, 36),
			BackgroundTransparency = 1,
			Text = "@" .. player.DisplayName,
			Font = Enum.Font.Gotham,
			TextSize = 12,
			TextColor3 = Theme.TextDim,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = entry
		})
		
		-- Actions
		local function createActionBtn(text, position, color, callback)
			local btn = Create("TextButton", {
				Size = UDim2.fromOffset(70, 30),
				Position = position,
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundColor3 = color,
				Text = text,
				Font = Enum.Font.GothamBold,
				TextSize = 12,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Parent = entry
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 4),
				Parent = btn
			})
			
			CreateGlow(btn, color, 0.5)
			
			btn.MouseButton1Click:Connect(callback)
			
			btn.MouseEnter:Connect(function()
				Tween(btn, {BackgroundColor3 = Theme.Secondary})
			end)
			
			btn.MouseLeave:Connect(function()
				Tween(btn, {BackgroundColor3 = color})
			end)
			
			return btn
		end
		
		createActionBtn("TP", UDim2.new(1, -155, 0.5, 0), Theme.Primary, function()
			if player.Character and LocalPlayer.Character then
				LocalPlayer.Character:SetPrimaryPartCFrame(player.Character.PrimaryPart.CFrame)
			end
		end)
		
		createActionBtn("View", UDim2.new(1, -80, 0.5, 0), Theme.Secondary, function()
			workspace.CurrentCamera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid")
		end)
		
		entry.MouseEnter:Connect(function()
			Tween(entry, {BackgroundColor3 = Theme.ElementHover})
		end)
		
		entry.MouseLeave:Connect(function()
			Tween(entry, {BackgroundColor3 = Theme.Element})
		end)
		
		return entry
	end
	
	-- Populate
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			createPlayerEntry(player)
		end
	end
	
	Players.PlayerAdded:Connect(function(player)
		createPlayerEntry(player)
	end)
	
	Players.PlayerRemoving:Connect(function(player)
		local entry = listFrame:FindFirstChild(player.Name)
		if entry then entry:Destroy() end
	end)
	
	-- Search filter
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

-- ========================================
-- CONFIG SYSTEM
-- ========================================

function Elysium:SaveConfig(name)
	local config = {}
	for flag, value in pairs(self.Flags) do
		if typeof(value) == "Color3" then
			config[flag] = {r = value.R, g = value.G, b = value.B}
		elseif typeof(value) == "EnumItem" then
			config[flag] = tostring(value)
		elseif typeof(value) == "table" then
			config[flag] = value
		else
			config[flag] = value
		end
	end
	print("[ELYSIUM] Config saved:", name)
	return HttpService:JSONEncode(config)
end

function Elysium:LoadConfig(configString)
	local success, config = pcall(function()
		return HttpService:JSONDecode(configString)
	end)
	
	if not success then
		warn("[ELYSIUM] Failed to load config")
		return
	end
	
	for flag, value in pairs(config) do
		if typeof(value) == "table" and value.r then
			self.Flags[flag] = Color3.new(value.r, value.g, value.b)
		else
			self.Flags[flag] = value
		end
	end
	print("[ELYSIUM] Config loaded successfully")
end

return Elysium
