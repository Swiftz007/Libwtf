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

    local function CreateNotify(message, duration, delayTime)
        task.delay(delayTime or 0, function()
            if not notifyGui or not notifyGui.Parent then
                return
            end

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0, 0, 0, 60)
            frame.Position = UDim2.new(0.5, 0, 0, 20)
            frame.AnchorPoint = Vector2.new(0.5, 0)
            frame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
            frame.BackgroundTransparency = 0.15
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
            stroke.Transparency = 0.1
            stroke.Parent = frame

            -- Reaper icon background
            local iconGlow = Instance.new("Frame")
            iconGlow.Size = UDim2.fromOffset(42, 42)
            iconGlow.Position = UDim2.new(0, 8, 0.5, 0)
            iconGlow.AnchorPoint = Vector2.new(0, 0.5)
            iconGlow.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
            iconGlow.BackgroundTransparency = 0.88
            iconGlow.BorderSizePixel = 0
            iconGlow.ZIndex = 1001
            iconGlow.Parent = frame

            local glowCorner = Instance.new("UICorner")
            glowCorner.CornerRadius = UDim.new(1, 0)
            glowCorner.Parent = iconGlow

            -- Reaper icon
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

            -- Open animation
            TweenService:Create(
                frame,
                TweenInfo.new(
                    0.4,
                    Enum.EasingStyle.Back,
                    Enum.EasingDirection.Out
                ),
                {
                    Size = UDim2.new(0, 340, 0, 60)
                }
            ):Play()

            -- Close animation
            task.delay(duration, function()
                if not frame or not frame.Parent then
                    return
                end

                local closeTween = TweenService:Create(
                    frame,
                    TweenInfo.new(
                        0.35,
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

                task.wait(0.4)

                if frame and frame.Parent then
                    frame:Destroy()
                end
            end)
        end)
    end

    -- Notification 1
    CreateNotify(
        "Please wait for the script to load.",
        5,
        0
    )

    -- Notification 2
    CreateNotify(
        "มึงก็รอสิไม่สัส กำลังโหลด",
        6,
        0.8
    )

    -- Cleanup
    task.delay(7.5, function()
        if notifyGui and notifyGui.Parent then
            notifyGui:Destroy()
        end
    end)
end
