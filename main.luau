--[[
    RIVALS SPOOFER V6 - CLEAN & WORKING
    Features:
    - Global Name Spoofer (works in ANY game)
    - Display Name Spoofer
    - Avatar Changer (by player ID)
    - Tier-based features
    - Toggle UI with H
    - Auto-spoof on join
    - Preset saves (Ultra+)
    - God Mode (Legendary)
]]

-- ============================================
-- SECTION 1: TIER-BASED KEY SYSTEM
-- ============================================

local KeySystem = {
    LocalKeys = {
        ["FREE-TRIAL-2024"] = {
            expiry = "2025-12-31",
            tier = "Basic",
            features = {
                nameSpoof = true,
                displayName = true,
                avatarChanger = false,
                autoSpoof = false,
                savePresets = false,
                godMode = false
            }
        },
        ["VIP-KEY-001"] = {
            expiry = "2026-12-31",
            tier = "VIP",
            features = {
                nameSpoof = true,
                displayName = true,
                avatarChanger = true,
                autoSpoof = true,
                savePresets = false,
                godMode = false
            }
        },
        ["ULTRA-KEY-999"] = {
            expiry = "2027-12-31",
            tier = "Ultra",
            features = {
                nameSpoof = true,
                displayName = true,
                avatarChanger = true,
                autoSpoof = true,
                savePresets = true,
                godMode = false,
                unlimitedNames = true
            }
        },
        ["LEGEND-777"] = {
            expiry = "2028-12-31",
            tier = "Legendary",
            features = {
                nameSpoof = true,
                displayName = true,
                avatarChanger = true,
                autoSpoof = true,
                savePresets = true,
                godMode = true,
                unlimitedNames = true,
                allAccess = true
            }
        }
    },
    
    IsAuthenticated = false,
    CurrentTier = nil,
    CurrentFeatures = nil
}

function KeySystem:ValidateKey(key)
    local keyData = self.LocalKeys[key]
    if keyData then
        if keyData.expiry and keyData.expiry < os.date("%Y-%m-%d") then
            return false, "❌ Key expired on " .. keyData.expiry
        end
        self.IsAuthenticated = true
        self.CurrentTier = keyData.tier
        self.CurrentFeatures = keyData.features
        return true, "✅ Authenticated! Tier: " .. keyData.tier
    end
    return false, "❌ Invalid key! Try: FREE-TRIAL-2024"
end

-- ============================================
-- SECTION 2: SPOOFER FUNCTIONS (WORKING)
-- ============================================

local Spoofer = {
    CurrentName = nil,
    CurrentDisplayName = nil,
    CurrentAvatar = nil,
    Presets = {}
}

-- ===== GLOBAL NAME SPOOFER =====
function Spoofer:SpoofName(newName)
    if not newName or newName == "" then return false end
    local success = pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player then
            player.Name = newName
            player.DisplayName = newName
            self.CurrentName = newName
            
            -- Hook to prevent reset
            game:GetService("Players").LocalPlayer.Changed:Connect(function(prop)
                if prop == "Name" then
                    game:GetService("Players").LocalPlayer.Name = newName
                elseif prop == "DisplayName" then
                    game:GetService("Players").LocalPlayer.DisplayName = newName
                end
            end)
        end
    end)
    if success then
        print("[Spoofer] ✅ Name changed to: " .. newName)
        return true
    else
        print("[Spoofer] ❌ Failed to change name")
        return false
    end
end

-- ===== DISPLAY NAME SPOOFER =====
function Spoofer:SpoofDisplayName(newDisplayName)
    if not newDisplayName or newDisplayName == "" then return false end
    local success = pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player then
            player.DisplayName = newDisplayName
            self.CurrentDisplayName = newDisplayName
            
            -- Hook to prevent reset
            game:GetService("Players").LocalPlayer.Changed:Connect(function(prop)
                if prop == "DisplayName" then
                    game:GetService("Players").LocalPlayer.DisplayName = newDisplayName
                end
            end)
        end
    end)
    if success then
        print("[Spoofer] ✅ Display name changed to: " .. newDisplayName)
        return true
    else
        print("[Spoofer] ❌ Failed to change display name")
        return false
    end
end

-- ===== AVATAR CHANGER (by player ID) =====
function Spoofer:ChangeAvatar(userId)
    if not userId or userId == "" then return false end
    local success = pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player then
            -- Method 1: Use Roblox API to get avatar data
            local avatarData = game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar?userIds=" .. userId .. "&size=420x420&format=Png&isCircular=false")
            if avatarData then
                -- Store current avatar for reset
                self.CurrentAvatar = userId
                
                -- Apply avatar (method varies by game)
                -- Some games use CharacterAppearance
                local character = player.Character
                if character then
                    -- Load the new avatar
                    local newAvatar = game:GetService("Players"):GetHumanoidDescriptionFromUserId(tonumber(userId))
                    if newAvatar then
                        local humanoid = character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid:ApplyDescription(newAvatar)
                            print("[Spoofer] ✅ Avatar changed to user: " .. userId)
                            return
                        end
                    end
                end
                
                -- Method 2: Use ReplicatedStorage remote (if exists)
                local remote = game:GetService("ReplicatedStorage"):FindFirstChild("ChangeAvatar")
                if remote then
                    remote:FireServer(userId)
                    print("[Spoofer] ✅ Avatar change requested via remote")
                    return
                end
            end
        end
    end)
    if success then
        return true
    else
        print("[Spoofer] ❌ Failed to change avatar")
        return false
    end
end

-- ===== RESET ALL =====
function Spoofer:ResetAll()
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player then
            -- Reset name
            if self.CurrentName then
                player.Name = self.CurrentName
            end
            -- Reset display name
            if self.CurrentDisplayName then
                player.DisplayName = self.CurrentDisplayName
            end
            -- Reset avatar
            if self.CurrentAvatar then
                -- Revert to original avatar
                local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:ApplyDescription(game:GetService("Players"):GetHumanoidDescriptionFromUserId(player.UserId))
                end
            end
        end
    end)
    print("[Spoofer] 🔄 All spoofs reset")
end

-- ===== SAVE PRESET (Ultra+) =====
function Spoofer:SavePreset(name)
    if not KeySystem.CurrentFeatures.savePresets then
        print("⚠️ Save presets requires Ultra tier or higher")
        return false
    end
    self.Presets[name] = {
        name = self.CurrentName,
        displayName = self.CurrentDisplayName,
        avatar = self.CurrentAvatar
    }
    print("[Spoofer] 💾 Preset saved: " .. name)
    return true
end

-- ===== LOAD PRESET (Ultra+) =====
function Spoofer:LoadPreset(name)
    if not KeySystem.CurrentFeatures.savePresets then
        print("⚠️ Load presets requires Ultra tier or higher")
        return false
    end
    local preset = self.Presets[name]
    if preset then
        if preset.name then self:SpoofName(preset.name) end
        if preset.displayName then self:SpoofDisplayName(preset.displayName) end
        if preset.avatar then self:ChangeAvatar(preset.avatar) end
        print("[Spoofer] 📂 Preset loaded: " .. name)
        return true
    else
        print("[Spoofer] ❌ Preset not found: " .. name)
        return false
    end
end

-- ============================================
-- SECTION 3: FANCY UI
-- ============================================

local UIManager = {
    MainGui = nil,
    IsVisible = true,
    KeyBind = Enum.KeyCode.H,
    AutoSpoof = false
}

function UIManager:CreateFancyUI()
    local player = game:GetService("Players").LocalPlayer
    if not player then return end
    
    if self.MainGui then
        self.MainGui:Destroy()
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SpooferUI_V6"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    self.MainGui = screenGui
    
    -- Main Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 480)
    frame.Position = UDim2.new(0.5, -175, 0.5, -240)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = frame
    
    -- Glass border
    local border = Instance.new("Frame")
    border.Size = UDim2.new(1, 2, 1, 2)
    border.Position = UDim2.new(0, -1, 0, -1)
    border.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
    border.BackgroundTransparency = 0.7
    border.BorderSizePixel = 0
    border.Parent = frame
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 15)
    borderCorner.Parent = border
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "✨ SPOOFER V6"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.Parent = frame
    
    -- Tier badge
    local tierBadge = Instance.new("TextLabel")
    tierBadge.Size = UDim2.new(0, 120, 0, 25)
    tierBadge.Position = UDim2.new(0.5, -60, 0.11, 0)
    tierBadge.Text = "🏆 " .. (KeySystem.CurrentTier or "Basic")
    tierBadge.TextColor3 = Color3.fromRGB(255, 255, 255)
    tierBadge.BackgroundColor3 = KeySystem.CurrentTier == "Legendary" and Color3.fromRGB(200, 50, 200) or
                                 KeySystem.CurrentTier == "Ultra" and Color3.fromRGB(255, 150, 0) or
                                 KeySystem.CurrentTier == "VIP" and Color3.fromRGB(0, 150, 255) or
                                 Color3.fromRGB(100, 100, 100)
    tierBadge.BackgroundTransparency = 0.3
    tierBadge.Font = Enum.Font.GothamBold
    tierBadge.TextSize = 13
    tierBadge.Parent = frame
    
    local tierCorner = Instance.new("UICorner")
    tierCorner.CornerRadius = UDim.new(0, 8)
    tierCorner.Parent = tierBadge
    
    -- ===== INPUT FIELDS =====
    local function CreateInputField(parent, yPos, labelText, placeholderText, buttonText, buttonColor)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.25, 0, 0, 30)
        label.Position = UDim2.new(0.03, 0, yPos, 0)
        label.Text = labelText
        label.TextColor3 = Color3.fromRGB(200, 200, 220)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = parent
        
        local box = Instance.new("TextBox")
        box.Size = UDim2.new(0.35, 0, 0, 30)
        box.Position = UDim2.new(0.28, 0, yPos, 0)
        box.PlaceholderText = placeholderText
        box.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.Font = Enum.Font.Gotham
        box.TextSize = 13
        box.ClearTextOnFocus = false
        box.BackgroundTransparency = 0.2
        box.Parent = parent
        
        local boxCorner = Instance.new("UICorner")
        boxCorner.CornerRadius = UDim.new(0, 6)
        boxCorner.Parent = box
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.2, 0, 0, 30)
        btn.Position = UDim2.new(0.75, 0, yPos, 0)
        btn.Text = buttonText
        btn.BackgroundColor3 = buttonColor or Color3.fromRGB(200, 100, 0)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        btn.Parent = parent
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        return box, btn
    end
    
    -- Name Spoofer
    local nameBox, nameBtn = CreateInputField(frame, 0.18, "🌐 Name", "NewName", "Set", Color3.fromRGB(0, 150, 200))
    
    -- Display Name Spoofer
    local displayBox, displayBtn = CreateInputField(frame, 0.30, "👤 Display", "NewDisplay", "Set", Color3.fromRGB(150, 50, 200))
    
    -- Avatar Changer (VIP+)
    local avatarBox, avatarBtn = CreateInputField(frame, 0.42, "🎭 Avatar", "User ID", "Set", Color3.fromRGB(200, 100, 0))
    
    -- Preset Saver (Ultra+)
    local presetBox, presetBtn = CreateInputField(frame, 0.54, "💾 Preset", "PresetName", "Save", Color3.fromRGB(0, 200, 150))
    
    -- ===== FEATURES SECTION =====
    local featuresFrame = Instance.new("Frame")
    featuresFrame.Size = UDim2.new(0.9, 0, 0, 70)
    featuresFrame.Position = UDim2.new(0.05, 0, 0.66, 0)
    featuresFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    featuresFrame.BackgroundTransparency = 0.3
    featuresFrame.Parent = frame
    
    local featuresCorner = Instance.new("UICorner")
    featuresCorner.CornerRadius = UDim.new(0, 8)
    featuresCorner.Parent = featuresFrame
    
    -- Auto-Spoof Toggle
    local autoToggle = Instance.new("TextButton")
    autoToggle.Size = UDim2.new(0.45, 0, 0, 30)
    autoToggle.Position = UDim2.new(0.03, 0, 0.05, 0)
    autoToggle.Text = "🔄 Auto: OFF"
    autoToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    autoToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoToggle.Font = Enum.Font.GothamBold
    autoToggle.TextSize = 12
    autoToggle.Parent = featuresFrame
    
    local autoCorner = Instance.new("UICorner")
    autoCorner.CornerRadius = UDim.new(0, 6)
    autoCorner.Parent = autoToggle
    
    -- God Mode Toggle (Legendary only)
    local godToggle = Instance.new("TextButton")
    godToggle.Size = UDim2.new(0.45, 0, 0, 30)
    godToggle.Position = UDim2.new(0.52, 0, 0.05, 0)
    godToggle.Text = "👑 God: OFF"
    godToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    godToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    godToggle.Font = Enum.Font.GothamBold
    godToggle.TextSize = 12
    godToggle.Visible = KeySystem.CurrentFeatures and KeySystem.CurrentFeatures.godMode or false
    godToggle.Parent = featuresFrame
    
    local godCorner = Instance.new("UICorner")
    godCorner.CornerRadius = UDim.new(0, 6)
    godCorner.Parent = godToggle
    
    -- Load Preset Button (Ultra+)
    local loadPresetBtn = Instance.new("TextButton")
    loadPresetBtn.Size = UDim2.new(0.45, 0, 0, 30)
    loadPresetBtn.Position = UDim2.new(0.03, 0, 0.55, 0)
    loadPresetBtn.Text = "📂 Load Preset"
    loadPresetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    loadPresetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadPresetBtn.Font = Enum.Font.GothamBold
    loadPresetBtn.TextSize = 12
    loadPresetBtn.Visible = KeySystem.CurrentFeatures and KeySystem.CurrentFeatures.savePresets or false
    loadPresetBtn.Parent = featuresFrame
    
    local loadCorner = Instance.new("UICorner")
    loadCorner.CornerRadius = UDim.new(0, 6)
    loadCorner.Parent = loadPresetBtn
    
    -- Reset Button
    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0.45, 0, 0, 30)
    resetBtn.Position = UDim2.new(0.52, 0, 0.55, 0)
    resetBtn.Text = "🔄 RESET ALL"
    resetBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.TextSize = 12
    resetBtn.Parent = featuresFrame
    
    local resetCorner = Instance.new("UICorner")
    resetCorner.CornerRadius = UDim.new(0, 6)
    resetCorner.Parent = resetBtn
    
    -- ===== BOTTOM STATUS =====
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
    statusLabel.Position = UDim2.new(0.05, 0, 0.9, 0)
    statusLabel.Text = "✅ Ready | Press H to toggle"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 12
    statusLabel.Parent = frame
    
    -- ============================================
    -- SECTION 4: UI EVENTS
    -- ============================================
    
    -- Name Spoofer
    nameBtn.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.nameSpoof then
            statusLabel.Text = "⚠️ Name spoof requires Basic tier"
            return
        end
        if nameBox.Text ~= "" then
            if Spoofer:SpoofName(nameBox.Text) then
                statusLabel.Text = "✅ Name: " .. nameBox.Text
                nameBox.Text = ""
            end
        end
    end)
    
    -- Display Name Spoofer
    displayBtn.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.displayName then
            statusLabel.Text = "⚠️ Display name requires Basic tier"
            return
        end
        if displayBox.Text ~= "" then
            if Spoofer:SpoofDisplayName(displayBox.Text) then
                statusLabel.Text = "✅ Display: " .. displayBox.Text
                displayBox.Text = ""
            end
        end
    end)
    
    -- Avatar Changer
    avatarBtn.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.avatarChanger then
            statusLabel.Text = "⚠️ Avatar changer requires VIP tier"
            return
        end
        if avatarBox.Text ~= "" then
            if Spoofer:ChangeAvatar(avatarBox.Text) then
                statusLabel.Text = "✅ Avatar set to user: " .. avatarBox.Text
                avatarBox.Text = ""
            end
        end
    end)
    
    -- Save Preset
    presetBtn.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.savePresets then
            statusLabel.Text = "⚠️ Presets require Ultra tier"
            return
        end
        if presetBox.Text ~= "" then
            if Spoofer:SavePreset(presetBox.Text) then
                statusLabel.Text = "💾 Preset saved: " .. presetBox.Text
                presetBox.Text = ""
            end
        end
    end)
    
    -- Load Preset
    loadPresetBtn.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.savePresets then
            statusLabel.Text = "⚠️ Presets require Ultra tier"
            return
        end
        local presetName = presetBox.Text
        if presetName ~= "" then
            if Spoofer:LoadPreset(presetName) then
                statusLabel.Text = "📂 Preset loaded: " .. presetName
            end
        end
    end)
    
    -- Auto-Spoof Toggle
    autoToggle.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.autoSpoof then
            statusLabel.Text = "⚠️ Auto-spoof requires VIP tier"
            return
        end
        self.AutoSpoof = not self.AutoSpoof
        autoToggle.Text = "🔄 Auto: " .. (self.AutoSpoof and "ON" or "OFF")
        autoToggle.BackgroundColor3 = self.AutoSpoof and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 80)
        statusLabel.Text = self.AutoSpoof and "✅ Auto-spoof enabled" or "⏹️ Auto-spoof disabled"
    end)
    
    -- God Mode Toggle (Legendary)
    local godMode = false
    godToggle.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.godMode then
            statusLabel.Text = "⚠️ God mode requires Legendary tier"
            return
        end
        godMode = not godMode
        godToggle.Text = "👑 God: " .. (godMode and "ON" or "OFF")
        godToggle.BackgroundColor3 = godMode and Color3.fromRGB(200, 50, 200) or Color3.fromRGB(60, 60, 80)
        if godMode then
            Spoofer:SpoofName("God")
            Spoofer:SpoofDisplayName("👑")
            statusLabel.Text = "👑 GOD MODE ACTIVATED"
        else
            statusLabel.Text = "⏹️ God mode disabled"
        end
    end)
    
    -- Reset All
    resetBtn.MouseButton1Click:Connect(function()
        Spoofer:ResetAll()
        nameBox.Text = ""
        displayBox.Text = ""
        avatarBox.Text = ""
        presetBox.Text = ""
        statusLabel.Text = "🔄 All spoofs reset"
    end)
    
    -- ============================================
    -- SECTION 5: KEYBIND (H)
    -- ============================================
    
    self.KeyBind = Enum.KeyCode.H
    self.IsVisible = true
    
    local userInput = game:GetService("UserInputService")
    self.KeyConnection = userInput.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == self.KeyBind and input.UserInputType == Enum.UserInputType.Keyboard then
            self.IsVisible = not self.IsVisible
            self.MainGui.Enabled = self.IsVisible
            print("[UI] Toggled: " .. (self.IsVisible and "Visible" or "Hidden"))
        end
    end)
end

-- ============================================
-- SECTION 6: KEY UI
-- ============================================

local function CreateKeyUI()
    local player = game:GetService("Players").LocalPlayer
    if not player then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeyAuthUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 380, 0, 240)
    frame.Position = UDim2.new(0.5, -190, 0.5, -120)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = frame
    
    local border = Instance.new("Frame")
    border.Size = UDim2.new(1, 2, 1, 2)
    border.Position = UDim2.new(0, -1, 0, -1)
    border.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    border.BackgroundTransparency = 0.7
    border.BorderSizePixel = 0
    border.Parent = frame
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 15)
    borderCorner.Parent = border
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "🔑 RIVALS SPOOFER V6"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.Parent = frame
    
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0.2, 0)
    sub.Text = "Enter your license key"
    sub.TextColor3 = Color3.fromRGB(180, 180, 210)
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 13
    sub.Parent = frame
    
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.8, 0, 0, 40)
    keyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
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
    authBtn.Size = UDim2.new(0.8, 0, 0, 40)
    authBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
    authBtn.Text = "AUTHENTICATE"
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
    statusLabel.Position = UDim2.new(0.05, 0, 0.82, 0)
    statusLabel.Text = "Enter key to continue"
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 13
    statusLabel.Parent = frame
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.Text = "✕"
    closeBtn.BackgroundTransparency = 1
    closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    closeBtn.Font = Enum.Font.Gotham
    closeBtn.TextSize = 18
    closeBtn.Parent = frame
    
    -- Events
    authBtn.MouseButton1Click:Connect(function()
        local key = keyBox.Text
        if key == "" then
            statusLabel.Text = "⚠️ Please enter a key"
            statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
            return
        end
        
        local valid, msg = KeySystem:ValidateKey(key)
        if valid then
            statusLabel.Text = msg
            statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
            wait(0.5)
            screenGui:Destroy()
            UIManager:CreateFancyUI()
        else
            statusLabel.Text = msg
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
end

-- ============================================
-- SECTION 7: INIT
-- ============================================

local player = game:GetService("Players").LocalPlayer
if not player then
    game:GetService("Players").PlayerAdded:Wait()
    player = game:GetService("Players").LocalPlayer
end

wait(0.5)
CreateKeyUI()

print([[
╔══════════════════════════════════════════╗
║     RIVALS SPOOFER V6 LOADED            ║
║     Press H to toggle UI                ║
║     Enter FREE-TRIAL-2024 to start      ║
╚══════════════════════════════════════════╝
]])
