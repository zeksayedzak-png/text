-- 💎 MASS STONE MERGER - MOBILE EDITION
-- ⚠️ FOR EDUCATIONAL PURPOSES ONLY

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- تنظيف
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "StoneMergerMobile" then
        gui:Destroy()
    end
end

-- الواجهة الصغيرة للموبايل
local gui = Instance.new("ScreenGui")
gui.Name = "StoneMergerMobile"
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 220) -- ⬅️ أصغر للموبايل
frame.Position = UDim2.new(0.1, 0, 0.1, 0) -- ⬅️ في الزاوية
frame.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
frame.BorderSizePixel = 0
frame.Parent = gui

-- 🔥 تحريك بالإصبع
local dragging = false
local dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

local title = Instance.new("TextLabel")
title.Text = "💎 STONE MERGER (اسحبني)"
title.Size = UDim2.new(1, 0, 0, 30) -- ⬅️ أصغر
title.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 14 -- ⬅️ أصغر
title.Parent = frame

-- البحث عن الـ Pickaxe بطريقة مبسطة للموبايل
local function findArcanePickaxe()
    -- محاولة مباشرة
    local pickaxe = player:FindFirstChild("Backpack")
    if pickaxe then
        pickaxe = pickaxe:FindFirstChild("Arcane Pickaxe")
        if pickaxe then return pickaxe end
    end
    
    -- في PlayerGui
    if player:FindFirstChild("PlayerGui") then
        -- البحث في جميع الأماكن
        for _, child in pairs(player.PlayerGui:GetDescendants()) do
            if child.Name == "Arcane Pickaxe" then
                return child
            end
        end
    end
    
    return nil
end

-- زر البحث المبسط
local scanBtn = Instance.new("TextButton")
scanBtn.Text = "🔍 FIND PICKAXE"
scanBtn.Size = UDim2.new(0.9, 0, 0, 30) -- ⬅️ أصغر
scanBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
scanBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
scanBtn.TextColor3 = Color3.new(1, 1, 1)
scanBtn.Font = Enum.Font.SourceSansBold
scanBtn.TextSize = 13 -- ⬅️ أصغر
scanBtn.Parent = frame

-- زر دمج 10K (أقل للموبايل)
local mergeBtn = Instance.new("TextButton")
mergeBtn.Text = "💥 MERGE 10K"
mergeBtn.Size = UDim2.new(0.9, 0, 0, 35) -- ⬅️ أصغر
mergeBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
mergeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
mergeBtn.TextColor3 = Color3.new(1, 1, 1)
mergeBtn.Font = Enum.Font.SourceSansBold
mergeBtn.TextSize = 14 -- ⬅️ أصغر
mergeBtn.Parent = frame

-- زر إلغاء
local stopBtn = Instance.new("TextButton")
stopBtn.Text = "⏹ STOP"
stopBtn.Size = UDim2.new(0.9, 0, 0, 30) -- ⬅️ أصغر
stopBtn.Position = UDim2.new(0.05, 0, 0.5, 0)
stopBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Font = Enum.Font.SourceSansBold
stopBtn.TextSize = 13 -- ⬅️ أصغر
stopBtn.Parent = frame

-- النتائج
local resultBox = Instance.new("TextLabel")
resultBox.Text = "👉 اضغط FIND PICKAXE"
resultBox.Size = UDim2.new(0.9, 0, 0, 60) -- ⬅️ أصغر
resultBox.Position = UDim2.new(0.05, 0, 0.65, 0)
resultBox.BackgroundColor3 = Color3.fromRGB(35, 45, 65)
resultBox.TextColor3 = Color3.new(1, 1, 1)
resultBox.TextWrapped = true
resultBox.Font = Enum.Font.SourceSans
resultBox.TextSize = 12 -- ⬅️ أصغر
resultBox.Parent = frame

-- متغيرات
local isMerging = false
local foundPickaxe = nil

-- البحث عن Pickaxe
scanBtn.MouseButton1Click:Connect(function()
    resultBox.Text = "🔍 جاري البحث عن Pickaxe..."
    
    foundPickaxe = findArcanePickaxe()
    
    if foundPickaxe then
        resultBox.Text = "✅ وجدت: " .. foundPickaxe.Name .. "\n"
        resultBox.Text = resultBox.Text .. "📍 في: " .. foundPickaxe:GetFullName()
        mergeBtn.Text = "💥 MERGE 10K (جاهز)"
        mergeBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        resultBox.Text = "❌ ما لقيت Arcane Pickaxe\n"
        resultBox.Text = resultBox.Text .. "🔍 ابحث في Backpack يدوياً"
        mergeBtn.Text = "💥 MERGE 10K"
        mergeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

-- دالة دمج مبسطة للموبايل
local function simpleMerge()
    if not foundPickaxe then
        resultBox.Text = "❌ ما فيش Pickaxe!\n"
        resultBox.Text = resultBox.Text .. "اضغط FIND PICKAXE أولاً"
        return false
    end
    
    -- البحث عن RemoteEvents للدمج
    for _, remote in pairs(game:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            if remote.Name:lower():find("mine") or 
               remote.Name:lower():find("collect") or
               remote.Name:lower():find("merge") then
                -- إرسال طلب دمج
                pcall(function()
                    remote:FireServer({
                        tool = foundPickaxe,
                        action = "mine",
                        count = 10000
                    })
                    return true
                end)
            end
        end
    end
    
    -- محاولة بدون Remote
    pcall(function()
        if foundPickaxe:IsA("Tool") then
            foundPickaxe:Activate()
        end
    end)
    
    return true
end

-- دمج 10,000 مرة
mergeBtn.MouseButton1Click:Connect(function()
    if isMerging then return end
    
    if not foundPickaxe then
        resultBox.Text = "❌ ابحث عن Pickaxe أولاً!"
        return
    end
    
    isMerging = true
    mergeBtn.Text = "⏳ MERGING..."
    mergeBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    
    resultBox.Text = "💥 جاري الدمج...\n"
    
    local merged = 0
    local failed = 0
    
    -- دمج 10,000 مرة (أقل للموبايل)
    spawn(function()
        for i = 1, 10000 do
            if not isMerging then break end
            
            if i % 500 == 0 then
                resultBox.Text = "📊 " .. i .. "/10000\n"
                resultBox.Text = resultBox.Text .. "✅ " .. merged .. " ⛔ " .. failed
                task.wait(0.05) -- تأخير للموبايل
            end
            
            local success = simpleMerge()
            
            if success then
                merged = merged + 1
            else
                failed = failed + 1
            end
            
            -- تأخير خفيف للموبايل
            if i % 100 == 0 then
                task.wait(0.01)
            end
        end
        
        isMerging = false
        mergeBtn.Text = "💥 MERGE 10K"
        mergeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        
        resultBox.Text = "✅ انتهى الدمج!\n"
        resultBox.Text = resultBox.Text .. "💎 مدمج: " .. merged .. "\n"
        resultBox.Text = resultBox.Text .. "❌ فاشل: " .. failed
    end)
end)

-- إيقاف الدمج
stopBtn.MouseButton1Click:Connect(function()
    isMerging = false
    mergeBtn.Text = "💥 MERGE 10K"
    mergeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    resultBox.Text = "⏹ توقف الدمج"
end)

-- زر إغلاق صغير
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -25, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    isMerging = false
    gui:Destroy()
end)

-- اكتشاف تلقائي عند التحميل
spawn(function()
    wait(1)
    foundPickaxe = findArcanePickaxe()
    
    if foundPickaxe then
        resultBox.Text = "✅ Pickaxe موجود!\n"
        resultBox.Text = resultBox.Text .. "👉 اضغط MERGE 10K"
        mergeBtn.Text = "💥 MERGE 10K (جاهز)"
        mergeBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        resultBox.Text = "🔍 ابحث عن Pickaxe\n"
        resultBox.Text = resultBox.Text .. "اضغط FIND PICKAXE"
    end
end)

print("========================================")
print("💎 STONE MERGER MOBILE LOADED")
print("📱 Optimized for Mobile")
print("⚠️  FOR EDUCATIONAL PURPOSES ONLY")
print("========================================")
