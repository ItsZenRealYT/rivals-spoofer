--[[
    DEBUG VERSION - Shows every step
]]

print("🟢 STEP 1: Script started!")

-- Wait for player
local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("🟢 STEP 2: LocalPlayer =", player)

if not player then
    print("❌ No LocalPlayer! Waiting...")
    Players.PlayerAdded:Wait()
    player = Players.LocalPlayer
    print("🟢 STEP 3: Got player after wait:", player)
end

-- Wait for PlayerGui
local playerGui = player:WaitForChild("PlayerGui")
print("🟢 STEP 4: PlayerGui found:", playerGui)

-- Create a test UI to see if ScreenGuis work at all
local testGui = Instance.new("ScreenGui")
testGui.Name = "TestUI"
testGui.ResetOnSpawn = false
testGui.Parent = playerGui
print("🟢 STEP 5: Test GUI created!")

-- Add a simple label to the test GUI
local testLabel = Instance.new("TextLabel")
testLabel.Size = UDim2.new(0, 200, 0, 50)
testLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
testLabel.Text = "✅ UI WORKS!"
testLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
testLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
testLabel.BackgroundTransparency = 0.3
testLabel.Font = Enum.Font.GothamBold
testLabel.TextSize = 24
testLabel.Parent = testGui

print("🟢 STEP 6: Test label added! You should see 'UI WORKS!' on screen.")

-- Wait 3 seconds then remove test UI and load actual script
wait(3)
testGui:Destroy()
print("🟢 STEP 7: Test UI removed, loading actual script...")

-- ============================================
-- ACTUAL SCRIPT (Simplified)
-- ============================================

local KeySystem = {
    ValidKeys = {
        ["FREE"] = { tier = "Basic" },
        ["VIP-KEY-001"] = { tier = "VIP" },
        ["ULTRA-KEY-999"] = { tier = "Ultra" },
        ["LEGEND-777"] = { tier = "Legendary" },
    },
    IsAuthenticated = false,
    CurrentTier = nil
}

function KeySystem:ValidateKey(key)
    key = string.upper(key)
    local data = self.ValidKeys[key]
    if data then
        self.IsAuthenticated = true
        self.CurrentTier = data.tier
        return true, "✅ " .. data.tier .. " access granted!"
    end
    return false, "❌ Invalid key! Try: FREE"
end

print("🟢 STEP 8: KeySystem loaded!")

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

print("🟢 STEP 9: Spoofer functions loaded!")

-- ============================================
-- CREATE UI
-- ============================================

local function CreateUI()
    print("🟢 STEP 10: CreateUI() called!")
    
    local p = game:GetService("Players").LocalPlayer
    if not p then
        print("❌ No LocalPlayer in CreateUI!")
        return
    end
    
    local gui = p:FindFirstChild("PlayerGui")
    if not gui then
        print("❌ No PlayerGui found!")
        return
    end
    
    print("🟢 STEP 11: Creating ScreenGui...")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeyAuth"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = gui
    
    print("🟢 STEP 12: ScreenGui created! Parent =", screenGui.Parent)
    
    -- Main Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 220)
    frame.Position = UDim2.new(0.5, -175, 0.5, -110)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    print("🟢 STEP 13: Frame created!")

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "🔑 KEY AUTH"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.Parent = frame

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0.2, 0)
    sub.Text = "Enter FREE or your key"
    sub.TextColor3 = Color3.fromRGB(180, 180, 210)
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 13
    sub.Parent = frame

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

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
    statusLabel.Position = UDim2.new(0.05, 0, 0.7, 0)
    statusLabel.Text = "Enter FREE for free access"
    statusLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 12
    statusLabel.Parent = frame

    print("🟢 STEP 14: UI fully built!")

    -- ============================================
    -- BUTTON EVENT
    -- ============================================

    authBtn.MouseButton1Click:Connect(function()
        print("🟢 STEP 15: Auth button clicked!")
        local key = keyBox.Text:upper()
        print("🟢 Key entered:", key)
        
        if key == "" then
            statusLabel.Text = "⚠️ Please enter a key"
            statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
            return
        end
        
        local valid, msg = KeySystem:ValidateKey(key)
        print("🟢 Validation result:", valid, msg)
        
        if valid then
            statusLabel.Text = msg
            statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
            
            -- Create spoof UI
            print("🟢 STEP 16: Creating spoof UI...")
            
            local spoofGui = Instance.new("ScreenGui")
            spoofGui.Name = "SpooferUI"
            spoofGui.ResetOnSpawn = false
            spoofGui.Parent = gui
            
            local sf = Instance.new("Frame")
            sf.Size = UDim2.new(0, 280, 0, 180)
            sf.Position = UDim2.new(0.5, -140, 0.5, -90)
            sf.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
            sf.BackgroundTransparency = 0.1
            sf.BorderSizePixel = 0
            sf.Active = true
            sf.Draggable = true
            sf.Parent = spoofGui
            
            local sc = Instance.new("UICorner")
            sc.CornerRadius = UDim.new(0, 12)
            sc.Parent = sf
            
            local st = Instance.new("TextLabel")
            st.Size = UDim2.new(1, 0, 0, 35)
            st.Text = "✅ " .. KeySystem.CurrentTier .. " TIER"
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
            
            local btnCorner2 = Instance.new("UICorner")
            btnCorner2.CornerRadius = UDim.new(0, 8)
            btnCorner2.Parent = nameBtn
            
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
            
            local dbCorner2 = Instance.new("UICorner")
            dbCorner2.CornerRadius = UDim.new(0, 8)
            dbCorner2.Parent = displayBtn
            
            -- Button events
            nameBtn.MouseButton1Click:Connect(function()
                if nameBox.Text ~= "" then
                    SpoofName(nameBox.Text)
                    nameBox.Text = ""
                end
            end)
            
            displayBtn.MouseButton1Click:Connect(function()
                if displayBox.Text ~= "" then
                    SpoofDisplayName(displayBox.Text)
                    displayBox.Text = ""
                end
            end)
            
            -- Close button
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
            
            -- H key toggle
            local visible = true
            game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
                if processed then return end
                if input.KeyCode == Enum.KeyCode.H then
                    visible = not visible
                    spoofGui.Enabled = visible
                end
            end)
            
            print("🟢 STEP 17: Spoof UI created!")
            
        else
            statusLabel.Text = msg
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    keyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            authBtn.MouseButton1Click:Fire()
        end
    end)
    
    print("🟢 STEP 18: UI events connected!")
end

-- ============================================
-- START
-- ============================================

print("🟢 STEP 19: Starting CreateUI()...")
CreateUI()
print("🟢 STEP 20: Script finished!")
