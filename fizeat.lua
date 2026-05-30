-- =======================================================
-- اسم السكربت المحدث: FIZE AT Pro v3.0
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

-- اللوحة الرئيسية بتصميم نيون فخم
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 10, 28)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 270)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

-- شريط العنوان المتناسق
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(24, 18, 51)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BorderSizePixel = 0

Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Text = "⚡ FIZE AT PREMIUM"
Title.TextColor3 = Color3.fromRGB(0, 195, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- أزرار التحكم بالشريط العلوي
CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(0.85, 0, 0, 0)
CloseButton.Size = UDim2.new(0, 35, 1, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 75, 75)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold

MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(0.70, 0, 0, 0)
MinimizeButton.Size = UDim2.new(0, 35, 1, 0)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.TextSize = 16
MinimizeButton.Font = Enum.Font.GothamBold

-- زر الفتح الصغير (مربع قابل للتحريك في أي مكان على الشاشة)
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(24, 18, 51)
OpenButton.Position = UDim2.new(0.1, 0, 0.4, 0) -- موقعه الافتراضي على الجنب
OpenButton.Size = UDim2.new(0, 45, 0, 45)
OpenButton.Text = "X"
OpenButton.TextColor3 = Color3.fromRGB(0, 195, 255)
OpenButton.TextSize = 20
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenButton.BorderSizePixel = 0
OpenButton.Active = true
OpenButton.Draggable = true -- تم تفعيل خاصية السحب في أي مكان للزر الصغير!

local function styleButton(btn, text, pos)
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0, 220, 0, 45)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(22, 16, 43)
    btn.Text = text .. " : قيد الإيقاف"
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.TextSize = 14
    btn.Font = Enum.Font.Gotham
    btn.BorderSizePixel = 0
end

styleButton(ESPButton, "كشف مشع (Blue ESP)", UDim2.new(0.08, 0, 0.22, 0))
styleButton(EvadeButton, "تفادي ذكي (Smart Evade)", UDim2.new(0.08, 0, 0.46, 0))
styleButton(AttackButton, "هجوم آلي (Fast Combo)", UDim2.new(0.08, 0, 0.70, 0))

-- تحريك النوافذ وقفلها
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
MinimizeButton.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenButton.Visible = true end)
OpenButton.MouseButton1Click:Connect(function() OpenButton.Visible = false MainFrame.Visible = true end)

-- =======================================================
-- الأكواد الخلفية المعدلة والمحسنة
-- =======================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local ESP_Enabled = false
local Evade_Enabled = false
local Attack_Enabled = false

-- [1] ميزة الـ ESP المشع الأزرق المريح
ESPButton.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    ESPButton.Text = ESP_Enabled and "كشف مشع (Blue ESP) : يعمل" or "كشف مشع (Blue ESP) : قيد الإيقاف"
    ESPButton.BackgroundColor3 = ESP_Enabled and Color3.fromRGB(30, 80, 50) or Color3.fromRGB(22, 16, 43)
    ESPButton.TextColor3 = ESP_Enabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

RunService.Heartbeat:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local highlight = player.Character:FindFirstChild("FIZE_Highlight")
            if ESP_Enabled then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "FIZE_Highlight"
                    highlight.FillColor = Color3.fromRGB(0, 120, 255) -- أزرق مريح
                    highlight.OutlineColor = Color3.fromRGB(0, 255, 255) -- حواف نيون مشعة
                    highlight.FillTransparency = 0.6
                    highlight.OutlineTransparency = 0
                    highlight.Parent = player.Character
                end
            else
                if highlight then highlight:Destroy() end
            end
        end
    end
end)

-- [2] ميزة التفادي الذكي (يهرب فقط أثناء هجوم الخصم)
EvadeButton.MouseButton1Click:Connect(function()
    Evade_Enabled = not Evade_Enabled
    EvadeButton.Text = Evade_Enabled and "تفادي ذكي (Smart Evade) : يعمل" or "تفادي ذكي (Smart Evade) : قيد الإيقاف"
    EvadeButton.BackgroundColor3 = Evade_Enabled and Color3.fromRGB(30, 80, 50) or Color3.fromRGB(22, 16, 43)
    EvadeButton.TextColor3 = Evade_Enabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

RunService.Heartbeat:Connect(function()
    if not Evade_Enabled then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    for _, enemy in ipairs(Players:GetPlayers()) do
        if enemy ~= LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("Humanoid") and enemy.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (char.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).Magnitude
            
            -- فحص المسافة القتالية القريبة
            if distance < 10 then
                local isAttacking = false
                -- فحص هل الخصم يقوم بحركة ضرب فعلية لتفاديها
                for _, track in ipairs(enemy.Character.Humanoid:GetPlayingAnimationTracks()) do
                    local name = track.Animation.Name:lower()
                    if name:find("attack") or name:find("punch") or name:find("m1") or name:find("swing") then
                        isAttacking = true
                        break
                    end
                end
                
                -- التهرب الجانبي الذكي فقط في حالة وجود هجوم لتتمكن من ضربه
                if isAttacking then
                    char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(math.random(-6, 6), 0, 3)
                    task.wait(0.5) -- وقت مستقطع لضمان عدم حدوث شلل في الحركة
                    break
                end
            end
        end
    end
end)

-- [3] ميزة القتال التلقائي السريع جداً المخترق للحماية
AttackButton.MouseButton1Click:Connect(function()
    Attack_Enabled = not Attack_Enabled
    AttackButton.Text = Attack_Enabled and "هجوم آلي (Fast Combo) : يعمل" or "هجوم آلي (Fast Combo) : قيد الإيقاف"
    AttackButton.BackgroundColor3 = Attack_Enabled and Color3.fromRGB(30, 80, 50) or Color3.fromRGB(22, 16, 43)
    AttackButton.TextColor3 = Attack_Enabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

task.spawn(function()
    while true do
        task.wait(0.05) -- تسريع وتيرة ضغط الأزرار لمحاكاة سريعة
        if Attack_Enabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, enemy in ipairs(Players:GetPlayers()) do
                    if enemy ~= LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (char.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).Magnitude
                        
                        -- نطاق الاشتباك القريب
                        if distance < 11 and enemy.Character.Humanoid.Health > 0 then
                            -- إرسال ضغطات مستمرة ومكثفة لتشغيل الكومبو رغماً عن التحديث
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton1(Vector2.new(0,0))
                        end
                    end
                end
            end
        end
    end
end)
