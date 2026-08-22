--4
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
        UDim2.new(0.5, 0, 0, 100)

    local SECOND_POSITION =
        UDim2.new(0.5, 0, 0, 100)

    local FIRST_MOVED_POSITION =
        UDim2.new(0.5, 0, 0, 32)

    --// Notifications
    local firstNotification = nil
    local secondNotification = nil

    local function CreateNotify(message, duration, delayTime, notifyType)

        task.delay(delayTime or 0, function()

            if not notifyGui or not notifyGui.Parent then
                return
            end

            --------------------------------------------------
            -- Frame
            --------------------------------------------------

            local frame = Instance.new("Frame")

            frame.Name = "Notification"
            frame.Size = UDim2.new(0, 340, 0, 60)

            frame.Position = UDim2.new(
                0.5,
                0,
                0,
                155
            )

            frame.AnchorPoint = Vector2.new(0.5, 0)

            frame.BackgroundColor3 =
                Color3.fromRGB(10, 10, 12)

            -- เห็นเกมด้านหลังได้ แต่ไม่ใสจนเกินไป
            frame.BackgroundTransparency = 0.28

            frame.BorderSizePixel = 0
            frame.ClipsDescendants = true
            frame.ZIndex = 1000
            frame.Parent = notifyGui

            --------------------------------------------------
            -- Corner
            --------------------------------------------------

            local corner = Instance.new("UICorner")

            corner.CornerRadius =
                UDim.new(0, 14)

            corner.Parent = frame

            --------------------------------------------------
            -- Border
            --------------------------------------------------

            local stroke = Instance.new("UIStroke")

            stroke.Color =
                Color3.fromRGB(239, 68, 68)

            stroke.Thickness = 1
            stroke.Transparency = 0.2
            stroke.Parent = frame

            --------------------------------------------------
            -- Icon Glow
            --------------------------------------------------

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

            glowCorner.CornerRadius =
                UDim.new(1, 0)

            glowCorner.Parent = iconGlow

            --------------------------------------------------
            -- Reaper Icon
            --------------------------------------------------

            local icon = Instance.new("ImageLabel")

            icon.Size =
                UDim2.fromOffset(36, 36)

            icon.Position =
                UDim2.new(0, 11, 0.5, 0)

            icon.AnchorPoint =
                Vector2.new(0, 0.5)

            icon.BackgroundTransparency = 1

            icon.Image = ReaperIcon

            icon.ScaleType =
                Enum.ScaleType.Fit

            icon.ZIndex = 1002
            icon.Parent = frame

            --------------------------------------------------
            -- Text
            --------------------------------------------------

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

            text.Font =
                Enum.Font.GothamMedium

            text.TextXAlignment =
                Enum.TextXAlignment.Left

            text.TextYAlignment =
                Enum.TextYAlignment.Center

            text.TextWrapped = true

            text.ZIndex = 1002
            text.Parent = frame

            --------------------------------------------------
            -- Register notification
            --------------------------------------------------

            if notifyType == 1 then

                firstNotification = frame

            elseif notifyType == 2 then

                secondNotification = frame

            end

            --------------------------------------------------
            -- Opening animation
            --------------------------------------------------

            frame.Size =
                UDim2.new(0, 300, 0, 56)

            TweenService:Create(

                frame,

                TweenInfo.new(
                    0.55,
                    Enum.EasingStyle.Quint,
                    Enum.EasingDirection.Out
                ),

                {
                    Size =
                        UDim2.new(0, 340, 0, 60)
                }

            ):Play()

            --------------------------------------------------
            -- Second notification
            --------------------------------------------------

            if notifyType == 2 then

                -- ดันอันแรกขึ้น
                if firstNotification
                    and firstNotification.Parent then

                    TweenService:Create(

                        firstNotification,

                        TweenInfo.new(
                            0.65,
                            Enum.EasingStyle.Quint,
                            Enum.EasingDirection.Out
                        ),

                        {
                            Position =
                                FIRST_MOVED_POSITION
                        }

                    ):Play()

                end

                -- อันสองเริ่มจากด้านล่าง
                frame.Position =
                    UDim2.new(
                        0.5,
                        0,
                        0,
                        165
                    )

                -- แล้วเลื่อนขึ้นมาตำแหน่งเดิม
                TweenService:Create(

                    frame,

                    TweenInfo.new(
                        0.7,
                        Enum.EasingStyle.Quint,
                        Enum.EasingDirection.Out
                    ),

                    {
                        Position =
                            SECOND_POSITION
                    }

                ):Play()

            end

            --------------------------------------------------
            -- Remove notification
            --------------------------------------------------

            task.delay(duration, function()

                if not frame
                    or not frame.Parent then

                    return

                end

                --------------------------------------------------
                -- Closing animation
                --------------------------------------------------

                local closeTween =
                    TweenService:Create(

                        frame,

                        TweenInfo.new(
                            0.5,
                            Enum.EasingStyle.Quint,
                            Enum.EasingDirection.In
                        ),

                        {
                            Position =
                                UDim2.new(
                                    0.5,
                                    0,
                                    0,
                                    -20
                                ),

                            BackgroundTransparency = 1
                        }

                    )

                closeTween:Play()

                --------------------------------------------------
                -- Fade text
                --------------------------------------------------

                TweenService:Create(

                    text,

                    TweenInfo.new(0.4),

                    {
                        TextTransparency = 1
                    }

                ):Play()

                --------------------------------------------------
                -- Fade icon
                --------------------------------------------------

                TweenService:Create(

                    icon,

                    TweenInfo.new(0.4),

                    {
                        ImageTransparency = 1
                    }

                ):Play()

                --------------------------------------------------
                -- Fade glow
                --------------------------------------------------

                TweenService:Create(

                    iconGlow,

                    TweenInfo.new(0.4),

                    {
                        BackgroundTransparency = 1
                    }

                ):Play()

                --------------------------------------------------
                -- Fade border
                --------------------------------------------------

                TweenService:Create(

                    stroke,

                    TweenInfo.new(0.4),

                    {
                        Transparency = 1
                    }

                ):Play()

                task.wait(0.55)

                if frame and frame.Parent then
                    frame:Destroy()
                end

                --------------------------------------------------
                -- First notification disappeared
                --------------------------------------------------

                if notifyType == 1 then

                    firstNotification = nil

                    -- ให้อันสองเลื่อนขึ้นมาแทน
                    if secondNotification
                        and secondNotification.Parent then

                        TweenService:Create(

                            secondNotification,

                            TweenInfo.new(
                                0.7,
                                Enum.EasingStyle.Quint,
                                Enum.EasingDirection.Out
                            ),

                            {
                                Position =
                                    FIRST_MOVED_POSITION
                            }

                        ):Play()

                    end

                elseif notifyType == 2 then

                    secondNotification = nil

                end

            end)

        end)

    end

    ----------------------------------------------------------
    -- Notification 1
    ----------------------------------------------------------

    CreateNotify(
        "Please wait for the script to load.",
        5,
        0,
        1
    )

    ----------------------------------------------------------
    -- Notification 2
    ----------------------------------------------------------

    CreateNotify(
        "มึงก็รอสิไม่สัส กำลังโหลด",
        6,
        0.8,
        2
    )

    ----------------------------------------------------------
    -- Cleanup
    ----------------------------------------------------------

    task.delay(7.8, function()

        if notifyGui
            and notifyGui.Parent then

            notifyGui:Destroy()

        end

    end)

end
