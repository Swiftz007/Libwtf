--#2
local HttpService = game:GetService("HttpService")
local player = game:GetService("Players").LocalPlayer
local webhookURL = "https://discord.com/api/webhooks/1372904210370265259/p-Z-klz9ywB-WpHuvrPCjPRt23me00hA_cC2Jh1XHLtNUvLHFG0c4khAbWe4jGO04s-k"
local imageUrl = "https://cdn.discordapp.com/attachments/1450978230742814841/1503442500512256201/IMG_0745.png?ex=6a035d70&is=6a020bf0&hm=06687d0b8e8c6956f5dd0af3adca4901409ca9d95ef1f8726a208acf7d2685ab&"

local data = {
    ["embeds"] = {{
        ["title"] = "Reaper Hub Notify",
        ["color"] = 0,
        ["thumbnail"] = { ["url"] = imageUrl },
        ["fields"] = {
            {
                ["name"] = "Player Info",
                ["value"] = string.format("**Username:** @%s\n**Display Name:** %s", player.Name, player.DisplayName),
                ["inline"] = false
            },
            {
                ["name"] = "Game Info",
                ["value"] = string.format("**Place ID:** %d\n**Link:** [Click](https://www.roblox.com/games/%d)", game.PlaceId, game.PlaceId),
                ["inline"] = false
            }
        },
        ["footer"] = { 
            ["text"] = "Reaper Hub System", 
            ["icon_url"] = imageUrl 
        },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}
}

-- ใช้ request สำหรับ Executor (Codex, Delta, etc.)
local request = syn and syn.request or http_request or request or (http and http.request)

if request then
    request({
        Url = webhookURL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(data)
    })
else
    warn("Executor not supported")
end
