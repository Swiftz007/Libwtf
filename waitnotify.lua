--5
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

--// Reaper Early Loading Notify
do
    local oldNotify = CoreGui:FindFirstChild("ReaperEarlyLoadingNotify")
    if oldNotify then
        oldNotify:Destroy()
    end

    local notifyGui = Instance.new("ScreenGui")
    notifyGui.Name = "ReaperEarlyLoadingNotify"
    notifyGui.ResetOnSpawn = false
    notifyGui.IgnoreGuiInset = true
    notifyGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    notifyGui.Parent = CoreGui

    local ReaperIcon = "rbxassetid://131279093559313"

    --// Positions
    local FIRST_POSITION =
        UDim2.new(0.5, 0, 0, 32)

    local SECOND_POSITION =
        UDim2.new(0.5, 0, 0, 100)

    --==================================================
    -- Create Notification
    --==================================================

    local function CreateNotify(message)

        local frame = Instance.new("Frame")

        frame.Name = "Notification"
        frame.Size = UDim2.new(0, 340, 0, 60)

        frame.AnchorPoint =
            Vector2.new(0.5, 0)

        frame.BackgroundColor3 =
            Color3.fromRGB(10, 10, 12)

        frame.BackgroundTransparency = 0.28

        frame.BorderSizePixel = 0
        frame.ClipsDescendants = true
        frame.ZIndex = 1000
        frame.Parent = notifyGui

        -- Corner
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 14)
        corner.Parent = frame

        -- Border
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(239, 68, 68)
        stroke.Thickness = 1
        stroke.Transparency = 0.2
        stroke.Parent = frame

        -- Icon glow
        local iconGlow = Instance.new("Frame")

        iconGlow.Size =
            UDim2.fromOffset(42, 42)

        iconGlow.Position =
            UDim2.new(0, 8, 0.5, 0)

        iconGlow.AnchorPoint =
            Vector2.new(0, 0.5)

        iconGlow.BackgroundColor3 =
            Color3.fromRGB(239, 68, 68)

        iconGlow.BackgroundTransparency = 0.84

        iconGlow.BorderSizePixel = 0
        iconGlow.ZIndex = 1001
        iconGlow.Parent = frame

        local glowCorner = Instance.new("UICorner")
        glowCorner.CornerRadius = UDim.new(1, 0)
        glowCorner.Parent = iconGlow

        -- Reaper Icon
        local icon = Instance.new("ImageLabel")

        icon.Size =
            UDim2.fromOffset(36, 36)

        icon.Position =
            UDim2.new(0, 11, 0.5, 0)

        icon.AnchorPoint =
            Vector2.new(0, 0.5)

        icon.BackgroundTransparency = 1
        icon.Image = ReaperIcon
        icon.ScaleType = Enum.ScaleType.Fit
        icon.ZIndex = 1002
        icon.Parent = frame

        -- Text
        local text = Instance.new("TextLabel")

        text.Size =
            UDim2.new(1, -64, 1, 0)

        text.Position =
            UDim2.new(0, 60, 0, 0)

        text.BackgroundTransparency = 1
        text.Text = message

        text.TextColor3 =
            Color3.fromRGB(255, 255, 255)

        text.TextSize = 13
        text.Font = Enum.Font.GothamMedium

        text.TextXAlignment =
            Enum.TextXAlignment.Left

        text.TextYAlignment =
            Enum.TextYAlignment.Center

        text.TextWrapped = true
        text.ZIndex = 1002
        text.Parent = frame

        return frame, text, icon, iconGlow, stroke
    end

    --==================================================
    -- Fade Out
    --==================================================

    local function RemoveNotify(frame, text, icon, iconGlow, stroke)

        if not frame or not frame.Parent then
            return
        end

        TweenService:Create(
            frame,
            TweenInfo.new(
                0.45,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.In
            ),
            {
                Position =
                    UDim2.new(0.5, 0, 0, -40),

                BackgroundTransparency = 1
            }
        ):Play()

        TweenService:Create(
            text,
            TweenInfo.new(0.35),
            {
                TextTransparency = 1
            }
        ):Play()

        TweenService:Create(
            icon,
            TweenInfo.new(0.35),
            {
                ImageTransparency = 1
            }
        ):Play()

        TweenService:Create(
            iconGlow,
            TweenInfo.new(0.35),
            {
                BackgroundTransparency = 1
            }
        ):Play()

        TweenService:Create(
            stroke,
            TweenInfo.new(0.35),
            {
                Transparency = 1
            }
        ):Play()

        task.wait(0.5)

        if frame and frame.Parent then
            frame:Destroy()
        end
    end

    --==================================================
    -- NOTIFICATION 1
    --==================================================

    local notify1, text1, icon1, glow1, stroke1 =
        CreateNotify(
            "Please wait for the script to load."
        )

    -- เริ่มที่ตำแหน่งของอันที่ 2
    notify1.Position =
        UDim2.new(0.5, 0, 0, 100)

    -- ขยับขึ้นมาตำแหน่งของตัวเอง
    TweenService:Create(
        notify1,
        TweenInfo.new(
            0.65,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        {
            Position = FIRST_POSITION
        }
    ):Play()

    --==================================================
    -- รอ 1 วินาที
    --==================================================

    task.wait(1)

    --==================================================
    -- NOTIFICATION 2
    --==================================================

    local notify2, text2, icon2, glow2, stroke2 =
        CreateNotify(
            "มึงก็รอสิไอสัส กำลังโหลด"
        )

    -- อันสองสร้างตรงตำแหน่งของมัน
    notify2.Position = SECOND_POSITION

    --==================================================
    -- รอให้อันแรกหมดเวลา
    --==================================================

    task.wait(4)

    -- อันแรกหายก่อน
    RemoveNotify(
        notify1,
        text1,
        icon1,
        glow1,
        stroke1
    )

    --==================================================
    -- รออีก 1 วินาที
    --==================================================

    task.wait(1)

    -- อันสองค่อยหาย
    RemoveNotify(
        notify2,
        text2,
        icon2,
        glow2,
        stroke2
    )

    --==================================================
    -- Cleanup
    --==================================================

    task.wait(0.2)

    if notifyGui and notifyGui.Parent then
        notifyGui:Destroy()
    end
end
