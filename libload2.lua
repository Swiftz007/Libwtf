-- [[ Reaper Hub Loading System - Static Logo Edition ]] --

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local LogService = game:GetService("LogService")

-- 1. Setup Effects (เบลอทันที)
for _, v in pairs(Lighting:GetChildren()) do
    if v.Name == "ReaperEffect" then v:Destroy() end
end

local blur = Instance.new("BlurEffect")
blur.Name = "ReaperEffect"
blur.Size = 56
blur.Parent = Lighting

local colorCorr = Instance.new("ColorCorrectionEffect")
colorCorr.Name = "ReaperEffect"
colorCorr.Brightness = -0.1
colorCorr.Parent = Lighting

-- 2. UI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ReaperLoadingUI"
screenGui.Parent = CoreGui
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 99999

local canvasGroup = Instance.new("CanvasGroup")
canvasGroup.Size = UDim2.new(1, 0, 1, 0)
canvasGroup.GroupTransparency = 1
canvasGroup.Parent = screenGui

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
bg.BorderSizePixel = 0
bg.Parent = canvasGroup

-- Vignette (ขอบมืดเพิ่มมิติ)
local vignette = Instance.new("ImageLabel")
vignette.Size = UDim2.new(1, 0, 1, 0)
vignette.BackgroundTransparency = 1
vignette.Image = "rbxassetid://4031889928"
vignette.ImageColor3 = Color3.fromRGB(0, 0, 0)
vignette.ImageTransparency = 0.3
vignette.Parent = bg

-- [[ LOGO - STATIC POSITION ]] --
local logo = Instance.new("ImageLabel")
logo.Image = "rbxassetid://131279093559313"
logo.Size = UDim2.new(0, 150, 0, 150)
logo.Position = UDim2.new(0.5, 0, 0.35, 0) -- อยู่เหนือชื่อ
logo.AnchorPoint = Vector2.new(0.5, 0.5)
logo.BackgroundTransparency = 1
logo.Parent = canvasGroup

-- Title
local title = Instance.new("TextLabel")
title.Text = "REAPER HUB"
title.Font = Enum.Font.Michroma
title.TextSize = 55
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Position = UDim2.new(0.5, 0, 0.52, 0)
title.AnchorPoint = Vector2.new(0.5, 0.5)
title.BackgroundTransparency = 1
title.Parent = canvasGroup

-- Subtitle Cycle
local subtitle = Instance.new("TextLabel")
subtitle.Text = "Initializing..."
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 13
subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitle.Position = UDim2.new(0.5, 0, 0.58, 0)
subtitle.AnchorPoint = Vector2.new(0.5, 0.5)
subtitle.BackgroundTransparency = 1
subtitle.Parent = canvasGroup

local phrases = {
    "Initializing...",
    "Reaper Hub Better",
    "Credit : x2sxqz_",
    "Project by NongDiw",
    "Official Discord",
    "https://discord.gg/RPVTDFZyhw"
}

-- Progress Bar
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0, 280, 0, 4)
barBg.Position = UDim2.new(0.5, 0, 0.63, 0)
barBg.AnchorPoint = Vector2.new(0.5, 0.5)
barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barBg.BorderSizePixel = 0
barBg.Parent = canvasGroup
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
barFill.BorderSizePixel = 0
barFill.Parent = barBg
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

-- 3. Logic
local isLoaded = false

local function StartAnims()
    -- Fade UI เข้ามา
    TweenService:Create(canvasGroup, TweenInfo.new(1), {GroupTransparency = 0}):Play()
    
    -- ข้อความเปลี่ยนไปเรื่อยๆ
    task.spawn(function()
        local i = 1
        while not isLoaded do
            subtitle.Text = phrases[i]
            TweenService:Create(subtitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
            task.wait(2.5)
            if isLoaded then break end
            local fadeOut = TweenService:Create(subtitle, TweenInfo.new(0.5), {TextTransparency = 1})
            fadeOut:Play()
            fadeOut.Completed:Wait()
            i = i % #phrases + 1
        end
    end)

    -- หลอดโหลด (Smart Progress)
    TweenService:Create(barFill, TweenInfo.new(15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0.92, 0, 1, 0)}):Play()
end

local function Finalize()
    if isLoaded then return end
    isLoaded = true
    
    subtitle.Text = "READY"
    subtitle.TextTransparency = 0
    
    -- วิ่งเต็มหลอด
    local final = TweenService:Create(barFill, TweenInfo.new(0.4), {Size = UDim2.new(1, 0, 1, 0)})
    final:Play()
    final.Completed:Wait()
    
    task.wait(0.5)
    
    -- Outro
    local info = TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    TweenService:Create(blur, info, {Size = 0}):Play()
    TweenService:Create(colorCorr, info, {Brightness = 0}):Play()
    local exit = TweenService:Create(canvasGroup, info, {GroupTransparency = 1, Size = UDim2.new(1.1, 0, 1.1, 0)})
    exit:Play()
    exit.Completed:Wait()
    screenGui:Destroy()
end

-- 4. Execute
StartAnims()

LogService.MessageOut:Connect(function(msg)
    if msg:find("Reaper Hub Loaded") then
        Finalize()
    end
end)

task.delay(30, function() if not isLoaded then Finalize() end end)
