--[[
    RIVALS SPOOFER V7 - WITH TIER EMOJIS
    Features:
    - Tier indicators with emojis
    - Global Name Spoofer
    - Display Name Spoofer
    - Avatar Changer (by player ID)
    - Tier-based features
    - Toggle UI with H
    - Auto-spoof on join
    - Preset saves (Ultra+)
    - God Mode (Legendary)
]]

-- ============================================
-- SECTION 1: TIER SYSTEM WITH EMOJIS
-- ============================================

local TierData = {
    Basic = {
        emoji = "🟢",
        color = Color3.fromRGB(100, 200, 100),
        badge = "BASIC",
        rank = 1
    },
    VIP = {
        emoji = "💎",
        color = Color3.fromRGB(0, 150, 255),
        badge = "VIP",
        rank = 2
    },
    Ultra = {
        emoji = "🔥",
        color = Color3.fromRGB(255, 150, 0),
        badge = "ULTRA",
        rank = 3
    },
    Legendary = {
        emoji = "👑",
        color = Color3.fromRGB(200, 50, 200),
        badge = "LEGENDARY",
        rank = 4
    }
}

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
                godMode = false,
                customColors = false
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
                godMode = false,
                customColors = true
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
                customColors = true,
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
                customColors = true,
                unlimitedNames = true,
                allAccess = true
            }
        }
    },
    
    IsAuthenticated = false,
    CurrentTier = nil,
    CurrentFeatures = nil
}

function KeySystem:GetTierData()
    if not self.CurrentTier then return TierData.Basic end
    return TierData[self.CurrentTier] or TierData.Basic
end

function KeySystem:GetTierEmoji()
    return self:GetTierData().emoji
end

function KeySystem:GetTierColor()
    return self:GetTierData().color
end

function KeySystem:GetTierBadge()
    return self:GetTierData().badge
end

function KeySystem:ValidateKey(key)
    local keyData = self.LocalKeys[key]
    if keyData then
        if keyData.expiry and keyData.expiry < os.date("%Y-%m-%d") then
            return false, "❌ Key expired on " .. keyData.expiry
        end
        self.IsAuthenticated = true
        self.CurrentTier = keyData.tier
        self.CurrentFeatures = keyData.features
        
        local emoji = self:GetTierEmoji()
        local badge = self:GetTierBadge()
        return true, "✅ Authenticated! " .. emoji .. " Tier: " .. badge
    end
    return false, "❌ Invalid key! Try: FREE-TRIAL-2024"
end

-- ============================================
-- SECTION 2: SPOOFER FUNCTIONS
-- ============================================

local Spoofer = {
    CurrentName = nil,
    CurrentDisplayName = nil,
    CurrentAvatar = nil,
    Presets = {}
}

function Spoofer:SpoofName(newName)
    if not newName or newName == "" then return false end
    local success = pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player then
            player.Name = newName
            player.DisplayName = newName
            self.CurrentName = newName
            
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
    end
    return false
end

function Spoofer:SpoofDisplayName(newDisplayName)
    if not newDisplayName or newDisplayName == "" then return false end
    local success = pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player then
            player.DisplayName = newDisplayName
            self.CurrentDisplayName = newDisplayName
            
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
    end
    return false
end

function Spoofer:ChangeAvatar(userId)
    if not userId or userId == "" then return false end
    local success = pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player then
            self.CurrentAvatar = userId
            local newAvatar = game:GetService("Players"):GetHumanoidDescriptionFromUserId(tonumber(userId))
            if newAvatar then
                local character = player.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:ApplyDescription(newAvatar)
                        print("[Spoofer] ✅ Avatar changed to user: " .. userId)
                        return
                    end
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

function Spoofer:ResetAll()
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player then
            if self.CurrentName then
                player.Name = self.CurrentName
            end
            if self.CurrentDisplayName then
                player.DisplayName = self.CurrentDisplayName
            end
            if self.CurrentAvatar then
                local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:ApplyDescription(game:GetService("Players"):GetHumanoidDescriptionFromUserId(player.UserId))
                end
            end
        end
    end)
    print("[Spoofer] 🔄 All spoofs reset")
end

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
-- SECTION 3: FANCY UI WITH TIER INDICATORS
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
    screenGui.Name = "SpooferUI_V7"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    self.MainGui = screenGui
    
    -- Get tier data
    local tierEmoji = KeySystem:GetTierEmoji()
    local tierColor = KeySystem:GetTierColor()
    local tierBadge = KeySystem:GetTierBadge()
    local tierName = KeySystem.CurrentTier or "Basic"
    
    -- Main Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 380, 0, 520)
    frame.Position = UDim2.new(0.5, -190, 0.5, -260)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = frame
    
    -- Glow border (color matches tier)
    local border = Instance.new("Frame")
    border.Size = UDim2.new(1, 2, 1, 2)
    border.Position = UDim2.new(0, -1, 0, -1)
    border.BackgroundColor3 = tierColor
    border.BackgroundTransparency = 0.5
    border.BorderSizePixel = 0
    border.Parent = frame
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 15)
    borderCorner.Parent = border
    
    -- Title with tier emoji
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = tierEmoji .. " SPOOFER V7"
    title.TextColor3 = tierColor
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.Parent = frame
    
    -- Tier Badge (large, center)
    local tierBadgeFrame = Instance.new("Frame")
    tierBadgeFrame.Size = UDim2.new(0, 180, 0, 35)
    tierBadgeFrame.Position = UDim2.new(0.5, -90, 0.11, 0)
    tierBadgeFrame.BackgroundColor3 = tierColor
    tierBadgeFrame.BackgroundTransparency = 0.2
    tierBadgeFrame.BorderSizePixel = 0
    tierBadgeFrame.Parent = frame
    
    local tierCorner = Instance.new("UICorner")
    tierCorner.CornerRadius = UDim.new(0, 10)
    tierCorner.Parent = tierBadgeFrame
    
    local tierLabel = Instance.new("TextLabel")
    tierLabel.Size = UDim2.new(1, 0, 1, 0)
    tierLabel.Text = tierEmoji .. " " .. tierBadge .. " TIER"
    tierLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    tierLabel.BackgroundTransparency = 1
    tierLabel.Font = Enum.Font.GothamBold
    tierLabel.TextSize = 16
    tierLabel.Parent = tierBadgeFrame
    
    -- Tier rank indicator (stars)
    local rankString = ""
    local rank = TierData[tierName].rank or 1
    for i = 1, rank do
        rankString = rankString .. "⭐"
    end
    local rankLabel = Instance.new("TextLabel")
    rankLabel.Size = UDim2.new(1, 0, 0, 20)
    rankLabel.Position = UDim2.new(0, 0, 0.18, 0)
    rankLabel.Text = rankString
    rankLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    rankLabel.BackgroundTransparency = 1
    rankLabel.Font = Enum.Font.Gotham
    rankLabel.TextSize = 14
    rankLabel.Parent = frame
    
    -- ===== INPUT FIELDS =====
    local function CreateInputField(parent, yPos, labelText, placeholderText, buttonText, buttonColor, tierLock)
        -- Lock icon for tier-locked features
        local lockIcon = ""
        if tierLock then
            lockIcon = "🔒 "
        end
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.25, 0, 0, 30)
        label.Position = UDim2.new(0.03, 0, yPos, 0)
        label.Text = lockIcon .. labelText
        label.TextColor3 = tierLock and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(200, 200, 220)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = parent
        
        local box = Instance.new("TextBox")
        box.Size = UDim2.new(0.35, 0, 0, 30)
        box.Position = UDim2.new(0.28, 0, yPos, 0)
        box.PlaceholderText = tierLock and "🔒 " .. placeholderText or placeholderText
        box.BackgroundColor3 = tierLock and Color3.fromRGB(30, 30, 40) or Color3.fromRGB(45, 45, 60)
        box.TextColor3 = tierLock and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(255, 255, 255)
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
        btn.Text = tierLock and "🔒" or buttonText
        btn.BackgroundColor3 = tierLock and Color3.fromRGB(60, 60, 80) or (buttonColor or Color3.fromRGB(200, 100, 0))
        btn.TextColor3 = tierLock and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        btn.Parent = parent
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        return box, btn
    end
    
    -- Name Spoofer (Basic+)
    local nameBox, nameBtn = CreateInputField(frame, 0.22, "🌐 Name", "NewName", "Set", Color3.fromRGB(0, 150, 200), false)
    
    -- Display Name Spoofer (Basic+)
    local displayBox, displayBtn = CreateInputField(frame, 0.34, "👤 Display", "NewDisplay", "Set", Color3.fromRGB(150, 50, 200), false)
    
    -- Avatar Changer (VIP+)
    local avatarLocked = not KeySystem.CurrentFeatures.avatarChanger
    local avatarBox, avatarBtn = CreateInputField(frame, 0.46, "🎭 Avatar", "User ID", "Set", Color3.fromRGB(200, 100, 0), avatarLocked)
    
    -- Preset Saver (Ultra+)
    local presetLocked = not KeySystem.CurrentFeatures.savePresets
    local presetBox, presetBtn = CreateInputField(frame, 0.58, "💾 Preset", "PresetName", "Save", Color3.fromRGB(0, 200, 150), presetLocked)
    
    -- ===== FEATURES SECTION =====
    local featuresFrame = Instance.new("Frame")
    featuresFrame.Size = UDim2.new(0.9, 0, 0, 80)
    featuresFrame.Position = UDim2.new(0.05, 0, 0.70, 0)
    featuresFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    featuresFrame.BackgroundTransparency = 0.3
    featuresFrame.Parent = frame
    
    local featuresCorner = Instance.new("UICorner")
    featuresCorner.CornerRadius = UDim.new(0, 8)
    featuresCorner.Parent = featuresFrame
    
    -- Auto-Spoof Toggle (VIP+)
    local autoLocked = not KeySystem.CurrentFeatures.autoSpoof
    local autoToggle = Instance.new("TextButton")
    autoToggle.Size = UDim2.new(0.45, 0, 0, 30)
    autoToggle.Position = UDim2.new(0.03, 0, 0.05, 0)
    autoToggle.Text = (autoLocked and "🔒 " or "🔄 ") .. "Auto: OFF"
    autoToggle.BackgroundColor3 = autoLocked and Color3.fromRGB(40, 40, 50) or Color3.fromRGB(60, 60, 80)
    autoToggle.TextColor3 = autoLocked and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(255, 255, 255)
    autoToggle.Font = Enum.Font.GothamBold
    autoToggle.TextSize = 12
    autoToggle.Parent = featuresFrame
    
    local autoCorner = Instance.new("UICorner")
    autoCorner.CornerRadius = UDim.new(0, 6)
    autoCorner.Parent = autoToggle
    
    -- God Mode Toggle (Legendary only)
    local godLocked = not KeySystem.CurrentFeatures.godMode
    local godToggle = Instance.new("TextButton")
    godToggle.Size = UDim2.new(0.45, 0, 0, 30)
    godToggle.Position = UDim2.new(0.52, 0, 0.05, 0)
    godToggle.Text = (godLocked and "🔒 " or "👑 ") .. "God: OFF"
    godToggle.BackgroundColor3 = godLocked and Color3.fromRGB(40, 40, 50) or Color3.fromRGB(60, 60, 80)
    godToggle.TextColor3 = godLocked and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(255, 255, 255)
    godToggle.Font = Enum.Font.GothamBold
    godToggle.TextSize = 12
    godToggle.Parent = featuresFrame
    
    local godCorner = Instance.new("UICorner")
    godCorner.CornerRadius = UDim.new(0, 6)
    godCorner.Parent = godToggle
    
    -- Load Preset Button (Ultra+)
    local loadLocked = not KeySystem.CurrentFeatures.savePresets
    local loadPresetBtn = Instance.new("TextButton")
    loadPresetBtn.Size = UDim2.new(0.45, 0, 0, 30)
    loadPresetBtn.Position = UDim2.new(0.03, 0, 0.55, 0)
    loadPresetBtn.Text = (loadLocked and "🔒 " or "📂 ") .. "Load Preset"
    loadPresetBtn.BackgroundColor3 = loadLocked and Color3.fromRGB(40, 40, 50) or Color3.fromRGB(60, 60, 80)
    loadPresetBtn.TextColor3 = loadLocked and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(255, 255, 255)
    loadPresetBtn.Font = Enum.Font.GothamBold
    loadPresetBtn.TextSize = 12
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
    
    -- ===== BOTTOM STATUS WITH TIER =====
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
    statusLabel.Position = UDim2.new(0.05, 0, 0.92, 0)
    statusLabel.Text = tierEmoji .. " " .. tierBadge .. " | Ready | Press H to toggle"
    statusLabel.TextColor3 = tierColor
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.TextSize = 12
    statusLabel.Parent = frame
    
    -- ============================================
    -- SECTION 4: UI EVENTS
    -- ============================================
    
    -- Helper function to update status
    local function UpdateStatus(text, isError)
        if isError then
            statusLabel.Text = "❌ " .. text
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        else
            statusLabel.Text = tierEmoji .. " " .. text
            statusLabel.TextColor3 = tierColor
        end
    end
    
    -- Name Spoofer
    nameBtn.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.nameSpoof then
            UpdateStatus("Name spoof requires Basic tier", true)
            return
        end
        if nameBox.Text ~= "" then
            if Spoofer:SpoofName(nameBox.Text) then
                UpdateStatus("✅ Name: " .. nameBox.Text)
                nameBox.Text = ""
            end
        end
    end)
    
    -- Display Name Spoofer
    displayBtn.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.displayName then
            UpdateStatus("Display name requires Basic tier", true)
            return
        end
        if displayBox.Text ~= "" then
            if Spoofer:SpoofDisplayName(displayBox.Text) then
                UpdateStatus("✅ Display: " .. displayBox.Text)
                displayBox.Text = ""
            end
        end
    end)
    
    -- Avatar Changer
    avatarBtn.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.avatarChanger then
            UpdateStatus("🔒 Avatar changer requires VIP tier", true)
            return
        end
        if avatarBox.Text ~= "" then
            if Spoofer:ChangeAvatar(avatarBox.Text) then
                UpdateStatus("✅ Avatar set to user: " .. avatarBox.Text)
                avatarBox.Text = ""
            end
        end
    end)
    
    -- Save Preset
    presetBtn.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.savePresets then
            UpdateStatus("🔒 Presets require Ultra tier", true)
            return
        end
        if presetBox.Text ~= "" then
            if Spoofer:SavePreset(presetBox.Text) then
                UpdateStatus("💾 Preset saved: " .. presetBox.Text)
                presetBox.Text = ""
            end
        end
    end)
    
    -- Load Preset
    loadPresetBtn.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.savePresets then
            UpdateStatus("🔒 Presets require Ultra tier", true)
            return
        end
        local presetName = presetBox.Text
        if presetName ~= "" then
            if Spoofer:LoadPreset(presetName) then
                UpdateStatus("📂 Preset loaded: " .. presetName)
            end
        end
    end)
    
    -- Auto-Spoof Toggle
    autoToggle.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.autoSpoof then
            UpdateStatus("🔒 Auto-spoof requires VIP tier", true)
            return
        end
        self.AutoSpoof = not self.AutoSpoof
        autoToggle.Text = "🔄 Auto: " .. (self.AutoSpoof and "ON" or "OFF")
        autoToggle.BackgroundColor3 = self.AutoSpoof and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 80)
        UpdateStatus(self.AutoSpoof and "✅ Auto-spoof enabled" or "⏹️ Auto-spoof disabled")
    end)
    
    -- God Mode Toggle
    local godMode = false
    godToggle.MouseButton1Click:Connect(function()
        if not KeySystem.CurrentFeatures.godMode then
            UpdateStatus("🔒 God mode requires Legendary tier", true)
            return
        end
        godMode = not godMode
        godToggle.Text = "👑 God: " .. (godMode and "ON" or "OFF")
        godToggle.BackgroundColor3 = godMode and Color3.fromRGB(200, 50, 200) or Color3.fromRGB(60, 60, 80)
        if godMode then
            Spoofer:SpoofName("God")
            Spoofer:SpoofDisplayName("👑")
            UpdateStatus("👑 GOD MODE ACTIVATED")
        else
            UpdateStatus("⏹️ God mode disabled")
        end
    end)
    
    -- Reset All
    resetBtn.MouseButton1Click:Connect(function()
        Spoofer:ResetAll()
        nameBox.Text = ""
        displayBox.Text = ""
        avatarBox.Text = ""
        presetBox.Text = ""
        UpdateStatus("🔄 All spoofs reset")
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
-- SECTION 6: KEY UI WITH TIER INDICATORS
-- ============================================

local function CreateKeyUI()
    local player = game:GetService("Players").LocalPlayer
    if not player then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeyAuthUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 420, 0, 280)
    frame.Position = UDim2.new(0.5, -210, 0.5, -140)
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
    border.BackgroundTransparency = 0.5
    border.BorderSizePixel = 0
    border.Parent = frame
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 15)
    borderCorner.Parent = border
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "🔑 RIVALS SPOOFER V7"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.Parent = frame
    
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0.18, 0)
    sub.Text = "Enter your license key"
    sub.TextColor3 = Color3.fromRGB(180, 180, 210)
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 13
    sub.Parent = frame
    
    -- Key Input Box
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.8, 0, 0, 40)
    keyBox.Position = UDim2.new(0.1, 0, 0.32, 0)
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
    
    -- Authenticate Button
    local authBtn = Instance.new("TextButton")
    authBtn.Size = UDim2.new(0.8, 0, 0, 40)
    authBtn.Position = UDim2.new(0.1, 0, 0.56, 0)
    authBtn.Text = "AUTHENTICATE"
    authBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    authBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    authBtn.Font = Enum.Font.GothamBold
    authBtn.TextSize = 16
    authBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = authBtn
    
    -- Status Label (will show tier emoji after auth)
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
    statusLabel.Position = UDim2.new(0.05, 0, 0.80, 0)
    statusLabel.Text = "Enter key to continue"
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 13
    statusLabel.Parent = frame
    
    -- Tier Legend (shows all tiers)
    local legendFrame = Instance.new("Frame")
    legendFrame.Size = UDim2.new(0.9, 0, 0, 30)
    legendFrame.Position = UDim2.new(0.05, 0, 0.90, 0)
    legendFrame.BackgroundTransparency = 1
    legendFrame.Parent = frame
    
    local legendText = Instance.new("TextLabel")
    legendText.Size = UDim2.new(1, 0, 1, 0)
    legendText.Text = "🟢Basic  💎VIP  🔥Ultra  👑Legendary"
    legendText.TextColor3 = Color3.fromRGB(150, 150, 180)
    legendText.BackgroundTransparency = 1
    legendText.Font = Enum.Font.Gotham
    legendText.TextSize = 11
    legendText.Parent = legendFrame
    
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
