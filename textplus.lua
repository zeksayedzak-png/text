-- 🎯 Booth Free Purchase Hack - Grow a Garden
-- ⚠️ FOR EDUCATIONAL PURPOSES ONLY

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- تنظيف
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "BoothZeroHack" then
        gui:Destroy()
    end
end

-- الواجهة
local gui = Instance.new("ScreenGui")
gui.Name = "BoothZeroHack"
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 250)
frame.Position = UDim2.new(0.5, -175, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 35, 50)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Text = "🎯 BOOTH FREE PET HACK"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

-- زر تفعيل الهجوم
local activateBtn = Instance.new("TextButton")
activateBtn.Text = "🔓 ACTIVATE FREE PURCHASE"
activateBtn.Size = UDim2.new(0.9, 0, 0, 45)
activateBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
activateBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
activateBtn.TextColor3 = Color3.new(1, 1, 1)
activateBtn.Font = Enum.Font.SourceSansBold
activateBtn.TextSize = 16
activateBtn.Parent = frame

-- زر إلغاء الهجوم
local deactivateBtn = Instance.new("TextButton")
deactivateBtn.Text = "🔒 DEACTIVATE (NORMAL)"
deactivateBtn.Size = UDim2.new(0.9, 0, 0, 45)
deactivateBtn.Position = UDim2.new(0.05, 0, 0.5, 0)
deactivateBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
deactivateBtn.TextColor3 = Color3.new(1, 1, 1)
deactivateBtn.Font = Enum.Font.SourceSansBold
deactivateBtn.TextSize = 16
deactivateBtn.Parent = frame

-- حالة الهجوم
local statusLabel = Instance.new("TextLabel")
statusLabel.Text = "🔴 Status: INACTIVE"
statusLabel.Size = UDim2.new(0.9, 0, 0, 30)
statusLabel.Position = UDim2.new(0.05, 0, 0.8, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.Font = Enum.Font.SourceSansSemibold
statusLabel.Parent = frame

-- النتائج
local resultBox = Instance.new("TextLabel")
resultBox.Text = "👉 اضغط ACTIVATE لتفعيل الشراء المجاني"
resultBox.Size = UDim2.new(0.9, 0, 0, 60)
resultBox.Position = UDim2.new(0.05, 0, 0.9, 0)
resultBox.BackgroundColor3 = Color3.fromRGB(35, 45, 60)
resultBox.TextColor3 = Color3.new(1, 1, 1)
resultBox.TextWrapped = true
resultBox.Font = Enum.Font.SourceSans
resultBox.TextSize = 12
resultBox.Parent = frame

-- متغيرات
local originalFunctions = {}
local isHackActive = false

-- البحث عن RemoteFunctions للشراء
local function findPurchaseRemotes()
    local purchaseRemotes = {}
    
    -- 1. Booth Purchase (أهم واحد)
    local BuyListing = game:GetService("ReplicatedStorage"):FindFirstChild("GameEvents")
    if BuyListing then
        BuyListing = BuyListing:FindFirstChild("TradeEvents")
        if BuyListing then
            BuyListing = BuyListing:FindFirstChild("Booths")
            if BuyListing then
                BuyListing = BuyListing:FindFirstChild("BuyListing")
                if BuyListing and BuyListing:IsA("RemoteFunction") then
                    table.insert(purchaseRemotes, {
                        remote = BuyListing,
                        name = "BuyListing",
                        path = "GameEvents.TradeEvents.Booths.BuyListing"
                    })
                end
            end
        end
    end
    
    -- 2. TradeTokens Purchase
    local Purchase = game:GetService("ReplicatedStorage"):FindFirstChild("GameEvents")
    if Purchase then
        Purchase = Purchase:FindFirstChild("TradeEvents")
        if Purchase then
            Purchase = Purchase:FindFirstChild("TradeTokens")
            if Purchase then
                Purchase = Purchase:FindFirstChild("Purchase")
                if Purchase and Purchase:IsA("RemoteFunction") then
                    table.insert(purchaseRemotes, {
                        remote = Purchase,
                        name = "Purchase",
                        path = "GameEvents.TradeEvents.TradeTokens.Purchase"
                    })
                end
            end
        end
    end
    
    -- 3. CanPurchase (للتحقق)
    local CanPurchase = game:GetService("ReplicatedStorage"):FindFirstChild("GameEvents")
    if CanPurchase then
        CanPurchase = CanPurchase:FindFirstChild("TradeEvents")
        if CanPurchase then
            CanPurchase = CanPurchase:FindFirstChild("TradeTokens")
            if CanPurchase then
                CanPurchase = CanPurchase:FindFirstChild("CanPurchase")
                if CanPurchase and CanPurchase:IsA("RemoteFunction") then
                    table.insert(purchaseRemotes, {
                        remote = CanPurchase,
                        name = "CanPurchase",
                        path = "GameEvents.TradeEvents.TradeTokens.CanPurchase"
                    })
                end
            end
        end
    end
    
    return purchaseRemotes
end

-- تفعيل الهجوم: جعل كل المشتريات ببلاش
local function activateFreePurchase()
    if isHackActive then return end
    
    resultBox.Text = "🔍 جاري البحث عن أنظمة الشراء..."
    
    local purchaseRemotes = findPurchaseRemotes()
    
    if #purchaseRemotes == 0 then
        resultBox.Text = "❌ ما لقيت أنظمة شراء Booths!"
        return
    end
    
    resultBox.Text = "✅ وجدت " .. #purchaseRemotes .. " نظام شراء\n"
    
    -- حفظ الوظائف الأصلية واستبدالها
    for _, remoteInfo in ipairs(purchaseRemotes) do
        local remote = remoteInfo.remote
        
        -- حفظ الوظيفة الأصلية
        originalFunctions[remoteInfo.name] = remote.InvokeServer
        
        -- استبدال الوظيفة بوظيفة مزورة
        remote.InvokeServer = function(self, ...)
            local args = {...}
            resultBox.Text = resultBox.Text .. "🎯 اعتراض: " .. remoteInfo.name .. "\n"
            
            -- إذا كان طلب شراء
            if remoteInfo.name == "BuyListing" or remoteInfo.name == "Purchase" then
                -- تحليل البيانات
                if type(args[1]) == "table" then
                    -- تغيير السعر لـ 0
                    args[1].price = 0
                    args[1].originalPrice = nil
                    args[1].fakePrice = 0
                    
                    resultBox.Text = resultBox.Text .. "💰 حولت السعر لـ 0!\n"
                    
                elseif #args >= 2 then
                    -- إذا كان السعر في argument منفصل
                    for i, arg in ipairs(args) do
                        if type(arg) == "number" and arg > 0 then
                            args[i] = 0  -- جعل السعر 0
                            resultBox.Text = resultBox.Text .. "💰 حولت السعر من " .. arg .. " لـ 0\n"
                        end
                    end
                end
            end
            
            -- إذا كان CanPurchase (للتحقق)
            if remoteInfo.name == "CanPurchase" then
                -- دايماً تقول "نعم تقدر تشتري"
                return true
            end
            
            -- إرسال البيانات المعدلة للخادم
            resultBox.Text = resultBox.Text .. "📤 أرسلت طلب شراء بالسعر 0\n"
            return originalFunctions[remoteInfo.name](self, unpack(args))
        end
        
        resultBox.Text = resultBox.Text .. "🔧 خترقت: " .. remoteInfo.path .. "\n"
    end
    
    -- أيضاَ اعتراض RemoteEvents
    local remoteEvents = {
        "FakePurchase",
        "PromptPurchase",
        "BuyGardenCoinShopStock",
        "BuyDailySeedShopStock"
    }
    
    for _, eventName in ipairs(remoteEvents) do
        local event = game:GetService("ReplicatedStorage").GameEvents:FindFirstChild(eventName)
        if event and event:IsA("RemoteEvent") then
            -- حفظ الوظيفة الأصلية
            originalFunctions[eventName] = event.FireServer
            
            -- استبدالها
            event.FireServer = function(self, ...)
                local args = {...}
                
                -- إذا كان في بيانات شراء
                if type(args[1]) == "table" then
                    args[1].price = 0
                    args[1].cost = 0
                    args[1].robux = 0
                    
                    resultBox.Text = resultBox.Text .. "⚡ حولت " .. eventName .. " لـ 0\n"
                end
                
                return originalFunctions[eventName](self, unpack(args))
            end
        end
    end
    
    isHackActive = true
    statusLabel.Text = "🟢 Status: ACTIVE (All purchases = 0)"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    
    resultBox.Text = resultBox.Text .. "\n✅ الهجوم مفعل! كل المشتريات ببلاش الآن!"
    
    -- إضافة زر لاختبار سريع
    local testBtn = Instance.new("TextButton")
    testBtn.Text = "🛒 TEST FREE PURCHASE"
    testBtn.Size = UDim2.new(0.9, 0, 0, 35)
    testBtn.Position = UDim2.new(0.05, 0, 1.2, 0)
    testBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    testBtn.TextColor3 = Color3.new(1, 1, 1)
    testBtn.Visible = false
    testBtn.Parent = frame
    
    testBtn.MouseButton1Click:Connect(function()
        -- محاولة شراء اختبارية
        local fakePurchase = {
            listingId = "TEST_" .. math.random(1000, 9999),
            itemId = "Premium_Pet",
            price = 1000,  -- السعر الأصلي
            sellerId = 123456,
            itemName = "Test Pet",
            rarity = "Legendary"
        }
        
        local BuyListing = findPurchaseRemotes()[1]
        if BuyListing then
            pcall(function()
                BuyListing.remote:InvokeServer(fakePurchase)
                resultBox.Text = resultBox.Text .. "\n🧪 جربت شراء اختباري!"
            end)
        end
    end)
    
    testBtn.Visible = true
end

-- إلغاء الهجوم: إرجاع كل شيء طبيعي
local function deactivateHack()
    if not isHackActive then return end
    
    -- إرجاع RemoteFunctions الأصلية
    for name, originalFunc in pairs(originalFunctions) do
        local remote = findRemoteByName(name)
        if remote then
            remote.InvokeServer = originalFunc
        end
    end
    
    -- إرجاع RemoteEvents الأصلية
    local remoteEvents = {"FakePurchase", "PromptPurchase"}
    for _, eventName in ipairs(remoteEvents) do
        local event = game:GetService("ReplicatedStorage").GameEvents:FindFirstChild(eventName)
        if event and originalFunctions[eventName] then
            event.FireServer = originalFunctions[eventName]
        end
    end
    
    isHackActive = false
    statusLabel.Text = "🔴 Status: INACTIVE"
    statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    resultBox.Text = "✅ الهجوم معطل، كل شيء طبيعي الآن"
    
    originalFunctions = {}
end

-- دالة مساعدة للبحث عن Remote
local function findRemoteByName(name)
    local paths = {
        ["BuyListing"] = "GameEvents.TradeEvents.Booths.BuyListing",
        ["Purchase"] = "GameEvents.TradeEvents.TradeTokens.Purchase",
        ["CanPurchase"] = "GameEvents.TradeEvents.TradeTokens.CanPurchase"
    }
    
    local path = paths[name]
    if not path then return nil end
    
    local current = game
    for part in path:gmatch("[^.]+") do
        current = current:FindFirstChild(part)
        if not current then return nil end
    end
    
    return current
end

-- الأحداث
activateBtn.MouseButton1Click:Connect(activateFreePurchase)
deactivateBtn.MouseButton1Click:Connect(deactivateHack)

-- زر إغلاق
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    -- إرجاع كل شيء لطبيعته عند الإغلاق
    if isHackActive then
        deactivateHack()
    end
end)

-- الكشف التلقائي عن Booths
local function autoDetectBooths()
    resultBox.Text = "🔍 جاري البحث عن Booths تلقائياً..."
    
    -- البحث عن أي booth في workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:find("Booth") or obj.Name:find("Stand") then
            if obj:FindFirstChild("ProximityPrompt") then
                resultBox.Text = resultBox.Text .. "\n📍 وجدت Booth: " .. obj.Name
                
                -- تلقائياً نعطل ProximityPrompt إذا كان الهجوم مفعل
                if isHackActive then
                    pcall(function()
                        obj.ProximityPrompt.Enabled = false
                        resultBox.Text = resultBox.Text .. "\n   ⚡ عطلت ProximityPrompt"
                    end)
                end
            end
        end
    end
end

-- بدء الكشف التلقائي
spawn(function()
    wait(2)
    autoDetectBooths()
end)

print("==========================================")
print("🎯 BOOTH FREE PURCHASE HACK LOADED")
print("💰 كل مشتريات Booths ببلاش عند التفعيل")
print("⚠️  USE AT YOUR OWN RISK")
print("==========================================")
