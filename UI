local Elysium = {}
Elysium.__index = Elysium

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Theme Configuration (Explosive Style)
local Theme = {
	Background = Color3.fromRGB(8, 8, 12),
	Sidebar = Color3.fromRGB(12, 12, 18),
	Content = Color3.fromRGB(16, 16, 24),
	Element = Color3.fromRGB(24, 24, 36),
	ElementHover = Color3.fromRGB(32, 32, 48),
	ElementActive = Color3.fromRGB(40, 40, 60),
	
	-- Pink/Purple Gradient Accents (The Explosive Look)
	Primary = Color3.fromRGB(255, 0, 128),      -- Hot Pink
	Secondary = Color3.fromRGB(180, 0, 255),    -- Purple
	Accent = Color3.fromRGB(255, 50, 150),      -- Neon Pink
	
	Text = Color3.fromRGB(255, 255, 255),
	TextDim = Color3.fromRGB(160, 160, 180),
	TextDark = Color3.fromRGB(100, 100, 120),
	
	Glow = Color3.fromRGB(255, 0, 128),
	Border = Color3.fromRGB(40, 40, 60),
	
	-- Gradients
	HeaderGradient = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 128)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 0, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 200))
	}),
	
	CornerRadius = 4,
	AnimationSpeed = 0.2
}

-- Utility Functions
local function Create(instanceType, properties)
	local instance = Instance.new(instanceType)
	for prop, value in pairs(properties or {}) do
		instance[prop] = value
	end
	return instance
end

local function Tween(instance, properties, duration, style, direction)
	duration = duration or Theme.AnimationSpeed
	style = style or Enum.EasingStyle.Quad
	direction = direction or Enum.EasingDirection.Out
	
	local tween = TweenService:Create(instance, TweenInfo.new(duration, style, direction), properties)
	tween:Play()
	return tween
end

local function CreateGlow(parent, color, size)
	size = size or 20
	local glow = Create("ImageLabel", {
		Name = "Glow",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, size * 2, 1, size * 2),
		ZIndex = parent.ZIndex - 1,
		Image = "rbxassetid://6015897843",
		ImageColor3 = color or Theme.Glow,
		ImageTransparency = 0.7,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450),
		Parent = parent
	})
	return glow
end

local function CreateGradient(parent, colorSequence, rotation)
	local gradient = Create("UIGradient", {
		Color = colorSequence or Theme.HeaderGradient,
		Rotation = rotation or 0,
		Parent = parent
	})
	return gradient
end

-- Main UI Constructor
function Elysium.new()
	local self = setmetatable({}, Elysium)
	
	self.Flags = {}
	self.Tabs = {}
	self.CurrentTab = nil
	self.Open = false
	self.ScreenGui = nil
	self.MainFrame = nil
	
	self:Initialize()
	return self
end

function Elysium:Initialize()
	-- ScreenGui
	self.ScreenGui = Create("ScreenGui", {
		Name = "ElysiumUI",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent = LocalPlayer:WaitForChild("PlayerGui")
	})
	
	-- Main Container
	self.MainFrame = Create("Frame", {
		Name = "Main",
		Size = UDim2.fromOffset(900, 600),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Theme.Background,
		BorderSizePixel = 0,
		Visible = false,
		ClipsDescendants = true,
		Parent = self.ScreenGui
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, Theme.CornerRadius),
		Parent = self.MainFrame
	})
	
	-- Main Glow
	CreateGlow(self.MainFrame, Theme.Primary, 30)
	
	-- Create Layout
	self:CreateHeader()
	self:CreateSidebar()
	self:CreateContentArea()
	self:CreateTooltip()
	self:SetupInput()
	
	-- Show initial
	task.delay(0.5, function()
		self:Toggle(true)
	end)
end

function Elysium:CreateHeader()
	local header = Create("Frame", {
		Name = "Header",
		Size = UDim2.new(1, 0, 0, 50),
		BackgroundColor3 = Theme.Sidebar,
		BorderSizePixel = 0,
		Parent = self.MainFrame
	})
	
	-- Gradient Line
	local gradientLine = Create("Frame", {
		Size = UDim2.new(1, 0, 0, 2),
		Position = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Parent = header
	})
	CreateGradient(gradientLine, Theme.HeaderGradient)
	
	-- Title
	local title = Create("TextLabel", {
		Size = UDim2.new(0, 200, 1, 0),
		Position = UDim2.fromOffset(20, 0),
		BackgroundTransparency = 1,
		Text = "ELYSIUM",
		Font = Enum.Font.GothamBlack,
		TextSize = 24,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = header
	})
	
	-- Gradient Title
	CreateGradient(title)
	
	-- Build Info
	local build = Create("TextLabel", {
		Size = UDim2.new(0, 100, 0, 20),
		Position = UDim2.new(0, 20, 1, -25),
		BackgroundTransparency = 1,
		Text = "Build: 3.0.0",
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = Theme.TextDim,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = header
	})
	
	-- Page Counter
	self.PageCounter = Create("TextLabel", {
		Size = UDim2.new(0, 60, 0, 20),
		Position = UDim2.new(1, -80, 0, 15),
		BackgroundTransparency = 1,
		Text = "1/1",
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text,
		Parent = header
	})
	
	-- Close Button
	local closeBtn = Create("TextButton", {
		Size = UDim2.fromOffset(30, 30),
		Position = UDim2.new(1, -40, 0, 10),
		BackgroundColor3 = Theme.Element,
		Text = "×",
		Font = Enum.Font.GothamBold,
		TextSize = 20,
		TextColor3 = Theme.Text,
		Parent = header
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = closeBtn
	})
	
	closeBtn.MouseEnter:Connect(function()
		Tween(closeBtn, {BackgroundColor3 = Color3.fromRGB(200, 50, 50)})
	end)
	
	closeBtn.MouseLeave:Connect(function()
		Tween(closeBtn, {BackgroundColor3 = Theme.Element})
	end)
	
	closeBtn.MouseButton1Click:Connect(function()
		self:Toggle(false)
	end)
	
	self.Header = header
end

function Elysium:CreateSidebar()
	local sidebar = Create("Frame", {
		Name = "Sidebar",
		Size = UDim2.new(0, 200, 1, -50),
		Position = UDim2.fromOffset(0, 50),
		BackgroundColor3 = Theme.Sidebar,
		BorderSizePixel = 0,
		Parent = self.MainFrame
	})
	
	-- Tab Container
	local tabList = Create("ScrollingFrame", {
		Name = "TabList",
		Size = UDim2.new(1, -10, 1, -20),
		Position = UDim2.fromOffset(5, 10),
		BackgroundTransparency = 1,
		ScrollBarThickness = 2,
		ScrollBarImageColor3 = Theme.Primary,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Parent = sidebar
	})
	
	local listLayout = Create("UIListLayout", {
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = tabList
	})
	
	self.TabList = tabList
end

function Elysium:CreateContentArea()
	-- Content Background
	local content = Create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, -210, 1, -60),
		Position = UDim2.fromOffset(205, 55),
		BackgroundColor3 = Theme.Content,
		BorderSizePixel = 0,
		Parent = self.MainFrame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, Theme.CornerRadius),
		Parent = content
	})
	
	-- Options Container
	local optionsFrame = Create("ScrollingFrame", {
		Name = "Options",
		Size = UDim2.new(1, -20, 1, -20),
		Position = UDim2.fromOffset(10, 10),
		BackgroundTransparency = 1,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = Theme.Primary,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Parent = content
	})
	
	local optionsLayout = Create("UIListLayout", {
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = optionsFrame
	})
	
	-- Right Side Indicators (The Explosive Style)
	local indicatorBar = Create("Frame", {
		Name = "Indicators",
		Size = UDim2.new(0, 30, 1, -20),
		Position = UDim2.new(1, -35, 0, 10),
		BackgroundTransparency = 1,
		Parent = content
	})
	
	self.OptionsFrame = optionsFrame
	self.IndicatorBar = indicatorBar
	self.Content = content
end

function Elysium:CreateTooltip()
	self.Tooltip = Create("Frame", {
		Size = UDim2.fromOffset(200, 0),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 100,
		Parent = self.ScreenGui
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = self.Tooltip
	})
	
	CreateGlow(self.Tooltip, Theme.Primary, 10)
	
	local text = Create("TextLabel", {
		Name = "Text",
		Size = UDim2.new(1, -20, 1, -10),
		Position = UDim2.fromOffset(10, 5),
		BackgroundTransparency = 1,
		Text = "",
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = Theme.Text,
		TextWrapped = true,
		Parent = self.Tooltip
	})
	
	self.TooltipText = text
end

-- Tab System
function Elysium:AddTab(name, icon)
	local tabBtn = Create("TextButton", {
		Name = name .. "Tab",
		Size = UDim2.new(1, -10, 0, 40),
		BackgroundColor3 = Theme.Element,
		BackgroundTransparency = 1,
		Text = "",
		LayoutOrder = #self.Tabs,
		Parent = self.TabList
	})
	
	local corner = Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = tabBtn
	})
	
	-- Active Indicator (Left side pink bar)
	local indicator = Create("Frame", {
		Name = "Indicator",
		Size = UDim2.new(0, 3, 0.6, 0),
		Position = UDim2.fromOffset(0, 0.2),
		AnchorPoint = Vector2.new(0, 0),
		BackgroundColor3 = Theme.Primary,
		BorderSizePixel = 0,
		Visible = false,
		Parent = tabBtn
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = indicator
	})
	
	-- Icon
	if icon then
		local iconLabel = Create("ImageLabel", {
			Size = UDim2.fromOffset(20, 20),
			Position = UDim2.fromOffset(15, 10),
			BackgroundTransparency = 1,
			Image = icon,
			ImageColor3 = Theme.TextDim,
			Parent = tabBtn
		})
	end
	
	-- Label
	local label = Create("TextLabel", {
		Size = UDim2.new(1, -50, 1, 0),
		Position = UDim2.fromOffset(icon and 45 or 20, 0),
		BackgroundTransparency = 1,
		Text = name:upper(),
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = Theme.TextDim,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = tabBtn
	})
	
	-- Arrow
	local arrow = Create("ImageLabel", {
		Size = UDim2.fromOffset(16, 16),
		Position = UDim2.new(1, -26, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(964, 284),
		ImageRectSize = Vector2.new(36, 36),
		ImageColor3 = Theme.Primary,
		Visible = false,
		Parent = tabBtn
	})
	
	-- Page
	local page = Create("ScrollingFrame", {
		Name = name .. "Page",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ScrollBarThickness = 0,
		Visible = false,
		Parent = self.OptionsFrame
	})
	
	local pageLayout = Create("UIListLayout", {
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = page
	})
	
	-- Tab Logic
	tabBtn.MouseEnter:Connect(function()
		if self.CurrentTab ~= page then
			Tween(tabBtn, {BackgroundTransparency = 0.8})
			Tween(label, {TextColor3 = Theme.Text})
		end
	end)
	
	tabBtn.MouseLeave:Connect(function()
		if self.CurrentTab ~= page then
			Tween(tabBtn, {BackgroundTransparency = 1})
			Tween(label, {TextColor3 = Theme.TextDim})
		end
	end)
	
	tabBtn.MouseButton1Click:Connect(function()
		self:SelectTab(name)
	end)
	
	local tabData = {
		Name = name,
		Button = tabBtn,
		Page = page,
		Indicator = indicator,
		Arrow = arrow,
		Label = label,
		Elements = {}
	}
	
	table.insert(self.Tabs, tabData)
	
	-- Auto select first
	if #self.Tabs == 1 then
		task.delay(0.1, function()
			self:SelectTab(name)
		end)
	end
	
	return page, tabData
end

function Elysium:SelectTab(name)
	for _, tab in ipairs(self.Tabs) do
		if tab.Name == name then
			-- Show
			tab.Page.Visible = true
			self.CurrentTab = tab.Page
			
			Tween(tab.Button, {BackgroundTransparency = 0.6})
			Tween(tab.Label, {TextColor3 = Theme.Primary})
			tab.Indicator.Visible = true
			tab.Arrow.Visible = true
			
			-- Glow effect
			CreateGlow(tab.Button, Theme.Primary, 15)
			
			-- Update counter
			self.PageCounter.Text = tostring(table.find(self.Tabs, tab)) .. "/" .. tostring(#self.Tabs)
			
		else
			-- Hide
			tab.Page.Visible = false
			Tween(tab.Button, {BackgroundTransparency = 1})
			Tween(tab.Label, {TextColor3 = Theme.TextDim})
			tab.Indicator.Visible = false
			tab.Arrow.Visible = false
			
			-- Remove glow
			local glow = tab.Button:FindFirstChild("Glow")
			if glow then glow:Destroy() end
		end
	end
end

-- Component Creation
function Elysium:CreateButton(parent, text, callback, description)
	local btn = Create("TextButton", {
		Size = UDim2.new(1, -40, 0, 45),
		BackgroundColor3 = Theme.Element,
		Text = "",
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = btn
	})
	
	-- Left accent line
	local accent = Create("Frame", {
		Size = UDim2.new(0, 2, 0.7, 0),
		Position = UDim2.fromOffset(0, 0.15),
		BackgroundColor3 = Theme.Primary,
		BorderSizePixel = 0,
		Parent = btn
	})
	
	local label = Create("TextLabel", {
		Size = UDim2.new(1, -60, 1, 0),
		Position = UDim2.fromOffset(15, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = btn
	})
	
	-- Arrow indicator
	local arrow = Create("ImageLabel", {
		Size = UDim2.fromOffset(20, 20),
		Position = UDim2.new(1, -30, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(964, 284),
		ImageRectSize = Vector2.new(36, 36),
		ImageColor3 = Theme.Primary,
		Parent = btn
	})
	
	-- Hover Effects
	btn.MouseEnter:Connect(function()
		Tween(btn, {BackgroundColor3 = Theme.ElementHover})
		Tween(accent, {BackgroundColor3 = Theme.Secondary})
		self:ShowTooltip(description, btn)
	end)
	
	btn.MouseLeave:Connect(function()
		Tween(btn, {BackgroundColor3 = Theme.Element})
		Tween(accent, {BackgroundColor3 = Theme.Primary})
		self:HideTooltip()
	end)
	
	btn.MouseButton1Click:Connect(function()
		Tween(btn, {BackgroundColor3 = Theme.ElementActive}, 0.1)
		task.delay(0.1, function()
			Tween(btn, {BackgroundColor3 = Theme.ElementHover}, 0.1)
		end)
		if callback then callback() end
	end)
	
	return btn
end

function Elysium:CreateToggle(parent, text, flag, default, callback)
	default = default or false
	self.Flags[flag] = default
	
	local frame = Create("Frame", {
		Size = UDim2.new(1, -40, 0, 45),
		BackgroundColor3 = Theme.Element,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = frame
	})
	
	-- Status indicator (left side)
	local status = Create("Frame", {
		Size = UDim2.new(0, 3, 0.7, 0),
		Position = UDim2.fromOffset(0, 0.15),
		BackgroundColor3 = default and Theme.Primary or Theme.Border,
		BorderSizePixel = 0,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = status
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
	
	-- Toggle Switch
	local switch = Create("Frame", {
		Size = UDim2.fromOffset(50, 26),
		Position = UDim2.new(1, -65, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = default and Theme.Primary or Color3.fromRGB(60, 60, 80),
		BorderSizePixel = 0,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = switch
	})
	
	-- Glow when on
	if default then
		CreateGlow(switch, Theme.Primary, 10)
	end
	
	-- Knob
	local knob = Create("Frame", {
		Size = UDim2.fromOffset(20, 20),
		Position = UDim2.new(0, default and 28 or 2, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Parent = switch
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = knob
	})
	
	-- Click area
	local click = Create("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "",
		Parent = frame
	})
	
	local function update_state(state)
		self.Flags[flag] = state
		Tween(status, {BackgroundColor3 = state and Theme.Primary or Theme.Border})
		Tween(switch, {BackgroundColor3 = state and Theme.Primary or Color3.fromRGB(60, 60, 80)})
		Tween(knob, {Position = UDim2.new(0, state and 28 or 2, 0.5, 0)})
		
		-- Handle glow
		local glow = switch:FindFirstChild("Glow")
		if state and not glow then
			CreateGlow(switch, Theme.Primary, 10)
		elseif not state and glow then
			glow:Destroy()
		end
		
		if callback then callback(state) end
	end
	
	click.MouseButton1Click:Connect(function()
		update_state(not self.Flags[flag])
	end)
	
	frame.MouseEnter:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.ElementHover})
	end)
	
	frame.MouseLeave:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.Element})
	end)
	
	return frame, update_state
end

function Elysium:CreateSlider(parent, text, min, max, default, decimals, flag, callback)
	default = default or min
	decimals = decimals or 0
	self.Flags[flag] = default
	
	local frame = Create("Frame", {
		Size = UDim2.new(1, -40, 0, 60),
		BackgroundColor3 = Theme.Element,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = frame
	})
	
	-- Label
	local label = Create("TextLabel", {
		Size = UDim2.new(1, -100, 0, 25),
		Position = UDim2.fromOffset(15, 5),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame
	})
	
	-- Value Box
	local valueBox = Create("TextLabel", {
		Size = UDim2.fromOffset(70, 25),
		Position = UDim2.new(1, -85, 0, 5),
		BackgroundColor3 = Theme.Background,
		Text = tostring(default),
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = Theme.Primary,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = valueBox
	})
	
	-- Slider Track
	local track = Create("Frame", {
		Size = UDim2.new(1, -30, 0, 8),
		Position = UDim2.fromOffset(15, 38),
		BackgroundColor3 = Color3.fromRGB(40, 40, 60),
		BorderSizePixel = 0,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = track
	})
	
	-- Fill
	local fill = Create("Frame", {
		Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
		BackgroundColor3 = Theme.Primary,
		BorderSizePixel = 0,
		Parent = track
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = fill
	})
	
	-- Knob
	local knob = Create("Frame", {
		Size = UDim2.fromOffset(16, 16),
		Position = UDim2.new((default - min) / (max - min), -8, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = track
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = knob
	})
	
	-- Glow
	CreateGlow(knob, Theme.Primary, 8)
	
	-- Logic
	local dragging = false
	
	local function update(input)
		local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		local value = min + (max - min) * pos
		
		if decimals == 0 then
			value = math.floor(value)
		else
			value = math.floor(value * (10 ^ decimals)) / (10 ^ decimals)
		end
		
		self.Flags[flag] = value
		valueBox.Text = tostring(value)
		fill.Size = UDim2.new(pos, 0, 1, 0)
		knob.Position = UDim2.new(pos, -8, 0.5, 0)
		
		if callback then callback(value) end
	end
	
	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			update(input)
		end
	end)
	
	knob.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input)
		end
	end)
	
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
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

function Elysium:CreateDropdown(parent, text, options, default, flag, callback)
	default = default or options[1]
	self.Flags[flag] = default
	
	local frame = Create("Frame", {
		Size = UDim2.new(1, -40, 0, 45),
		BackgroundColor3 = Theme.Element,
		ClipsDescendants = true,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = frame
	})
	
	-- Label
	local label = Create("TextLabel", {
		Size = UDim2.new(1, -150, 1, 0),
		Position = UDim2.fromOffset(15, 0),
		BackgroundTransparency = 1,
		Text = text .. ":",
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame
	})
	
	-- Selected Value
	local valueBtn = Create("TextButton", {
		Size = UDim2.fromOffset(120, 35),
		Position = UDim2.new(1, -135, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.Background,
		Text = default,
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = Theme.Primary,
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = valueBtn
	})
	
	-- Arrow
	local arrow = Create("ImageLabel", {
		Size = UDim2.fromOffset(16, 16),
		Position = UDim2.new(1, -25, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(964, 284),
		ImageRectSize = Vector2.new(36, 36),
		ImageColor3 = Theme.Primary,
		Parent = valueBtn
	})
	
	-- Options Container
	local optionsFrame = Create("Frame", {
		Size = UDim2.new(1, -30, 0, #options * 35),
		Position = UDim2.fromOffset(15, 50),
		BackgroundTransparency = 1,
		Visible = false,
		Parent = frame
	})
	
	local optionsList = Create("UIListLayout", {
		Padding = UDim.new(0, 4),
		Parent = optionsFrame
	})
	
	local isOpen = false
	
	local function toggle()
		isOpen = not isOpen
		Tween(arrow, {Rotation = isOpen and 180 or 0})
		Tween(frame, {Size = UDim2.new(1, -40, 0, isOpen and 50 + #options * 35 or 45)})
		optionsFrame.Visible = isOpen
	end
	
	for i, option in ipairs(options) do
		local optBtn = Create("TextButton", {
			Size = UDim2.new(1, 0, 0, 35),
			BackgroundColor3 = Theme.Background,
			Text = option,
			Font = Enum.Font.Gotham,
			TextSize = 13,
			TextColor3 = Theme.TextDim,
			Parent = optionsFrame
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 4),
			Parent = optBtn
		})
		
		optBtn.MouseEnter:Connect(function()
			Tween(optBtn, {BackgroundColor3 = Theme.ElementHover, TextColor3 = Theme.Text})
		end)
		
		optBtn.MouseLeave:Connect(function()
			Tween(optBtn, {BackgroundColor3 = Theme.Background, TextColor3 = Theme.TextDim})
		end)
		
		optBtn.MouseButton1Click:Connect(function()
			self.Flags[flag] = option
			valueBtn.Text = option
			toggle()
			if callback then callback(option) end
		end)
	end
	
	valueBtn.MouseButton1Click:Connect(toggle)
	
	frame.MouseEnter:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.ElementHover})
	end)
	
	frame.MouseLeave:Connect(function()
		if not isOpen then
			Tween(frame, {BackgroundColor3 = Theme.Element})
		end
	end)
	
	return frame
end

function Elysium:CreateKeybind(parent, text, defaultKey, flag, callback)
	self.Flags[flag] = defaultKey
	
	local frame = Create("Frame", {
		Size = UDim2.new(1, -40, 0, 45),
		BackgroundColor3 = Theme.Element,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = frame
	})
	
	-- Label
	local label = Create("TextLabel", {
		Size = UDim2.new(1, -100, 1, 0),
		Position = UDim2.fromOffset(15, 0),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame
	})
	
	-- Key Button
	local keyBtn = Create("TextButton", {
		Size = UDim2.fromOffset(80, 35),
		Position = UDim2.new(1, -95, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Theme.Primary,
		Text = defaultKey and defaultKey.Name or "None",
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = keyBtn
	})
	
	CreateGlow(keyBtn, Theme.Primary, 8)
	
	local listening = false
	
	keyBtn.MouseButton1Click:Connect(function()
		listening = true
		keyBtn.Text = "..."
		Tween(keyBtn, {BackgroundColor3 = Theme.Secondary})
	end)
	
	UserInputService.InputBegan:Connect(function(input)
		if listening and input.UserInputType == Enum.UserInputType.Keyboard then
			listening = false
			self.Flags[flag] = input.KeyCode
			keyBtn.Text = input.KeyCode.Name
			Tween(keyBtn, {BackgroundColor3 = Theme.Primary})
			if callback then callback(input.KeyCode) end
		elseif input.KeyCode == self.Flags[flag] and not listening then
			if callback then callback(input.KeyCode) end
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

-- Sub-Menu (Category Headers like in Explosive)
function Elysium:CreateCategory(parent, name)
	local category = Create("Frame", {
		Size = UDim2.new(1, -40, 0, 35),
		BackgroundTransparency = 1,
		Parent = parent
	})
	
	-- Pink left bar
	local bar = Create("Frame", {
		Size = UDim2.new(0, 3, 0.8, 0),
		Position = UDim2.fromOffset(0, 0.1),
		BackgroundColor3 = Theme.Primary,
		BorderSizePixel = 0,
		Parent = category
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = bar
	})
	
	local label = Create("TextLabel", {
		Size = UDim2.new(1, -20, 1, 0),
		Position = UDim2.fromOffset(15, 0),
		BackgroundTransparency = 1,
		Text = name:upper(),
		Font = Enum.Font.GothamBlack,
		TextSize = 16,
		TextColor3 = Theme.Primary,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = category
	})
	
	CreateGradient(label, Theme.HeaderGradient)
	
	return category
end

-- Color Picker
function Elysium:CreateColorPicker(parent, text, default, flag, callback)
	default = default or Color3.fromRGB(255, 0, 128)
	self.Flags[flag] = default
	
	local frame = Create("Frame", {
		Size = UDim2.new(1, -40, 0, 45),
		BackgroundColor3 = Theme.Element,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
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
	
	-- Color Display
	local colorDisplay = Create("TextButton", {
		Size = UDim2.fromOffset(50, 30),
		Position = UDim2.new(1, -65, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = default,
		Text = "",
		Parent = frame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = colorDisplay
	})
	
	CreateGlow(colorDisplay, default, 8)
	
	-- Color Picker Popup
	local pickerOpen = false
	local picker = Create("Frame", {
		Size = UDim2.fromOffset(220, 200),
		Position = UDim2.new(0, frame.AbsolutePosition.X, 0, frame.AbsolutePosition.Y + 50),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 50,
		Parent = self.ScreenGui
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = picker
	})
	
	CreateGlow(picker, Theme.Primary, 15)
	
	-- Saturation/Value Box
	local svBox = Create("ImageButton", {
		Size = UDim2.fromOffset(180, 150),
		Position = UDim2.fromOffset(10, 10),
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
		Size = UDim2.fromOffset(20, 150),
		Position = UDim2.fromOffset(195, 10),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Image = "rbxassetid://3641079629",
		ImageColor3 = Color3.fromRGB(255, 255, 255),
		Parent = picker
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = hueSlider
	})
	
	-- Color Indicator
	local indicator = Create("Frame", {
		Size = UDim2.fromOffset(8, 8),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 2,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		ZIndex = 51,
		Parent = svBox
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = indicator
	})
	
	local h, s, v = default:ToHSV()
	
	local function updateColor()
		local color = Color3.fromHSV(h, s, v)
		self.Flags[flag] = color
		colorDisplay.BackgroundColor3 = color
		svBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
		
		local glow = colorDisplay:FindFirstChild("Glow")
		if glow then glow.ImageColor3 = color end
		
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
		indicator.Position = UDim2.new(posX, -4, posY, -4)
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
	
	-- Toggle Picker
	colorDisplay.MouseButton1Click:Connect(function()
		pickerOpen = not pickerOpen
		picker.Visible = pickerOpen
		picker.Position = UDim2.fromOffset(
			frame.AbsolutePosition.X - 220,
			frame.AbsolutePosition.Y + 50
		)
	end)
	
	frame.MouseEnter:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.ElementHover})
	end)
	
	frame.MouseLeave:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.Element})
	end)
	
	return frame
end

-- Search Box
function Elysium:CreateSearch(parent, placeholder, callback)
	local frame = Create("Frame", {
		Size = UDim2.new(1, -40, 0, 45),
		BackgroundColor3 = Theme.Element,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = frame
	})
	
	-- Search Icon
	local icon = Create("ImageLabel", {
		Size = UDim2.fromOffset(20, 20),
		Position = UDim2.fromOffset(15, 12.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(964, 324),
		ImageRectSize = Vector2.new(36, 36),
		ImageColor3 = Theme.Primary,
		Parent = frame
	})
	
	-- Text Box
	local textBox = Create("TextBox", {
		Size = UDim2.new(1, -90, 1, 0),
		Position = UDim2.fromOffset(45, 0),
		BackgroundTransparency = 1,
		PlaceholderText = placeholder or "Search...",
		PlaceholderColor3 = Theme.TextDark,
		Text = "",
		Font = Enum.Font.Gotham,
		TextSize = 14,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Parent = frame
	})
	
	-- Clear Button
	local clearBtn = Create("TextButton", {
		Size = UDim2.fromOffset(30, 30),
		Position = UDim2.new(1, -40, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = "×",
		Font = Enum.Font.GothamBold,
		TextSize = 20,
		TextColor3 = Theme.TextDim,
		Visible = false,
		Parent = frame
	})
	
	textBox:GetPropertyChangedSignal("Text"):Connect(function()
		clearBtn.Visible = textBox.Text ~= ""
		if callback then callback(textBox.Text) end
	end)
	
	clearBtn.MouseButton1Click:Connect(function()
		textBox.Text = ""
	end)
	
	clearBtn.MouseEnter:Connect(function()
		Tween(clearBtn, {TextColor3 = Theme.Primary})
	end)
	
	clearBtn.MouseLeave:Connect(function()
		Tween(clearBtn, {TextColor3 = Theme.TextDim})
	end)
	
	frame.MouseEnter:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.ElementHover})
	end)
	
	frame.MouseLeave:Connect(function()
		Tween(frame, {BackgroundColor3 = Theme.Element})
	end)
	
	return textBox
end

-- Player List
function Elysium:CreatePlayerList(parent)
	local frame = Create("Frame", {
		Size = UDim2.new(1, -40, 1, -20),
		BackgroundColor3 = Theme.Element,
		Parent = parent
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = frame
	})
	
	-- Search
	local searchBox = self:CreateSearch(frame, "Search players...")
	searchBox.Parent.Size = UDim2.new(1, -20, 0, 40)
	searchBox.Parent.Position = UDim2.fromOffset(10, 10)
	
	-- Player List
	local listFrame = Create("ScrollingFrame", {
		Size = UDim2.new(1, -20, 1, -65),
		Position = UDim2.fromOffset(10, 55),
		BackgroundTransparency = 1,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = Theme.Primary,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Parent = frame
	})
	
	local listLayout = Create("UIListLayout", {
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.Name,
		Parent = listFrame
	})
	
	local function createPlayerEntry(player)
		local entry = Create("Frame", {
			Name = player.Name,
			Size = UDim2.new(1, -10, 0, 50),
			BackgroundColor3 = Theme.Background,
			Parent = listFrame
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 4),
			Parent = entry
		})
		
		-- Avatar
		local avatar = Create("ImageLabel", {
			Size = UDim2.fromOffset(40, 40),
			Position = UDim2.fromOffset(5, 5),
			BackgroundColor3 = Theme.Element,
			Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48),
			Parent = entry
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 4),
			Parent = avatar
		})
		
		-- Name
		local nameLabel = Create("TextLabel", {
			Size = UDim2.new(1, -130, 0, 20),
			Position = UDim2.fromOffset(50, 5),
			BackgroundTransparency = 1,
			Text = player.Name,
			Font = Enum.Font.GothamBold,
			TextSize = 13,
			TextColor3 = Theme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = entry
		})
		
		-- Display Name
		local displayLabel = Create("TextLabel", {
			Size = UDim2.new(1, -130, 0, 18),
			Position = UDim2.fromOffset(50, 25),
			BackgroundTransparency = 1,
			Text = "@" .. player.DisplayName,
			Font = Enum.Font.Gotham,
			TextSize = 11,
			TextColor3 = Theme.TextDim,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = entry
		})
		
		-- Actions
		local teleportBtn = Create("TextButton", {
			Size = UDim2.fromOffset(60, 35),
			Position = UDim2.new(1, -70, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Theme.Primary,
			Text = "TP",
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Parent = entry
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 4),
			Parent = teleportBtn
		})
		
		teleportBtn.MouseEnter:Connect(function()
			Tween(teleportBtn, {BackgroundColor3 = Theme.Secondary})
		end)
		
		teleportBtn.MouseLeave:Connect(function()
			Tween(teleportBtn, {BackgroundColor3 = Theme.Primary})
		end)
		
		teleportBtn.MouseButton1Click:Connect(function()
			if player.Character and LocalPlayer.Character then
				LocalPlayer.Character:SetPrimaryPartCFrame(player.Character.PrimaryPart.CFrame)
			end
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
	
	return frame
end

-- Tooltip System
function Elysium:ShowTooltip(text, parent)
	if not text then return end
	self.TooltipText.Text = text
	self.Tooltip.Size = UDim2.fromOffset(200, 0)
	
	-- Measure text
	local textBounds = game:GetService("TextService"):GetTextSize(
		text, 12, Enum.Font.Gotham, Vector2.new(180, 1000)
	)
	
	self.Tooltip.Size = UDim2.fromOffset(200, textBounds.Y + 20)
	self.Tooltip.Visible = true
	
	-- Position near mouse or parent
	local pos = parent.AbsolutePosition
	self.Tooltip.Position = UDim2.fromOffset(pos.X + parent.AbsoluteSize.X + 10, pos.Y)
end

function Elysium:HideTooltip()
	self.Tooltip.Visible = false
end

-- Window Controls
function Elysium:Toggle(state)
	self.Open = state
	self.MainFrame.Visible = true
	
	if state then
		Tween(self.MainFrame, {Size = UDim2.fromOffset(900, 600)}, 0.3, Enum.EasingStyle.Back)
	else
		Tween(self.MainFrame, {Size = UDim2.fromOffset(900, 0)}, 0.2).Completed:Connect(function()
			if not self.Open then
				self.MainFrame.Visible = false
			end
		end)
	end
end

-- Input Handling
function Elysium:SetupInput()
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		
		if input.KeyCode == Enum.KeyCode.Insert then
			self:Toggle(not self.Open)
		elseif input.KeyCode == Enum.KeyCode.Delete then
			self.ScreenGui:Destroy()
		end
	end)
	
	-- Dragging
	local dragging = false
	local dragStart = nil
	local startPos = nil
	
	self.Header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = self.MainFrame.Position
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			self.MainFrame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
	
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
end

-- Notification System
function Elysium:Notify(title, message, type, duration)
	type = type or "info"
	duration = duration or 3
	
	local colors = {
		info = Theme.Primary,
		success = Color3.fromRGB(0, 255, 128),
		warning = Color3.fromRGB(255, 200, 0),
		error = Color3.fromRGB(255, 50, 50)
	}
	
	local notif = Create("Frame", {
		Size = UDim2.fromOffset(300, 80),
		Position = UDim2.new(1, 320, 1, -100),
		BackgroundColor3 = Theme.Element,
		BorderSizePixel = 0,
		Parent = self.ScreenGui
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 4),
		Parent = notif
	})
	
	CreateGlow(notif, colors[type], 15)
	
	-- Accent line
	local accent = Create("Frame", {
		Size = UDim2.new(0, 3, 0.8, 0),
		Position = UDim2.fromOffset(0, 0.1),
		BackgroundColor3 = colors[type],
		BorderSizePixel = 0,
		Parent = notif
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = accent
	})
	
	local titleLabel = Create("TextLabel", {
		Size = UDim2.new(1, -30, 0, 25),
		Position = UDim2.fromOffset(15, 8),
		BackgroundTransparency = 1,
		Text = title,
		Font = Enum.Font.GothamBlack,
		TextSize = 16,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = notif
	})
	
	local msgLabel = Create("TextLabel", {
		Size = UDim2.new(1, -30, 0, 40),
		Position = UDim2.fromOffset(15, 35),
		BackgroundTransparency = 1,
		Text = message,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = Theme.TextDim,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		Parent = notif
	})
	
	-- Slide in
	Tween(notif, {Position = UDim2.new(1, -320, 1, -100)}, 0.3, Enum.EasingStyle.Back)
	
	-- Progress bar
	local progress = Create("Frame", {
		Size = UDim2.new(1, 0, 0, 2),
		Position = UDim2.new(0, 0, 1, -2),
		BackgroundColor3 = colors[type],
		BorderSizePixel = 0,
		Parent = notif
	})
	
	Tween(progress, {Size = UDim2.new(0, 0, 0, 2)}, duration)
	
	task.delay(duration, function()
		Tween(notif, {Position = UDim2.new(1, 320, 1, -100)}, 0.3).Completed:Connect(function()
			notif:Destroy()
		end)
	end)
end

-- Config System
function Elysium:SaveConfig(name)
	local config = {}
	for flag, value in pairs(self.Flags) do
		if typeof(value) == "Color3" then
			config[flag] = {r = value.R, g = value.G, b = value.B}
		elseif typeof(value) == "EnumItem" then
			config[flag] = tostring(value)
		else
			config[flag] = value
		end
	end
	print("[Elysium] Config saved:", name)
	return HttpService:JSONEncode(config)
end

function Elysium:LoadConfig(configString)
	local success, config = pcall(function()
		return HttpService:JSONDecode(configString)
	end)
	
	if not success then
		warn("[Elysium] Failed to load config")
		return
	end
	
	for flag, value in pairs(config) do
		if typeof(value) == "table" and value.r then
			self.Flags[flag] = Color3.new(value.r, value.g, value.b)
		else
			self.Flags[flag] = value
		end
	end
	print("[Elysium] Config loaded successfully")
end

-- ========================================
-- UTILITY LIBRARIES
-- ========================================

-- Math Library
Elysium.Math = {}

function Elysium.Math:WorldToScreen(position)
	local camera = workspace.CurrentCamera
	local screenPos, onScreen = camera:WorldToViewportPoint(position)
	return Vector2.new(screenPos.X, screenPos.Y), onScreen, screenPos.Z
end

function Elysium.Math:GetDistance(from, to)
	if typeof(from) == "Instance" then
		from = from.Position
	end
	if typeof(to) == "Instance" then
		to = to.Position
	end
	return (from - to).Magnitude
end

function Elysium.Math:GetClosestPlayer(maxDistance)
	maxDistance = maxDistance or math.huge
	local closestPlayer = nil
	local shortestDistance = maxDistance
	
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				local distance = self:GetDistance(LocalPlayer.Character.HumanoidRootPart.Position, humanoidRootPart.Position)
				if distance < shortestDistance then
					shortestDistance = distance
					closestPlayer = player
				end
			end
		end
	end
	
	return closestPlayer, shortestDistance
end

function Elysium.Math:GetClosestPlayerToMouse(maxDistance, fov)
	maxDistance = maxDistance or math.huge
	fov = fov or 360
	local closestPlayer = nil
	local shortestDistance = maxDistance
	local mousePos = UserInputService:GetMouseLocation()
	
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local head = player.Character:FindFirstChild("Head")
			if head then
				local screenPos, onScreen = self:WorldToScreen(head.Position)
				if onScreen then
					local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
					if distance < shortestDistance and distance <= fov then
						shortestDistance = distance
						closestPlayer = player
					end
				end
			end
		end
	end
	
	return closestPlayer, shortestDistance
end

function Elysium.Math:CalculateLeadPosition(targetPosition, targetVelocity, projectileSpeed)
	local distance = self:GetDistance(LocalPlayer.Character.HumanoidRootPart.Position, targetPosition)
	local timeToHit = distance / projectileSpeed
	return targetPosition + (targetVelocity * timeToHit)
end

function Elysium.Math:PredictPosition(character, predictionAmount)
	predictionAmount = predictionAmount or 0.1
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if rootPart then
		local velocity = rootPart.AssemblyLinearVelocity or rootPart.Velocity
		return rootPart.Position + (velocity * predictionAmount)
	end
	return nil
end

-- Wallcheck/Raycast Library
Elysium.Wallcheck = {}

function Elysium.Wallcheck:IsVisible(targetPosition, ignoreList)
	if not LocalPlayer.Character then return false end
	
	local camera = workspace.CurrentCamera
	local origin = camera.CFrame.Position
	
	ignoreList = ignoreList or {LocalPlayer.Character, camera}
	
	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = ignoreList
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.IgnoreWater = true
	
	local direction = (targetPosition - origin)
	local raycastResult = workspace:Raycast(origin, direction, raycastParams)
	
	return raycastResult == nil or raycastResult.Distance >= direction.Magnitude - 0.5
end

function Elysium.Wallcheck:IsPlayerVisible(player)
	if not player.Character then return false end
	
	local head = player.Character:FindFirstChild("Head")
	local torso = player.Character:FindFirstChild("HumanoidRootPart")
	
	if head and self:IsVisible(head.Position, {LocalPlayer.Character, player.Character}) then
		return true
	end
	
	if torso and self:IsVisible(torso.Position, {LocalPlayer.Character, player.Character}) then
		return true
	end
	
	return false
end

function Elysium.Wallcheck:GetVisiblePlayers()
	local visiblePlayers = {}
	
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and self:IsPlayerVisible(player) then
			table.insert(visiblePlayers, player)
		end
	end
	
	return visiblePlayers
end

function Elysium.Wallcheck:CanHit(origin, target, ignoreList)
	ignoreList = ignoreList or {LocalPlayer.Character}
	
	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = ignoreList
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.IgnoreWater = true
	
	local direction = (target - origin)
	local raycastResult = workspace:Raycast(origin, direction, raycastParams)
	
	return raycastResult ~= nil, raycastResult
end

-- ESP/Drawing Library
Elysium.ESP = {}
Elysium.ESP.Objects = {}

function Elysium.ESP:CreateBox(player)
	local box = {
		Player = player,
		Drawings = {}
	}
	
	-- Create 4 lines for box outline
	for i = 1, 4 do
		local line = Drawing.new("Line")
		line.Thickness = 2
		line.Color = Color3.fromRGB(255, 0, 128)
		line.Visible = false
		table.insert(box.Drawings, line)
	end
	
	-- Name text
	local nameText = Drawing.new("Text")
	nameText.Size = 14
	nameText.Center = true
	nameText.Outline = true
	nameText.Color = Color3.fromRGB(255, 255, 255)
	nameText.Visible = false
	nameText.Text = player.Name
	box.NameText = nameText
	
	-- Distance text
	local distText = Drawing.new("Text")
	distText.Size = 12
	distText.Center = true
	distText.Outline = true
	distText.Color = Color3.fromRGB(200, 200, 200)
	distText.Visible = false
	box.DistText = distText
	
	-- Health bar
	local healthBar = Drawing.new("Line")
	healthBar.Thickness = 3
	healthBar.Color = Color3.fromRGB(0, 255, 0)
	healthBar.Visible = false
	box.HealthBar = healthBar
	
	self.Objects[player] = box
	return box
end

function Elysium.ESP:UpdateBox(box)
	local player = box.Player
	if not player or not player.Character then
		self:RemoveBox(player)
		return
	end
	
	local character = player.Character
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChild("Humanoid")
	
	if not rootPart or not humanoid then
		self:RemoveBox(player)
		return
	end
	
	local camera = workspace.CurrentCamera
	local rootPos = rootPart.Position
	local headOffset = Vector3.new(0, 2, 0)
	local legOffset = Vector3.new(0, -3, 0)
	
	local topPos, topOnScreen = Elysium.Math:WorldToScreen(rootPos + headOffset)
	local bottomPos, bottomOnScreen = Elysium.Math:WorldToScreen(rootPos + legOffset)
	
	if topOnScreen and bottomOnScreen then
		local height = (bottomPos - topPos).Y
		local width = height / 2
		
		-- Update box lines
		local lines = box.Drawings
		lines[1].From = Vector2.new(topPos.X - width/2, topPos.Y)
		lines[1].To = Vector2.new(topPos.X + width/2, topPos.Y)
		lines[1].Visible = true
		
		lines[2].From = Vector2.new(topPos.X + width/2, topPos.Y)
		lines[2].To = Vector2.new(bottomPos.X + width/2, bottomPos.Y)
		lines[2].Visible = true
		
		lines[3].From = Vector2.new(bottomPos.X + width/2, bottomPos.Y)
		lines[3].To = Vector2.new(bottomPos.X - width/2, bottomPos.Y)
		lines[3].Visible = true
		
		lines[4].From = Vector2.new(bottomPos.X - width/2, bottomPos.Y)
		lines[4].To = Vector2.new(topPos.X - width/2, topPos.Y)
		lines[4].Visible = true
		
		-- Update name
		box.NameText.Position = Vector2.new(topPos.X, topPos.Y - 20)
		box.NameText.Visible = true
		
		-- Update distance
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local distance = Elysium.Math:GetDistance(LocalPlayer.Character.HumanoidRootPart.Position, rootPos)
			box.DistText.Text = string.format("%.0f studs", distance)
			box.DistText.Position = Vector2.new(bottomPos.X, bottomPos.Y + 5)
			box.DistText.Visible = true
		end
		
		-- Update health bar
		local healthPercent = humanoid.Health / humanoid.MaxHealth
		box.HealthBar.From = Vector2.new(topPos.X - width/2 - 6, topPos.Y)
		box.HealthBar.To = Vector2.new(topPos.X - width/2 - 6, topPos.Y + (height * healthPercent))
		box.HealthBar.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
		box.HealthBar.Visible = true
	else
		-- Hide if not on screen
		for _, line in ipairs(box.Drawings) do
			line.Visible = false
		end
		box.NameText.Visible = false
		box.DistText.Visible = false
		box.HealthBar.Visible = false
	end
end

function Elysium.ESP:RemoveBox(player)
	local box = self.Objects[player]
	if box then
		for _, drawing in ipairs(box.Drawings) do
			drawing:Remove()
		end
		if box.NameText then box.NameText:Remove() end
		if box.DistText then box.DistText:Remove() end
		if box.HealthBar then box.HealthBar:Remove() end
		self.Objects[player] = nil
	end
end

function Elysium.ESP:EnableAll()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			if not self.Objects[player] then
				self:CreateBox(player)
			end
		end
	end
	
	Players.PlayerAdded:Connect(function(player)
		self:CreateBox(player)
	end)
	
	Players.PlayerRemoving:Connect(function(player)
		self:RemoveBox(player)
	end)
	
	RunService.RenderStepped:Connect(function()
		for player, box in pairs(self.Objects) do
			self:UpdateBox(box)
		end
	end)
end

function Elysium.ESP:DisableAll()
	for player, _ in pairs(self.Objects) do
		self:RemoveBox(player)
	end
end

return Elysium
