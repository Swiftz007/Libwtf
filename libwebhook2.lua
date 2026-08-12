local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local player = game:GetService("Players").LocalPlayer

local webhookURL = "https://discord.com/api/webhooks/1372904210370265259/p-Z-klz9ywB-WpHuvrPCjPRt23me00hA_cC2Jh1XHLtNUvLHFG0c4khAbWe4jGO04s-k"
local imageUrl = "https://cdn.discordapp.com/attachments/1450978230742814841/1503442500512256201/IMG_0745.png"

-- ข้อมูลทางเทคนิค
local hwid = gethwid and gethwid() or "Not Supported"
local jobId = game.JobId
local executor = identifyexecutor and identifyexecutor() or "Unknown"

-- ตรวจสอบภาษา
local language = (_G.Script_Language == "Thai") and "Thai" or "Eng"

-- ดึงชื่อเกม
local gameName = "Unknown"

pcall(function()
    local info = MarketplaceService:GetProductInfo(game.PlaceId)
    gameName = info.Name or "Unknown"
end)

local data = {
    ["embeds"] = {{
        ["title"] = "Reaper Hub Notify",
        ["color"] = 0xFFFFFF,

        ["thumbnail"] = {
            ["url"] = imageUrl
        },

        ["fields"] = {
            {
                ["name"] = "User Information",
                ["value"] = string.format(
                    "**Username:** @%s\n**Display Name:** %s\n**HWID:**\n`%s`\n**Language:** %s",
                    player.Name,
                    player.DisplayName,
                    hwid,
                    language
                ),
                ["inline"] = false
            },

            {
                ["name"] = "Game Details",
                ["value"] = string.format(
                    "**Game Name:**\n`%s`\n**Place ID:**\n`%d`\n**Job ID:**\n`%s`\n**Executor:**\n`%s`",
                    gameName,
                    game.PlaceId,
                    jobId,
                    executor
                ),
                ["inline"] = false
            },

            {
                ["name"] = "Direct Link",
                ["value"] = string.format(
                    "[Click to Join](https://www.roblox.com/games/%d)",
                    game.PlaceId
                ),
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
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(data)
    })
else
    warn("Executor not supported")
end
