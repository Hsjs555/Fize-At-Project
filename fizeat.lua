-- =======================================================
-- اسم السكربت المحدث: FIZE AT Pro v4.0 (Steal a Brainrot)
-- =======================================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local OpenButton = Instance.new("TextButton")

local FlyButton = Instance.new("TextButton")
local NoclipButton = Instance.new("TextButton")
local AutoTeleportButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- تصميم اللوحة الرئيسية النيون (أزرق/بنفسجي داكن)
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 10, 28)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 270)
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
Title.Text = "⚡ FIZE AT v4.0"
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

-- زر الاختصار X الصغير (قابل للتحريك في أي مكان على الشاشة)
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
OpenButton.Draggable = true -- سحب حر بالكامل في أي مكان!

local function styleButton(btn, text, pos)
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0, 220, 0, 45)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(22, 16, 43)
    btn.Text = text .. " [❌]"
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.TextSize = 13
    btn.Font = Enum.Font.Gotham
    btn.BorderSizePixel = 0
end

styleButton(FlyButton, "خيار الطيران (Fly)", UDim2.new(0.08, 0, 0.22, 0))
styleButton(NoclipButton, "اختراق الجدران (Noclip)", UDim2.new(0.08, 0, 0.46, 0))
styleButton(AutoTeleportButton, "رسبون تلقائي بالخزائن", UDim2.new(0.08, 0, 0.70, 0))

-- تحكم النوافذ
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
MinimizeButton.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenButton.Visible = true end)
OpenButton.MouseButton1Click:Connect(function() OpenButton.Visible = false MainFrame.Visible = true end)

-- =======================================================
-- البرمجة الخاصة بالميزات (الطيران، الاختراق، والانتقال)
-- =======================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Flying = false
local Noclip = false
local AutoTP = false
local Speed = 50

-- [1] كود الطيران الاحترافي للهواتف
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
                if hum.Jump then
                    bv.Velocity = bv.Velocity + Vector3.new(0, Speed, 0)
                end
            end
            bv:Destroy()
        end)
    end
end)

-- [2] كود اختراق الجدران (Noclip)
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
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- [3] كود الرسبون/الانتقال التلقائي داخل غرف السرقة عند فتحها
AutoTeleportButton.MouseButton1Click:Connect(function()
    AutoTP = not AutoTP
    AutoTeleportButton.Text = AutoTP and "رسبون تلقائي بالخزائن [✅]" or "رسبون تلقائي بالخزائن [❌]"
    AutoTeleportButton.BackgroundColor3 = AutoTP and Color3.fromRGB(30, 80, 50) or Color3.fromRGB(22, 16, 43)
    AutoTeleportButton.TextColor3 = AutoTP and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
end)

-- فحص الماب والانتقال التلقائي للغرف المفتوحة
RunService.Heartbeat:Connect(function()
    if not AutoTP then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    -- البحث في مجلد الماب عن بيوت أو خزائن اللاعبين
    local tycoonFolder = workspace:FindFirstChild("Tycoons") or workspace:FindFirstChild("Plots") or workspace
    
    for _, tycoon in ipairs(tycoonFolder:GetChildren()) do
        -- التحقق من وجود باب أو خزنة مفتوحة (Open) بناءً على تصميم مابات السرقة
        local gate = tycoon:FindFirstChild("Gate") or tycoon:FindFirstChild("Door") or tycoon:FindFirstChild("Vault")
        local mainArea = tycoon:FindFirstChild("Main") or tycoon:FindFirstChild("Interior") or tycoon:FindFirstChild("ItemSpawn")
        
        if gate and mainArea then
            -- إذا كان الباب مفتوحاً أو شفافاً (تم فتح البيوت للسرقة)
            if gate.CanCollide == false or gate.Transparency > 0.5 then
                -- رسبون فوري داخل الغرفة فوق مكان الأغراض المشعة مباشرة
                char.HumanoidRootPart.CFrame = mainArea.CFrame + Vector3.new(0, 3, 0)
                task.wait(1.5) -- انتظار بسيط لتجميع الأغراض قبل الانتقال للغرفة التالية لحمايتك من الـ Kick
                break
            end
        end
    end
end)
