--2
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

--// Reaper Early Loading Notify Test
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

    local FIRST_POSITION = UDim2.new(0.5, 0, 0, 38)
    local SECOND_POSITION = UDim2.new(0.5, 0, 0, 18)
    local FIRST_MOVED_POSITION = UDim2.new(0.5, 0, 0, -28)

    local activeNotifications = {}

    local function CreateNotify(message, duration, delayTime, notifyType)
        task.delay(delayTime or 0, function()
            if not notifyGui or not notifyGui.Parent then
                return
            end

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0, 340, 0, 60)
            frame.Position = FIRST_POSITION
            frame.AnchorPoint = Vector2.new(0.5, 0)
            frame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)

            -- เห็นเกมด้านหลังได้ แต่ไม่ใสจนเกินไป
            frame.BackgroundTransparency = 0.28

            frame.BorderSizePixel = 0
            frame.ClipsDescendants = true
            frame.ZIndex = 1000
            frame.Parent = notifyGui

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 14)
            corner.Parent = frame

            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.fromRGB(239, 68, 68)
            stroke.Thickness = 1
            stroke.Transparency = 0.2
            stroke.Parent = frame

            -- Icon glow
            local iconGlow = Instance.new("Frame")
            iconGlow.Size = UDim2.fromOffset(42, 42)
            iconGlow.Position = UDim2.new(0, 8, 0.5, 0)
            iconGlow.AnchorPoint = Vector2.new(0, 0.5)
            iconGlow.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
            iconGlow.BackgroundTransparency = 0.84
            iconGlow.BorderSizePixel = 0
            iconGlow.ZIndex = 1001
            iconGlow.Parent = frame

            local glowCorner = Instance.new("UICorner")
            glowCorner.CornerRadius = UDim.new(1, 0)
            glowCorner.Parent = iconGlow

            -- Reaper Icon
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.fromOffset(36, 36)
            icon.Position = UDim2.new(0, 11, 0.5, 0)
            icon.AnchorPoint = Vector2.new(0, 0.5)
            icon.BackgroundTransparency = 1
            icon.Image = ReaperIcon
            icon.ScaleType = Enum.ScaleType.Fit
            icon.ZIndex = 1002
            icon.Parent = frame

            -- Text
            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1, -64, 1, 0)
            text.Position = UDim2.new(0, 60, 0, 0)
            text.BackgroundTransparency = 1
            text.Text = message
            text.TextColor3 = Color3.fromRGB(255, 255, 255)
            text.TextSize = 13
            text.Font = Enum.Font.GothamMedium
            text.TextXAlignment = Enum.TextXAlignment.Left
            text.TextYAlignment = Enum.TextYAlignment.Center
            text.TextWrapped = true
            text.ZIndex = 1002
            text.Parent = frame

            table.insert(activeNotifications, frame)

            -- เปิดเข้ามา
            frame.Size = UDim2.new(0, 300, 0, 56)

            TweenService:Create(
                frame,
                TweenInfo.new(
                    0.35,
                    Enum.EasingStyle.Quint,
                    Enum.EasingDirection.Out
                ),
                {
                    Size = UDim2.new(0, 340, 0, 60)
                }
            ):Play()

            -- ถ้าเป็นแจ้งเตือนที่สอง
            if notifyType == 2 then

                local first = activeNotifications[1]

                if first and first.Parent then
                    -- ดันอันแรกขึ้น
                    TweenService:Create(
                        first,
                        TweenInfo.new(
                            0.45,
                            Enum.EasingStyle.Quint,
                            Enum.EasingDirection.Out
                        ),
                        {
                            Position = FIRST_MOVED_POSITION
                        }
                    ):Play()
                end

                -- อันสองมาแทนตำแหน่งเดิม
                frame.Position = UDim2.new(
                    0.5,
                    0,
                    0,
                    55
                )

                TweenService:Create(
                    frame,
                    TweenInfo.new(
                        0.45,
                        Enum.EasingStyle.Quint,
                        Enum.EasingDirection.Out
                    ),
                    {
                        Position = SECOND_POSITION
                    }
                ):Play()
            end

            -- เวลาหาย
            task.delay(duration, function()
                if not frame or not frame.Parent then
                    return
                end

                local closeTween = TweenService:Create(
                    frame,
                    TweenInfo.new(
                        0.4,
                        Enum.EasingStyle.Quint,
                        Enum.EasingDirection.In
                    ),
                    {
                        Position = UDim2.new(0.5, 0, 0, -90),
                        BackgroundTransparency = 1
                    }
                )

                closeTween:Play()

                TweenService:Create(
                    text,
                    TweenInfo.new(0.3),
                    {
                        TextTransparency = 1
                    }
                ):Play()

                TweenService:Create(
                    icon,
                    TweenInfo.new(0.3),
                    {
                        ImageTransparency = 1
                    }
                ):Play()

                TweenService:Create(
                    iconGlow,
                    TweenInfo.new(0.3),
                    {
                        BackgroundTransparency = 1
                    }
                ):Play()

                TweenService:Create(
                    stroke,
                    TweenInfo.new(0.3),
                    {
                        Transparency = 1
                    }
                ):Play()

                task.wait(0.45)

                if frame and frame.Parent then
                    frame:Destroy()
                end
            end)
        end)
    end

    -- แจ้งเตือนแรก
    CreateNotify(
        "Please wait for the script to load.",
        5,
        0,
        1
    )

    -- แจ้งเตือนสอง
    task.delay(0.8, function()
        CreateNotify(
            "มึงก็รอสิไม่สัส กำลังโหลด",
            6,
            0,
            2
        )
    end)

    -- Cleanup
    task.delay(7.5, function()
        if notifyGui and notifyGui.Parent then
            notifyGui:Destroy()
        end
    end)
end
