-- =======================================================
-- اسم السكربت المحدث: FIZE AT Pro v5.0 (Steal a Brainrot)
-- =======================================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local OpenButton = Instance.new("TextButton")

-- الأزرار الـ 5 المخصصة للماب
local FlyButton = Instance.new("TextButton")
local NoclipButton = Instance.new("TextButton")
local AutoTeleportButton = Instance.new("TextButton")
local FastThiefButton = Instance.new("TextButton")
local TeleportHomeButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- تصميم اللوحة الرئيسية النيون (زيادة الطول ليتسع للأزرار الجديدة)
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 10, 28)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

-- شريط العنوان
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(24, 18, 51)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BorderSizePixel = 0

Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Text = "⚡ FIZE AT v5.0"
Title.TextColor3 = Color3.fromRGB(0, 195, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- أزرار الإغلاق والتصغير
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

-- زر الاختصار X الصغير (حر الحركة بالكامل)
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(24, 18, 51)
OpenButton.Position = UDim2.new(0.1, 0, 0.4, 0)
OpenButton.Size = UDim2.new(0, 45, 0, 45)
OpenButton.Text = "X"
OpenButton.TextColor3 = Color3.fromRGB(0, 195, 255)
OpenButton.TextSize = 20
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenButton.BorderSizePixel = 0
OpenButton.Active = true
OpenButton.Draggable = true

local function styleButton(btn, text, pos)
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0, 220, 0, 42)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(22, 16, 43)
    btn.Text = text .. " [❌]"
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.TextSize = 13
    btn.Font = Enum.Font.Gotham
    btn.BorderSizePixel = 0
end

-- توزيع الأزرار بشكل متناسق داخل اللوحة
styleButton(FlyButton, "خيار الطيران (Fly)", UDim2.new(0.08, 0, 0.14, 0))
styleButton(NoclipButton, "اختراق الجدران (Noclip)", UDim2.new(0.08, 0, 0.31, 0))
styleButton(AutoTeleportButton, "رسبون تلقائي بالخزائن", UDim2.new(0.08, 0, 0.48, 0))
styleButton(FastThiefButton, "سرقة بسرعة فائقة", UDim2.new(0.08, 0, 0.65, 0))

-- زر العودة للبيت (تصميم مميز لأنه زر ضغطة فورية وليس تفعيل مستمر)
TeleportHomeButton.Parent = MainFrame
TeleportHomeButton.Size = UDim2.new(0, 220, 0, 42)
TeleportHomeButton.Position = UDim2.new(0.08, 0, 0.82, 0)
TeleportHomeButton.BackgroundColor3 = Color3.fromRGB(80, 20, 120) -- لون بنفسجي مميز
TeleportHomeButton.Text = "⚡ عودة للبيت بسرعة البرق ⚡"
TeleportHomeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportHomeButton.TextSize = 13
TeleportHomeButton.Font = Enum.Font.GothamBold
TeleportHomeButton.BorderSizePixel = 0

-- تحكم النوافذ
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
MinimizeButton.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenButton.Visible = true end)
OpenButton.MouseButton1Click:Connect(function() OpenButton.Visible = false MainFrame.Visible = true end)

-- =======================================================
-- البرمجة الخاصة بالميزات الأساسية والمحدثة
-- =======================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local Flying = false
local Noclip = false
local AutoTP = false
local FastThief = false
local Speed = 50

-- [1] الطيران
FlyButton.MouseButton1Click:Connect(function()
    Flying = not Flying
    FlyButton.Text = Flying and "خيار الطيران (Fly) [✅]" or "خيار الطيران (Fly) [❌]"
    FlyButton.BackgroundColor3 = Flying and Color3.fromRGB(30, 80, 50) or Color3.fromRGB(22, 16, 43)
    FlyButton.TextColor3 = Flying and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    if Flying then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "FIZE_Fly"
        bv.Velocity = Vector3.new(0,0,0)
        bv.MaxForce = Vector3.new(1,1,1) * 9e9
        bv.Parent = char.HumanoidRootPart
        
        task.spawn(function()
            local hum = char:WaitForChild("Humanoid")
            while Flying do
                RunService.RenderStepped:Wait()
                bv.Velocity = hum.MoveDirection * Speed
                if hum.Jump then bv.Velocity = bv.Velocity + Vector3.new(0, Speed, 0) end
            end
            bv:Destroy()
        end)
    end
end)

-- [2] اختراق الجدران (Noclip)
NoclipButton.MouseButton1Click:Connect(function()
    Noclip = not Noclip
    NoclipButton.Text = Noclip and "اختراق الجدران (Noclip) [✅]" or "اختراق الجدران (Noclip) [❌]"
    NoclipButton.BackgroundColor3 = Noclip and Color3.fromRGB(30, 80, 50) or Color3.fromRGB(22, 16, 43)
    NoclipButton.TextColor3 = Noclip and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

RunService.Stepped:Connect(function()
    if Noclip then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

-- [3] الرسبون/الانتقال التلقائي للغرف المفتوحة
AutoTeleportButton.MouseButton1Click:Connect(function()
    AutoTP = not AutoTP
    AutoTeleportButton.Text = AutoTP and "رسبون تلقائي بالخزائن [✅]" or "رسبون تلقائي بالخزائن [❌]"
    AutoTeleportButton.BackgroundColor3 = AutoTP and Color3.fromRGB(30, 80, 50) or Color3.fromRGB(22, 16, 43)
    AutoTeleportButton.TextColor3 = AutoTP and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

RunService.Heartbeat:Connect(function()
    if not AutoTP then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local tycoonFolder = workspace:FindFirstChild("Tycoons") or workspace:FindFirstChild("Plots") or workspace
    for _, tycoon in ipairs(tycoonFolder:GetChildren()) do
        local gate = tycoon:FindFirstChild("Gate") or tycoon:FindFirstChild("Door") or tycoon:FindFirstChild("Vault")
        local mainArea = tycoon:FindFirstChild("Main") or tycoon:FindFirstChild("Interior") or tycoon:FindFirstChild("ItemSpawn")
        
        if gate and mainArea then
            if gate.CanCollide == false or gate.Transparency > 0.5 then
                char.HumanoidRootPart.CFrame = mainArea.CFrame + Vector3.new(0, 3, 0)
                task.wait(1.2)
                break
            end
        end
    end
end)

-- [4] ميزة السرقة بسرعة فائقة (تفعيل ضغط مستمر سريع جداً على أزرار الماب لجمع الأغراض في لحظة)
FastThiefButton.MouseButton1Click:Connect(function()
    FastThief = not FastThief
    FastThiefButton.Text = FastThief and "سرقة بسرعة فائقة [✅]" or "سرقة بسرعة فائقة [❌]"
    FastThiefButton.BackgroundColor3 = FastThief and Color3.fromRGB(30, 80, 50) or Color3.fromRGB(22, 16, 43)
    FastThiefButton.TextColor3 = FastThief and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

task.spawn(function()
    while true do
        task.wait(0.01) -- سرعة فائقة تكرر الضغط 100 مرة في الثانية
        if FastThief then
            -- محاكاة النقر والتقاط الأغراض التلقائي المخترق للماب
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(0,0))
            
            -- كود برمي إضافي لتفعيل الـ ProximityPrompt (أزرار السرقة داخل اللعبة) تلقائياً وبدون انتظار الشحن
            for _, prompt in ipairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                    fireproximityprompt(prompt)
                end
            end
        end
    end
end)

-- [5] ميزة العودة للبيت بسرعة البرق
TeleportHomeButton.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local tycoonFolder = workspace:FindFirstChild("Tycoons") or workspace:FindFirstChild("Plots") or workspace
    local foundHome = false
    
    -- البحث عن التيكور أو القاعدة التي يمتلكها اللاعب لتأمين السرقات
    for _, tycoon in ipairs(tycoonFolder:GetChildren()) do
        if tycoon:FindFirstChild("Owner") and tycoon.Owner.Value == LocalPlayer then
            local spawnArea = tycoon:FindFirstChild("Spawn") or tycoon:FindFirstChild("Base") or tycoon
            char.HumanoidRootPart.CFrame = spawnArea.CFrame + Vector3.new(0, 4, 0)
            foundHome = true
            break
        end
    end
    
    -- إذا لم يجد السكربت بيتك بعد (مثلاً لم تقم بشرائه)، سيقوم برسبون آمن في منطقة الـ Spawn الرئيسية للعبة فوراً
    if not foundHome then
        char.HumanoidRootPart.CFrame = CFrame.new(0, 20, 0) -- الانتقال للـ Center الآمن
    end
end)
