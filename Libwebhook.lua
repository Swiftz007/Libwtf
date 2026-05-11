local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local webhookURL = "https://discord.com/api/webhooks/1372904210370265259/p-Z-klz9ywB-WpHuvrPCjPRt23me00hA_cC2Jh1XHLtNUvLHFG0c4khAbWe4jGO04s-k"
local player = Players.LocalPlayer
local imageUrl = "https://cdn.discordapp.com/attachments/1450978230742814841/1503442500512256201/IMG_0745.png?ex=6a035d70&is=6a020bf0&hm=06687d0b8e8c6956f5dd0af3adca4901409ca9d95ef1f8726a208acf7d2685ab&"

local data = {
    ["embeds"] = {{
        ["title"] = "Reaper Hub Notify",
        ["description"] = "มีการรันสคริปต์ใหม่เกิดขึ้นในระบบ",
        ["color"] = 0, -- สีดำ (เปลี่ยนเลขรหัสสีได้)
        ["thumbnail"] = {
            ["url"] = imageUrl
        },
        ["fields"] = {
            {
                ["name"] = "Player",
                ["value"] = string.format("**Username:** @%s\n**Display Name:** %s\n**User ID:** %d", player.Name, player.DisplayName, player.UserId),
                ["inline"] = false
            },
            {
                ["name"] = "Place ID",
                ["value"] = string.format("**Place ID:** %d\n**Link:** [คลิกเพื่อเข้าเกม](https://www.roblox.com/games/%d)", game.PlaceId, game.PlaceId),
                ["inline"] = false
            },
            {
                ["name"] = "Time",
                ["value"] = os.date("%Y-%m-%d %H:%M:%S"),
                ["inline"] = false
            }
        },
        ["footer"] = {
            ["text"] = "Reaper Hub Logging System",
            ["icon_url"] = imageUrl
        }
    }}
}

local success, err = pcall(function()
    local payload = HttpService:JSONEncode(data)
    HttpService:PostAsync(webhookURL, payload)
end)

if not success then
    warn("Webhook Error: " .. err)
end
