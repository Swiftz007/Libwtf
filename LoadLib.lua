-- [[ Reaper Hub Loading System - Synchronized Version ]] --

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local LogService = game:GetService("LogService")

-- 1. สร้าง Blur
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

-- 2. สร้าง UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ReaperLoadingUI"
screenGui.Parent = CoreGui
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999

-- ใช้ CanvasGroup เพื่อให้เวลา Fade มันไปพร้อมกันทั้งยวง
local canvasGroup = Instance.new("CanvasGroup")
canvasGroup.Size = UDim2.new(1, 0, 1, 0)
canvasGroup.BackgroundTransparency = 1
canvasGroup.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
canvasGroup.GroupTransparency = 1 -- เริ่มต้นที่โปร่งใส 100%
canvasGroup.Parent = screenGui

local title = Instance.new("TextLabel")
title.Text = "REAPER HUB"
title.Font = Enum.Font.Michroma
title.TextSize = 60
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Position = UDim2.new(0.5, 0, 0.4, 0)
title.AnchorPoint = Vector2.new(0.5, 0.5)
title.BackgroundTransparency = 1
title.Parent = canvasGroup

local loadingBarBG = Instance.new("Frame")
loadingBarBG.Size = UDim2.new(0, 250, 0, 2)
loadingBarBG.Position = UDim2.new(0.5, 0, 0.55, 0)
loadingBarBG.AnchorPoint = Vector2.new(0.5, 0.5)
loadingBarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
loadingBarBG.BorderSizePixel = 0
loadingBarBG.Parent = canvasGroup

local loadingBarFill = Instance.new("Frame")
loadingBarFill.Size = UDim2.new(0, 0, 1, 0)
loadingBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
loadingBarFill.BorderSizePixel = 0
loadingBarFill.Parent = loadingBarBG

-- ตั้งค่าเวลาที่ต้องการให้จางหาย (เท่ากันทุกอย่าง)
local FADE_TIME = 0.6 
local fadeInfo = TweenInfo.new(FADE_TIME, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

-- เริ่มแสดงผล
TweenService:Create(blur, fadeInfo, {Size = 35}):Play()
TweenService:Create(canvasGroup, fadeInfo, {GroupTransparency = 0, BackgroundTransparency = 0.3}):Play()

-- หลอดโหลด
local loadingConnection
loadingConnection = game:GetService("RunService").RenderStepped:Connect(function()
    if loadingBarFill.Size.X.Scale >= 1 then
        loadingBarFill.Size = UDim2.new(0, 0, 1, 0)
    end
    loadingBarFill.Size = loadingBarFill.Size + UDim2.new(0.008, 0, 0, 0)
end)

-- ฟังก์ชันเคลียร์ทุกอย่าง "พร้อมกัน"
local function CleanupEverything()
    if loadingConnection then loadingConnection:Disconnect() end
    
    -- รัน Tween พร้อมกันด้วยเวลาที่เท่ากันเป๊ะ
    local blurTween = TweenService:Create(blur, fadeInfo, {Size = 0})
    local uiTween = TweenService:Create(canvasGroup, fadeInfo, {GroupTransparency = 1, BackgroundTransparency = 1})
    
    blurTween:Play()
    uiTween:Play()
    
    -- รอให้ Tween จบแล้วลบ Object ทิ้ง
    uiTween.Completed:Wait()
    screenGui:Destroy()
    blur:Destroy()
end

-- ตรวจจับคำสั่ง print
LogService.MessageOut:Connect(function(message)
    if message == "Reaper Hub Loaded" then
        CleanupEverything()
    end
end)
