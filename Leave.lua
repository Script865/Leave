-- Debug Leave Button (LocalScript)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
if not player then
    warn("LocalPlayer غير موجود — تأكد أنك تشغّل في وضع Play (F5).")
    return
end

-- Ensure PlayerGui ready
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then
    warn("PlayerGui لم يظهر خلال 10 ثواني.")
    return
end

-- Helper to show an on-screen status label for debugging
local function mkStatus(msg)
    local s = Instance.new("ScreenGui")
    s.Name = "LeaveDebug_StatusGui"
    s.ResetOnSpawn = false
    s.Parent = playerGui

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0,300,0,40)
    label.Position = UDim2.new(1,-320,0,60)
    label.AnchorPoint = Vector2.new(0,0)
    label.Text = msg
    label.TextSize = 16
    label.Font = Enum.Font.SourceSans
    label.BackgroundTransparency = 0.4
    label.BackgroundColor3 = Color3.fromRGB(30,30,30)
    label.TextColor3 = Color3.new(1,1,1)
    label.Parent = s
    return label
end

local statusLabel = mkStatus("Initializing Leave Button...")

-- Remove existing if موجود (عشان تجارب متعددة)
local existing = playerGui:FindFirstChild("LeaveGui")
if existing then existing:Destroy() end

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LeaveGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local button = Instance.new("TextButton")
button.Name = "LeaveButton"
button.Text = "Leave"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18
button.TextColor3 = Color3.new(1,1,1)
button.BackgroundColor3 = Color3.fromRGB(220,20,60)
button.Size = UDim2.new(0,90,0,36)
button.AnchorPoint = Vector2.new(1,0)
button.Position = UDim2.new(1,-12,0,12) -- فوق على اليمين
button.Parent = gui
button.ZIndex = 10
button.AutoButtonColor = false
button.BorderSizePixel = 0
button.BackgroundTransparency = 1

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0,10)
uiCorner.Parent = button

-- Animations
local okTween, okErr = pcall(function()
    TweenService:Create(button, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
end)
if not okTween then warn("Tween failed:", okErr) end

local pulseTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local pulse = TweenService:Create(button, pulseTweenInfo, {Size = UDim2.new(0,100,0,40)})
pulse:Play()

button.MouseEnter:Connect(function()
    TweenService:Create(button, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {Size = UDim2.new(0,110,0,44)}):Play()
end)
button.MouseLeave:Connect(function()
    TweenService:Create(button, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {Size = UDim2.new(0,100,0,40)}):Play()
end)

statusLabel.Text = "Ready: Button created."

-- Click handler with debug info
button.MouseButton1Click:Connect(function()
    statusLabel.Text = "Button clicked — attempting to leave..."
    button.Text = "Leaving..."
    button.AutoButtonColor = false

    -- Use pcall around Kick to catch errors
    local ok, err = pcall(function()
        -- In Studio, Kick will stop Play; in live game it returns player to Roblox menu
        player:Kick("Returned to main menu.")
    end)
    if not ok then
        warn("player:Kick failed:", err)
        statusLabel.Text = "Kick failed — check Output."
        -- Fallback: if in Studio, try closing play session (best-effort)
        if RunService:IsStudio() then
            statusLabel.Text = "Studio mode: stopping play."
            -- No direct safe API to stop Play programmatically from LocalScript; inform user
        end
    end
end)
