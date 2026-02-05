-- ElyESP Library

local ElyESP = {}
ElyESP.__index = ElyESP

local services = {
	players = game:GetService("Players"),
	run_service = game:GetService("RunService"),
	workspace = game:GetService("Workspace")
}

local local_player = services.players.LocalPlayer
local camera = services.workspace.CurrentCamera

local defaults = {
	enabled = true,
	team_check = false,
	max_distance = 3000,
	update_rate = 0,
	max_players_drawn = 0,
	box_fill_panels = false,

	box_2d = true,
	corner_box = false,
	box_3d = false,
	wire_box_3d = false,
	skeleton = false,
	chams = false,
	glow = false,
	highlight = true,
	fill_box = false,
	box_outline = true,
	gradient_box = false,
	direction = false,

	name = true,
	health = true,
	distance = true,
	weapon = false,
	velocity = false,

	snaplines = false,
	snapline_from = "bottom",
	tracers = false,
	tracer_from = "bottom",
	out_of_view = true,
	arrows = true,

	rainbow = false,
	use_billboard = false,
	text_size = 12,

	box_color = Color3.fromRGB(200, 200, 200),
	corner_color = Color3.fromRGB(200, 200, 200),
	fill_color = Color3.fromRGB(200, 200, 200),
	text_color = Color3.fromRGB(240, 240, 240),
	tracer_color = Color3.fromRGB(200, 200, 200),
	arrow_color = Color3.fromRGB(200, 200, 200),
	snapline_color = Color3.fromRGB(200, 200, 200),
	chams_color = Color3.fromRGB(200, 200, 200),
	highlight_fill = Color3.fromRGB(200, 200, 200),
	highlight_outline = Color3.fromRGB(90, 90, 90),
	health_color = Color3.fromRGB(90, 220, 110),
	velocity_color = Color3.fromRGB(140, 170, 230),
	team_color = false,
	weapon_colors = {}
}

local function clamp(value, min_value, max_value)
	if value < min_value then
		return min_value
	end
	if value > max_value then
		return max_value
	end
	return value
end

local function get_rainbow_color()
	local t = tick() * 0.2
	return Color3.fromHSV(t % 1, 1, 1)
end

local function is_alive(player)
	local character = player.Character
	if not character then
		return false
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	return humanoid and humanoid.Health > 0
end

local function get_root(character)
	return character and character:FindFirstChild("HumanoidRootPart")
end

local function get_distance(character)
	local root = get_root(character)
	if not root then
		return math.huge
	end
	return (camera.CFrame.Position - root.Position).Magnitude
end

local function get_tool_name(character)
	if not character then
		return ""
	end
	local tool = character:FindFirstChildOfClass("Tool")
	return tool and tool.Name or ""
end

local function get_weapon_color(config, tool_name)
	if config.weapon_colors and config.weapon_colors[tool_name] then
		return config.weapon_colors[tool_name]
	end
	if tool_name == "" then
		return config.text_color
	end
	local hash = 0
	for i = 1, #tool_name do
		hash = (hash + tool_name:byte(i) * i) % 255
	end
	return Color3.fromHSV((hash / 255), 0.6, 0.9)
end

local function get_outline_thickness(distance)
	local base = 2 - (distance / 2000)
	return clamp(base, 1, 2)
end

local function world_to_screen(position)
	local point, on_screen = camera:WorldToViewportPoint(position)
	return Vector2.new(point.X, point.Y), on_screen, point.Z
end

local function get_character_bounds(character)
	if not character then
		return nil
	end
	local cf, size = character:GetBoundingBox()
	local corners = {
		cf * CFrame.new(size.X / 2, size.Y / 2, size.Z / 2),
		cf * CFrame.new(-size.X / 2, size.Y / 2, size.Z / 2),
		cf * CFrame.new(size.X / 2, -size.Y / 2, size.Z / 2),
		cf * CFrame.new(-size.X / 2, -size.Y / 2, size.Z / 2),
		cf * CFrame.new(size.X / 2, size.Y / 2, -size.Z / 2),
		cf * CFrame.new(-size.X / 2, size.Y / 2, -size.Z / 2),
		cf * CFrame.new(size.X / 2, -size.Y / 2, -size.Z / 2),
		cf * CFrame.new(-size.X / 2, -size.Y / 2, -size.Z / 2)
	}
	return corners
end

local function get_screen_bounds(character)
	local corners = get_character_bounds(character)
	if not corners then
		return nil
	end

	local min_x, min_y = math.huge, math.huge
	local max_x, max_y = -math.huge, -math.huge
	local on_screen = false

	for _, corner in ipairs(corners) do
		local screen_pos, visible = world_to_screen(corner.Position)
		if visible then
			on_screen = true
		end
		min_x = math.min(min_x, screen_pos.X)
		min_y = math.min(min_y, screen_pos.Y)
		max_x = math.max(max_x, screen_pos.X)
		max_y = math.max(max_y, screen_pos.Y)
	end

	if not on_screen then
		return nil
	end

	return Vector2.new(min_x, min_y), Vector2.new(max_x, max_y)
end

local function create_drawing(draw_type)
	if not Drawing then
		return nil
	end
	local obj = Drawing.new(draw_type)
	obj.Visible = false
	return obj
end

function ElyESP.new(config)
	local self = setmetatable({}, ElyESP)
	self.config = {}
	for key, value in pairs(defaults) do
		self.config[key] = value
	end
	if config then
		for key, value in pairs(config) do
			self.config[key] = value
		end
	end

	self.objects = {}
	self.connection = nil

	return self
end

function ElyESP:set(key, value)
	self.config[key] = value
end

function ElyESP:destroy_player(player)
	local obj = self.objects[player]
	if not obj then
		return
	end

	for _, item in pairs(obj) do
		if typeof(item) == "Instance" then
			item:Destroy()
		elseif typeof(item) == "table" then
			for _, sub in pairs(item) do
				if typeof(sub) == "Instance" then
					sub:Destroy()
				elseif sub and sub.Remove then
					sub:Remove()
				elseif sub and sub.Destroy then
					sub:Destroy()
				end
			end
		elseif item and item.Remove then
			item:Remove()
		elseif item and item.Destroy then
			item:Destroy()
		end
	end

	self.objects[player] = nil
end

function ElyESP:create_highlight(player)
	local character = player.Character
	if not character then
		return
	end

	local highlight = Instance.new("Highlight")
	highlight.Name = "ElyESP_Highlight"
	highlight.Adornee = character
	highlight.FillTransparency = 0.65
	highlight.OutlineTransparency = 0.2
	highlight.FillColor = self.config.highlight_fill
	highlight.OutlineColor = self.config.highlight_outline
	highlight.Parent = character

	self.objects[player] = self.objects[player] or {}
	self.objects[player].highlight = highlight
end

function ElyESP:create_chams(player)
	local character = player.Character
	if not character then
		return
	end

	local cham_folder = Instance.new("Folder")
	cham_folder.Name = "ElyESP_Chams"
	cham_folder.Parent = character

	for _, part in ipairs(character:GetChildren()) do
		if part:IsA("BasePart") then
			local adorn = Instance.new("BoxHandleAdornment")
			adorn.Name = "ElyESP_Cham"
			adorn.Adornee = part
			adorn.AlwaysOnTop = true
			adorn.ZIndex = 0
			adorn.Size = part.Size + Vector3.new(0.02, 0.02, 0.02)
			adorn.Transparency = 0.5
			adorn.Color3 = self.config.chams_color
			adorn.Parent = cham_folder
		end
	end

	self.objects[player] = self.objects[player] or {}
	self.objects[player].chams = cham_folder
end

function ElyESP:create_glow(player)
	local character = player.Character
	if not character then
		return
	end

	local glow = Instance.new("Highlight")
	glow.Name = "ElyESP_Glow"
	glow.Adornee = character
	glow.FillTransparency = 1
	glow.OutlineTransparency = 0
	glow.OutlineColor = self.config.chams_color
	glow.Parent = character

	self.objects[player] = self.objects[player] or {}
	self.objects[player].glow = glow
end

function ElyESP:create_box_panels(player)
	local character = player.Character
	if not character then
		return
	end

	local root = get_root(character)
	if not root then
		return
	end

	local box = Instance.new("BoxHandleAdornment")
	box.Name = "ElyESP_BoxPanel"
	box.Adornee = root
	box.AlwaysOnTop = false
	box.ZIndex = 0
	box.Size = Vector3.new(4, 6, 2)
	box.Transparency = 0.75
	box.Color3 = self.config.fill_color
	box.Parent = root

	self.objects[player] = self.objects[player] or {}
	self.objects[player].box_panel = box
end

function ElyESP:create_billboard(player)
	local character = player.Character
	if not character then
		return
	end

	local root = get_root(character)
	if not root then
		return
	end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ElyESP_Billboard"
	billboard.Size = UDim2.new(0, 180, 0, 70)
	billboard.AlwaysOnTop = true
	billboard.StudsOffset = Vector3.new(0, 2.8, 0)
	billboard.Parent = character

	local name_label = Instance.new("TextLabel")
	name_label.Size = UDim2.new(1, 0, 0, 18)
	name_label.BackgroundTransparency = 1
	name_label.Font = Enum.Font.GothamBold
	name_label.TextSize = self.config.text_size
	name_label.TextColor3 = self.config.text_color
	name_label.Text = player.Name
	name_label.Parent = billboard

	local health_label = Instance.new("TextLabel")
	health_label.Size = UDim2.new(1, 0, 0, 16)
	health_label.Position = UDim2.new(0, 0, 0, 20)
	health_label.BackgroundTransparency = 1
	health_label.Font = Enum.Font.Gotham
	health_label.TextSize = self.config.text_size - 1
	health_label.TextColor3 = self.config.text_color
	health_label.Text = ""
	health_label.Parent = billboard

	local distance_label = Instance.new("TextLabel")
	distance_label.Size = UDim2.new(1, 0, 0, 16)
	distance_label.Position = UDim2.new(0, 0, 0, 38)
	distance_label.BackgroundTransparency = 1
	distance_label.Font = Enum.Font.Gotham
	distance_label.TextSize = self.config.text_size - 1
	distance_label.TextColor3 = self.config.text_color
	distance_label.Text = ""
	distance_label.Parent = billboard

	local weapon_label = Instance.new("TextLabel")
	weapon_label.Size = UDim2.new(1, 0, 0, 16)
	weapon_label.Position = UDim2.new(0, 0, 0, 56)
	weapon_label.BackgroundTransparency = 1
	weapon_label.Font = Enum.Font.Gotham
	weapon_label.TextSize = self.config.text_size - 2
	weapon_label.TextColor3 = self.config.text_color
	weapon_label.Text = ""
	weapon_label.Parent = billboard

	self.objects[player] = self.objects[player] or {}
	self.objects[player].billboard = billboard
	self.objects[player].billboard_name = name_label
	self.objects[player].billboard_health = health_label
	self.objects[player].billboard_distance = distance_label
	self.objects[player].billboard_weapon = weapon_label
end

function ElyESP:create_drawings(player)
	local drawings = {
		box = create_drawing("Square"),
		box_fill = create_drawing("Square"),
		corner = {},
		snapline = create_drawing("Line"),
		tracer = create_drawing("Line"),
		arrow = create_drawing("Triangle"),
		arrow_label = create_drawing("Text"),
		name = create_drawing("Text"),
		health = create_drawing("Line"),
		health_bg = create_drawing("Line"),
		distance = create_drawing("Text"),
		weapon = create_drawing("Text"),
		velocity = create_drawing("Text"),
		direction = create_drawing("Line"),
		skeleton = {},
		wire_box = {}
	}

	for i = 1, 12 do
		drawings.wire_box[i] = create_drawing("Line")
	end

	for i = 1, 8 do
		drawings.corner[i] = create_drawing("Line")
	end

	for i = 1, 15 do
		drawings.skeleton[i] = create_drawing("Line")
	end

	self.objects[player] = self.objects[player] or {}
	self.objects[player].drawings = drawings
end

local function get_joint_positions(character)
	local joints = {}
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return joints
	end

	local parts = {
		Head = "Head",
		UpperTorso = "UpperTorso",
		LowerTorso = "LowerTorso",
		LeftUpperArm = "LeftUpperArm",
		LeftLowerArm = "LeftLowerArm",
		LeftHand = "LeftHand",
		RightUpperArm = "RightUpperArm",
		RightLowerArm = "RightLowerArm",
		RightHand = "RightHand",
		LeftUpperLeg = "LeftUpperLeg",
		LeftLowerLeg = "LeftLowerLeg",
		LeftFoot = "LeftFoot",
		RightUpperLeg = "RightUpperLeg",
		RightLowerLeg = "RightLowerLeg",
		RightFoot = "RightFoot"
	}

	for key, part_name in pairs(parts) do
		local part = character:FindFirstChild(part_name)
		if part then
			joints[key] = part.Position
		end
	end

	return joints
end

function ElyESP:update_drawings(player)
	local obj = self.objects[player]
	if not obj or not obj.drawings then
		return
	end

	local character = player.Character
	local root = get_root(character)
	if not root then
		return
	end

	local min_pos, max_pos = get_screen_bounds(character)
	if not min_pos or not max_pos then
		for _, item in pairs(obj.drawings) do
			if typeof(item) == "table" then
				for _, sub in pairs(item) do
					if sub then
						sub.Visible = false
					end
				end
			elseif item then
				item.Visible = false
			end
		end
		return
	end

	local width = max_pos.X - min_pos.X
	local height = max_pos.Y - min_pos.Y
	local mid_x = (min_pos.X + max_pos.X) / 2
	local color = self.config.rainbow and get_rainbow_color() or self.config.box_color
	if self.config.team_color and player.Team then
		color = player.Team.TeamColor.Color
	end

	if self.config.box_2d and obj.drawings.box then
		local thickness = get_outline_thickness(get_distance(character))
		obj.drawings.box.Visible = true
		obj.drawings.box.Position = min_pos
		obj.drawings.box.Size = Vector2.new(width, height)
		obj.drawings.box.Color = color
		obj.drawings.box.Thickness = self.config.box_outline and thickness or 1
		obj.drawings.box.Filled = false
	else
		if obj.drawings.box then
			obj.drawings.box.Visible = false
		end
	end

	if self.config.fill_box and obj.drawings.box_fill then
		obj.drawings.box_fill.Visible = true
		obj.drawings.box_fill.Position = min_pos
		obj.drawings.box_fill.Size = Vector2.new(width, height)
		obj.drawings.box_fill.Color = self.config.rainbow and get_rainbow_color() or self.config.fill_color
		obj.drawings.box_fill.Thickness = 1
		obj.drawings.box_fill.Filled = true
		obj.drawings.box_fill.Transparency = self.config.gradient_box and 0.35 or 0.2
	else
		if obj.drawings.box_fill then
			obj.drawings.box_fill.Visible = false
		end
	end

	if self.config.corner_box then
		local corner_color = self.config.rainbow and get_rainbow_color() or self.config.corner_color
		local corner_size = math.min(width, height) * 0.2
		local corners = {
			{Vector2.new(min_pos.X, min_pos.Y), Vector2.new(min_pos.X + corner_size, min_pos.Y)},
			{Vector2.new(min_pos.X, min_pos.Y), Vector2.new(min_pos.X, min_pos.Y + corner_size)},
			{Vector2.new(max_pos.X, min_pos.Y), Vector2.new(max_pos.X - corner_size, min_pos.Y)},
			{Vector2.new(max_pos.X, min_pos.Y), Vector2.new(max_pos.X, min_pos.Y + corner_size)},
			{Vector2.new(min_pos.X, max_pos.Y), Vector2.new(min_pos.X + corner_size, max_pos.Y)},
			{Vector2.new(min_pos.X, max_pos.Y), Vector2.new(min_pos.X, max_pos.Y - corner_size)},
			{Vector2.new(max_pos.X, max_pos.Y), Vector2.new(max_pos.X - corner_size, max_pos.Y)},
			{Vector2.new(max_pos.X, max_pos.Y), Vector2.new(max_pos.X, max_pos.Y - corner_size)}
		}

		for i, line in ipairs(obj.drawings.corner) do
			local pair = corners[i]
			line.Visible = true
			line.From = pair[1]
			line.To = pair[2]
			line.Color = corner_color
			line.Thickness = 1
		end
	else
		for _, line in ipairs(obj.drawings.corner) do
			line.Visible = false
		end
	end

	if self.config.snaplines and obj.drawings.snapline then
		local viewport = services.workspace.CurrentCamera.ViewportSize
		local from_y = 0
		if self.config.snapline_from == "center" then
			from_y = viewport.Y / 2
		elseif self.config.snapline_from == "bottom" then
			from_y = viewport.Y
		end
		obj.drawings.snapline.Visible = true
		obj.drawings.snapline.From = Vector2.new(viewport.X / 2, from_y)
		obj.drawings.snapline.To = Vector2.new(mid_x, max_pos.Y)
		obj.drawings.snapline.Color = self.config.rainbow and get_rainbow_color() or self.config.snapline_color
		obj.drawings.snapline.Thickness = 1
	else
		if obj.drawings.snapline then
			obj.drawings.snapline.Visible = false
		end
	end

	if self.config.tracers and obj.drawings.tracer then
		local from_y = self.config.tracer_from == "top" and 0 or services.workspace.CurrentCamera.ViewportSize.Y
		obj.drawings.tracer.Visible = true
		obj.drawings.tracer.From = Vector2.new(services.workspace.CurrentCamera.ViewportSize.X / 2, from_y)
		obj.drawings.tracer.To = Vector2.new(mid_x, max_pos.Y)
		obj.drawings.tracer.Color = self.config.rainbow and get_rainbow_color() or self.config.tracer_color
		obj.drawings.tracer.Thickness = 1
	else
		if obj.drawings.tracer then
			obj.drawings.tracer.Visible = false
		end
	end

	if self.config.name and obj.drawings.name then
		obj.drawings.name.Visible = true
		obj.drawings.name.Text = player.Name
		obj.drawings.name.Size = self.config.text_size
		obj.drawings.name.Color = self.config.text_color
		obj.drawings.name.Center = true
		obj.drawings.name.Outline = true
		obj.drawings.name.Position = Vector2.new(mid_x, min_pos.Y - 14)
	else
		if obj.drawings.name then
			obj.drawings.name.Visible = false
		end
	end

	if self.config.health and obj.drawings.health then
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			local health_percent = clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
			obj.drawings.health_bg.Visible = true
			obj.drawings.health_bg.From = Vector2.new(min_pos.X - 4, max_pos.Y)
			obj.drawings.health_bg.To = Vector2.new(min_pos.X - 4, min_pos.Y)
			obj.drawings.health_bg.Color = Color3.fromRGB(40, 40, 40)
			obj.drawings.health_bg.Thickness = 3

			obj.drawings.health.Visible = true
			obj.drawings.health.From = Vector2.new(min_pos.X - 4, max_pos.Y)
			obj.drawings.health.To = Vector2.new(min_pos.X - 4, max_pos.Y - (height * health_percent))
			obj.drawings.health.Color = self.config.health_color
			obj.drawings.health.Thickness = 2
		end
	else
		if obj.drawings.health then
			obj.drawings.health.Visible = false
		end
		if obj.drawings.health_bg then
			obj.drawings.health_bg.Visible = false
		end
	end

	if self.config.distance and obj.drawings.distance then
		local dist = math.floor(get_distance(character))
		obj.drawings.distance.Visible = true
		obj.drawings.distance.Text = string.format("%dm", dist)
		obj.drawings.distance.Size = self.config.text_size - 1
		obj.drawings.distance.Color = self.config.text_color
		obj.drawings.distance.Center = true
		obj.drawings.distance.Outline = true
		obj.drawings.distance.Position = Vector2.new(mid_x, max_pos.Y + 2)
	else
		if obj.drawings.distance then
			obj.drawings.distance.Visible = false
		end
	end

	if self.config.weapon and obj.drawings.weapon then
		obj.drawings.weapon.Visible = true
		local tool_name = get_tool_name(character)
		obj.drawings.weapon.Text = tool_name
		obj.drawings.weapon.Size = self.config.text_size - 1
		local weapon_color = get_weapon_color(self.config, tool_name)
		obj.drawings.weapon.Color = weapon_color
		obj.drawings.weapon.Center = true
		obj.drawings.weapon.Outline = true
		obj.drawings.weapon.Position = Vector2.new(mid_x, max_pos.Y + 14)
	else
		if obj.drawings.weapon then
			obj.drawings.weapon.Visible = false
		end
	end

	if self.config.velocity and obj.drawings.velocity then
		local root_vel = root.AssemblyLinearVelocity
		local speed = math.floor(root_vel.Magnitude)
		obj.drawings.velocity.Visible = true
		obj.drawings.velocity.Text = string.format("%d studs/s", speed)
		obj.drawings.velocity.Size = self.config.text_size - 1
		obj.drawings.velocity.Color = self.config.velocity_color
		obj.drawings.velocity.Center = true
		obj.drawings.velocity.Outline = true
		obj.drawings.velocity.Position = Vector2.new(mid_x, max_pos.Y + 28)
	else
		if obj.drawings.velocity then
			obj.drawings.velocity.Visible = false
		end
	end

	if self.config.direction and obj.drawings.direction then
		local forward = root.CFrame.LookVector
		local start_pos = root.Position
		local end_pos = start_pos + forward * 3
		local start_screen, start_visible = world_to_screen(start_pos)
		local end_screen, end_visible = world_to_screen(end_pos)
		obj.drawings.direction.Visible = start_visible and end_visible
		obj.drawings.direction.From = start_screen
		obj.drawings.direction.To = end_screen
		obj.drawings.direction.Color = self.config.velocity_color
		obj.drawings.direction.Thickness = 2
	else
		if obj.drawings.direction then
			obj.drawings.direction.Visible = false
		end
	end

	if self.config.skeleton and obj.drawings.skeleton then
		local joints = get_joint_positions(character)
		local segments = {
			{"Head", "UpperTorso"},
			{"UpperTorso", "LowerTorso"},
			{"UpperTorso", "LeftUpperArm"},
			{"LeftUpperArm", "LeftLowerArm"},
			{"LeftLowerArm", "LeftHand"},
			{"UpperTorso", "RightUpperArm"},
			{"RightUpperArm", "RightLowerArm"},
			{"RightLowerArm", "RightHand"},
			{"LowerTorso", "LeftUpperLeg"},
			{"LeftUpperLeg", "LeftLowerLeg"},
			{"LeftLowerLeg", "LeftFoot"},
			{"LowerTorso", "RightUpperLeg"},
			{"RightUpperLeg", "RightLowerLeg"},
			{"RightLowerLeg", "RightFoot"}
		}

		local skeleton_color = self.config.rainbow and get_rainbow_color() or self.config.box_color
		if self.config.team_color and player.Team then
			skeleton_color = player.Team.TeamColor.Color
		end
		for i, pair in ipairs(segments) do
			local line = obj.drawings.skeleton[i]
			local start_pos = joints[pair[1]]
			local end_pos = joints[pair[2]]
			if line and start_pos and end_pos then
				local start_screen, start_visible = world_to_screen(start_pos)
				local end_screen, end_visible = world_to_screen(end_pos)
				line.Visible = start_visible and end_visible
				line.From = start_screen
				line.To = end_screen
				line.Color = skeleton_color
				line.Thickness = 1
			elseif line then
				line.Visible = false
			end
		end
	else
		if obj.drawings.skeleton then
			for _, line in ipairs(obj.drawings.skeleton) do
				line.Visible = false
			end
		end
	end

	if self.config.wire_box_3d and obj.drawings.wire_box then
		local corners = get_character_bounds(character)
		if corners then
			local edges = {
				{1, 2}, {1, 3}, {2, 4}, {3, 4},
				{5, 6}, {5, 7}, {6, 8}, {7, 8},
				{1, 5}, {2, 6}, {3, 7}, {4, 8}
			}
			local wire_color = self.config.rainbow and get_rainbow_color() or self.config.box_color
			for i, edge in ipairs(edges) do
				local line = obj.drawings.wire_box[i]
				local start_pos = corners[edge[1]].Position
				local end_pos = corners[edge[2]].Position
				if line then
					local start_screen, start_visible = world_to_screen(start_pos)
					local end_screen, end_visible = world_to_screen(end_pos)
					line.Visible = start_visible and end_visible
					line.From = start_screen
					line.To = end_screen
					line.Color = wire_color
					line.Thickness = 1
				end
			end
		end
	else
		if obj.drawings.wire_box then
			for _, line in ipairs(obj.drawings.wire_box) do
				line.Visible = false
			end
		end
	end

	local on_screen = true
	local root_screen, visible = world_to_screen(root.Position)
	if not visible then
		on_screen = false
	end

	if self.config.out_of_view and obj.drawings.arrow then
		local viewport = camera.ViewportSize
		local center = Vector2.new(viewport.X / 2, viewport.Y / 2)
		local to_center = center - Vector2.new(mid_x, (min_pos.Y + max_pos.Y) / 2)
		local dir = to_center.Unit
		local radius = math.min(center.X, center.Y) - 24
		local arrow_pos = center - dir * radius
		obj.drawings.arrow.Visible = not on_screen
		obj.drawings.arrow.Color = self.config.rainbow and get_rainbow_color() or self.config.arrow_color
		obj.drawings.arrow.Filled = true
		obj.drawings.arrow.Thickness = 1
		obj.drawings.arrow.PointA = arrow_pos
		obj.drawings.arrow.PointB = arrow_pos + Vector2.new(-dir.Y, dir.X) * 10
		obj.drawings.arrow.PointC = arrow_pos + Vector2.new(dir.Y, -dir.X) * 10

		if obj.drawings.arrow_label then
			local dist = math.floor(get_distance(character))
			local tool_name = get_tool_name(character)
			local label_text = string.format("%s [%dm]", player.Name, dist)
			if self.config.weapon and tool_name ~= "" then
				label_text = string.format("%s [%dm] - %s", player.Name, dist, tool_name)
			end
			obj.drawings.arrow_label.Visible = not on_screen
			obj.drawings.arrow_label.Text = label_text
			obj.drawings.arrow_label.Size = self.config.text_size - 2
			obj.drawings.arrow_label.Color = self.config.text_color
			obj.drawings.arrow_label.Center = true
			obj.drawings.arrow_label.Outline = true
			obj.drawings.arrow_label.Position = arrow_pos + dir * 18
		end
	else
		if obj.drawings.arrow then
			obj.drawings.arrow.Visible = false
		end
		if obj.drawings.arrow_label then
			obj.drawings.arrow_label.Visible = false
		end
	end
end

function ElyESP:update_billboard(player, distance)
	local obj = self.objects[player]
	if not obj or not obj.billboard then
		return
	end

	obj.billboard_name.Text = player.Name
	if self.config.health then
		local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			obj.billboard_health.Text = string.format("%d HP", humanoid.Health)
		end
	else
		obj.billboard_health.Text = ""
	end

	if self.config.distance then
		obj.billboard_distance.Text = string.format("%dm", distance)
	else
		obj.billboard_distance.Text = ""
	end

	if self.config.weapon then
		obj.billboard_weapon.Text = get_tool_name(player.Character)
	else
		obj.billboard_weapon.Text = ""
	end

	local color = self.config.rainbow and get_rainbow_color() or self.config.text_color
	obj.billboard_name.TextColor3 = color
	obj.billboard_health.TextColor3 = color
	obj.billboard_distance.TextColor3 = color
	obj.billboard_weapon.TextColor3 = color
end

function ElyESP:update_highlight(player)
	local obj = self.objects[player]
	if not obj or not obj.highlight then
		return
	end

	local color = self.config.rainbow and get_rainbow_color() or self.config.highlight_fill
	obj.highlight.FillColor = color
	obj.highlight.OutlineColor = self.config.highlight_outline
end

function ElyESP:update_player(player)
	if player == local_player then
		return
	end

	if self.config.team_check and player.Team == local_player.Team then
		self:destroy_player(player)
		return
	end

	if not is_alive(player) then
		self:destroy_player(player)
		return
	end

	local distance = get_distance(player.Character)
	if distance > self.config.max_distance then
		self:destroy_player(player)
		return
	end

	if self.config.highlight then
		if not (self.objects[player] and self.objects[player].highlight) then
			self:create_highlight(player)
		end
		self:update_highlight(player)
	else
		if self.objects[player] and self.objects[player].highlight then
			self.objects[player].highlight.Enabled = false
		end
	end

	if not self.config.chams and self.objects[player] and self.objects[player].chams then
		self.objects[player].chams:Destroy()
		self.objects[player].chams = nil
	end

	if not self.config.glow and self.objects[player] and self.objects[player].glow then
		self.objects[player].glow:Destroy()
		self.objects[player].glow = nil
	end

	if not self.config.box_fill_panels and self.objects[player] and self.objects[player].box_panel then
		self.objects[player].box_panel:Destroy()
		self.objects[player].box_panel = nil
	end

	if self.config.chams then
		if not (self.objects[player] and self.objects[player].chams) then
			self:create_chams(player)
		end
	end

	if self.config.glow then
		if not (self.objects[player] and self.objects[player].glow) then
			self:create_glow(player)
		end
	end

	if self.config.box_fill_panels then
		if not (self.objects[player] and self.objects[player].box_panel) then
			self:create_box_panels(player)
		end
	end

	if self.objects[player] and self.objects[player].chams then
		for _, adorn in ipairs(self.objects[player].chams:GetChildren()) do
			if adorn:IsA("BoxHandleAdornment") then
				adorn.Color3 = self.config.rainbow and get_rainbow_color() or self.config.chams_color
			end
		end
	end

	if self.objects[player] and self.objects[player].glow then
		self.objects[player].glow.OutlineColor = self.config.rainbow and get_rainbow_color() or self.config.chams_color
	end

	if self.objects[player] and self.objects[player].box_panel then
		self.objects[player].box_panel.Color3 = self.config.rainbow and get_rainbow_color() or self.config.fill_color
	end

	if self.config.use_billboard then
		if not (self.objects[player] and self.objects[player].billboard) then
			self:create_billboard(player)
		end
		self:update_billboard(player, math.floor(distance))
	end

	if Drawing then
		if not (self.objects[player] and self.objects[player].drawings) then
			self:create_drawings(player)
		end
		self:update_drawings(player)
	end
end

function ElyESP:start()
	if self.connection then
		return
	end

	self.connection = services.run_service.RenderStepped:Connect(function()
		if not self.config.enabled then
			return
		end

		local now = tick()
		self.last_update = self.last_update or 0
		if self.config.update_rate > 0 and now - self.last_update < self.config.update_rate then
			return
		end
		self.last_update = now

		local count = 0
		for _, player in ipairs(services.players:GetPlayers()) do
			if self.config.max_players_drawn > 0 and count >= self.config.max_players_drawn then
				break
			end
			self:update_player(player)
			count += 1
		end
	end)
end

function ElyESP:stop()
	if self.connection then
		self.connection:Disconnect()
		self.connection = nil
	end

	for player in pairs(self.objects) do
		self:destroy_player(player)
	end
end

return ElyESP
