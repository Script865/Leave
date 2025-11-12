-- Leave Button GUI (LocalScript) -- ضع هذا السكربت داخل StarterGui ليُنشئ زر "Leave" أحمر متحرك يخرجك للشاشة الرئيسية (قائمة Roblox)

local Players = game:GetService("Players") local TweenService = game:GetService("TweenService") local player = Players.LocalPlayer local playerGui = player:WaitForChild("PlayerGui")

-- إنشاء الواجهة local gui = Instance.new("ScreenGui") gui.Name = "LeaveGui" gui.ResetOnSpawn = false gui.Parent = playerGui

local button = Instance.new("TextButton") button.Name = "LeaveButton" button.Text = "Leave" button.Font = Enum.Font.SourceSansBold button.TextSize = 18 button.TextColor3 = Color3.new(1,1,1) button.BackgroundColor3 = Color3.fromRGB(220,20,60) button.Size = UDim2.new(0,90,0,36) button.AnchorPoint = Vector2.new(1,0) button.Position = UDim2.new(1,-12,0,12) button.Parent = gui button.ZIndex = 10 button.AutoButtonColor = false button.BorderSizePixel = 0 button.BackgroundTransparency = 1

local uiCorner = Instance.new("UICorner") uiCorner.CornerRadius = UDim.new(0,10) uiCorner.Parent = button

-- تأثير دخول local enterInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out) TweenService:Create(button, enterInfo, {BackgroundTransparency = 0}):Play()

-- نبض بسيط local pulseTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true) local pulse = TweenService:Create(button, pulseTweenInfo, {Size = UDim2.new(0,100,0,40)}) pulse:Play()

-- تكبير عند المرور button.MouseEnter:Connect(function() TweenService:Create(button, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {Size = UDim2.new(0,110,0,44)}):Play() end) button.MouseLeave:Connect(function() TweenService:Create(button, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {Size = UDim2.new(0,100,0,40)}):Play() end)

-- عند الضغط يخرج اللاعب للشاشة الرئيسية button.MouseButton1Click:Connect(function() button.Text = "Leaving..." button.AutoButtonColor = false task.wait(0.3) player:Kick("Returned to main menu.") -- يخرجك من اللعبة إلى واجهة Roblox الرئيسية end)
