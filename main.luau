--[[
    RIVALS SPOOFER V13 - CLEAN UI
    Features:
    - Name Spoofer (with label)
    - Display Name Spoofer (with label)
    - Avatar Changer (with label)
    - Presets (save/load)
    - Fly (Premium)
    - ESP (Premium)
    - Themes
]]

print("🟢 SCRIPT STARTED!")

-- ============================================
-- WAIT FOR PLAYER
-- ============================================

local player = game:GetService("Players").LocalPlayer
if not player then
    print("⏳ Waiting for player...")
    game:GetService("Players").PlayerAdded:Wait()
    player = game:GetService("Players").LocalPlayer
end
print("✅ Player found!")

-- ============================================
-- SIMPLE KEY SYSTEM
-- ============================================

local authenticated = false
local currentTier = nil

function ValidateKey(key)
    key = string.upper(key)
    
    if key == "FREE" then
        authenticated = true
        currentTier = "Basic"
        return true, "✅ Free access granted! 🟢 Basic Tier"
    end
    
    if key == "PREMIUM-3673111-NEVERTYPETHIS" then
        authenticated = true
        currentTier = "Premium"
        return true, "⭐ Premium access granted! All features unlocked!"
    end
    
    return false, "❌ Invalid key! Try: FREE"
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

local function ChangeAvatar(userId)
    if not userId or userId == "" then return end
    pcall(function()
        local p = game:GetService("Players").LocalPlayer
        if p then
            local desc = game:GetService("Players"):GetHumanoidDescriptionFromUserId(tonumber(userId))
            if desc then
                local humanoid = p.Character and p.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:ApplyDescription(desc)
                    print("✅ Avatar changed to user: " .. userId)
                end
            end
        end
    end)
end

-- ============================================
-- FLY FEATURE (Premium)
-- ============================================

local Fly = {
    Enabled = false,
    Speed = 50,
    BodyVelocity = nil,
    BodyGyro = nil,
    Connections = {}
}

function Fly:Toggle()
    local p = game:GetService("Players").LocalPlayer
    if not p or not p.Character then return end
    
    local humanoid = p.Character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
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
    
    self.Enabled = true
    humanoid.PlatformStand = true
    
    local rootPart = p.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    self.BodyVelocity = Instance.new("BodyVelocity")
    self.BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    self.BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    self.BodyVelocity.Parent = rootPart
    
    self.BodyGyro = Instance.new("BodyGyro")
    self.BodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    self.BodyGyro.CFrame = rootPart.CFrame
    self.BodyGyro.Parent = rootPart
    
    local runService = game:GetService("RunService")
    local userInput = game:GetService("UserInputService")
    
    local moveConnection = runService.RenderStepped:Connect(function()
        if not self.Enabled or not rootPart or not self.BodyVelocity then return end
        
        local moveDirection = Vector3.new(0, 0, 0)
        
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
        if userInput:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
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
    
    local keyConnection = userInput.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.X then
            self:Toggle()
        end
    end)
    table.insert(self.Connections, keyConnection)
    
    print("✈️ Flying enabled! WASD to move, Space up, Shift down, X to toggle")
end

-- ============================================
-- ESP FEATURE (Premium)
-- ============================================

local ESP = {
    Enabled = false,
    Boxes = {},
    Lines = {},
    Names = {},
    Connections = {}
}

function ESP:Toggle()
    self.Enabled = not self.Enabled
    
    if not self.Enabled then
        -- Clean up all ESP objects
        for _, v in ipairs(self.Boxes) do if v then v:Destroy() end end
        for _, v in ipairs(self.Lines) do if v then v:Destroy() end end
        for _, v in ipairs(self.Names) do if v then v:Destroy() end end
        self.Boxes = {}
        self.Lines = {}
        self.Names = {}
        for _, conn in ipairs(self.Connections) do if conn then conn:Disconnect() end end
        self.Connections = {}
        print("👻 ESP disabled")
        return
    end
    
    print("👻 ESP enabled")
    
    local runService = game:GetService("RunService")
    local players = game:GetService("Players")
    local camera = workspace.CurrentCamera
    
    local function CreateESP(player)
        if player == players.LocalPlayer then return end
        if not player.Character then return end
        
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        -- Create Box
        local box = Instance.new("BoxHandleAdornment")
        box.Size = Vector3.new(3, 5, 2)
        box.Color3 = Color3.fromRGB(0, 255, 0)
        box.Transparency = 0.5
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Adornee = rootPart
        box.Parent = rootPart
        table.insert(self.Boxes, box)
        
        -- Create Line (tracer)
        local line = Instance.new("LineHandleAdornment")
        line.Color3 = Color3.fromRGB(255, 0, 0)
        line.Thickness = 1
        line.Transparency = 0.6
        line.AlwaysOnTop = true
        line.ZIndex = 5
        line.Adornee = rootPart
        line.Parent = rootPart
        table.insert(self.Lines, line)
        
        -- Update line position
        local lineConn = runService.RenderStepped:Connect(function()
            if not line or not line.Parent then return end
            local playerPos = rootPart.Position
            local camPos = camera.CFrame.Position
            line.Points = {camPos, playerPos}
        end)
        table.insert(self.Connections, lineConn)
        
        -- Create Name label (BillboardGui)
        local nameGui = Instance.new("BillboardGui")
        nameGui.Size = UDim2.new(0, 100, 0, 30)
        nameGui.Adornee = rootPart
        nameGui.AlwaysOnTop = true
        nameGui.Parent = rootPart
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextStrokeTransparency = 0.3
        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 14
        nameLabel.Parent = nameGui
        table.insert(self.Names, nameGui)
    end
    
    -- ESP for existing players
    for _, plr in ipairs(players:GetPlayers()) do
        CreateESP(plr)
    end
    
    -- ESP for new players
    local joinConn = players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function()
            wait(0.5)
            CreateESP(plr)
        end)
    end)
    table.insert(self.Connections, joinConn)
end

-- ============================================
-- PRESETS
-- ============================================

local Presets = {}
local currentPresetName = ""

local function SavePreset(name)
    if name == "" then return false end
    Presets[name] = {
        name = "TestName",
        display = "TestDisplay",
        avatar = "123456789"
    }
    print("💾 Preset saved: " .. name)
    return true
end

local function LoadPreset(name)
    if not Presets[name] then
        print("❌ Preset not found: " .. name)
        return false
    end
    local p = Presets[name]
    SpoofName(p.name)
    SpoofDisplayName(p.display)
    ChangeAvatar(p.avatar)
    print("📂 Preset loaded: " .. name)
    return true
end

-- ============================================
-- CREATE UI
-- ============================================

local function CreateUI()
    print("🟢 Creating UI...")
    
    local p = game:GetService("Players").LocalPlayer
    if not p then
        print("❌ No player found!")
        return
    end
    
    local gui = p:FindFirstChild("PlayerGui")
    if not gui then
        print("❌ No PlayerGui found! Creating one...")
        gui = Instance.new("PlayerGui")
        gui.Parent = p
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SpooferUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = gui
    
    local isPremium = currentTier == "Premium"
    
    -- MAIN FRAME
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 520)
    frame.Position = UDim2.new(0.5, -200, 0.5, -260)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    frame.BackgroundTransparency = 0.15
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    -- TITLE
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = (isPremium and "⭐ " or "🟢 ") .. "SPOOFER MENU"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Parent = frame
    
    -- TIER DISPLAY
    local tierLabel = Instance.new("TextLabel")
    tierLabel.Size = UDim2.new(1, 0, 0, 20)
    tierLabel.Position = UDim2.new(0, 0, 0.1, 0)
    tierLabel.Text = "Tier: " .. (currentTier or "Not Authenticated")
    tierLabel.TextColor3 = isPremium and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(100, 200, 100)
    tierLabel.BackgroundTransparency = 1
    tierLabel.Font = Enum.Font.GothamBold
    tierLabel.TextSize = 14
    tierLabel.Parent = frame
    
    -- ============================================
    -- HELPER FUNCTION: Create labeled input
    -- ============================================
    
    local function CreateLabeledInput(yPos, labelText, placeholderText, buttonText, btnColor, isPremiumLocked)
        -- Label
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.9, 0, 0, 18)
        label.Position = UDim2.new(0.05, 0, yPos, 0)
        label.Text = labelText
        label.TextColor3 = isPremiumLocked and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(200, 200, 220)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        -- Input Box
        local box = Instance.new("TextBox")
        box.Size = UDim2.new(0.6, 0, 0, 30)
        box.Position = UDim2.new(0.05, 0, yPos + 0.045, 0)
        box.PlaceholderText = placeholderText
        box.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.BackgroundTransparency = 0.2
        box.Font = Enum.Font.Gotham
        box.TextSize = 13
        box.ClearTextOnFocus = false
        box.Parent = frame
        
        local boxCorner = Instance.new("UICorner")
        boxCorner.CornerRadius = UDim.new(0, 8)
        boxCorner.Parent = box
        
        -- Button
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.25, 0, 0, 30)
        btn.Position = UDim2.new(0.7, 0, yPos + 0.045, 0)
        btn.Text = isPremiumLocked and "🔒 " .. buttonText or buttonText
        btn.BackgroundColor3 = isPremiumLocked and Color3.fromRGB(80, 80, 100) or (btnColor or Color3.fromRGB(200, 100, 0))
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.Parent = frame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
        
        return box, btn
    end
    
    -- ============================================
    -- INPUT FIELDS WITH LABELS
    -- ============================================
    
    -- 1. Name Spoofer
    local nameBox, nameBtn = CreateLabeledInput(0.18, "🌐 Change Your Name", "New name...", "Set", Color3.fromRGB(0, 150, 200), false)
    
    -- 2. Display Name Spoofer
    local displayBox, displayBtn = CreateLabeledInput(0.32, "👤 Change Display Name", "New display name...", "Set", Color3.fromRGB(150, 50, 200), false)
    
    -- 3. Avatar Changer (Premium)
    local avatarBox, avatarBtn = CreateLabeledInput(0.46, "🎭 Change Avatar (User ID)", "Enter User ID...", "Set", Color3.fromRGB(200, 100, 0), not isPremium)
    
    -- 4. Presets (Premium)
    local presetBox, presetBtn = CreateLabeledInput(0.60, "💾 Presets (Save/Load)", "Preset name...", "Save", Color3.fromRGB(0, 200, 150), not isPremium)
    
    -- Load Preset button (placed separately)
    local loadPresetBtn = Instance.new("TextButton")
    loadPresetBtn.Size = UDim2.new(0.25, 0, 0, 30)
    loadPresetBtn.Position = UDim2.new(0.7, 0, 0.645, 0)
    loadPresetBtn.Text = not isPremium and "🔒 Load" or "Load"
    loadPresetBtn.BackgroundColor3 = not isPremium and Color3.fromRGB(80, 80, 100) or Color3.fromRGB(200, 150, 0)
    loadPresetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadPresetBtn.Font = Enum.Font.GothamBold
    loadPresetBtn.TextSize = 12
    loadPresetBtn.Parent = frame
    
    local loadCorner = Instance.new("UICorner")
    loadCorner.CornerRadius = UDim.new(0, 8)
    loadCorner.Parent = loadPresetBtn
    
    -- ============================================
    -- FLY TOGGLE (Premium)
    -- ============================================
    
    local flyBtn = Instance.new("TextButton")
    flyBtn.Size = UDim2.new(0.4, 0, 0, 30)
    flyBtn.Position = UDim2.new(0.05, 0, 0.72, 0)
    flyBtn.Text = isPremium and "✈️ FLY: OFF" or "🔒 FLY: Premium"
    flyBtn.BackgroundColor3 = isPremium and Color3.fromRGB(200, 100, 0) or Color3.fromRGB(80, 80, 100)
    flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    flyBtn.Font = Enum.Font.GothamBold
    flyBtn.TextSize = 13
    flyBtn.Parent = frame
    
    local flyCorner = Instance.new("UICorner")
    flyCorner.CornerRadius = UDim.new(0, 8)
    flyCorner.Parent = flyBtn
    
    -- ============================================
    -- ESP TOGGLE (Premium)
    -- ============================================
    
    local espBtn = Instance.new("TextButton")
    espBtn.Size = UDim2.new(0.4, 0, 0, 30)
    espBtn.Position = UDim2.new(0.55, 0, 0.72, 0)
    espBtn.Text = isPremium and "👻 ESP: OFF" or "🔒 ESP: Premium"
    espBtn.BackgroundColor3 = isPremium and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(80, 80, 100)
    espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    espBtn.Font = Enum.Font.GothamBold
    espBtn.TextSize = 13
    espBtn.Parent = frame
    
    local espCorner = Instance.new("UICorner")
    espCorner.CornerRadius = UDim.new(0, 8)
    espCorner.Parent = espBtn
    
    -- ============================================
    -- STATUS BAR
    -- ============================================
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 20)
    statusLabel.Position = UDim2.new(0.05, 0, 0.88, 0)
    statusLabel.Text = "Press H to toggle • ESC to close"
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 11
    statusLabel.Parent = frame
    
    -- ============================================
    -- BUTTON EVENTS
    -- ============================================
    
    -- Name Spoofer
    nameBtn.MouseButton1Click:Connect(function()
        if nameBox.Text ~= "" then
            SpoofName(nameBox.Text)
            statusLabel.Text = "✅ Name changed to: " .. nameBox.Text
            nameBox.Text = ""
        end
    end)
    
    -- Display Name Spoofer
    displayBtn.MouseButton1Click:Connect(function()
        if displayBox.Text ~= "" then
            SpoofDisplayName(displayBox.Text)
            statusLabel.Text = "✅ Display name changed to: " .. displayBox.Text
            displayBox.Text = ""
        end
    end)
    
    -- Avatar Changer (Premium)
    avatarBtn.MouseButton1Click:Connect(function()
        if not isPremium then
            statusLabel.Text = "❌ Avatar changer requires Premium tier!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end
        if avatarBox.Text ~= "" then
            ChangeAvatar(avatarBox.Text)
            statusLabel.Text = "✅ Avatar changed to user: " .. avatarBox.Text
            avatarBox.Text = ""
        end
    end)
    
    -- Save Preset (Premium)
    presetBtn.MouseButton1Click:Connect(function()
        if not isPremium then
            statusLabel.Text = "❌ Presets require Premium tier!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end
        if presetBox.Text ~= "" then
            SavePreset(presetBox.Text)
            statusLabel.Text = "💾 Preset saved: " .. presetBox.Text
            presetBox.Text = ""
        end
    end)
    
    -- Load Preset (Premium)
    loadPresetBtn.MouseButton1Click:Connect(function()
        if not isPremium then
            statusLabel.Text = "❌ Presets require Premium tier!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end
        if presetBox.Text ~= "" then
            LoadPreset(presetBox.Text)
            statusLabel.Text = "📂 Preset loaded: " .. presetBox.Text
            presetBox.Text = ""
        end
    end)
    
    -- Fly Toggle (Premium)
    flyBtn.MouseButton1Click:Connect(function()
        if not isPremium then
            statusLabel.Text = "❌ Fly requires Premium tier!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end
        Fly:Toggle()
        flyBtn.Text = "✈️ FLY: " .. (Fly.Enabled and "ON" or "OFF")
        statusLabel.Text = Fly.Enabled and "✈️ Flying! WASD, Space up, Shift down" or "🛬 Landed!"
    end)
    
    -- ESP Toggle (Premium)
    espBtn.MouseButton1Click:Connect(function()
        if not isPremium then
            statusLabel.Text = "❌ ESP requires Premium tier!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end
        ESP:Toggle()
        espBtn.Text = "👻 ESP: " .. (ESP.Enabled and "ON" or "OFF")
        statusLabel.Text = ESP.Enabled and "👻 ESP enabled! (Boxes, Lines, Names)" or "👻 ESP disabled"
    end)
    
    -- ============================================
    -- KEYBINDS
    -- ============================================
    
    local visible = true
    local userInput = game:GetService("UserInputService")
    
    -- H to toggle UI
    userInput.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.H then
            visible = not visible
            screenGui.Enabled = visible
        end
    end)
    
    -- ESC to close
    userInput.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.Escape then
            screenGui:Destroy()
        end
    end)
    
    print("✅ UI loaded!")
end

-- ============================================
-- KEY UI
-- ============================================

local function CreateKeyUI()
    print("🟢 Creating Key UI...")
    
    local p = game:GetService("Players").LocalPlayer
    if not p then return end
    
    local gui = p:FindFirstChild("PlayerGui")
    if not gui then
        gui = Instance.new("PlayerGui")
        gui.Parent = p
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeyAuth"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = gui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 260)
    frame.Position = UDim2.new(0.5, -200, 0.5, -130)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    frame.BackgroundTransparency = 0.15
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "🔑 KEY AUTHENTICATION"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.Parent = frame
    
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0.17, 0)
    sub.Text = "Enter your key below"
    sub.TextColor3 = Color3.fromRGB(180, 180, 210)
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 13
    sub.Parent = frame
    
    -- FREE KEY INFO
    local freeInfo = Instance.new("TextLabel")
    freeInfo.Size = UDim2.new(0.9, 0, 0, 20)
    freeInfo.Position = UDim2.new(0.05, 0, 0.27, 0)
    freeInfo.Text = "🟢 FREE key: type FREE"
    freeInfo.TextColor3 = Color3.fromRGB(100, 200, 100)
    freeInfo.BackgroundTransparency = 1
    freeInfo.Font = Enum.Font.GothamBold
    freeInfo.TextSize = 12
    freeInfo.Parent = frame
    
    -- PREMIUM KEY INFO
    local premInfo = Instance.new("TextLabel")
    premInfo.Size = UDim2.new(0.9, 0, 0, 20)
    premInfo.Position = UDim2.new(0.05, 0, 0.34, 0)
    premInfo.Text = "⭐ PREMIUM key: ask the owner to buy"
    premInfo.TextColor3 = Color3.fromRGB(255, 215, 0)
    premInfo.BackgroundTransparency = 1
    premInfo.Font = Enum.Font.GothamBold
    premInfo.TextSize = 12
    premInfo.Parent = frame
    
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.7, 0, 0, 40)
    keyBox.Position = UDim2.new(0.05, 0, 0.42, 0)
    keyBox.PlaceholderText = "Enter key..."
    keyBox.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextSize = 16
    keyBox.ClearTextOnFocus = false
    keyBox.Parent = frame
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 8)
    boxCorner.Parent = keyBox
    
    local authBtn = Instance.new("TextButton")
    authBtn.Size = UDim2.new(0.2, 0, 0, 40)
    authBtn.Position = UDim2.new(0.75, 0, 0.42, 0)
    authBtn.Text = "GO"
    authBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    authBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    authBtn.Font = Enum.Font.GothamBold
    authBtn.TextSize = 16
    authBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = authBtn
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
    statusLabel.Position = UDim2.new(0.05, 0, 0.7, 0)
    statusLabel.Text = "Enter FREE for free access"
    statusLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 12
    statusLabel.Parent = frame
    
    local hint = Instance.new("TextLabel")
    hint.Size = UDim2.new(0.9, 0, 0, 20)
    hint.Position = UDim2.new(0.05, 0, 0.85, 0)
    hint.Text = "Premium key is paid — contact the owner"
    hint.TextColor3 = Color3.fromRGB(255, 215, 0)
    hint.BackgroundTransparency = 1
    hint.Font = Enum.Font.Gotham
    hint.TextSize = 11
    hint.Parent = frame
    
    authBtn.MouseButton1Click:Connect(function()
        local key = keyBox.Text:upper()
        if key == "" then
            statusLabel.Text = "⚠️ Please enter a key"
            statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
            return
        end
        
        local valid, msg = ValidateKey(key)
        if valid then
            statusLabel.Text = msg
            statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
            wait(0.5)
            screenGui:Destroy()
            CreateUI()
        else
            statusLabel.Text = msg
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
    
    keyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then authBtn.MouseButton1Click:Fire() end
    end)
end

-- ============================================
-- START
-- ============================================

local p = game:GetService("Players").LocalPlayer
if not p then
    game:GetService("Players").PlayerAdded:Wait()
    p = game:GetService("Players").LocalPlayer
end

wait(0.5)
CreateKeyUI()

print([[
╔══════════════════════════════════════════╗
║   🔑 SPOOFER V13 LOADED                 ║
║   Keys: FREE or PREMIUM-3673111-...     ║
║   Premium = All features unlocked       ║
║   Press H to toggle • ESC to close      ║
╚══════════════════════════════════════════╝
]])
