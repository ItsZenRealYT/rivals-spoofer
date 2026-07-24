--[[
    RIVALS SPOOFER - ULTRA SIMPLE VERSION
    Keys: FREE or PREMIUM-3673111-NEVERTYPETHIS
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
    print("✅ Player found!")
end

-- ============================================
-- SIMPLE KEY SYSTEM
-- ============================================

local authenticated = false
local currentTier = nil

function ValidateKey(key)
    key = string.upper(key)
    print("🔑 Validating key:", key)
    
    if key == "FREE" then
        authenticated = true
        currentTier = "Basic"
        print("✅ FREE key validated!")
        return true, "✅ Free access granted! 🟢 Basic Tier"
    end
    
    if key == "PREMIUM-3673111-NEVERTYPETHIS" then
        authenticated = true
        currentTier = "Premium"
        print("✅ PREMIUM key validated!")
        return true, "⭐ Premium access granted! All features unlocked!"
    end
    
    print("❌ Invalid key:", key)
    return false, "❌ Invalid key! Try: FREE"
end

-- ============================================
-- SPOOFER FUNCTIONS
-- ============================================

local function SpoofName(newName)
    if not newName or newName == "" then return end
    print("📝 Spoofing name to:", newName)
    pcall(function()
        local p = game:GetService("Players").LocalPlayer
        if p then
            p.Name = newName
            p.DisplayName = newName
            print("✅ Name changed to:", newName)
        end
    end)
end

local function SpoofDisplayName(newName)
    if not newName or newName == "" then return end
    print("📝 Spoofing display name to:", newName)
    pcall(function()
        local p = game:GetService("Players").LocalPlayer
        if p then
            p.DisplayName = newName
            print("✅ Display name changed to:", newName)
        end
    end)
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
        print("✅ PlayerGui created!")
    end
    
    print("🟢 Creating ScreenGui...")
    
    -- Create main ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SpooferUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = gui
    
    print("🟢 ScreenGui parent:", screenGui.Parent)
    
    -- MAIN FRAME
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 250)
    frame.Position = UDim2.new(0.5, -175, 0.5, -125)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    frame.BackgroundTransparency = 0.15
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    print("🟢 Frame created!")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    -- TITLE
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "🔑 KEY AUTH"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.Parent = frame
    
    -- SUBTITLE
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0.18, 0)
    sub.Text = "Enter FREE or PREMIUM-3673111-NEVERTYPETHIS"
    sub.TextColor3 = Color3.fromRGB(180, 180, 210)
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 12
    sub.Parent = frame
    
    -- KEY INPUT
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
    
    -- GO BUTTON
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
    
    -- STATUS LABEL
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
    statusLabel.Position = UDim2.new(0.05, 0, 0.62, 0)
    statusLabel.Text = "Enter FREE for free access"
    statusLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 12
    statusLabel.Parent = frame
    
    -- HINT
    local hint = Instance.new("TextLabel")
    hint.Size = UDim2.new(0.9, 0, 0, 20)
    hint.Position = UDim2.new(0.05, 0, 0.78, 0)
    hint.Text = "Press H to toggle UI"
    hint.TextColor3 = Color3.fromRGB(150, 150, 180)
    hint.BackgroundTransparency = 1
    hint.Font = Enum.Font.Gotham
    hint.TextSize = 11
    hint.Parent = frame
    
    print("🟢 UI built successfully!")
    
    -- ============================================
    -- BUTTON EVENT
    -- ============================================
    
    authBtn.MouseButton1Click:Connect(function()
        local key = keyBox.Text:upper()
        print("🟢 Button clicked! Key:", key)
        
        if key == "" then
            statusLabel.Text = "⚠️ Please enter a key"
            statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
            return
        end
        
        local valid, msg = ValidateKey(key)
        
        if valid then
            statusLabel.Text = msg
            statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
            
            -- Hide key UI
            screenGui.Enabled = false
            
            -- Create spoof UI
            print("🟢 Creating spoof UI...")
            local spoofGui = Instance.new("ScreenGui")
            spoofGui.Name = "SpooferUI_Main"
            spoofGui.ResetOnSpawn = false
            spoofGui.Parent = gui
            
            local sf = Instance.new("Frame")
            sf.Size = UDim2.new(0, 300, 0, 180)
            sf.Position = UDim2.new(0.5, -150, 0.5, -90)
            sf.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
            sf.BackgroundTransparency = 0.15
            sf.BorderSizePixel = 0
            sf.Active = true
            sf.Draggable = true
            sf.Parent = spoofGui
            
            local sfCorner = Instance.new("UICorner")
            sfCorner.CornerRadius = UDim.new(0, 12)
            sfCorner.Parent = sf
            
            local st = Instance.new("TextLabel")
            st.Size = UDim2.new(1, 0, 0, 35)
            st.Position = UDim2.new(0, 0, 0, 0)
            st.Text = "✅ " .. (currentTier or "Basic") .. " TIER"
            st.TextColor3 = Color3.fromRGB(0, 255, 100)
            st.BackgroundTransparency = 1
            st.Font = Enum.Font.GothamBold
            st.TextSize = 18
            st.Parent = sf
            
            -- Name input
            local nameBox = Instance.new("TextBox")
            nameBox.Size = UDim2.new(0.6, 0, 0, 30)
            nameBox.Position = UDim2.new(0.05, 0, 0.3, 0)
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
            nameBtn.Position = UDim2.new(0.7, 0, 0.3, 0)
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
            displayBox.Position = UDim2.new(0.05, 0, 0.55, 0)
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
            displayBtn.Position = UDim2.new(0.7, 0, 0.55, 0)
            displayBtn.Text = "Set"
            displayBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
            displayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            displayBtn.Font = Enum.Font.GothamBold
            displayBtn.TextSize = 12
            displayBtn.Parent = sf
            
            local dBtnCorner = Instance.new("UICorner")
            dBtnCorner.CornerRadius = UDim.new(0, 8)
            dBtnCorner.Parent = displayBtn
            
            -- Status on spoof UI
            local sfStatus = Instance.new("TextLabel")
            sfStatus.Size = UDim2.new(0.9, 0, 0, 20)
            sfStatus.Position = UDim2.new(0.05, 0, 0.82, 0)
            sfStatus.Text = "Press H to toggle • ESC to close"
            sfStatus.TextColor3 = Color3.fromRGB(150, 150, 180)
            sfStatus.BackgroundTransparency = 1
            sfStatus.Font = Enum.Font.Gotham
            sfStatus.TextSize = 11
            sfStatus.Parent = sf
            
            -- Close button (X)
            local closeBtn = Instance.new("TextButton")
            closeBtn.Size = UDim2.new(0, 30, 0, 30)
            closeBtn.Position = UDim2.new(1, -35, 0, 5)
            closeBtn.Text = "✕"
            closeBtn.BackgroundTransparency = 1
            closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            closeBtn.Font = Enum.Font.Gotham
            closeBtn.TextSize = 18
            closeBtn.Parent = sf
            
            closeBtn.MouseButton1Click:Connect(function()
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
            local userInput = game:GetService("UserInputService")
            userInput.InputBegan:Connect(function(input, processed)
                if processed then return end
                if input.KeyCode == Enum.KeyCode.H then
                    visible = not visible
                    spoofGui.Enabled = visible
                    print("[UI] Toggled:", visible and "Visible" or "Hidden")
                end
            end)
            
            -- ESC to close
            userInput.InputBegan:Connect(function(input, processed)
                if processed then return end
                if input.KeyCode == Enum.KeyCode.Escape then
                    spoofGui:Destroy()
                end
            end)
            
            print("🟢 Spoof UI created successfully!")
            
        else
            statusLabel.Text = msg
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
    
    -- Enter key support
    keyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then authBtn.MouseButton1Click:Fire() end
    end)
    
    print("🟢 All events connected!")
    print("========================================")
    print("✅ UI SHOULD BE VISIBLE NOW")
    print("✅ Enter FREE or PREMIUM-3673111-NEVERTYPETHIS")
    print("========================================")
end

-- ============================================
-- START
-- ============================================

print("🟢 Starting CreateUI()...")
CreateUI()
print("🟢 Script finished!")
