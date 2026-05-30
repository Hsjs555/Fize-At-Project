-- =======================================================
-- اسم السكربت الخاص بك: FIZE AT
-- =======================================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local OpenButton = Instance.new("TextButton")

-- قوائم الأزرار البرمجية داخل اللوحة
local ESPButton = Instance.new("TextButton")
local EvadeButton = Instance.new("TextButton")
local AttackButton = Instance.new("TextButton")

-- إعدادات الحاوية الرسومية
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- اللوحة الرئيسية (أزرق داكن يميل للبنفسجي الغامق)
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 12, 38) -- بنفسجي غامق جداً كحلي
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 270)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

-- شريط العنوان العلوي
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(28, 20, 58) -- أزرق بنفسجي أفتح قليلاً
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BorderSizePixel = 0

Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Text = "FIZE AT v1.0"
Title.TextColor3 = Color3.fromRGB(0, 195, 255) -- أزرق مضيء نيون
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- زر الإغلاق النهائي X (أقصى اليمين)
CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(0.85, 0, 0, 0)
CloseButton.Size = UDim2.new(0, 35, 1, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 75, 75)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.SourceSansBold

-- زر التصغير _ (بجانب زر الإغلاق)
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(0.70, 0, 0, 0)
MinimizeButton.Size = UDim2.new(0, 35, 1, 0)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.SourceSansBold

-- زر إعادة الفتح الاحترافي (يظهر في وسط الشاشة عند التصغير)
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(28, 20, 58)
OpenButton.Position = UDim2.new(0.5, -20, 0.5, -20) -- في وسط الشاشة تماماً
OpenButton.Size = UDim2.new(0, 40, 0, 40) -- مربع صغير
OpenButton.Text = "X" -- يحمل حرف X بشكل احترافي ومضيء
OpenButton.TextColor3 = Color3.fromRGB(0, 195, 255)
OpenButton.TextSize = 22
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.Visible = false
OpenButton.BorderSizePixel = 0

-- تزيين الأزرار الداخلية الخاصة بالميزات
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

-- =======================================================
-- برمجة ميزات النوافذ والتحكم (تفتيح وقفل وتصغير)
-- =======================================================

-- زر الإغلاق النهائي
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy() -- يحذف السكربت والواجهة نهائياً من اللعبة
end)

-- زر التصغير للإخفاء
MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true -- إظهار الزر المربع الصغير في الوسط
end)

-- زر إعادة الفتح من المربع الصغير
OpenButton.MouseButton1Click:Connect(function()
    OpenButton.Visible = false
    MainFrame.Visible = true -- إعادة إظهار القائمة الكاملة
end)

-- =======================================================
-- البرمجة الخلفية للميزات والقتال
-- =======================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local ESP_Enabled = false
local Evade_Enabled = false
local Attack_Enabled = false

-- [1] ميزة الـ ESP
ESPButton.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    if ESP_Enabled then
        ESPButton.Text = "كشف اللاعبين (ESP) [✅]"
        ESPButton.BackgroundColor3 = Color3.fromRGB(40, 110, 70)
        ESPButton.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        ESPButton.Text = "كشف اللاعبين (ESP) [❌]"
        ESPButton.BackgroundColor3 = Color3.fromRGB(32, 24, 66)
        ESPButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

RunService.Heartbeat:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local highlight = player.Character:FindFirstChild("Highlight")
            if ESP_Enabled then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.FillColor = Color3.fromRGB(0, 195, 255) -- متناسق مع اللون الأزرق للسكربت
                    highlight.FillTransparency = 0.4
                end
            else
                if highlight then highlight:Destroy() end
            end
        end
    end
end)

-- [2] ميزة تفادي الضربات
EvadeButton.MouseButton1Click:Connect(function()
    Evade_Enabled = not Evade_Enabled
    if Evade_Enabled then
        EvadeButton.Text = "تفادي الضربات (Evade) [✅]"
        EvadeButton.BackgroundColor3 = Color3.fromRGB(40, 110, 70)
        EvadeButton.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        EvadeButton.Text = "تفادي الضربات (Evade) [❌]"
        EvadeButton.BackgroundColor3 = Color3.fromRGB(32, 24, 66)
        EvadeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

RunService.Heartbeat:Connect(function()
    if not Evade_Enabled then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    for _, enemy in ipairs(Players:GetPlayers()) do
        if enemy ~= LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("Humanoid") and enemy.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (char.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).Magnitude
            if distance < 15 then
                for _, track in ipairs(enemy.Character.Humanoid:GetPlayingAnimationTracks()) do
                    local name = track.Animation.Name:lower()
                    if name:find("attack") or name:find("punch") or name:find("m1") then
                        char.HumanoidRootPart.Velocity = (char.HumanoidRootPart.CFrame.LookVector * -60) + Vector3.new(0, 20, 0)
                        task.wait(0.3)
                        break
                    end
                end
            end
        end
    end
end)

-- [3] ميزة القتال التلقائي
AttackButton.MouseButton1Click:Connect(function()
    Attack_Enabled = not Attack_Enabled
    if Attack_Enabled then
        AttackButton.Text = "قتال تلقائي (Auto-Combo) [✅]"
        AttackButton.BackgroundColor3 = Color3.fromRGB(40, 110, 70)
        AttackButton.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        AttackButton.Text = "قتال تلقائي (Auto-Combo) [❌]"
        AttackButton.BackgroundColor3 = Color3.fromRGB(32, 24, 66)
        AttackButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if Attack_Enabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, enemy in ipairs(Players:GetPlayers()) do
                    if enemy ~= LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (char.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).Magnitude
                        if distance < 10 and enemy.Character.Humanoid.Health > 0 then
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton1(Vector2.new(0,0))
                        end
                    end
                end
            end
        end
    end
end)
