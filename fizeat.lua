-- =======================================================
-- اسم السكربت المحدث: FIZE AT - Ghost Mode Edition v7.0
-- =======================================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local OpenButton = Instance.new("TextButton")

-- أزرار النسخة الجديدة
local InvisibleButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- إعدادات اللوحة الرئيسية النيون الشفافة
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 10, 28)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 140)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(24, 18, 51)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BorderSizePixel = 0

Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Text = "👻 FIZE AT GHOST v7.0"
Title.TextColor3 = Color3.fromRGB(0, 195, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold

CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(0.85, 0, 0, 0)
CloseButton.Size = UDim2.new(0, 35, 1, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 75, 75)
CloseButton.Font = Enum.Font.GothamBold

MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(0.70, 0, 0, 0)
MinimizeButton.Size = UDim2.new(0, 35, 1, 0)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.Font = Enum.Font.GothamBold

-- زر الاختصار الخارجي الصغير (حركة حرة بالكامل في الشاشة)
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(24, 18, 51)
OpenButton.Position = UDim2.new(0.1, 0, 0.4, 0)
OpenButton.Size = UDim2.new(0, 45, 0, 45)
OpenButton.Text = "FIZE"
OpenButton.TextColor3 = Color3.fromRGB(0, 195, 255)
OpenButton.TextSize = 13
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenButton.Active = true
OpenButton.Draggable = true

-- تصميم زر الإخفاء
InvisibleButton.Parent = MainFrame
InvisibleButton.Size = UDim2.new(0, 210, 0, 50)
InvisibleButton.Position = UDim2.new(0.08, 0, 0.45, 0)
InvisibleButton.BackgroundColor3 = Color3.fromRGB(35, 25, 65)
InvisibleButton.Text = "👻 تفعيل الإخفاء التام (Ghost Mode)"
InvisibleButton.TextColor3 = Color3.fromRGB(200, 200, 255)
InvisibleButton.TextSize = 12
InvisibleButton.Font = Enum.Font.GothamBold
InvisibleButton.BorderSizePixel = 0

-- التحكم في النوافذ
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
MinimizeButton.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenButton.Visible = true end)
OpenButton.MouseButton1Click:Connect(function() OpenButton.Visible = false MainFrame.Visible = true end)

-- =======================================================
-- كود نظام الإخفاء البرمجي (Invisible System)
-- =======================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local IsInvisible = false
local SavedParts = {}

InvisibleButton.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("LowerTorso") then return end
    
    IsInvisible = not IsInvisible
    
    if IsInvisible then
        -- تفعيل الإخفاء
        InvisibleButton.Text = "✅ أنت الآن مخفي عن الجميع!"
        InvisibleButton.BackgroundColor3 = Color3.fromRGB(30, 80, 50)
        InvisibleButton.TextColor3 = Color3.fromRGB(100, 255, 100)
        
        -- تدمير الجذور البصرية لكي يعتقد السيرفر أنك غير موجود بمكانك الحقيقي
        local root = char.HumanoidRootPart
        local clone = root:Clone()
        clone.Parent = char
        root:Destroy()
        char.PrimaryPart = clone
        
        -- جعل كل أجزاء الجسم شفافة تماماً
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                SavedParts[part] = part.Transparency
                part.Transparency = 1
            end
        end
    else
        -- إلغاء الإخفاء (طلب إعادة الرسبون العادي لإرجاعك كلاعب طبيعي)
        InvisibleButton.Text = "🔄 جاري إرجاع شكلك الطبيعي..."
        InvisibleButton.BackgroundColor3 = Color3.fromRGB(35, 25, 65)
        InvisibleButton.TextColor3 = Color3.fromRGB(200, 200, 255)
        
        LocalPlayer:LoadCharacter() -- إعادة رسبون آمن لإرجاع الشكل والملابس بالكامل
        IsInvisible = false
    end
end)
