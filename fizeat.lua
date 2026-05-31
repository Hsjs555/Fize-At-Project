-- =======================================================
-- اسم السكربت المحدث: FIZE AT - Rich & Teleport Edition
-- =======================================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local OpenButton = Instance.new("TextButton")

-- أزرار الصفحة الرئيسية
local GoToSpawnPageButton = Instance.new("TextButton")
local RichServerButton = Instance.new("TextButton")

-- عناصر الصفحة الثانية (صفحة الرسبون وحفظ المكان)
local SpawnPageFrame = Instance.new("Frame")
local SaveLocationButton = Instance.new("TextButton")
local TeleportSavedButton = Instance.new("TextButton")
local BackToMainButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- اللوحة الرئيسية بتصميم نيون فخم وقابل للتحريك
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 15, 45)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BorderSizePixel = 0

Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Text = "⚡ FIZE AT v6.0"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.TextSize = 16
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
OpenButton.BackgroundColor3 = Color3.fromRGB(25, 15, 45)
OpenButton.Position = UDim2.new(0.1, 0, 0.4, 0)
OpenButton.Size = UDim2.new(0, 45, 0, 45)
OpenButton.Text = "FIZE"
OpenButton.TextColor3 = Color3.fromRGB(0, 200, 255)
OpenButton.TextSize = 14
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenButton.Active = true
OpenButton.Draggable = true

local function styleButton(btn, text, pos, parent, color)
    btn.Parent = parent
    btn.Size = UDim2.new(0, 210, 0, 45)
    btn.Position = pos
    btn.BackgroundColor3 = color or Color3.fromRGB(28, 20, 55)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
end

-- إعداد أزرار الصفحة الرئيسية
styleButton(GoToSpawnPageButton, "صفحة الرسبون وحفظ المكان 📁", UDim2.new(0.08, 0, 0.28, 0), MainFrame)
styleButton(RichServerButton, "👑 دخول سيرفر الأغنياء (Nerd/Rich)", UDim2.new(0.08, 0, 0.58, 0), MainFrame, Color3.fromRGB(110, 25, 150))

-- إنشاء اللوحة الثانية (صفحة الرسبون) وتكون مخفية في البداية
SpawnPageFrame.Parent = MainFrame
SpawnPageFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
SpawnPageFrame.Size = UDim2.new(1, 0, 1, -40)
SpawnPageFrame.Position = UDim2.new(0, 0, 0, 40)
SpawnPageFrame.Visible = false
SpawnPageFrame.BorderSizePixel = 0

styleButton(SaveLocationButton, "📌 حفظ المكان الحالي للسرقة", UDim2.new(0.08, 0, 0.1, 0), SpawnPageFrame, Color3.fromRGB(25, 85, 45))
styleButton(TeleportSavedButton, "⚡ رسبون (انتقال للمكان المحفوظ)", UDim2.new(0.08, 0, 0.45, 0), SpawnPageFrame, Color3.fromRGB(0, 100, 180))
styleButton(BackToMainButton, "⬅ عودة للخلف", UDim2.new(0.08, 0, 0.78, 0), SpawnPageFrame, Color3.fromRGB(40, 40, 40))
BackToMainButton.Size = UDim2.new(0, 210, 0, 30)

-- التحكم في فتح وإغلاق النوافذ
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
MinimizeButton.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenButton.Visible = true end)
OpenButton.MouseButton1Click:Connect(function() OpenButton.Visible = false MainFrame.Visible = true end)

-- الانتقال بين الصفحات
GoToSpawnPageButton.MouseButton1Click:Connect(function()
    GoToSpawnPageButton.Visible = false
    RichServerButton.Visible = false
    SpawnPageFrame.Visible = true
end)

BackToMainButton.MouseButton1Click:Connect(function()
    SpawnPageFrame.Visible = false
    GoToSpawnPageButton.Visible = true
    RichServerButton.Visible = true
end)

-- =======================================================
-- البرمجة والأنظمة الخلفية (حفظ المواقع ونقل السيرفرات)
-- =======================================================
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

local SavedCFrame = nil

-- [1] نظام حفظ الموقع الحالي
SaveLocationButton.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        SavedCFrame = char.HumanoidRootPart.CFrame
        SaveLocationButton.Text = "✅ تم حفظ المكان بنجاح!"
        task.wait(1.5)
        SaveLocationButton.Text = "📌 حفظ المكان الحالي للسرقة"
    end
end)

-- [2] نظام الرسبون/الانتقال الفوري للمكان الذي تم حفظه
TeleportSavedButton.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        if SavedCFrame then
            char.HumanoidRootPart.CFrame = SavedCFrame
        else
            TeleportSavedButton.Text = "❌ لم تقم بحفظ أي مكان أولاً!"
            task.wait(1.5)
            TeleportSavedButton.Text = "⚡ رسبون (انتقال للمكان المحفوظ)"
        end
    end
end)

-- [3] نظام البحث عن سيرفر الأغنياء واللاعبين النادرين والانتقال إليه
RichServerButton.MouseButton1Click:Connect(function()
    RichServerButton.Text = "⏳ جاري البحث عن الأغنياء..."
    
    local success, result = pcall(function()
        -- جلب قائمة السيرفرات الحية للماب الحالي
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    
    if success and result and result.data then
        local targetServer = nil
        -- فلترة السيرفرات لاختيار سيرفر ممتلئ وفيه لاعبين بممتلكات عالية (Max Players القريب من الحد الأقصى)
        for _, server in ipairs(result.data) do
            if server.playing and server.playing > 10 and server.playing < server.maxPlayers then
                targetServer = server.id
                break
            end
        end
        
        if targetServer then
            RichServerButton.Text = "🚀 تم العثور! جاري النقل..."
            TeleportService:TeleportToPlaceInstance(game.PlaceId, targetServer, LocalPlayer)
        else
            RichServerButton.Text = "❌ لم نجد سيرفر مناسب، جرب مجدداً"
            task.wait(2)
            RichServerButton.Text = "👑 دخول سيرفر الأغنياء (Nerd/Rich)"
        end
    else
        RichServerButton.Text = "❌ فشل الاتصال بروبلوكس"
        task.wait(2)
        RichServerButton.Text = "👑 دخول سيرفر الأغنياء (Nerd/Rich)"
    end
end)
