-- ⚠️ White Hat Testing Tool Only - Educational Purposes
-- ⚠️ Use only on games you own or have explicit written permission to test

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- تنظيف الواجهات القديمة
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "WhiteHatScanner" then
        gui:Destroy()
    end
end

-- الواجهة الرئيسية
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WhiteHatScanner"
screenGui.Parent = CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 380)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- عنوان
local title = Instance.new("TextLabel")
title.Text = "🔐 WHITE HAT VULN SCANNER"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = mainFrame

-- إدخال GamePass ID
local inputFrame = Instance.new("Frame")
inputFrame.Size = UDim2.new(0.9, 0, 0, 80)
inputFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
inputFrame.BackgroundTransparency = 1
inputFrame.Parent = mainFrame

local idLabel = Instance.new("TextLabel")
idLabel.Text = "GAMEPASS ID:"
idLabel.Size = UDim2.new(1, 0, 0, 25)
idLabel.BackgroundTransparency = 1
idLabel.TextColor3 = Color3.new(1, 1, 1)
idLabel.Font = Enum.Font.SourceSansSemibold
idLabel.TextXAlignment = Enum.TextXAlignment.Left
idLabel.Parent = inputFrame

local idBox = Instance.new("TextBox")
idBox.PlaceholderText = "123456789"
idBox.Size = UDim2.new(1, 0, 0, 40)
idBox.Position = UDim2.new(0, 0, 0.5, 0)
idBox.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
idBox.TextColor3 = Color3.new(1, 1, 1)
idBox.Font = Enum.Font.SourceSans
idBox.TextSize = 18
idBox.Parent = inputFrame

-- زر التنفيذ
local executeBtn = Instance.new("TextButton")
executeBtn.Text = "🚀 EXECUTE PREVIEWBUTTON EXPLOIT"
executeBtn.Size = UDim2.new(0.9, 0, 0, 45)
executeBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
executeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
executeBtn.TextColor3 = Color3.new(1, 1, 1)
executeBtn.Font = Enum.Font.SourceSansBold
executeBtn.TextSize = 16
executeBtn.Parent = mainFrame

-- منطقة النتائج
local resultFrame = Instance.new("ScrollingFrame")
resultFrame.Size = UDim2.new(0.9, 0, 0, 120)
resultFrame.Position = UDim2.new(0.05, 0, 0.6, 0)
resultFrame.BackgroundColor3 = Color3.fromRGB(35, 40, 50)
resultFrame.BorderSizePixel = 0
resultFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
resultFrame.Parent = mainFrame

local resultLabel = Instance.new("TextLabel")
resultLabel.Text = "النتائج ستظهر هنا..."
resultLabel.Size = UDim2.new(1, -10, 1, -10)
resultLabel.Position = UDim2.new(0, 5, 0, 5)
resultLabel.BackgroundTransparency = 1
resultLabel.TextColor3 = Color3.new(1, 1, 1)
resultLabel.TextWrapped = true
resultLabel.TextXAlignment = Enum.TextXAlignment.Left
resultLabel.TextYAlignment = Enum.TextYAlignment.Top
resultLabel.Font = Enum.Font.SourceSans
resultLabel.TextSize = 14
resultLabel.Parent = resultFrame

-- زر الإغلاق
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Parent = mainFrame

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- دالة البحث عن PreviewButton
local function findPreviewButton()
    local gui = player:WaitForChild("PlayerGui")
    
    local paths = {
        "GachaWindow.HolidayGacha25.Premium.MainGachaUI.PurchaseFooter.PreviewButton",
        "ShopUI.PurchasePanel.PreviewButton",
        "StoreFrame.PreviewButton",
        "PurchaseUI.PreviewBtn"
    }
    
    for _, path in ipairs(paths) do
        local current = gui
        local found = true
        
        for part in path:gmatch("[^.]+") do
            current = current:FindFirstChild(part)
            if not current then
                found = false
                break
            end
        end
        
        if found and current:IsA("GuiButton") then
            return current
        end
    end
    
    -- بحث عام
    for _, guiObj in pairs(gui:GetDescendants()) do
        if guiObj:IsA("GuiButton") and 
           (guiObj.Name:lower():find("preview") or 
            guiObj.Name:lower():find("معاينة")) then
            return guiObj
        end
    end
    
    return nil
end

-- دالة التنفيذ الرئيسية
executeBtn.MouseButton1Click:Connect(function()
    local gamepassId = tonumber(idBox.Text)
    if not gamepassId then
        resultLabel.Text = "❌ أدخل GamePass ID صحيح"
        return
    end
    
    resultLabel.Text = "🔍 جاري البحث عن PreviewButton..."
    
    local previewBtn = findPreviewButton()
    
    if not previewBtn then
        resultLabel.Text = "❌ PreviewButton غير موجود\n" ..
                          "ابحث يدوياً في PlayerGui عن أزرار الشراء"
        return
    end
    
    resultLabel.Text = resultLabel.Text .. "\n✅ زر المعاينة موجود: " .. previewBtn:GetFullName()
    
    -- محاولة تعطيل الوظائف الأصلية
    local disabledCount = 0
    if getconnections then
        local connections = getconnections(previewBtn.MouseButton1Click)
        for _, conn in pairs(connections) do
            pcall(function()
                conn:Disable()
                disabledCount = disabledCount + 1
            end)
        end
    end
    
    resultLabel.Text = resultLabel.Text .. "\n🔌 عطلت " .. disabledCount .. " وظيفة أصلية"
    
    -- وظيفة الاختبار الجديدة
    previewBtn.MouseButton1Click:Connect(function()
        resultLabel.Text = resultLabel.Text .. "\n⚡ تم النقر على الزر المخترق"
        
        -- بيانات مزورة
        local fakeData = {
            type = "GAMEPASS_PURCHASE",
            gamepassId = gamepassId,
            playerId = player.UserId,
            playerName = player.Name,
            price = 0,  -- سعر صفر للتجربة
            receipt = "FAKE_RECEIPT_" .. math.random(10000, 99999),
            timestamp = os.time(),
            validation = "BYPASSED"
        }
        
        -- إرسال لجميع Remotes المحتملة
        local remoteCount = 0
        for _, remote in pairs(game:GetDescendants()) do
            if remote:IsA("RemoteEvent") then
                pcall(function()
                    remote:FireServer("PURCHASE", fakeData)
                    remote:FireServer("BUY_GAMEPASS", fakeData)
                    remote:FireServer("PURCHASE_COMPLETE", fakeData)
                    remoteCount = remoteCount + 1
                end)
            end
        end
        
        resultLabel.Text = resultLabel.Text .. "\n📤 أرسلت بيانات مزورة إلى " .. remoteCount .. " RemoteEvent"
        
        -- محاولة شراء حقيقية (تلقائي)
        if gamepassId then
            pcall(function()
                local MarketplaceService = game:GetService("MarketplaceService")
                MarketplaceService:PromptGamePassPurchase(player, gamepassId)
                resultLabel.Text = resultLabel.Text .. "\n🛒 فتحت نافذة شراء GamePass: " .. gamepassId
            end)
        end
    end)
    
    -- نقر تلقائي
    resultLabel.Text = resultLabel.Text .. "\n🔄 جرب النقر التلقائي..."
    for i = 1, 5 do
        pcall(function()
            previewBtn:Fire("click")
            resultLabel.Text = resultLabel.Text .. "\n   النقرة " .. i .. "/5"
        end)
        wait(0.3)
    end
    
    resultLabel.Text = resultLabel.Text .. "\n\n✅ الانتهاء!\nالزر جاهز للاختبار - اضغط عليه يدوياً"
end)

print("=====================================")
print("🔓 White Hat Scanner Loaded")
print("📱 متوافق مع الموبايل")
print("⚠️ للاستخدام في بيئات اختبار مصرح بها فقط")
print("=====================================")
