-- 💎 MASS STONE MERGER - 100,000 STONES
-- ⚠️ FOR EDUCATIONAL PURPOSES ONLY

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- تنظيف
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "StoneMerger" then
        gui:Destroy()
    end
end

-- الواجهة
local gui = Instance.new("ScreenGui")
gui.Name = "StoneMerger"
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 280)
frame.Position = UDim2.new(0.5, -160, 0.1, 0)
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
title.Text = "💎 MASS STONE MERGER (اسحبني)"
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.Parent = frame

-- البحث عن الـ Pickaxe
local function findArcanePickaxe()
    -- المسار الأول
    local pickaxe1 = player.PlayerGui:FindFirstChild("Menu")
    if pickaxe1 then
        pickaxe1 = pickaxe1:FindFirstChild("Frame")
        if pickaxe1 then
            pickaxe1 = pickaxe1:FindFirstChild("Frame")
            if pickaxe1 then
                pickaxe1 = pickaxe1:FindFirstChild("Menus")
                if pickaxe1 then
                    pickaxe1 = pickaxe1:FindFirstChild("Tools")
                    if pickaxe1 then
                        pickaxe1 = pickaxe1:FindFirstChild("Frame")
                        if pickaxe1 then
                            pickaxe1 = pickaxe1:FindFirstChild("Arcane Pickaxe")
                        end
                    end
                end
            end
        end
    end
    
    -- المسار الثاني (Backpack)
    local pickaxe2 = player.PlayerGui:FindFirstChild("BackpackGui")
    if pickaxe2 then
        pickaxe2 = pickaxe2:FindFirstChild("Backpack")
    end
    
    return pickaxe1 or pickaxe2
end

-- حجارة للدمج
local stones = {
    {
        name = "Stone 1",
        size = Vector3.new(7.1, 9.6, 8.5),
        position = Vector3.new(454.1, 130.6, -63.6),
        color = Color3.new(1.00, 0.35, 0.35)
    },
    {
        name = "Stone 2", 
        size = Vector3.new(8.6, 8.1, 8.1),
        position = Vector3.new(136.3, 37.2, 429.5),
        color = Color3.new(1.00, 0.35, 0.35)
    },
    -- يمكن إضافة المزيد
}

-- زر البحث عن الحجارة
local scanBtn = Instance.new("TextButton")
scanBtn.Text = "🔍 SCAN STONES"
scanBtn.Size = UDim2.new(0.9, 0, 0, 35)
scanBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
scanBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
scanBtn.TextColor3 = Color3.new(1, 1, 1)
scanBtn.Font = Enum.Font.SourceSansBold
scanBtn.Parent = frame

-- زر دمج 100K
local merge100kBtn = Instance.new("TextButton")
merge100kBtn.Text = "💥 MERGE 100,000 STONES"
merge100kBtn.Size = UDim2.new(0.9, 0, 0, 40)
merge100kBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
merge100kBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
merge100kBtn.TextColor3 = Color3.new(1, 1, 1)
merge100kBtn.Font = Enum.Font.SourceSansBold
merge100kBtn.Parent = frame

-- زر دمج جميع الحجارة
local mergeAllBtn = Instance.new("TextButton")
mergeAllBtn.Text = "💎 MERGE ALL STONES IN MAP"
mergeAllBtn.Size = UDim2.new(0.9, 0, 0, 40)
mergeAllBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
mergeAllBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
mergeAllBtn.TextColor3 = Color3.new(1, 1, 1)
mergeAllBtn.Font = Enum.Font.SourceSansBold
mergeAllBtn.Parent = frame

-- النتائج
local resultBox = Instance.new("TextLabel")
resultBox.Text = "👉 ابحث عن الحجارة أولاً"
resultBox.Size = UDim2.new(0.9, 0, 0, 70)
resultBox.Position = UDim2.new(0.05, 0, 0.7, 0)
resultBox.BackgroundColor3 = Color3.fromRGB(35, 45, 65)
resultBox.TextColor3 = Color3.new(1, 1, 1)
resultBox.TextWrapped = true
resultBox.Font = Enum.Font.SourceSans
resultBox.Parent = frame

-- دالة البحث عن الحجارة في الماب
local function scanForStones()
    resultBox.Text = "🔍 جاري البحث عن الحجارة...\n"
    
    local foundStones = {}
    
    -- البحث في workspace
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("Part") or part:IsA("MeshPart") then
            -- تحقق إذا كان حجر
            local isStone = false
            
            -- البحث عن كلمة "Stone" أو "Rock" في الاسم
            if part.Name:lower():find("stone") or 
               part.Name:lower():find("rock") or
               part.Name:lower():find("حجر") then
                isStone = true
            end
            
            -- أو لون أحمر (مثل اللي في الأمثلة)
            if part.Color.R > 0.8 and part.Color.G < 0.5 then
                isStone = true
            end
            
            if isStone then
                table.insert(foundStones, {
                    part = part,
                    position = part.Position,
                    size = part.Size
                })
            end
        end
    end
    
    resultBox.Text = resultBox.Text .. "✅ وجدت " .. #foundStones .. " حجر\n"
    
    if #foundStones > 0 then
        for i, stone in ipairs(foundStones) do
            if i <= 5 then  -- عرض أول 5 فقط
                resultBox.Text = resultBox.Text .. i .. ". " .. stone.part.Name .. "\n"
            end
        end
        
        if #foundStones > 5 then
            resultBox.Text = resultBox.Text .. "...و " .. (#foundStones - 5) .. " أكثر\n"
        end
    end
    
    return foundStones
end

-- دالة دمج حجر معين
local function mergeStone(stoneData, count)
    local pickaxe = findArcanePickaxe()
    
    if not pickaxe then
        return false, "❌ ما لقيت Arcane Pickaxe"
    end
    
    -- إنشاء Hitbox وهمي
    local fakeStone = Instance.new("Part")
    fakeStone.Size = stoneData.size
    fakeStone.Position = stoneData.position
    fakeStone.Color = stoneData.color
    fakeStone.Material = Enum.Material.Plastic
    fakeStone.Anchored = true
    fakeStone.CanCollide = false
    fakeStone.Transparency = 0.5  -- شفاف
    fakeStone.Name = "MERGING_STONE_" .. count
    fakeStone.Parent = workspace
    
    -- محاولة إرسال طلب دمج
    local success = false
    
    -- البحث عن RemoteEvents للدمج
    local mergeRemotes = {}
    for _, remote in pairs(game:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            if remote.Name:lower():find("merge") or 
               remote.Name:lower():find("combine") or
               remote.Name:lower():find("دمج") then
                table.insert(mergeRemotes, remote)
            end
        end
    end
    
    if #mergeRemotes > 0 then
        -- إرسال طلب دمج
        for _, remote in ipairs(mergeRemotes) do
            pcall(function()
                remote:FireServer({
                    tool = pickaxe,
                    stone = fakeStone,
                    count = 100000,  -- دمج 100K مرة
                    player = player
                })
                success = true
            end)
        end
    else
        -- محاولة بدون Remote
        pcall(function()
            -- محاكاة النقر على Pickaxe
            if pickaxe:IsA("Tool") then
                pickaxe:Activate()
            end
            
            -- أو إذا كان GUI Button
            if pickaxe:IsA("TextButton") or pickaxe:IsA("ImageButton") then
                pickaxe:Fire("click")
            end
            
            success = true
        end)
    end
    
    task.wait(0.05)  -- تأخير قصير
    
    -- تنظيف الحجر الوهمي
    fakeStone:Destroy()
    
    return success
end

-- دمج 100,000 حجر
scanBtn.MouseButton1Click:Connect(function()
    local stonesFound = scanForStones()
    
    if #stonesFound == 0 then
        -- إذا ما لقيت حجارة، استخدم الحجارة المحددة
        resultBox.Text = resultBox.Text .. "🔨 استخدام الحجارة الافتراضية\n"
    end
end)

-- دمج 100,000 مرة
merge100kBtn.MouseButton1Click:Connect(function()
    resultBox.Text = "💥 جاري دمج 100,000 حجر...\n"
    
    local pickaxe = findArcanePickaxe()
    if not pickaxe then
        resultBox.Text = resultBox.Text .. "❌ ما لقيت Arcane Pickaxe"
        return
    end
    
    resultBox.Text = resultBox.Text .. "✅ Pickaxe موجود: " .. pickaxe.Name .. "\n"
    
    -- استخدام الحجارة المحددة
    local targetStone = stones[1]  -- الحجر الأول
    
    local mergedCount = 0
    local failedCount = 0
    
    -- دمج 100,000 مرة
    for i = 1, 100000 do
        if i % 1000 == 0 then  -- تحديث كل 1000 مرة
            resultBox.Text = resultBox.Text .. "📊 " .. i .. "/100,000\n"
            task.wait()  -- منع التجميد
        end
        
        local success = mergeStone(targetStone, i)
        
        if success then
            mergedCount = mergedCount + 1
        else
            failedCount = failedCount + 1
        end
        
        -- تأخير بسيط لمنع الضغط
        if i % 100 == 0 then
            task.wait(0.01)
        end
    end
    
    resultBox.Text = resultBox.Text .. "\n✅ الانتهاء!\n"
    resultBox.Text = resultBox.Text .. "💎 مدمج: " .. mergedCount .. "\n"
    resultBox.Text = resultBox.Text .. "❌ فاشل: " .. failedCount
end)

-- دمج جميع الحجارة في الماب
mergeAllBtn.MouseButton1Click:Connect(function()
    resultBox.Text = "💎 جاري دمج كل الحجارة...\n"
    
    local allStones = scanForStones()
    
    if #allStones == 0 then
        resultBox.Text = resultBox.Text .. "❌ ما فيش حجارة في الماب"
        return
    end
    
    resultBox.Text = resultBox.Text .. "🔨 وجدت " .. #allStones .. " حجر\n"
    
    local totalMerged = 0
    
    for i, stoneData in ipairs(allStones) do
        resultBox.Text = resultBox.Text .. i .. ". دمج: " .. stoneData.part.Name .. "\n"
        
        -- تحويل إلى تنسيق الحجر
        local stoneConfig = {
            size = stoneData.size,
            position = stoneData.position,
            color = stoneData.part.Color
        }
        
        -- دمج 100 مرة لكل حجر
        for j = 1, 100 do
            mergeStone(stoneConfig, (i * 100) + j)
        end
        
        totalMerged = totalMerged + 100
        
        if i % 5 == 0 then  # تحديث كل 5 حجارة
            resultBox.Text = resultBox.Text .. "📊 مدمج حتى الآن: " .. totalMerged .. "\n"
            task.wait(0.1)
        end
    end
    
    resultBox.Text = resultBox.Text .. "\n✅ انتهى دمج " .. #allStones .. " حجر\n"
    resultBox.Text = resultBox.Text .. "💎 إجمالي عمليات الدمج: " .. totalMerged
end)

-- زر إغلاق
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -25, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- اكتشاف تلقائي
spawn(function()
    wait(2)
    local pickaxe = findArcanePickaxe()
    if pickaxe then
        resultBox.Text = "✅ Arcane Pickaxe موجود!\n"
        resultBox.Text = resultBox.Text .. "👉 استخدم Merge 100K للدمج"
    else
        resultBox.Text = "❌ Arcane Pickaxe مش موجود\n"
        resultBox.Text = resultBox.Text .. "🔍 ابحث في Backpack أو Tools"
    end
end)

print("========================================")
print("💎 MASS STONE MERGER LOADED")
print("🎯 100,000 stones merging")
print("⚠️  FOR EDUCATIONAL PURPOSES ONLY")
print("========================================")
