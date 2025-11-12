-- 🔴 Leave Button (ثابت فوق اليمين + متحرك)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- نحذف أي نسخة قديمة
local oldGui = playerGui:FindFirstChild("LeaveGui")
if oldGui then oldGui:Destroy() end

-- إنشاء ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "LeaveGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false -- يراعي شريط Roblox العلوي
gui.Parent = playerGui

-- إنشاء الزر
local button = Instance.new("TextButton")
button.Name = "LeaveButton"
button.Text = "Leave"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
button.Size = UDim2.new(0, 100, 0, 40)
button.AnchorPoint = Vector2.new(1, 0)
button.Position = UDim2.new(1, -20, 0, 20) -- فوق على اليمين
button.BorderSizePixel = 0
button.BackgroundTransparency = 1
button.AutoButtonColor = false
button.ZIndex = 10
button.Parent = gui

-- زوايا دائرية
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button

-- حركة الظهور
TweenService:Create(button, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	BackgroundTransparency = 0
}):Play()

-- حركة نبض مستمرة
local pulse = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
TweenService:Create(button, pulse, {Size = UDim2.new(0, 110, 0, 44)}):Play()

-- تكبير بسيط عند المرور بالماوس
button.MouseEnter:Connect(function()
	TweenService:Create(button, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {
		Size = UDim2.new(0, 115, 0, 48)
	}):Play()
end)
button.MouseLeave:Connect(function()
	TweenService:Create(button, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {
		Size = UDim2.new(0, 110, 0, 44)
	}):Play()
end)

-- عند الضغط على الزر يخرج اللاعب للشاشة الرئيسية
button.MouseButton1Click:Connect(function()
	button.Text = "Leaving..."
	task.wait(0.3)
	player:Kick("Returned to main menu.")
end)
