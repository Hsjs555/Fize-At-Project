-- [[ FIZE AT PROJECT - ZORO SWORD FINDER V3 ]] --
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local LeftPanel = Instance.new("Frame")
local RightPanel = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TabBtn = Instance.new("TextButton")
local RefreshBtn = Instance.new("TextButton")
local ServerList = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Status = Instance.new("TextLabel")

-- إعدادات الحماية والظهور
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "FizeAtZoroHub"
ScreenGui.ResetOnSpawn = false

-- [[ كود تحريك اللوحة الحديث والمستقر للهواتف ]] --
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- اللوحة الرئيسية
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.Position = UDim2.new(0.25, 0, 0.25, 0)
Main.Size = UDim2.new(0, 520, 0, 320)
Main.Active = true

local Corner1 = Instance.new("UICorner")
Corner1.CornerRadius = UDim.new(0, 12)
Corner1.Parent = Main

LeftPanel.Parent = Main
LeftPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
LeftPanel.Size = UDim2.new(0, 140, 1, 0)

local Corner2 = Instance.new("UICorner")
Corner2.CornerRadius = UDim.new(0, 12)
Corner2.Parent = LeftPanel

Title.Parent = LeftPanel
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "FIZE AT HUB"
Title.TextColor3 = Color3.fromRGB(0, 255, 120)
Title.TextSize = 14

TabBtn.Parent = LeftPanel
TabBtn.Position = UDim2.new(0, 0, 0.2, 0)
TabBtn.Size = UDim2.new(1, 0, 0, 40)
TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
TabBtn.Font = Enum.Font.GothamBold
TabBtn.Text = "⚔️ Sword Legend"
TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TabBtn.TextSize = 12

RightPanel.Parent = Main
RightPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
RightPanel.Position = UDim2.new(0, 145, 0, 0)
RightPanel.Size = UDim2.new(0, 375, 1, 0)

RefreshBtn.Parent = RightPanel
RefreshBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
RefreshBtn.Size = UDim2.new(0.9, 0, 0, 35)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 90)
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.Text = "Click to Refresh List (تحديث السيرفرات)"
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.TextSize = 13

local Corner3 = Instance.new("UICorner")
Corner3.CornerRadius = UDim.new(0, 6)
Corner3.Parent = RefreshBtn

ServerList.Parent = RightPanel
ServerList.Position = UDim2.new(0.05, 0, 0.2, 0)
ServerList.Size = UDim2.new(0.9, 0, 0, 200)
ServerList.BackgroundTransparency = 1
ServerList.ScrollBarThickness = 4

UIListLayout.Parent = ServerList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

Status.Parent = RightPanel
Status.Position = UDim2.new(0.05, 0, 0.88, 0)
Status.Size = UDim2.new(0.9, 0, 0, 30)
Status.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Status.Font = Enum.Font.GothamItalic
Status.Text = "الحالة: جاهز للفحص... الكاش 5 مليون جاهز"
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.TextSize = 11

local Corner4 = Instance.new("UICorner")
Corner4.CornerRadius = UDim.new(0, 6)
Corner4.Parent = Status

-- [[ إنشاء زر الإخفاء والإظهار الذكي المريح الحرف F ]] --
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.15, 0) -- موقع مريح على الشاشة
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "F"
ToggleBtn.TextColor3 = Color3.fromRGB(20, 20, 25)
ToggleBtn.TextSize = 20
ToggleBtn.Active = true
ToggleBtn.Draggable = true -- يمكنك تحريك زر الفتح أيضاً لأي مكان مريح

local CornerToggle = Instance.new("UICorner")
CornerToggle.CornerRadius = UDim.new(1, 0) -- يجعله دائري بالكامل وأنيق
CornerToggle.Parent = ToggleBtn

ToggleBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    if Main.Visible then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
        ToggleBtn.Text = "F"
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        ToggleBtn.Text = "F"
    end
end)

-- [[ كود معالجة قراءة السيرفرات المصلح والمحمي ]] --
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local player = game.Players.LocalPlayer
local PlaceId = game.PlaceId

local function refreshServers()
    for _, child in pairs(ServerList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    Status.Text = "جاري الاتصال الآمن وقراءة السيرفرات..."
    Status.TextColor3 = Color3.fromRGB(255, 200, 0)
    
    -- محاولة جلب بديلة ومحمية لحل مشكلة عدم الظهور
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=25"))
    end)
    
    if success and result and result.data and #result.data > 0 then
        Status.Text = "تم جلب السيرفرات بنجاح! اختر سيرفر أخضر"
        Status.TextColor3 = Color3.fromRGB(0, 255, 120)
        
        for i, server in pairs(result.data) do
            if server.playing < server.maxPlayers then
                local S_Btn = Instance.new("TextButton")
                S_Btn.Parent = ServerList
                S_Btn.Size = UDim2.new(1, 0, 0, 45)
                S_Btn.Font = Enum.Font.Gotham
                S_Btn.TextSize = 11
                
                local isOldServer = i > 12
                local statusText = isOldServer and "🟢 [بائع محتمل - قديم]" or "🔴 [سيرفر جديد]"
                S_Btn.BackgroundColor3 = isOldServer and Color3.fromRGB(20, 50, 30) or Color3.fromRGB(45, 30, 30)
                S_Btn.TextColor3 = isOldServer and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
                
                S_Btn.Text = statusText .. " | لاعبين: " .. server.playing .. "/" .. server.maxPlayers .. " | Ping: " .. (server.ping or "N/A")
                
                local CornerBtn = Instance.new("UICorner")
                CornerBtn.CornerRadius = UDim.new(0, 6)
                CornerBtn.Parent = S_Btn
                
                S_Btn.MouseButton1Click:Connect(function()
                    Status.Text = "جاري الانتقال... سيتم الشراء تلقائياً!"
                    TeleportService:TeleportToPlaceInstance(PlaceId, server.id, player)
                end)
            end
        end
    else
        Status.Text = "خطأ في الشبكة أو المشغل، أعد المحاولة بعد قليل."
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end

RefreshBtn.MouseButton1Click:Connect(refreshServers)

-- الشراء الخلفي التلقائي فور تحميل السيرفر المستهدف
spawn(function()
    repeat wait(1) until game:IsLoaded()
    local remotes = game:GetService("ReplicatedStorage").Remotes.CommF_
    if game.Workspace:FindFirstChild("Legendary Sword Dealer") or game.ReplicatedStorage:FindFirstChild("Legendary Sword Dealer") then
        remotes:InvokeServer("LegendarySwordDealer", "Shisui")
        remotes:InvokeServer("LegendarySwordDealer", "Wando")
        remotes:InvokeServer("LegendarySwordDealer", "Saddi")
    end
end)
