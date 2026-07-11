local HttpService = game:GetService("HttpService")
local player = game:GetService("Players").LocalPlayer
local webhookURL = "https://discord.com/api/webhooks/1372904210370265259/p-Z-klz9ywB-WpHuvrPCjPRt23me00hA_cC2Jh1XHLtNUvLHFG0c4khAbWe4jGO04s-k"
local imageUrl = "https://cdn.discordapp.com/attachments/1450978230742814841/1503442500512256201/IMG_0745.png?ex=6a035d70&is=6a020bf0&hm=06687d0b8e8c6956f5dd0af3adca4901409ca9d95ef1f8726a208acf7d2685ab&"

-- ข้อมูลเพิ่มเติมที่ควรมี
local hwid = gethwid and gethwid() or "Not Supported"
local executor = identifyexecutor and identifyexecutor() or "Unknown"
local accountAge = player.AccountAge
local jobId = game.JobId

local data = {
    ["embeds"] = {{
        ["title"] = "Reaper Hub Notification",
        ["color"] = 0xFFFFFF,
        ["thumbnail"] = { ["url"] = imageUrl },
        ["fields"] = {
            {
                ["name"] = "User Information",
                ["value"] = string.format("Username: @%s\nDisplay Name: %s\nAccount Age: %d days\nHWID: %s", 
                    player.Name, player.DisplayName, accountAge, hwid),
                ["inline"] = false
            },
            {
                ["name"] = "Game & Technical",
                ["value"] = string.format("Executor: %s\nPlace ID: %d\nJob ID: %s\nLink: [Click to Play](https://www.roblox.com/games/%d)", 
                    executor, game.PlaceId, jobId, game.PlaceId),
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

local request = syn and syn.request or http_request or request or (http and http.request)

if request then
    request({
        Url = webhookURL,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = HttpService:JSONEncode(data)
    })
else
    warn("Executor not supported")
end
