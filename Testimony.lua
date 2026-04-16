local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local Aurora = loadstring(game:HttpGet("https://raw.githubusercontent.com/Adiabaton/LuaLoads/refs/heads/main/AuroraLib.lua"))()

local Config = {
    Combat = {
        Aimbot = false,
        SilentAim = false,
        Triggerbot = false,
        Prediction = false,
        TeamCheck = false,
        WallCheck = false,
        Smoothness = 5,
        FOV = 120,
        TargetPart = "Head",
        ProjSpeed = 1000,
        ShowFOV = true,
        HitboxSize = 2,
        AutoShoot = false,
        Deadzone = 10
    },
    Visuals = {
        Enabled = false,
        Boxes = false,
        Box3D = false,
        Names = false,
        Tracers = false,
        Skeletons = false,
        Chams = false,
        HealthBar = false,
        Distance = false,
        ViewAngles = false,
        HeadDot = false,
        Arrows = false,
        Radar = false,
        Accent = Color3.fromRGB(115, 60, 255)
    },
    Weapon = {
        NoRecoil = false,
        NoSpread = false,
        InfiniteAmmo = false,
        RapidFire = false,
        Wallbang = false,
        InstantReload = false
    },
    Movement = {
        WalkSpeed = 16,
        JumpPower = 50,
        Fly = false,
        FlySpeed = 50,
        Noclip = false,
        InfJump = false,
        Spinbot = false,
        Airwalk = false,
        Bhop = false,
        SpeedJump = false
    },
    World = {
        FOV = 70,
        Brightness = 1,
        ClockTime = 12,
        Fullbright = false,
        NoFog = false,
        Ambient = Color3.fromRGB(0, 0, 0)
    },
    Utility = {
        AntiAFK = true,
        FPSUnlocker = false,
        AutoRejoin = false,
        ServerHop = false
    }
}

local function GetCharacter(player) return player.Character end
local function GetHumanoid(player) local char = GetCharacter(player) return char and char:FindFirstChild("Humanoid") end
local function GetHRP(player) local char = GetCharacter(player) return char and char:FindFirstChild("HumanoidRootPart") end

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 1
FOVCircle.NumSides = 64
FOVCircle.Color = Config.Visuals.Accent

local function IsVisible(part)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    params.FilterType = Enum.RaycastFilterType.Exclude
    local hit = workspace:Raycast(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 1000, params)
    return hit and hit.Instance:IsDescendantOf(part.Parent)
end

local function GetNearest()
    local target = nil
    local dist = Config.Combat.FOV
    local mPos = UserInputService:GetMouseLocation()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and GetCharacter(p) and GetCharacter(p):FindFirstChild(Config.Combat.TargetPart) then
            if Config.Combat.TeamCheck and p.Team == LocalPlayer.Team then continue end
            local part = GetCharacter(p)[Config.Combat.TargetPart]
            if Config.Combat.WallCheck and not IsVisible(part) then continue end
            local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - mPos).Magnitude
                if mag < dist then dist = mag target = p end
            end
        end
    end
    return target
end

local Window = Aurora:CreateWindow({ Name = "TESTIMONY", Footer = "Official v1.0" })
Window:CreateWatermark({ Name = "TESTIMONY" })

local Tab1 = Window:CreateTab({ Name = "Universal", Icon = "rbxassetid://10723415693" })
local Tab2 = Window:CreateTab({ Name = "Visuals", Icon = "rbxassetid://10723414979" })
local Tab3 = Window:CreateTab({ Name = "Movement", Icon = "rbxassetid://10723414631" })
local Tab4 = Window:CreateTab({ Name = "Weapon", Icon = "rbxassetid://10705001140" })
local Tab5 = Window:CreateTab({ Name = "World", Icon = "rbxassetid://10723343321" })
local Tab6 = Window:CreateTab({ Name = "Settings", Icon = "rbxassetid://10714902127" })

local Combat = Tab1:CreateSection("Combat")
Combat:CreateToggle({ Name = "Aimbot", Default = false, Callback = function(v) Config.Combat.Aimbot = v end })
Combat:CreateToggle({ Name = "Silent Aim", Default = false, Callback = function(v) Config.Combat.SilentAim = v end })
Combat:CreateToggle({ Name = "Triggerbot", Default = false, Callback = function(v) Config.Combat.Triggerbot = v end })
Combat:CreateToggle({ Name = "Prediction", Default = false, Callback = function(v) Config.Combat.Prediction = v end })
Combat:CreateSlider({ Name = "Horizontal Smoothness", Min = 1, Max = 50, Default = 5, Callback = function(v) Config.Combat.Smoothness = v end })
Combat:CreateSlider({ Name = "FOV Size", Min = 10, Max = 800, Default = 120, Callback = function(v) Config.Combat.FOV = v FOVCircle.Radius = v end })
Combat:CreateDropdown({ Name = "Priority Part", Options = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"}, Default = "Head", Callback = function(v) Config.Combat.TargetPart = v end })

local Visuals = Tab2:CreateSection("ESP Main")
Visuals:CreateToggle({ Name = "Enabled", Default = false, Callback = function(v) Config.Visuals.Enabled = v end })
Visuals:CreateToggle({ Name = "Boxes (2D)", Default = false, Callback = function(v) Config.Visuals.Boxes = v end })
Visuals:CreateToggle({ Name = "3D Box", Default = false, Callback = function(v) Config.Visuals.Box3D = v end })
Visuals:CreateToggle({ Name = "Name", Default = false, Callback = function(v) Config.Visuals.Names = v end })
Visuals:CreateToggle({ Name = "Healthbar", Default = false, Callback = function(v) Config.Visuals.HealthBar = v end })
Visuals:CreateToggle({ Name = "Skeleton", Default = false, Callback = function(v) Config.Visuals.Skeletons = v end })
Visuals:CreateToggle({ Name = "Distance", Default = false, Callback = function(v) Config.Visuals.Distance = v end })
Visuals:CreateToggle({ Name = "Head Dot", Default = false, Callback = function(v) Config.Visuals.HeadDot = v end })
Visuals:CreateToggle({ Name = "Chams", Default = false, Callback = function(v) Config.Visuals.Chams = v end })
Visuals:CreateColorPicker({ Name = "Theme Accent", Default = Color3.fromRGB(115, 60, 255), Callback = function(v) Config.Visuals.Accent = v end })

local Player = Tab3:CreateSection("Movement")
Player:CreateSlider({ Name = "WalkSpeed", Min = 16, Max = 250, Default = 16, Callback = function(v) Config.Movement.WalkSpeed = v end })
Player:CreateSlider({ Name = "JumpPower", Min = 50, Max = 350, Default = 50, Callback = function(v) Config.Movement.JumpPower = v end })
Player:CreateToggle({ Name = "Fly", Default = false, Callback = function(v) Config.Movement.Fly = v end })
Player:CreateToggle({ Name = "Infinite Jump", Default = false, Callback = function(v) Config.Movement.InfJump = v end })
Player:CreateToggle({ Name = "Noclip", Default = false, Callback = function(v) Config.Movement.Noclip = v end })
Player:CreateToggle({ Name = "Spinbot", Default = false, Callback = function(v) Config.Movement.Spinbot = v end })
Player:CreateToggle({ Name = "Airwalk", Default = false, Callback = function(v) Config.Movement.Airwalk = v end })

local Gun = Tab4:CreateSection("Weapon")
Gun:CreateToggle({ Name = "No Recoil", Default = false, Callback = function(v) Config.Weapon.NoRecoil = v end })
Gun:CreateToggle({ Name = "No Spread", Default = false, Callback = function(v) Config.Weapon.NoSpread = v end })
Gun:CreateToggle({ Name = "Infinite Ammo", Default = false, Callback = function(v) Config.Weapon.InfiniteAmmo = v end })
Gun:CreateToggle({ Name = "Rapid Fire", Default = false, Callback = function(v) Config.Weapon.RapidFire = v end })

local World = Tab5:CreateSection("Environment")
World:CreateSlider({ Name = "FOV", Min = 70, Max = 130, Default = 70, Callback = function(v) Config.World.FOV = v Camera.FieldOfView = v end })
World:CreateToggle({ Name = "Fullbright Mode", Default = false, Callback = function(v) Config.World.Fullbright = v end })
World:CreateToggle({ Name = "Remove Fog", Default = false, Callback = function(v) Config.World.NoFog = v end })
World:CreateSlider({ Name = "Clock Time", Min = 0, Max = 24, Default = 12, Callback = function(v) Lighting.ClockTime = v end })

local Conf = Tab6:CreateSection("Profiles")
Conf:CreateTextbox({ Name = "Config Name", Placeholder = "profile_1", Callback = function(v) Config.Settings.ConfigName = v end })
Conf:CreateButton({ Name = "Save Profile", Callback = function() Window:SaveConfig(Config.Settings.ConfigName, Config) end })
Conf:CreateButton({ Name = "Load Profile", Callback = function() local d = Window:LoadConfig(Config.Settings.ConfigName) if d then Config = d end end })
local Sys = Tab6:CreateSection("System")
Sys:CreateButton({ Name = "Server Hop", Callback = function() 
    local s = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100")).data
    for _, ser in ipairs(s) do if ser.playing < ser.maxPlayers and ser.id ~= game.JobId then TeleportService:TeleportToPlaceInstance(game.PlaceId, ser.id) end end
end })
Sys:CreateBind({ Name = "UI Toggle", Default = Enum.KeyCode.RightControl, Callback = function() Window.Screen.Enabled = not Window.Screen.Enabled end })

local ESP_Data = {}
local function CreateESP(p)
    local d = {
        Box = Drawing.new("Square"), Name = Drawing.new("Text"), Trace = Drawing.new("Line"),
        Health = Drawing.new("Line"), HealthBack = Drawing.new("Line"), 
        Skeleton = {}, Look = Drawing.new("Line"), 
        Cham = Instance.new("Highlight")
    }
    d.Box.Thickness = 1 d.Name.Size = 13 d.Name.Center = true d.Name.Outline = true
    d.Health.Thickness = 2 d.HealthBack.Thickness = 2 d.HealthBack.Color = Color3.new(0,0,0)
    for i = 1, 15 do table.insert(d.Skeleton, Drawing.new("Line")) end
    d.Cham.FillTransparency = 0.5 d.Cham.OutlineTransparency = 0
    ESP_Data[p] = d
end

local function CleanESP(p)
    if ESP_Data[p] then
        local d = ESP_Data[p]
        d.Box:Remove() d.Name:Remove() d.Trace:Remove() d.Health:Remove() d.HealthBack:Remove() d.Look:Remove()
        for _, l in ipairs(d.Skeleton) do l:Remove() end
        if d.Cham then d.Cham:Destroy() end
        ESP_Data[p] = nil
    end
end

for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then CreateESP(p) end end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(CleanESP)

RunService.RenderStepped:Connect(function()
    if Config.World.Fullbright then Lighting.Brightness = 2 Lighting.GlobalShadows = false Lighting.Ambient = Color3.new(1,1,1) end
    if Config.World.NoFog then Lighting.FogEnd = 1e9 end
    
    local lChar = GetCharacter(LocalPlayer)
    local lHum = GetHumanoid(LocalPlayer)
    local lHrp = GetHRP(LocalPlayer)
    
    if lHum then lHum.WalkSpeed = Config.Movement.WalkSpeed lHum.JumpPower = Config.Movement.JumpPower end
    if lHrp and Config.Movement.Fly then
        local m = Vector3.new(0, 0, 0)
        local cf = Camera.CFrame
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then m = m + cf.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then m = m - cf.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then m = m - cf.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then m = m + cf.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then m = m + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then m = m - Vector3.new(0, 1, 0) end
        lHrp.Velocity = m * Config.Movement.FlySpeed
        lHum.PlatformStand = true
    elseif lHum then lHum.PlatformStand = false end
    
    if lHrp and Config.Movement.Spinbot then lHrp.CFrame = lHrp.CFrame * CFrame.Angles(0, math.rad(50), 0) end
    if lHrp and Config.Movement.Airwalk then lHrp.Velocity = Vector3.new(lHrp.Velocity.X, 0, lHrp.Velocity.Z) end
    if Config.Movement.Noclip and lChar then for _, v in ipairs(lChar:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end

    for p, d in pairs(ESP_Data) do
        local char = GetCharacter(p)
        local hrp = GetHRP(p)
        local hum = GetHumanoid(p)
        if Config.Visuals.Enabled and char and hrp and hum and hum.Health > 0 then
            local pos, screen = Camera:WorldToViewportPoint(hrp.Position)
            if screen then
                local h = (Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y)
                local w = h * 0.6
                
                d.Box.Visible = Config.Visuals.Boxes
                d.Box.Size = Vector2.new(w, h)
                d.Box.Position = Vector2.new(pos.X - w/2, pos.Y - h/2)
                d.Box.Color = Config.Visuals.Accent
                
                d.Name.Visible = Config.Visuals.Names
                d.Name.Position = Vector2.new(pos.X, pos.Y - h/2 - 15)
                d.Name.Text = p.Name .. (Config.Visuals.Distance and string.format(" [%dm]", (hrp.Position - Camera.CFrame.Position).Magnitude) or "")
                
                d.HealthBack.Visible = Config.Visuals.HealthBar
                d.HealthBack.From = Vector2.new(pos.X - w/2 - 5, pos.Y + h/2)
                d.HealthBack.To = Vector2.new(pos.X - w/2 - 5, pos.Y - h/2)
                
                d.Health.Visible = Config.Visuals.HealthBar
                d.Health.From = Vector2.new(pos.X - w/2 - 5, pos.Y + h/2)
                d.Health.To = Vector2.new(pos.X - w/2 - 5, pos.Y + h/2 - (h * (hum.Health/hum.MaxHealth)))
                d.Health.Color = Color3.fromHSV(hum.Health/hum.MaxHealth * 0.3, 1, 1)
                
                if Config.Visuals.Skeletons then
                    local j = {{"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"}, {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}}
                    for i, v in ipairs(j) do
                        local p1, p2 = char:FindFirstChild(v[1]), char:FindFirstChild(v[2])
                        if p1 and p2 then
                            local v1, o1 = Camera:WorldToViewportPoint(p1.Position)
                            local v2, o2 = Camera:WorldToViewportPoint(p2.Position)
                            d.Skeleton[i].Visible = o1 and o2 d.Skeleton[i].From = Vector2.new(v1.X, v1.Y) d.Skeleton[i].To = Vector2.new(v2.X, v2.Y) d.Skeleton[i].Color = Config.Visuals.Accent
                        else d.Skeleton[i].Visible = false end
                    end
                else for _, l in ipairs(d.Skeleton) do l.Visible = false end end
                
                if d.Cham then d.Cham.Enabled = Config.Visuals.Chams d.Cham.Adornee = char d.Cham.FillColor = Config.Visuals.Accent end
            else d.Box.Visible = false d.Name.Visible = false d.Health.Visible = false d.HealthBack.Visible = false d.Cham.Enabled = false for _, l in ipairs(d.Skeleton) do l.Visible = false end end
        else d.Box.Visible = false d.Name.Visible = false d.Health.Visible = false d.HealthBack.Visible = false if d.Cham then d.Cham.Enabled = false end for _, l in ipairs(d.Skeleton) do l.Visible = false end end
    end

    if (Config.Combat.Aimbot or Config.Combat.SilentAim) and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local t = GetNearest()
        if t then
            local p = GetCharacter(t)[Config.Combat.TargetPart]
            local pos = p.Position
            if Config.Combat.Prediction then pos = pos + (GetHRP(t).Velocity * ((Camera.CFrame.Position - p.Position).Magnitude / Config.Combat.ProjSpeed)) end
            local v = Camera:WorldToViewportPoint(pos)
            if Config.Combat.Aimbot then
                local m = UserInputService:GetMouseLocation()
                mousemoverel((v.X - m.X) / Config.Combat.Smoothness, (v.Y - m.Y) / Config.Combat.Smoothness)
            end
        end
    end
    
    if Config.Combat.Triggerbot and Mouse.Target and Mouse.Target.Parent:FindFirstChild("Humanoid") then
        local p = Players:GetPlayerFromCharacter(Mouse.Target.Parent)
        if p and p ~= LocalPlayer and (not Config.Combat.TeamCheck or p.Team ~= LocalPlayer.Team) then
            mouse1click()
        end
    end

    if Config.Movement.Spinbot and hrp then hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(45), 0) end
    if hrp and Config.Movement.Airwalk then hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z) end

    FOVCircle.Visible = Config.Combat.ShowFOV
    FOVCircle.Position = UserInputService:GetMouseLocation()
    FOVCircle.Color = Config.Visuals.Accent
end)

local function AutoRejoin()
    if Config.Utility.AutoRejoin then
        RunService.Stepped:Connect(function()
            if not LocalPlayer.Parent then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
            end
        end)
    end
end
task.spawn(AutoRejoin)

local function AntiAFK()
    if Config.Utility.AntiAFK then
        local conn = LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
    end
end
task.spawn(AntiAFK)

Aurora:Notify({ Title = "Testimony", Content = "Loaded v1.0", Type = "Success" })

return true
