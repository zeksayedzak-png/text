-- 🔓 ADMIN COMMANDS UNLOCKER - Grow a Garden
-- ⚠️ FOR EDUCATIONAL PURPOSES ONLY

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- تنظيف
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "AdminUnlocker" then
        gui:Destroy()
    end
end

-- الواجهة
local gui = Instance.new("ScreenGui")
gui.Name = "AdminUnlocker"
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 400) -- ⬅️ تصغير الحجم
frame.Position = UDim2.new(0.5, -175, 0.1, 0) -- ⬅️ وضعها بالأعلى
frame.BackgroundColor3 = Color3.fromRGB(30, 40, 55)
frame.BorderSizePixel = 0
frame.Parent = gui

-- 🔥 إضافة التحريك هنا
local dragging = false
local dragStart
local startPos

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
title.Text = "👑 ADMIN (اسحبني)" -- ⬅️ تغيير النص
title.Size = UDim2.new(1, 0, 0, 35) -- ⬅️ تصغير
title.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16 -- ⬅️ تصغير الخط
title.Parent = frame

-- البحث عن CmdrClient
local function findCmdrClient()
    local CmdrClient = game:GetService("ReplicatedStorage"):FindFirstChild("CmdrClient")
    if not CmdrClient then
        return nil
    end
    
    local Commands = CmdrClient:FindFirstChild("Commands")
    local Types = CmdrClient:FindFirstChild("Types")
    
    return {
        CmdrClient = CmdrClient,
        Commands = Commands,
        Types = Types
    }
end

-- قائمة الأوامر الإدارية المتاحة
local adminCommands = {
    {name = "adminquest", desc = "أضف كويست إداري"},
    {name = "givepremium", desc = "أعط بريميوم"},
    {name = "completedailyquests", desc = "أكمل كل الكويستات"},
    {name = "skipdailyquesttime", desc = "تخطى وقت الكويست"},
    {name = "globaladminquest", desc = "كويست إداري عالمي"},
    {name = "skipadventcalendarquests", desc = "تخطى كويستات التقويم"},
    {name = "progresstime", desc = "تقدم في الوقت"},
    {name = "progressseasonpass", desc = "تقدم في الموسم"},
    {name = "clearachievements", desc = "امسح الإنجازات"},
    {name = "completeachievement", desc = "أكمل إنجاز"}
}

-- زر اكتشاف النظام
local detectBtn = Instance.new("TextButton")
detectBtn.Text = "🔍 DETECT SYSTEM"
detectBtn.Size = UDim2.new(0.9, 0, 0, 35) -- ⬅️ تصغير
detectBtn.Position = UDim2.new(0.05, 0, 0.1, 0)
detectBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
detectBtn.TextColor3 = Color3.new(1, 1, 1)
detectBtn.Font = Enum.Font.SourceSansBold
detectBtn.TextSize = 14 -- ⬅️ تصغير
detectBtn.Parent = frame

-- زر تفعيل البايباس
local bypassBtn = Instance.new("TextButton")
bypassBtn.Text = "🔓 BYPASS CHECK"
bypassBtn.Size = UDim2.new(0.9, 0, 0, 35) -- ⬅️ تصغير
bypassBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
bypassBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
bypassBtn.TextColor3 = Color3.new(1, 1, 1)
bypassBtn.Font = Enum.Font.SourceSansBold
bypassBtn.TextSize = 14 -- ⬅️ تصغير
bypassBtn.Parent = frame

-- حقل إدخال الأمر المخصص
local customInput = Instance.new("TextBox")
customInput.PlaceholderText = "أدخل أمر..."
customInput.Size = UDim2.new(0.9, 0, 0, 30) -- ⬅️ تصغير
customInput.Position = UDim2.new(0.05, 0, 0.3, 0)
customInput.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
customInput.TextColor3 = Color3.new(1, 1, 1)
customInput.Font = Enum.Font.SourceSans
customInput.TextSize = 13 -- ⬅️ تصغير
customInput.Parent = frame

-- زر تنفيذ الأمر المخصص
local executeCustomBtn = Instance.new("TextButton")
executeCustomBtn.Text = "⚡ EXECUTE"
executeCustomBtn.Size = UDim2.new(0.9, 0, 0, 35) -- ⬅️ تصغير
executeCustomBtn.Position = UDim2.new(0.05, 0, 0.38, 0)
executeCustomBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
executeCustomBtn.TextColor3 = Color3.new(1, 1, 1)
executeCustomBtn.Font = Enum.Font.SourceSansBold
executeCustomBtn.TextSize = 14 -- ⬅️ تصغير
executeCustomBtn.Parent = frame

-- منطقة الأوامر السريعة
local quickCommandsLabel = Instance.new("TextLabel")
quickCommandsLabel.Text = "⚡ QUICK COMMANDS:"
quickCommandsLabel.Size = UDim2.new(0.9, 0, 0, 20) -- ⬅️ تصغير
quickCommandsLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
quickCommandsLabel.BackgroundTransparency = 1
quickCommandsLabel.TextColor3 = Color3.new(1, 1, 1)
quickCommandsLabel.Font = Enum.Font.SourceSansSemibold
quickCommandsLabel.TextSize = 12 -- ⬅️ تصغير
quickCommandsLabel.Parent = frame

-- قائمة الأوامر السريعة
local quickCommandsFrame = Instance.new("ScrollingFrame")
quickCommandsFrame.Size = UDim2.new(0.9, 0, 0, 120) -- ⬅️ تصغير
quickCommandsFrame.Position = UDim2.new(0.05, 0, 0.55, 0)
quickCommandsFrame.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
quickCommandsFrame.BorderSizePixel = 0
quickCommandsFrame.CanvasSize = UDim2.new(0, 0, 0, #adminCommands * 35)
quickCommandsFrame.Parent = frame

-- النتائج
local resultBox = Instance.new("TextLabel")
resultBox.Text = "👉 اضغط DETECT أولاً"
resultBox.Size = UDim2.new(0.9, 0, 0, 70) -- ⬅️ تصغير
resultBox.Position = UDim2.new(0.05, 0, 0.9, 0)
resultBox.BackgroundColor3 = Color3.fromRGB(35, 45, 65)
resultBox.TextColor3 = Color3.new(1, 1, 1)
resultBox.TextWrapped = true
resultBox.Font = Enum.Font.SourceSans
resultBox.TextSize = 12 -- ⬅️ تصغير
resultBox.Parent = frame

-- متغيرات
local cmdrSystem = nil
local isBypassed = false
local originalFunctions = {}

-- اكتشاف CmdrClient
detectBtn.MouseButton1Click:Connect(function()
    resultBox.Text = "🔍 جاري البحث عن نظام CmdrClient..."
    
    cmdrSystem = findCmdrClient()
    
    if not cmdrSystem then
        resultBox.Text = "❌ ما لقيت CmdrClient"
        return
    end
    
    if not cmdrSystem.Commands then
        resultBox.Text = "❌ Commands مش موجود"
        return
    end
    
    resultBox.Text = "✅ وجدت CmdrClient!\n"
    resultBox.Text = resultBox.Text .. "📁 Commands: " .. #cmdrSystem.Commands:GetChildren() .. "\n"
    
    -- عرض الأوامر الموجودة
    local foundCommands = 0
    for _, cmd in pairs(cmdrSystem.Commands:GetChildren()) do
        if cmd:IsA("ModuleScript") then
            foundCommands = foundCommands + 1
            resultBox.Text = resultBox.Text .. "• " .. cmd.Name .. "\n"
        end
    end
    
    resultBox.Text = resultBox.Text .. "\n🎯 جاهز!"
    
    -- إنشاء أزرار الأوامر السريعة
    for i, cmd in ipairs(adminCommands) do
        local cmdBtn = Instance.new("TextButton")
        cmdBtn.Text = cmd.name
        cmdBtn.Size = UDim2.new(0.95, 0, 0, 30) -- ⬅️ تصغير
        cmdBtn.Position = UDim2.new(0.025, 0, 0, (i-1)*35)
        cmdBtn.BackgroundColor3 = Color3.fromRGB(60, 70, 90)
        cmdBtn.TextColor3 = Color3.new(1, 1, 1)
        cmdBtn.Font = Enum.Font.SourceSans
        cmdBtn.TextSize = 11 -- ⬅️ تصغير
        cmdBtn.Parent = quickCommandsFrame
        
        cmdBtn.MouseButton1Click:Connect(function()
            executeAdminCommand(cmd.name, "")
        end)
    end
end)

-- بايباس فحص الصلاحيات
bypassBtn.MouseButton1Click:Connect(function()
    if not cmdrSystem then
        resultBox.Text = "❌ اكتشف النظام أولاً!"
        return
    end
    
    resultBox.Text = "🔧 جاري بايباس..."
    
    -- الطريقة 1: تعديل الـ ModuleScripts
    local bypassSuccess = false
    
    for _, cmdModule in pairs(cmdrSystem.Commands:GetChildren()) do
        if cmdModule:IsA("ModuleScript") then
            pcall(function()
                local code = require(cmdModule)
                
                if type(code) == "table" then
                    if code.Execute then
                        originalFunctions[cmdModule.Name] = code.Execute
                        
                        code.Execute = function(player, args)
                            resultBox.Text = resultBox.Text .. "⚡ " .. cmdModule.Name .. "\n"
                            
                            local fakePlayer = game:GetService("Players"):GetPlayerByUserId(player.UserId)
                            if not fakePlayer then
                                fakePlayer = game.Players.LocalPlayer
                            end
                            
                            if originalFunctions[cmdModule.Name] then
                                return originalFunctions[cmdModule.Name](fakePlayer, args)
                            end
                        end
                        
                        bypassSuccess = true
                    end
                end
            end)
        end
    end
    
    -- الطريقة 2: hooking للـ Remotes
    if not bypassSuccess then
        resultBox.Text = resultBox.Text .. "🔄 جرب طريقة أخرى...\n"
        
        for _, remote in pairs(game:GetDescendants()) do
            if remote:IsA("RemoteFunction") and remote.Name:find("Command") then
                pcall(function()
                    originalFunctions[remote.Name] = remote.InvokeServer
                    
                    remote.InvokeServer = function(self, ...)
                        local args = {...}
                        
                        resultBox.Text = resultBox.Text .. "📡 " .. remote.Name .. "\n"
                        
                        args[1] = game.Players.LocalPlayer
                        
                        if remote.Name:find("Permission") then
                            return true
                        end
                        
                        return originalFunctions[remote.Name](self, unpack(args))
                    end
                    
                    bypassSuccess = true
                end)
            end
        end
    end
    
    if bypassSuccess then
        isBypassed = true
        bypassBtn.Text = "✅ BYPASS ACTIVE"
        bypassBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        resultBox.Text = resultBox.Text .. "\n✅ بايباس ناجح!"
    else
        resultBox.Text = resultBox.Text .. "❌ فشل البايباس"
    end
end)

-- تنفيذ أمر إدمن
local function executeAdminCommand(commandName, args)
    if not cmdrSystem or not isBypassed then
        resultBox.Text = "❌ فعّل البايباس أولاً!"
        return
    end
    
    resultBox.Text = "🎯 جاري: " .. commandName .. "\n"
    
    local commandModule = cmdrSystem.Commands:FindFirstChild(commandName)
    if not commandModule then
        resultBox.Text = resultBox.Text .. "❌ الأمر غير موجود"
        return
    end
    
    local commandArgs = args
    if commandArgs == "" then
        if commandName:find("give") then
            commandArgs = game.Players.LocalPlayer.Name
        elseif commandName:find("complete") then
            commandArgs = "all"
        elseif commandName:find("skip") then
            commandArgs = "all"
        end
    end
    
    pcall(function()
        local cmdCode = require(commandModule)
        
        if type(cmdCode) == "table" and cmdCode.Execute then
            local success, result = pcall(function()
                return cmdCode.Execute(game.Players.LocalPlayer, commandArgs)
            end)
            
            if success then
                resultBox.Text = resultBox.Text .. "✅ تم!\n"
                resultBox.Text = resultBox.Text .. "📤 " .. tostring(result)
            else
                resultBox.Text = resultBox.Text .. "❌ فشل: " .. tostring(result)
            end
        else
            resultBox.Text = resultBox.Text .. "❌ لا يمكن تنفيذه"
        end
    end)
end

-- تنفيذ أمر مخصص
executeCustomBtn.MouseButton1Click:Connect(function()
    local inputText = customInput.Text
    if inputText == "" then
        resultBox.Text = "❌ أدخل أمراً أولاً"
        return
    end
    
    local parts = {}
    for part in inputText:gmatch("%S+") do
        table.insert(parts, part)
    end
    
    if #parts == 0 then return end
    
    local commandName = parts[1]
    local args = ""
    
    if #parts > 1 then
        args = table.concat(parts, " ", 2)
    end
    
    executeAdminCommand(commandName, args)
end)

-- أوامر سريعة مسبقة الصنع
local preMadeCommands = {
    {name = "🎁 GET PREMIUM", cmd = "givepremium", args = ""},
    {name = "🏆 COMPLETE ALL", cmd = "completedailyquests", args = "all"},
    {name = "⏰ SKIP TIME", cmd = "skipdailyquesttime", args = "all"},
    {name = "👑 ADMIN QUEST", cmd = "adminquest", args = "add_rewards"}
}

for i, preCmd in ipairs(preMadeCommands) do
    local preBtn = Instance.new("TextButton")
    preBtn.Text = preCmd.name
    preBtn.Size = UDim2.new(0.9, 0, 0, 25) -- ⬅️ تصغير
    preBtn.Position = UDim2.new(0.05, 0, 0.75 + (i*0.05), 0)
    preBtn.BackgroundColor3 = Color3.fromRGB(80, 90, 110)
    preBtn.TextColor3 = Color3.new(1, 1, 1)
    preBtn.Font = Enum.Font.SourceSans
    preBtn.TextSize = 11 -- ⬅️ تصغير
    preBtn.Parent = frame
    
    preBtn.MouseButton1Click:Connect(function()
        if cmdrSystem and isBypassed then
            executeAdminCommand(preCmd.cmd, preCmd.args)
        else
            resultBox.Text = "❌ فعّل البايباس أولاً!"
        end
    end)
end

-- زر الإغلاق
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 25, 0, 25) -- ⬅️ تصغير
closeBtn.Position = UDim2.new(1, -25, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- تحقق تلقائي من النظام
spawn(function()
    wait(1)
    resultBox.Text = "🔎 فحص تلقائي..."
    
    local tempCmdr = findCmdrClient()
    if tempCmdr then
        resultBox.Text = "✅ CmdrClient موجود!\n"
        resultBox.Text = resultBox.Text .. "👉 اضغط DETECT"
    else
        resultBox.Text = "❌ CmdrClient مش موجود\n"
    end
end)

print("==========================================")
print("👑 ADMIN UNLOCKER LOADED")
print("🎯 Targets: CmdrClient System")
print("⚠️  FOR SECURITY RESEARCH ONLY")
print("==========================================")
