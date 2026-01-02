-- Grow a Garden Rewards Hacker
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- تنظيف
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "RewardsHacker" then
        gui:Destroy()
    end
end

-- واجهة
local gui = Instance.new("ScreenGui")
gui.Name = "RewardsHacker"
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 400)
frame.Position = UDim2.new(0.5, -175, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(25, 35, 45)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Text = "💰 GROW A GARDEN REWARDS HACK"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

-- أزرار الاختراق
local exploits = {
    {name = "⚡ HACK CMDER COMMANDS", desc = "يستغل الأوامر الإدارية"},
    {name = "🎁 MAX ALL REWARDS", desc = "يجعل كل المكافآت قصوى"},
    {name = "🎄 UNLOCK ALL GIFTS", desc = "يفتح كل الهدايا"},
    {name = "🏆 COMPLETE ALL QUESTS", desc = "يكمل كل المهام"}
}

for i, exploit in ipairs(exploits) do
    local btn = Instance.new("TextButton")
    btn.Text = exploit.name
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0.1 + (i*0.15), 0)
    btn.BackgroundColor3 = Color3.fromRGB(60, 70, 85)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.Parent = frame
    
    btn.MouseButton1Click:Connect(function()
        executeExploit(i)
    end)
end

-- منطقة النتائج
local resultBox = Instance.new("TextLabel")
resultBox.Text = "👉 اختر طريقة اختراق"
resultBox.Size = UDim2.new(0.9, 0, 0, 120)
resultBox.Position = UDim2.new(0.05, 0, 0.75, 0)
resultBox.BackgroundColor3 = Color3.fromRGB(35, 45, 55)
resultBox.TextColor3 = Color3.new(1, 1, 1)
resultBox.TextWrapped = true
resultBox.TextXAlignment = Enum.TextXAlignment.Left
resultBox.TextYAlignment = Enum.TextYAlignment.Top
resultBox.Font = Enum.Font.SourceSans
resultBox.TextSize = 13
resultBox.Parent = frame

-- دالة تنفيذ الاكسبلويت
local function executeExploit(mode)
    resultBox.Text = "🚀 جاري التنفيذ...\n"
    
    local Data = game:GetService("ReplicatedStorage").Data
    
    if mode == 1 then -- Cmder Commands
        resultBox.Text = resultBox.Text .. "⚡ جاري اختراق Cmder Commands...\n"
        
        local CmdrClient = game:GetService("ReplicatedStorage"):FindFirstChild("CmdrClient")
        if CmdrClient then
            local Commands = CmdrClient:FindFirstChild("Commands")
            if Commands then
                local commandsToTry = {
                    "completedailyquests",
                    "skipdailyquesttime", 
                    "adminquest",
                    "skipadventcalendarquests"
                }
                
                for _, cmdName in ipairs(commandsToTry) do
                    local cmd = Commands:FindFirstChild(cmdName)
                    if cmd then
                        local func = cmd:FindFirstChild("Function")
                        local event = cmd:FindFirstChild("Event")
                        
                        if func then
                            pcall(function()
                                func:InvokeServer("give_all")
                                resultBox.Text = resultBox.Text .. "✅ " .. cmdName .. " executed\n"
                            end)
                        elseif event then
                            pcall(function()
                                event:FireServer("activate")
                                resultBox.Text = resultBox.Text .. "✅ " .. cmdName .. " fired\n"
                            end)
                        end
                    end
                end
            end
        end
        
    elseif mode == 2 then -- Max All Rewards
        resultBox.Text = resultBox.Text .. "🎁 جاري تعديل كل المكافآت...\n"
        
        -- البحث عن كل ملفات المكافآت
        for _, child in pairs(Data:GetDescendants()) do
            if child.Name:find("Reward") or child.Name:find("Data") then
                if child:IsA("NumberValue") or child:IsA("IntValue") then
                    pcall(function()
                        local oldValue = child.Value
                        child.Value = 999999
                        resultBox.Text = resultBox.Text .. "💰 " .. child.Name .. ": " .. oldValue .. " → 999999\n"
                    end)
                end
            end
        end
        
    elseif mode == 3 then -- Unlock All Gifts
        resultBox.Text = resultBox.Text .. "🎄 جاري فتح كل الهدايا...\n"
        
        local GiftData = Data:FindFirstChild("GiftData")
        if GiftData then
            for _, gift in pairs(GiftData:GetChildren()) do
                if gift:IsA("Folder") then
                    -- تغيير الندرة
                    local rarity = gift:FindFirstChild("Rarity")
                    if rarity then
                        pcall(function() rarity.Value = "Legendary" end)
                    end
                    
                    -- تغيير القيمة
                    local value = gift:FindFirstChild("Value")
                    if value then
                        pcall(function() value.Value = 1000000 end)
                    end
                    
                    resultBox.Text = resultBox.Text .. "🎁 " .. gift.Name .. " unlocked\n"
                end
            end
        end
        
    elseif mode == 4 then -- Complete All Quests
        resultBox.Text = resultBox.Text .. "🏆 جاري إكمال كل المهام...\n"
        
        local QuestData = Data:FindFirstChild("QuestData")
        if QuestData then
            -- تحديث تقدم المهام
            for _, quest in pairs(QuestData:GetDescendants()) do
                if quest:IsA("IntValue") and quest.Name:find("Progress") then
                    pcall(function() quest.Value = 999 end)
                elseif quest:IsA("BoolValue") and quest.Name:find("Completed") then
                    pcall(function() quest.Value = true end)
                end
            end
            resultBox.Text = resultBox.Text .. "✅ All quests completed\n"
        end
    end
    
    resultBox.Text = resultBox.Text .. "\n🎯 الاختراق اكتمل!"
end

-- زر الإغلاق
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("========================================")
print("💰 GROW A GARDEN REWARDS HACKER LOADED")
print("🎯 Targets: Cmder Commands + Reward Data")
print("⚠️  Use only in private testing!")
print("========================================")
