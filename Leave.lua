local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "FancyLeaveGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.Parent = playerGui

-- زر الخروج
local button = Instance.new("TextButton")
button.Name = "ExitButton"
button.Size = UDim2.new(0, 130, 0, 45)
button.Position = UDim2.new(1, -30, 0, 25)
button.AnchorPoint = Vector2.new(1, 0)
button.Text = "Leave"
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
button.BorderSizePixel = 0
button.AutoButtonColor = false
button.ZIndex = 10
button.Parent = gui

-- زوايا دائرية
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = button

-- لمعة UIStroke
local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(255, 255, 255)
uiStroke.Transparency = 0.7
uiStroke.Parent = button

-- تأثير نبض لون
task.spawn(function()
	while task.wait(1.2) do
		TweenService:Create(button, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {
			BackgroundColor3 = Color3.fromRGB(255, 110, 110)
		}):Play()
		task.wait(0.6)
		TweenService:Create(button, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {
			BackgroundColor3 = Color3.fromRGB(255, 70, 70)
		}):Play()
	end
end)

-- تكبير عند الوقوف بالماوس
button.MouseEnter:Connect(function()
	TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Back), {
		Size = UDim2.new(0, 145, 0, 50)
	}):Play()
end)

button.MouseLeave:Connect(function()
	TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Back), {
		Size = UDim2.new(0, 130, 0, 45)
	}):Play()
end)

-- عند الضغط
button.MouseButton1Click:Connect(function()
	button.Text = "Leaving..."
	button.BackgroundColor3 = Color3.fromRGB(230, 40, 40)

	TweenService:Create(button, TweenInfo.new(0.3), {
		Size = UDim2.new(0, 150, 0, 50)
	}):Play()

	task.wait(0.6)
	player:Kick("You have left the experience.")
end)
