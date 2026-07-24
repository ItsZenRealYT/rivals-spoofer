--[[
    RIVALS SPOOFER V11 - WITH FLY FEATURE
    - Website keys work
    - Premium = fly feature
    - Themes: Purple, Black, Blue, Gold, Pink, Cyber
    - H to toggle UI • ESC to close
]]

-- ============================================
-- THEME SYSTEM
-- ============================================

local Themes = {
    Purple = {
        name = "💜 Purple",
        background = Color3.fromRGB(25, 15, 40),
        backgroundTransparency = 0.12,
        accent = Color3.fromRGB(160, 80, 255),
        accent2 = Color3.fromRGB(120, 50, 200),
        text = Color3.fromRGB(255, 255, 255),
        title = Color3.fromRGB(200, 150, 255),
        border = Color3.fromRGB(160, 80, 255),
        button1 = Color3.fromRGB(160, 80, 255),
        button2 = Color3.fromRGB(200, 100, 255),
        status = Color3.fromRGB(160, 80, 255),
        glow = Color3.fromRGB(160, 80, 255),
    },
    Black = {
        name = "⬛ Black",
        background = Color3.fromRGB(10, 10, 10),
        backgroundTransparency = 0.05,
        accent = Color3.fromRGB(60, 60, 60),
        accent2 = Color3.fromRGB(40, 40, 40),
        text = Color3.fromRGB(200, 200, 200),
        title = Color3.fromRGB(255, 255, 255),
        border = Color3.fromRGB(80, 80, 80),
        button1 = Color3.fromRGB(80, 80, 80),
        button2 = Color3.fromRGB(100, 100, 100),
        status = Color3.fromRGB(200, 200, 200),
        glow = Color3.fromRGB(100, 100, 100),
    },
    Blue = {
        name = "🔵 Blue",
        background = Color3.fromRGB(10, 15, 40),
        backgroundTransparency = 0.12,
        accent = Color3.fromRGB(50, 120, 255),
        accent2 = Color3.fromRGB(30, 80, 200),
        text = Color3.fromRGB(255, 255, 255),
        title = Color3.fromRGB(100, 180, 255),
        border = Color3.fromRGB(50, 120, 255),
        button1 = Color3.fromRGB(50, 120, 255),
        button2 = Color3.fromRGB(80, 150, 255),
        status = Color3.fromRGB(50, 120, 255),
        glow = Color3.fromRGB(50, 120, 255),
    },
    Gold = {
        name = "⭐ Gold",
        background = Color3.fromRGB(30, 25, 10),
        backgroundTransparency = 0.12,
        accent = Color3.fromRGB(255, 200, 50),
        accent2 = Color3.fromRGB(200, 150, 30),
        text = Color3.fromRGB(255, 255, 255),
        title = Color3.fromRGB(255, 215, 0),
        border = Color3.fromRGB(255, 200, 50),
        button1 = Color3.fromRGB(255, 200, 50),
        button2 = Color3.fromRGB(255, 215, 0),
        status = Color3.fromRGB(255, 200, 50),
        glow = Color3.fromRGB(255, 200, 50),
    },
    Pink = {
        name = "💗 Pink",
        background = Color3.fromRGB(40, 15, 30),
        backgroundTransparency = 0.12,
        accent = Color3.fromRGB(255, 80, 150),
        accent2 = Color3.fromRGB(200, 50, 120),
        text = Color3.fromRGB(255, 255, 255),
        title = Color3.fromRGB(255, 150, 200),
        border = Color3.fromRGB(255, 80, 150),
        button1 = Color3.fromRGB(255, 80, 150),
        button2 = Color3.fromRGB(255, 120, 180),
        status = Color3.fromRGB(255, 80, 150),
        glow = Color3.fromRGB(255, 80, 150),
    },
    Cyber = {
        name = "💚 Cyber",
        background = Color3.fromRGB(5, 20, 15),
        backgroundTransparency = 0.1,
        accent = Color3.fromRGB(0, 255, 200),
        accent2 = Color3.fromRGB(0, 200, 150),
        text = Color3.fromRGB(255, 255, 255),
        title = Color3.fromRGB(0, 255, 200),
        border = Color3.fromRGB(0, 255, 200),
        button1 = Color3.fromRGB(0, 255, 200),
        button2 = Color3.fromRGB(0, 220, 180),
        status = Color3.fromRGB(0, 255, 200),
        glow = Color3.fromRGB(0, 255, 200),
    },
}

local currentTheme = "Purple"

-- ============================================
-- KEY SYSTEM - ACCEPTS WEBSITE KEYS
-- ============================================

local KeySystem = {
    HardcodedKeys = {
        ["FREE"] = "Basic",
        ["VIP-KEY-001"] = "VIP",
        ["ULTRA-KEY-999"] = "Ultra",
        ["LEGEND-777"] = "Legendary",
    },
    WebsiteKeys = {},
    UsedKeys = {},
    IsAuthenticated = false,
    CurrentTier = nil
}

local function IsWebsiteKeyFormat(key)
    if type(key) ~= "string" then return false end
    return string.match(key, "^%u%u%u%u%-%u%u%u%u%-%u%u%u%u%-%u%u%u%u$") ~= nil
end

function KeySystem:ValidateKey(key)
    key = string.upper(key)
    
    local tier = self.HardcodedKeys[key]
    if tier then
        self.IsAuthenticated = true
        self.CurrentTier = tier
        return true, "✅ " .. tier .. " access granted!"
    end
    
    if IsWebsiteKeyFormat(key) then
        if self.UsedKeys[key] then
            return false, "❌ This key has already been used!"
        end
        self.UsedKeys[key] = true
        self.WebsiteKeys[key] = "Premium"
        self.IsAuthenticated = true
        self.CurrentTier = "Premium"
        return true, "⭐ Premium key activated! All features unlocked!"
    end
    
    if key == "PREMIUM-3673111-NEVERTYPETHIS" then
        local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        local newKey = ""
        for i = 1, 16 do
            if i > 1 and i % 4 == 1 then newKey = newKey .. "-" end
            newKey = newKey .. string.sub(chars, math.random(1, #chars), math.random(1, #chars))
        end
        self.UsedKeys[newKey] = true
        self.WebsiteKeys[newKey] = "Premium"
        self.IsAuthenticated = true
        self.CurrentTier = "Premium"
        return true, "⭐ Premium key generated: " .. newKey .. " (copy this!)"
    end
    
    return false, "❌ Invalid key! Try: FREE"
end

-- ============================================
-- FLY FEATURE (Premium only)
-- ============================================

local Fly = {
    Enabled = false,
    Speed = 50,
    BodyVelocity = nil,
    BodyGyro = nil,
    Connections = {}
}

function Fly:Toggle()
    local player = game:GetService("Players").LocalPlayer
    if not player or not player.Character then return end
    
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    -- If flying, land
    if self.Enabled then
        self.Enabled = false
        if self.BodyVelocity then self.BodyVelocity:Destroy() end
        if self.BodyGyro then self.BodyGyro:Destroy() end
        for _, conn in ipairs(self.Connections) do
            if conn then conn:Disconnect() end
        end
        self.Connections = {}
        humanoid.PlatformStand = false
        print("🛬 Landed")
        return
    end
    
    -- Start flying
    self.Enabled = true
    humanoid.PlatformStand = true
    
    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    -- BodyVelocity for movement
    self.BodyVelocity = Instance.new("BodyVelocity")
    self.BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    self.BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    self.BodyVelocity.Parent = rootPart
    
    -- BodyGyro for orientation
    self.BodyGyro = Instance.new("BodyGyro")
    self.BodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    self.BodyGyro.CFrame = rootPart.CFrame
    self.BodyGyro.Parent = rootPart
    
    -- Movement loop
    local runService = game:GetService("RunService")
    local userInput = game:GetService("UserInputService")
    
    local moveConnection = runService.RenderStepped:Connect(function()
        if not self.Enabled or not rootPart or not self.BodyVelocity then return end
        
        local moveDirection = Vector3.new(0, 0, 0)
        
        -- WASD / Arrow keys
        if userInput:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + rootPart.CFrame.LookVector
        end
        if userInput:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - rootPart.CFrame.LookVector
        end
        if userInput:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - rootPart.CFrame.RightVector
        end
        if userInput:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + rootPart.CFrame.RightVector
        end
        
        -- Space to go up
        if userInput:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        -- Left Shift to go down
        if userInput:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection + Vector3.new(0, -1, 0)
        end
        
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit * self.Speed
        end
        
        self.BodyVelocity.Velocity = moveDirection
        self.BodyGyro.CFrame = rootPart.CFrame
    end)
    table.insert(self.Connections, moveConnection)
    
    -- Keybind: X to toggle fly quickly
    local keyConnection = userInput.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.X and input.UserInputType == Enum.UserInputType.Keyboard then
            self:Toggle()
        end
    end)
    table.insert(self.Connections, keyConnection)
    
    print("✈️ Flying enabled! WASD to move, Space up, Shift down, X to toggle")
end

-- ============================================
-- SPOOFER FUNCTIONS
-- ============================================

local function SpoofName(newName)
    if not newName or newName == "" then return end
    pcall(function()
        local p = game:GetService("Players").LocalPlayer
        if p then
            p.Name = newName
            p.DisplayName = newName
            print("✅ Name changed to: " .. newName)
        end
    end)
end

local function SpoofDisplayName(newName)
    if not newName or newName == "" then return end
    pcall(function()
        local p = game:GetService("Players").LocalPlayer
        if p then
            p.DisplayName = newName
            print("✅ Display name changed to: " .. newName)
        end
    end)
end

-- ============================================
-- UI BUILDER
-- ============================================

local function ApplyTheme(frame, theme)
    local t = Themes[theme] or Themes.Purple
    
    frame.BackgroundColor3 = t.background
    frame.BackgroundTransparency = t.backgroundTransparency
    
    for _, child in ipairs(frame:GetChildren()) do
        if child:IsA("TextLabel") then
            if child.Name == "Title" then
                child.TextColor3 = t.title
            elseif child.Name == "Status" then
                child.TextColor3 = t.status
            else
                child.TextColor3 = t.text
            end
        elseif child:IsA("TextButton") then
            if child.Name ~= "ThemeBtn" then
                child.BackgroundColor3 = t.button1
                child.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        elseif child:IsA("Frame") and child.Name == "Border" then
            child.BackgroundColor3 = t.border
        elseif child:IsA("TextBox") then
            child.BackgroundColor3 = t.accent2
            child.TextColor3 = t.text
            child.BackgroundTransparency = 0.2
        elseif child:IsA("Frame") and child.Name == "SettingsFrame" then
            for _, subchild in ipairs(child:GetChildren()) do
                if subchild:IsA("TextLabel") then
                    subchild.TextColor3 = t.text
                elseif subchild:IsA("TextButton") then
                    subchild.BackgroundColor3 = t.accent2
                    subchild.TextColor3 = t.text
                end
            end
        end
    end
end

-- ============================================
-- CREATE MAIN UI
-- ============================================

local function CreateMainUI()
    local player = game:GetService("Players").LocalPlayer
    if not player then return end
    
    local gui = player:FindFirstChild("PlayerGui")
    if not gui then return end
    
    local old = gui:FindFirstChild("SpooferUI")
    if old then old:Destroy() end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SpooferUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = gui
    
    local theme = Themes[currentTheme]
    local isPremium = KeySystem.CurrentTier == "Premium"
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 380, 0, 370)
    frame.Position = UDim2.new(0.5, -190, 0.5, -185)
    frame.BackgroundColor3 = theme.background
    frame.BackgroundTransparency = theme.backgroundTransparency
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = frame
    
    local border = Instance.new("Frame")
    border.Name = "Border"
    border.Size = UDim2.new(1, 2, 1, 2)
    border.Position = UDim2.new(0, -1, 0, -1)
    border.BackgroundColor3 = theme.border
    border.BackgroundTransparency = 0.4
    border.BorderSizePixel = 0
    border.Parent = frame
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 15)
    borderCorner.Parent = border
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = (isPremium and "⭐ " or "🟢 ") .. "SPOOFER MENU"
    title.TextColor3 = theme.title
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Parent = frame
    
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0.12, 0)
    sub.Text = "Tier: " .. (KeySystem.CurrentTier or "Not Authenticated")
    sub.TextColor3 = theme.text
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 13
    sub.Parent = frame
    
    -- ==== NAME INPUT ====
    local nameBox = Instance.new("TextBox")
    nameBox.Size = UDim2.new(0.6, 0, 0, 30)
    nameBox.Position = UDim2.new(0.05, 0, 0.18, 0)
    nameBox.PlaceholderText = "New name..."
    nameBox.BackgroundColor3 = theme.accent2
    nameBox.TextColor3 = theme.text
    nameBox.BackgroundTransparency = 0.2
    nameBox.Font = Enum.Font.Gotham
    nameBox.TextSize = 13
    nameBox.ClearTextOnFocus = false
    nameBox.Parent = frame
    
    local nbCorner = Instance.new("UICorner")
    nbCorner.CornerRadius = UDim.new(0, 8)
    nbCorner.Parent = nameBox
    
    local nameBtn = Instance.new("TextButton")
    nameBtn.Size = UDim2.new(0.25, 0, 0, 30)
    nameBtn.Position = UDim2.new(0.7, 0, 0.18, 0)
    nameBtn.Text = "Set"
    nameBtn.BackgroundColor3 = theme.button1
    nameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameBtn.Font = Enum.Font.GothamBold
    nameBtn.TextSize = 12
    nameBtn.Parent = frame
    
    local nBtnCorner = Instance.new("UICorner")
    nBtnCorner.CornerRadius = UDim.new(0, 8)
    nBtnCorner.Parent = nameBtn
    
    -- ==== DISPLAY NAME INPUT ====
    local displayBox = Instance.new("TextBox")
    displayBox.Size = UDim2.new(0.6, 0, 0, 30)
    displayBox.Position = UDim2.new(0.05, 0, 0.30, 0)
    displayBox.PlaceholderText = "Display name..."
    displayBox.BackgroundColor3 = theme.accent2
    displayBox.TextColor3 = theme.text
    displayBox.BackgroundTransparency = 0.2
    displayBox.Font = Enum.Font.Gotham
    displayBox.TextSize = 13
    displayBox.ClearTextOnFocus = false
    displayBox.Parent = frame
    
    local dbCorner = Instance.new("UICorner")
    dbCorner.CornerRadius = UDim.new(0, 8)
    dbCorner.Parent = displayBox
    
    local displayBtn = Instance.new("TextButton")
    displayBtn.Size = UDim2.new(0.25, 0, 0, 30)
    displayBtn.Position = UDim2.new(0.7, 0, 0.30, 0)
    displayBtn.Text = "Set"
    displayBtn.BackgroundColor3 = theme.button2
    displayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    displayBtn.Font = Enum.Font.GothamBold
    displayBtn.TextSize = 12
    displayBtn.Parent = frame
    
    local dBtnCorner = Instance.new("UICorner")
    dBtnCorner.CornerRadius = UDim.new(0, 8)
    dBtnCorner.Parent = displayBtn
    
    -- ==== FLY BUTTON (Premium only) ====
    local flyBtn = Instance.new("TextButton")
    flyBtn.Size = UDim2.new(0.9, 0, 0, 35)
    flyBtn.Position = UDim2.new(0.05, 0, 0.44, 0)
    flyBtn.Text = isPremium and "✈️ FLY: OFF (Press X to toggle)" or "🔒 FLY: Premium Only"
    flyBtn.BackgroundColor3 = isPremium and theme.button1 or Color3.fromRGB(50, 50, 70)
    flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    flyBtn.BackgroundTransparency = isPremium and 0 or 0.3
    flyBtn.Font = Enum.Font.GothamBold
    flyBtn.TextSize = 14
    flyBtn.Parent = frame
    
    local flyCorner = Instance.new("UICorner")
    flyCorner.CornerRadius = UDim.new(0, 8)
    flyCorner.Parent = flyBtn
    
    local flyStatus = Instance.new("TextLabel")
    flyStatus.Name = "Status"
    flyStatus.Size = UDim2.new(0.9, 0, 0, 20)
    flyStatus.Position = UDim2.new(0.05, 0, 0.57, 0)
    flyStatus.Text = isPremium and "✈️ Press X to toggle flight" or "⭐ Upgrade to Premium for fly feature"
    flyStatus.TextColor3 = isPremium and theme.status or Color3.fromRGB(150, 150, 150)
    flyStatus.BackgroundTransparency = 1
    flyStatus.Font = Enum.Font.Gotham
    flyStatus.TextSize = 11
    flyStatus.Parent = frame
    
    -- ==== SETTINGS BUTTON ====
    local settingsBtn = Instance.new("TextButton")
    settingsBtn.Size = UDim2.new(0.45, 0, 0, 30)
    settingsBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
    settingsBtn.Text = "⚙️ Settings"
    settingsBtn.BackgroundColor3 = theme.accent
    settingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    settingsBtn.Font = Enum.Font.GothamBold
    settingsBtn.TextSize = 13
    settingsBtn.Parent = frame
    
    local sBtnCorner = Instance.new("UICorner")
    sBtnCorner.CornerRadius = UDim.new(0, 8)
    sBtnCorner.Parent = settingsBtn
    
    -- ==== STATUS ====
    local status = Instance.new("TextLabel")
    status.Name = "Status"
    status.Size = UDim2.new(0.9, 0, 0, 20)
    status.Position = UDim2.new(0.05, 0, 0.88, 0)
    status.Text = "Press H to toggle • ESC to close"
    status.TextColor3 = theme.status
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.Gotham
    status.TextSize = 11
    status.Parent = frame
    
    -- ============================================
    -- SETTINGS FRAME
    -- ============================================
    
    local settingsFrame = Instance.new("Frame")
    settingsFrame.Name = "SettingsFrame"
    settingsFrame.Size = UDim2.new(0.9, 0, 0, 0)
    settingsFrame.Position = UDim2.new(0.05, 0, 0.73, 0)
    settingsFrame.BackgroundColor3 = theme.accent
    settingsFrame.BackgroundTransparency = 0.3
    settingsFrame.Visible = false
    settingsFrame.Parent = frame
    
    local sfCorner = Instance.new("UICorner")
    sfCorner.CornerRadius = UDim.new(0, 8)
    sfCorner.Parent = settingsFrame
    
    local sfTitle = Instance.new("TextLabel")
    sfTitle.Size = UDim2.new(1, 0, 0, 25)
    sfTitle.Position = UDim2.new(0, 0, 0, 0)
    sfTitle.Text = "🎨 Select Theme"
    sfTitle.TextColor3 = theme.text
    sfTitle.BackgroundTransparency = 1
    sfTitle.Font = Enum.Font.GothamBold
    sfTitle.TextSize = 14
    sfTitle.Parent = settingsFrame
    
    local themeNames = {"Purple", "Black", "Blue", "Gold", "Pink", "Cyber"}
    local themeEmojis = {"💜", "⬛", "🔵", "⭐", "💗", "💚"}
    
    for i, name in ipairs(themeNames) do
        local btn = Instance.new("TextButton")
        btn.Name = "ThemeBtn"
        btn.Size = UDim2.new(0.3, 0, 0, 25)
        btn.Position = UDim2.new((i-1) % 3 * 0.33 + 0.02, 0, math.floor((i-1)/3) * 0.35 + 0.12, 0)
        btn.Text = themeEmojis[i] .. " " .. name
        btn.BackgroundColor3 = Themes[name].accent
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundTransparency = 0.3
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.Parent = settingsFrame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            currentTheme = name
            ApplyTheme(frame, currentTheme)
            status.Text = "✅ Theme changed to: " .. Themes[name].name
            status.TextColor3 = Themes[name].status
        end)
    end
    
    local closeSettings = Instance.new("TextButton")
    closeSettings.Size = UDim2.new(0.2, 0, 0, 25)
    closeSettings.Position = UDim2.new(0.4, 0, 0.9, 0)
    closeSettings.Text = "Close"
    closeSettings.BackgroundColor3 = theme.button1
    closeSettings.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeSettings.BackgroundTransparency = 0.3
    closeSettings.Font = Enum.Font.GothamBold
    closeSettings.TextSize = 11
    closeSettings.Parent = settingsFrame
    
    local csCorner = Instance.new("UICorner")
    csCorner.CornerRadius = UDim.new(0, 6)
    csCorner.Parent = closeSettings
    
    closeSettings.MouseButton1Click:Connect(function()
        settingsFrame.Visible = false
        settingsFrame.Size = UDim2.new(0.9, 0, 0, 0)
        frame.Size = UDim2.new(0, 380, 0, 370)
    end)
    
    -- ============================================
    -- BUTTON EVENTS
    -- ============================================
    
    nameBtn.MouseButton1Click:Connect(function()
        if nameBox.Text ~= "" then
            SpoofName(nameBox.Text)
            status.Text = "✅ Name changed to: " .. nameBox.Text
            nameBox.Text = ""
        end
    end)
    
    displayBtn.MouseButton1Click:Connect(function()
        if displayBox.Text ~= "" then
            SpoofDisplayName(displayBox.Text)
            status.Text = "✅ Display name changed to: " .. displayBox.Text
            displayBox.Text = ""
        end
    end)
    
    -- Fly button
    flyBtn.MouseButton1Click:Connect(function()
        if not isPremium then
            status.Text = "❌ Fly feature requires Premium tier!"
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end
        Fly:Toggle()
        flyBtn.Text = Fly.Enabled and "✈️ FLY: ON (Press X to toggle)" or "✈️ FLY: OFF (Press X to toggle)"
        status.Text = Fly.Enabled and "✈️ Flying! WASD, Space up, Shift down" or "🛬 Landed!"
    end)
    
    -- Settings toggle
    local settingsOpen = false
    settingsBtn.MouseButton1Click:Connect(function()
        settingsOpen = not settingsOpen
        settingsFrame.Visible = settingsOpen
        if settingsOpen then
            settingsFrame.Size = UDim2.new(0.9, 0, 0, 140)
            frame.Size = UDim2.new(0, 380, 0, 510)
            ApplyTheme(settingsFrame, currentTheme)
        else
            settingsFrame.Size = UDim2.new(0.9, 0, 0, 0)
            frame.Size = UDim2.new(0, 380, 0, 370)
        end
    end)
    
    -- ============================================
    -- H KEY TOGGLE
    -- ============================================
    
    local visible = true
    local userInput = game:GetService("UserInputService")
    userInput.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.H then
            visible = not visible
            screenGui.Enabled = visible
            print("[UI] Toggled: " .. (visible and "Visible" or "Hidden"))
        end
    end)
    
    userInput.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.Escape then
            screenGui:Destroy()
        end
    end)
    
    print("✅ UI loaded! Press H to toggle, ESC to close")
end

-- ============================================
-- KEY UI
-- ============================================

local function CreateKeyUI()
    local player = game:GetService("Players").LocalPlayer
    if not player then return end
    
    local gui = player:FindFirstChild("PlayerGui")
    if not gui then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeyAuth"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = gui
    
    local theme = Themes[currentTheme]
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 380, 0, 250)
    frame.Position = UDim2.new(0.5, -190, 0.5, -125)
    frame.BackgroundColor3 = theme.background
    frame.BackgroundTransparency = theme.backgroundTransparency
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = frame
    
    local border = Instance.new("Frame")
    border.Name = "Border"
    border.Size = UDim2.new(1, 2, 1, 2)
    border.Position = UDim2.new(0, -1, 0, -1)
    border.BackgroundColor3 = theme.border
    border.BackgroundTransparency = 0.4
    border.BorderSizePixel = 0
    border.Parent = frame
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 15)
    borderCorner.Parent = border
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "🔑 KEY AUTHENTICATION"
    title.TextColor3 = theme.title
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.Parent = frame
    
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0.2, 0)
    sub.Text = "Enter FREE or your premium key"
    sub.TextColor3 = theme.text
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 13
    sub.Parent = frame
    
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.7, 0, 0, 40)
    keyBox.Position = UDim2.new(0.05, 0, 0.35, 0)
    keyBox.PlaceholderText = "Enter key..."
    keyBox.BackgroundColor3 = theme.accent2
    keyBox.TextColor3 = theme.text
    keyBox.BackgroundTransparency = 0.2
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextSize = 16
    keyBox.ClearTextOnFocus = false
    keyBox.Parent = frame
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 8)
    boxCorner.Parent = keyBox
    
    local authBtn = Instance.new("TextButton")
    authBtn.Size = UDim2.new(0.2, 0, 0, 40)
    authBtn.Position = UDim2.new(0.75, 0, 0.35, 0)
    authBtn.Text = "GO"
    authBtn.BackgroundColor3 = theme.button1
    authBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    authBtn.Font = Enum.Font.GothamBold
    authBtn.TextSize = 16
    authBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = authBtn
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "Status"
    statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
    statusLabel.Position = UDim2.new(0.05, 0, 0.65, 0)
    statusLabel.Text = "Enter FREE for free access"
    statusLabel.TextColor3 = theme.text
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 12
    statusLabel.Parent = frame
    
    local hint = Instance.new("TextLabel")
    hint.Size = UDim2.new(0.9, 0, 0, 20)
    hint.Position = UDim2.new(0.05, 0, 0.82, 0)
    hint.Text = "Premium = Fly feature (X to toggle)"
    hint.TextColor3 = theme.text
    hint.BackgroundTransparency = 1
    hint.Font = Enum.Font.Gotham
    hint.TextSize = 10
