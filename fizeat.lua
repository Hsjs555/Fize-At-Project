-- =======================================================
-- اسم السكربت: FIZE AT (نسخة مقاومة للتحديثات v2.0)
-- =======================================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local OpenButton = Instance.new("TextButton")

local ESPButton = Instance.new("TextButton")
local EvadeButton = Instance.new("TextButton")
local AttackButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 12, 38)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 270)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(28, 20, 58)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BorderSizePixel = 0

Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Text = "FIZE AT v2.0 ⚡"
Title.TextColor3 = Color3.fromRGB(0, 195, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(0.85, 0, 0, 0)
CloseButton.Size = UDim2.new(0, 35, 1, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 75, 75)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.SourceSansBold

MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(0.70, 0, 0, 0)
MinimizeButton.Size = UDim2.new(0, 35, 1, 0)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.SourceSansBold

OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(28, 20, 58)
OpenButton.Position = UDim2.new(0.5, -20, 0.5, -20)
OpenButton.Size = UDim2.new(0, 40, 0, 40)
OpenButton.Text = "X"
OpenButton.TextColor3 = Color3.fromRGB(0, 195, 255)
OpenButton.TextSize = 22
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.Visible = false
OpenButton.BorderSizePixel = 0

local function styleButton(btn, text, pos)
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0, 220, 0, 45)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(32, 24, 66)
    btn.Text = text .. " [❌]"
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.TextSize = 15
    btn.Font = Enum.Font.SourceSans
    btn.BorderSizePixel = 0
end

styleButton(ESPButton, "كشف اللاعبين (ESP)", UDim2.new(0.08, 0, 0.22, 0))
styleButton(EvadeButton, "تفادي الضربات (Evade)", UDim2.new(0.08, 0, 0.46, 0))
styleButton(AttackButton, "قتال تلقائي (Auto-Combo)", UDim2.new(0.08, 0, 0.70, 0))

CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
MinimizeButton.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenButton.Visible = true end)
OpenButton.MouseButton1Click:Connect(function() OpenButton.Visible = false MainFrame.Visible = true end)

-- =======================================================
-- أنظمة تخطي التحديث والـ Anti-Cheat الجديد
-- =======================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local ESP_Enabled = false
local Evade_Enabled = false
local Attack_Enabled = false

-- [1] ميزة الـ ESP (تعتمد على نظام الصناديق لتخطي الحظر)
ESPButton.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    ESPButton.Text = ESP_Enabled and "كشف اللاعبين (ESP) [✅]" or "كشف اللاعبين (ESP) [❌]"
    ESPButton.BackgroundColor3 = ESP_Enabled and Color3.fromRGB(40, 110, 70) or Color3.fromRGB(32, 24, 66)
    ESPButton.TextColor3 = ESP_Enabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

RunService.Heartbeat:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local box = player.Character:FindFirstChild("FIZE_ESP")
            if ESP_Enabled then
                if not box then
                    local bg = Instance.new("BoxHandleAdornment")
                    bg.Name = "FIZE_ESP"
                    bg.Size = Vector3.new(4, 6, 4)
                    bg.Color3 = Color3.fromRGB(0, 195, 255)
                    bg.AlwaysOnTop = true
                    bg.ZIndex = 10
                    bg.Transparency = 0.6
                    bg.Adornee = player.Character.HumanoidRootPart
                    bg.Parent = player.Character
                end
            else
                if player.Character:FindFirstChild("FIZE_ESP") then player.Character.FIZE_ESP:Destroy() end
            end
        end
    end
end)

-- [2] ميزة تفادي الضربات (محدثة: تعتمد على المسافة والسرعة المفاجئة لتجنب التحديثات)
EvadeButton.MouseButton1Click:Connect(function()
    Evade_Enabled = not Evade_Enabled
    EvadeButton.Text = Evade_Enabled and "تفادي الضربات (Evade) [✅]" or "تفادي الضربات (Evade) [❌]"
    EvadeButton.BackgroundColor3 = Evade_Enabled and Color3.fromRGB(40, 110, 70) or Color3.fromRGB(32, 24, 66)
    EvadeButton.TextColor3 = Evade_Enabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

RunService.Heartbeat:Connect(function()
    if not Evade_Enabled then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    for _, enemy in ipairs(Players:GetPlayers()) do
        if enemy ~= LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (char.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).Magnitude
            
            -- إذا اقترب العدو بسرعة كبيرة وبمسافة قتالية خطيرة
            if distance < 12 then
                local enemyVel = enemy.Character.HumanoidRootPart.Velocity.Magnitude
                -- إذا كان الخصم يتحرك بسرعة هجومية (يعني يضرب أو يندفع نحوك)
                if enemyVel > 15 or enemy.Character.Humanoid.MoveDirection.Magnitude > 0 then
                    -- تفادي ذكي وجانبي لعدم لفت انتباه السيرفر
                    char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(math.random(-10, 10), 0, 8)
                    task.wait(0.4) -- حماية ضد التكرار السريع (Anti-Kick)
                    break
                end
            end
        end
    end
end)

-- [3] ميزة القتال التلقائي (محدثة ومقاومة للحظر)
AttackButton.MouseButton1Click:Connect(function()
    Attack_Enabled = not Attack_Enabled
    AttackButton.Text = Attack_Enabled and "قتال تلقائي (Auto-Combo) [✅]" or "قتال تلقائي (Auto-Combo) [❌]"
    AttackButton.BackgroundColor3 = Attack_Enabled and Color3.fromRGB(40, 110, 70) or Color3.fromRGB(32, 24, 66)
    AttackButton.TextColor3 = Attack_Enabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

task.spawn(function()
    while true do
        task.wait(0.15) -- سرعة آمنة وممتازة للـ Combo
        if Attack_Enabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, enemy in ipairs(Players:GetPlayers()) do
                    if enemy ~= LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (char.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).Magnitude
                        if distance < 11 and enemy.Character.Humanoid.Health > 0 then
                            -- استخدام نظام النقر الآمن الافتراضي لتخطي حماية التحديث
                            VirtualUser:Button1Down(Vector2.new(0,0))
                            task.wait(0.05)
                            VirtualUser:Button1Up(Vector2.new(0,0))
                        end
                    end
                end
            end
        end
    end
end)
