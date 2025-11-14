-- 🔴 Leave Button (ثابت فوق اليمين + متحرك)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- حذف أي نسخة قديمة
local oldGui = playerGui:FindFirstChild("LeaveGui")
if oldGui then oldGui:Destroy() end

-- إنشاء ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "LeaveGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- زر الخروج
local button = Instance.new("TextButton")
button.Name = "LeaveButton"
button.Text = "Leave"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
button.Size = UDim2.new(0, 100, 0, 40)
button.AnchorPoint = Vector2.new(1, 0)
button.Position = UDim2.new(1, -20, 0, 20)
button.BackgroundTransparency = 1
button.BorderSizePixel = 0
button.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button

-- ظهور الزر
TweenService:Create(button, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
	BackgroundTransparency = 0
}):Play()

-- نبض
local pulseInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
TweenService:Create(button, pulseInfo, {Size = UDim2.new(0, 110, 0, 44)}):Play()

-- Hover
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

-- ⬇ هنا تعديل الخروج بدون ما يعلق اللاعب ⬇
button.MouseButton1Click:Connect(function()
	button.Text = "Leaving..."

	-- شاشة سوداء ناعمة
	local fade = Instance.new("Frame")
	fade.Size = UDim2.new(1, 0, 1, 0)
	fade.BackgroundColor3 = Color3.new(0, 0, 0)
	fade.BackgroundTransparency = 1
	fade.ZIndex = 50
	fade.Parent = gui

	TweenService:Create(fade, TweenInfo.new(0.25), {
		BackgroundTransparency = 0
	}):Play()

	-- تعطيل حركة اللاعب لحل مشكلة التجميد
	local char = player.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = 0
		char.Humanoid.JumpPower = 0
	end

	task.wait(0.28)

	player:Kick("Returned to main menu.")
end)
