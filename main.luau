--[[
    RIVALS SPOOFER V3 - Professional Key System
    Luarmor-style authentication + all spoofers
]]

-- ============================================
-- SECTION 1: KEY SYSTEM (Luarmor-style)
-- ============================================

local KeySystem = {
    -- Local keys (no internet required for these)
    LocalKeys = {
        ["FREE-TRIAL-2024"] = {expiry = "2025-12-31", tier = "Basic"},
        ["VIP-KEY-001"] = {expiry = "2026-12-31", tier = "VIP"},
        ["ULTRA-KEY-999"] = {expiry = "2027-12-31", tier = "Ultra"},
        ["LEGEND-777"] = {expiry = "2028-12-31", tier = "Legendary"}
    },
    
    IsAuthenticated = false,
    CurrentTier = nil
}

-- Validate key
function KeySystem:ValidateKey(key)
    local keyData = self.LocalKeys[key]
    if keyData then
        if keyData.expiry and keyData.expiry < os.date("%Y-%m-%d") then
            return false, "Key expired on " .. keyData.expiry
        end
        self.IsAuthenticated = true
        self.CurrentTier = keyData.tier
        return true, "✅ Authenticated! Tier: " .. keyData.tier
    end
    return false, "❌ Invalid key! Try: FREE-TRIAL-2024"
end

-- ============================================
-- SECTION 2: KEY UI
-- ============================================

local function CreateKeyUI()
    local player = game:GetService("Players").LocalPlayer
    if not player then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeyAuth"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- Main Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 220)
    frame.Position = UDim2.new(0.5, -175, 0.5, -110)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "🔑 RIVALS SPOOFER"
    title.TextColor3 = Color3.fromRGB(255, 200, 50)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Parent = frame
    
    -- Subtitle
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0.2, 0)
    sub.Text = "Enter your license key"
    sub.TextColor3 = Color3.fromRGB(180, 180, 200)
    sub.BackgroundTransparency = 1
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 13
    sub.Parent = frame
    
    -- Key Input Box
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.8, 0, 0, 40)
    keyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
    keyBox.PlaceholderText = "Enter key..."
    keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
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
    
    -- Status Label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
    statusLabel.Position = UDim2.new(0.05, 0, 0.82, 0)
    statusLabel.Text = "Enter key to continue"
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 13
    statusLabel.Parent = frame
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.Text = "✕"
    closeBtn.BackgroundTransparency = 1
    closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    closeBtn.Font = Enum.Font.Gotham
    closeBtn.TextSize = 18
    closeBtn.Parent = frame
    
    -- ============================================
    -- BUTTON EVENTS
    -- ============================================
    
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
            LoadSpoofers()
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
-- SECTION 3: SPOOFER FUNCTIONS
-- ============================================

-- Global Name Spoofer (works in ANY game)
local function SpoofName(newName)
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player then
            player.Name = newName
            player.DisplayName = newName
        end
    end)
    print("[Spoofer] Name changed to: " .. newName)
end

-- Winstreak Spoofer (Rivals)
local function SpoofWinstreak(streak)
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player then
            local stats = player:FindFirstChild("leaderstats")
            if stats then
                local ws = stats:FindFirstChild("Winstreak")
                if ws then ws.Value = streak end
            end
        end
    end)
    print("[Spoofer] Winstreak set to: " .. streak)
end

-- Level Spoofer (Rivals)
local function SpoofLevel(level)
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player then
            local stats = player:FindFirstChild("leaderstats")
            if stats then
                local lvl = stats:FindFirstChild("Level")
                if lvl then lvl.Value = level end
            end
        end
    end)
    print("[Spoofer] Level set to: " .. level)
end

-- Leaderboard Position Spoofer
local function SpoofLeaderboard(position)
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        local gui = player:FindFirstChild("PlayerGui")
        if gui then
            local lb = gui:FindFirstChild("Leaderboard")
            if lb then
                local frame = lb:FindFirstChild("Frame")
                if frame then
                    local cards = frame:GetChildren()
                    for _, card in ipairs(cards) do
                        if card:IsA("Frame") and card:FindFirstChild("PlayerName") then
                            local nameLabel = card:FindFirstChild("PlayerName")
                            if nameLabel and nameLabel.Text == player.Name then
                                card.Position = UDim2.new(0, 0, (position - 1) * 30, 0)
                            end
                        end
                    end
                end
            end
        end
    end)
    print("[Spoofer] Leaderboard position: #" .. position)
end

-- ============================================
-- SECTION 4: SPOOFER UI
-- ============================================

function LoadSpoofers()
    local player = game:GetService("Players").LocalPlayer
    if not player then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SpooferUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- Main frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 280, 0, 320)
    frame.Position = UDim2.new(0.5, -140, 0.5, -160)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Text = "🎯 SPOOFER | " .. (KeySystem.CurrentTier or "Basic")
    title.TextColor3 = Color3.fromRGB(255, 200, 50)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = frame
    
    -- Winstreak
    local wsBox = Instance.new("TextBox")
    wsBox.Size = UDim2.new(0.6, 0, 0, 30)
    wsBox.Position = UDim2.new(0.05, 0, 0.15, 0)
    wsBox.PlaceholderText = "Winstreak: 99"
    wsBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    wsBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    wsBox.Font = Enum.Font.Gotham
    wsBox.TextSize = 13
    wsBox.Parent = frame
    
    local wsBtn = Instance.new("TextButton")
    wsBtn.Size = UDim2.new(0.25, 0, 0, 30)
    wsBtn.Position = UDim2.new(0.7, 0, 0.15, 0)
    wsBtn.Text = "Set"
    wsBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    wsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    wsBtn.Font = Enum.Font.GothamBold
    wsBtn.TextSize = 13
    wsBtn.Parent = frame
    
    -- Level
    local lvlBox = Instance.new("TextBox")
    lvlBox.Size = UDim2.new(0.6, 0, 0, 30)
    lvlBox.Position = UDim2.new(0.05, 0, 0.30, 0)
    lvlBox.PlaceholderText = "Level: 100"
    lvlBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    lvlBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    lvlBox.Font = Enum.Font.Gotham
    lvlBox.TextSize = 13
    lvlBox.Parent = frame
    
    local lvlBtn = Instance.new("TextButton")
    lvlBtn.Size = UDim2.new(0.25, 0, 0, 30)
    lvlBtn.Position = UDim2.new(0.7, 0, 0.30, 0)
    lvlBtn.Text = "Set"
    lvlBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    lvlBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    lvlBtn.Font = Enum.Font.GothamBold
    lvlBtn.TextSize = 13
    lvlBtn.Parent = frame
    
    -- Name
    local nameBox = Instance.new("TextBox")
    nameBox.Size = UDim2.new(0.6, 0, 0, 30)
    nameBox.Position = UDim2.new(0.05, 0, 0.45, 0)
    nameBox.PlaceholderText = "Name: NewName"
    nameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    nameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameBox.Font = Enum.Font.Gotham
    nameBox.TextSize = 13
    nameBox.Parent = frame
    
    local nameBtn = Instance.new("TextButton")
    nameBtn.Size = UDim2.new(0.25, 0, 0, 30)
    nameBtn.Position = UDim2.new(0.7, 0, 0.45, 0)
    nameBtn.Text = "Set"
    nameBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    nameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameBtn.Font = Enum.Font.GothamBold
    nameBtn.TextSize = 13
    nameBtn.Parent = frame
    
    -- Leaderboard
    local lbBox = Instance.new("TextBox")
    lbBox.Size = UDim2.new(0.6, 0, 0, 30)
    lbBox.Position = UDim2.new(0.05, 0, 0.60, 0)
    lbBox.PlaceholderText = "LB Position #: 1"
    lbBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    lbBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbBox.Font = Enum.Font.Gotham
    lbBox.TextSize = 13
    lbBox.Parent = frame
    
    local lbBtn = Instance.new("TextButton")
    lbBtn.Size = UDim2.new(0.25, 0, 0, 30)
    lbBtn.Position = UDim2.new(0.7, 0, 0.60, 0)
    lbBtn.Text = "Set"
    lbBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
    lbBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbBtn.Font = Enum.Font.GothamBold
    lbBtn.TextSize = 13
    lbBtn.Parent = frame
    
    -- Reset
    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0.4, 0, 0, 30)
    resetBtn.Position = UDim2.new(0.3, 0, 0.78, 0)
    resetBtn.Text = "🔄 RESET ALL"
    resetBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.TextSize = 12
    resetBtn.Parent = frame
    
    -- Status
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 20)
    statusLabel.Position = UDim2.new(0.05, 0, 0.9, 0)
    statusLabel.Text = "✅ Ready"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 11
    statusLabel.Parent = frame
    
    -- Button events
    wsBtn.MouseButton1Click:Connect(function()
        local val = tonumber(wsBox.Text)
        if val then SpoofWinstreak(val) statusLabel.Text = "✅ Winstreak: " .. val end
    end)
    
    lvlBtn.MouseButton1Click:Connect(function()
        local val = tonumber(lvlBox.Text)
        if val then SpoofLevel(val) statusLabel.Text = "✅ Level: " .. val end
    end)
    
    nameBtn.MouseButton1Click:Connect(function()
        if nameBox.Text ~= "" then SpoofName(nameBox.Text) statusLabel.Text = "✅ Name: " .. nameBox.Text end
    end)
    
    lbBtn.MouseButton1Click:Connect(function()
        local val = tonumber(lbBox.Text)
        if val then SpoofLeaderboard(val) statusLabel.Text = "✅ LB #" .. val end
    end)
    
    resetBtn.MouseButton1Click:Connect(function()
        statusLabel.Text = "🔄 Reset"
    end)
end

-- ============================================
-- SECTION 5: START
-- ============================================

local player = game:GetService("Players").LocalPlayer
if not player then
    game:GetService("Players").PlayerAdded:Wait()
    player = game:GetService("Players").LocalPlayer
end

wait(0.5)
CreateKeyUI()

print([[
╔═══════════════════════════════════════╗
║     RIVALS SPOOFER V3 LOADED         ║
║     Enter FREE-TRIAL-2024            ║
╚═══════════════════════════════════════╝
]])
