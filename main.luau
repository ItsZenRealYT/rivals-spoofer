--[[
    FIXED SCRIPT - Should work 100%
    Shows debug prints for every step
]]

print("========================================")
print("🟢 STARTING FIXED SCRIPT")
print("========================================")

-- ============================================
-- SIMPLE KEY SYSTEM
-- ============================================

local ValidKeys = {
    ["FREE"] = "Basic",
    ["VIP-KEY-001"] = "VIP",
    ["ULTRA-KEY-999"] = "Ultra",
    ["LEGEND-777"] = "Legendary",
}

local authenticated = false
local currentTier = nil

local function ValidateKey(key)
    key = string.upper(key)
    local tier = ValidKeys[key]
    if tier then
        authenticated = true
        currentTier = tier
        return true, "✅ " .. tier .. " access granted!"
    end
    return false, "❌ Invalid key! Try: FREE"
end

print("🟢 Key system loaded!")

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

print("🟢 Spoofer functions loaded!")

-- ============================================
-- CREATE UI (SIMPLIFIED)
-- ============================================

local function CreateMainUI()
    print("🟢 Creating Main UI...")
    
    local player = game:GetService("Players").LocalPlayer
    if not player then
        print("❌ No player found!")
        return
    end
    
    local gui = player:FindFirstChild("PlayerGui")
    if not gui then
        print("❌ No PlayerGui found!")
        return
    end
    
    print("🟢 PlayerGui found!")
    
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeyAuthUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = gui
    
    print("🟢 ScreenGui created!")
    
    -- Main Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 380, 0, 240)
    frame.Position = UDim2.new(0.5, -190, 0.5, -120)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    frame.BackgroundTransparency = 0.15
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    -- Corner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = frame
    
    -- Border glow
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
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "🔑 KEY AUTHENTICATION"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.Parent = frame
    
    -- Subtitle
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0.2, 0)
    sub.Text = "Enter FREE or your premium key"
    sub.TextColor3 = Color3.fromRGB(180, 180, 210)
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 13
    sub.Parent = frame
    
    -- Key Input
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.7, 0, 0, 40)
    keyBox.Position = UDim2.new(0.05, 0, 0.35, 0)
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
    
    -- Auth Button
    local authBtn = Instance.new("TextButton")
    authBtn.Size = UDim2.new(0.2, 0, 0, 40)
    authBtn.Position = UDim2.new(0.75, 0, 0.35, 0)
    authBtn.Text = "GO"
    authBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    authBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    authBtn.Font = Enum.Font.GothamBold
    authBtn.TextSize = 16
    authBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = authBtn
    
    -- Status Label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
    statusLabel.Position = UDim2.new(0.05, 0, 0.65, 0)
    statusLabel.Text = "Enter FREE for free access"
    statusLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 12
    statusLabel.Parent = frame
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.Text = "✕"
    closeBtn.BackgroundTransparency = 1
    closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    closeBtn.Font = Enum.Font.Gotham
    closeBtn.TextSize = 18
    closeBtn.Parent = frame
    
    print("🟢 UI built successfully!")
    
    -- ============================================
    -- BUTTON EVENT
    -- ============================================
    
    authBtn.MouseButton1Click:Connect(function()
        local key = keyBox.Text:upper()
        print("🟢 Key entered:", key)
        
        if key == "" then
            statusLabel.Text = "⚠️ Please enter a key"
            statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
            return
        end
        
        local valid, msg = ValidateKey(key)
        print("🟢 Valid:", valid, msg)
        
        if valid then
            statusLabel.Text = msg
            statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
            
            -- Hide key UI, show spoofer UI
            screenGui.Enabled = false
            
            print("🟢 Creating Spoofer UI...")
            
            -- Create Spoofer UI
            local spoofGui = Instance.new("ScreenGui")
            spoofGui.Name = "SpooferUI"
            spoofGui.ResetOnSpawn = false
            spoofGui.Parent = gui
            
            local sf = Instance.new("Frame")
            sf.Size = UDim2.new(0, 320, 0, 220)
            sf.Position = UDim2.new(0.5, -160, 0.5, -110)
            sf.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
            sf.BackgroundTransparency = 0.1
            sf.BorderSizePixel = 0
            sf.Active = true
            sf.Draggable = true
            sf.Parent = spoofGui
            
            local sfCorner = Instance.new("UICorner")
            sfCorner.CornerRadius = UDim.new(0, 15)
            sfCorner.Parent = sf
            
            -- Title
            local sfTitle = Instance.new("TextLabel")
            sfTitle.Size = UDim2.new(1, 0, 0, 40)
            sfTitle.Position = UDim2.new(0, 0, 0, 0)
            sfTitle.Text = "✅ " .. currentTier .. " TIER"
            sfTitle.TextColor3 = Color3.fromRGB(0, 255, 100)
            sfTitle.BackgroundTransparency = 1
            sfTitle.Font = Enum.Font.GothamBold
            sfTitle.TextSize = 20
            sfTitle.Parent = sf
            
            -- Name input
            local nameBox = Instance.new("TextBox")
            nameBox.Size = UDim2.new(0.6, 0, 0, 30)
            nameBox.Position = UDim2.new(0.05, 0, 0.25, 0)
            nameBox.PlaceholderText = "New name..."
            nameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
            nameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameBox.Font = Enum.Font.Gotham
            nameBox.TextSize = 13
            nameBox.ClearTextOnFocus = false
            nameBox.Parent = sf
            
            local nbCorner = Instance.new("UICorner")
            nbCorner.CornerRadius = UDim.new(0, 8)
            nbCorner.Parent = nameBox
            
            local nameBtn = Instance.new("TextButton")
            nameBtn.Size = UDim2.new(0.25, 0, 0, 30)
            nameBtn.Position = UDim2.new(0.7, 0, 0.25, 0)
            nameBtn.Text = "Set"
            nameBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
            nameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameBtn.Font = Enum.Font.GothamBold
            nameBtn.TextSize = 12
            nameBtn.Parent = sf
            
            local nBtnCorner = Instance.new("UICorner")
            nBtnCorner.CornerRadius = UDim.new(0, 8)
            nBtnCorner.Parent = nameBtn
            
            -- Display name input
            local displayBox = Instance.new("TextBox")
            displayBox.Size = UDim2.new(0.6, 0, 0, 30)
            displayBox.Position = UDim2.new(0.05, 0, 0.45, 0)
            displayBox.PlaceholderText = "Display name..."
            displayBox.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
            displayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            displayBox.Font = Enum.Font.Gotham
            displayBox.TextSize = 13
            displayBox.ClearTextOnFocus = false
            displayBox.Parent = sf
            
            local dbCorner = Instance.new("UICorner")
            dbCorner.CornerRadius = UDim.new(0, 8)
            dbCorner.Parent = displayBox
            
            local displayBtn = Instance.new("TextButton")
            displayBtn.Size = UDim2.new(0.25, 0, 0, 30)
            displayBtn.Position = UDim2.new(0.7, 0, 0.45, 0)
            displayBtn.Text = "Set"
            displayBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
            displayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            displayBtn.Font = Enum.Font.GothamBold
            displayBtn.TextSize = 12
            displayBtn.Parent = sf
            
            local dBtnCorner = Instance.new("UICorner")
            dBtnCorner.CornerRadius = UDim.new(0, 8)
            dBtnCorner.Parent = displayBtn
            
            -- Status
            local sfStatus = Instance.new("TextLabel")
            sfStatus.Size = UDim2.new(0.9, 0, 0, 20)
            sfStatus.Position = UDim2.new(0.05, 0, 0.78, 0)
            sfStatus.Text = "Press H to toggle UI"
            sfStatus.TextColor3 = Color3.fromRGB(150, 150, 180)
            sfStatus.BackgroundTransparency = 1
            sfStatus.Font = Enum.Font.Gotham
            sfStatus.TextSize = 11
            sfStatus.Parent = sf
            
            -- Close button on spoof UI
            local sfClose = Instance.new("TextButton")
            sfClose.Size = UDim2.new(0, 30, 0, 30)
            sfClose.Position = UDim2.new(1, -35, 0, 5)
            sfClose.Text = "✕"
            sfClose.BackgroundTransparency = 1
            sfClose.TextColor3 = Color3.fromRGB(200, 200, 200)
            sfClose.Font = Enum.Font.Gotham
            sfClose.TextSize = 18
            sfClose.Parent = sf
            
            sfClose.MouseButton1Click:Connect(function()
                spoofGui:Destroy()
            end)
            
            -- Name button
            nameBtn.MouseButton1Click:Connect(function()
                if nameBox.Text ~= "" then
                    SpoofName(nameBox.Text)
                    sfStatus.Text = "✅ Name changed to: " .. nameBox.Text
                    nameBox.Text = ""
                end
            end)
            
            -- Display name button
            displayBtn.MouseButton1Click:Connect(function()
                if displayBox.Text ~= "" then
                    SpoofDisplayName(displayBox.Text)
                    sfStatus.Text = "✅ Display name changed to: " .. displayBox.Text
                    displayBox.Text = ""
                end
            end)
            
            -- H key toggle
            local visible = true
            game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
                if processed then return end
                if input.KeyCode == Enum.KeyCode.H then
                    visible = not visible
                    spoofGui.Enabled = visible
                end
            end)
            
            print("🟢 Spoofer UI created successfully!")
            
        else
            statusLabel.Text = msg
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
    
    -- Close button
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Enter key support
    keyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            authBtn.MouseButton1Click:Fire()
        end
    end)
    
    print("🟢 All events connected!")
end

-- ============================================
-- START
-- ============================================

print("🟢 Starting...")
CreateMainUI()
print("========================================")
print("🟢 SCRIPT FINISHED - UI SHOULD APPEAR")
print("🟢 Enter FREE to test")
print("========================================")
