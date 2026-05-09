-- [[ Reaper Hub Loading System - Optimized Version ]] -- 2

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local LogService = game:GetService("LogService")
local RunService = game:GetService("RunService")

-- 1. เคลียร์ของเก่า (ถ้ามี)
for _, v in pairs(Lighting:GetChildren()) do
    if v.Name == "ReaperEffect" then v:Destroy() end
end

-- 2. สร้าง Effects ใน Lighting เพื่อความเนียน
local blur = Instance.new("BlurEffect")
blur.Name = "ReaperEffect"
blur.Size = 0
blur.Parent = Lighting

local colorCorr = Instance.new("ColorCorrectionEffect")
colorCorr.Name = "ReaperEffect"
colorCorr.Brightness = 0
colorCorr.Parent = Lighting

-- 3. สร้าง UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ReaperLoadingUI"
screenGui.Parent = CoreGui
screenGui.IgnoreGuiInset = true -- ทะลุแถบเมนูบน
screenGui.DisplayOrder = 88888 -- ปรับตามที่คุณต้องการ

-- CanvasGroup เพื่อความสมูทในการจางหาย
local canvasGroup = Instance.new("CanvasGroup")
canvasGroup.Size = UDim2.new(1.1, 0, 1.1, 0) -- ขยายเกินจอนิดหน่อยเพื่อปิดขอบ
canvasGroup.Position = UDim2.new(-0.05, 0, -0.05, 0)
canvasGroup.BackgroundTransparency = 1
canvasGroup.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
canvasGroup.GroupTransparency = 1 -- เริ่มที่โปร่งใส
canvasGroup.Parent = screenGui

-- แผ่นดำซ้อนหลัง (กันขอบรั่ว)
local blackBg = Instance.new("Frame")
blackBg.Size = UDim2.new(1, 0, 1, 0)
blackBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blackBg.BackgroundTransparency = 0.3
blackBg.BorderSizePixel = 0
blackBg.Parent = canvasGroup

-- ข้อความ REAPER HUB
local title = Instance.new("TextLabel")
title.Text = "REAPER HUB"
title.Font = Enum.Font.Michroma
title.TextSize = 65
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Position = UDim2.new(0.5, 0, 0.42, 0) -- อยู่กลางจอเยื้องขึ้นบนนิดหน่อย
title.AnchorPoint = Vector2.new(0.5, 0.5)
title.BackgroundTransparency = 1
title.Parent = canvasGroup

-- Loading Bar
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0, 280, 0, 3)
barBg.Position = UDim2.new(0.5, 0, 0.55, 0)
barBg.AnchorPoint = Vector2.new(0.5, 0.5)
barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
barBg.BorderSizePixel = 0
barBg.Parent = canvasGroup

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- แดง Reaper
barFill.BorderSizePixel = 0
barFill.Parent = barBg

-- อนิเมชั่นขาเข้า
local fadeInfo = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
TweenService:Create(blur, fadeInfo, {Size = 56}):Play()
TweenService:Create(colorCorr, fadeInfo, {Brightness = -0.15}):Play()
TweenService:Create(canvasGroup, fadeInfo, {GroupTransparency = 0}):Play()

-- หลอดโหลดวิ่งวนไปเรื่อยๆ
local connection
connection = RunService.RenderStepped:Connect(function()
    if barFill.Size.X.Scale >= 1 then
        barFill.Size = UDim2.new(0, 0, 1, 0)
    end
    barFill.Size = barFill.Size + UDim2.new(0.008, 0, 0, 0)
end)

-- ฟังก์ชัน Cleanup เมื่อได้รับสัญญาณ
local function CleanUp()
    if connection then connection:Disconnect() end
    
    local outInfo = TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    
    -- จางหายทุกอย่างพร้อมกันเป๊ะ
    TweenService:Create(blur, outInfo, {Size = 0}):Play()
    TweenService:Create(colorCorr, outInfo, {Brightness = 0}):Play()
    local mainTween = TweenService:Create(canvasGroup, outInfo, {GroupTransparency = 1})
    
    mainTween:Play()
    mainTween.Completed:Wait()
    
    screenGui:Destroy()
    blur:Destroy()
    colorCorr:Destroy()
end

-- ดักฟังการ Print
LogService.MessageOut:Connect(function(msg)
    if msg == "Reaper Hub Loaded" then
        CleanUp()
    end
end)
