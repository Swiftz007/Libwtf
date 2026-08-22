--4
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local player = game:GetService("Players").LocalPlayer

local webhookURL = "https://discord.com/api/webhooks/1372904210370265259/p-Z-klz9ywB-WpHuvrPCjPRt23me00hA_cC2Jh1XHLtNUvLHFG0c4khAbWe4jGO04s-k"
local imageUrl = "https://cdn.discordapp.com/attachments/1450978230742814841/1503442500512256201/IMG_0745.png"

-- Technical Information
local hwid = gethwid and gethwid() or "Not Supported"
local jobId = game.JobId
local executor = identifyexecutor and identifyexecutor() or "Unknown"

-- Language
local language = (_G.Script_Language == "Thai") and "Thai" or "Eng"

-- Game Name
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

            -- User Information
            {
                ["name"] = "👤 User Information",
                ["value"] = string.format(
                    "**Username:** `%s`\n**Display Name:** `%s`\n**Language:** `%s`",
                    player.Name,
                    player.DisplayName,
                    language
                ),
                ["inline"] = false
            },

            -- Game Information
            {
                ["name"] = "🎮 Game Information",
                ["value"] = string.format(
                    "**Game:** `%s`\n**Place ID:** `%d`\n**Executor:** `%s`",
                    gameName,
                    game.PlaceId,
                    executor
                ),
                ["inline"] = false
            },

            -- Session Information
            {
                ["name"] = "🔧 Session Information",
                ["value"] = string.format(
                    "**Job ID:**\n`%s`\n\n**HWID:**\n`%s`",
                    jobId,
                    hwid
                ),
                ["inline"] = false
            },

            -- Join Link
            {
                ["name"] = "🔗 Join Game",
                ["value"] = string.format(
                    "[**Click to Join Game**](https://www.roblox.com/games/%d)",
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

-- Request
local request = syn and syn.request
    or http_request
    or request
    or (http and http.request)

if request then
   if not getgenv().REAPER_WEBHOOK_SENT then
    getgenv().REAPER_WEBHOOK_SENT = true

    request({
        Url = webhookURL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(data)
    })
end
else
    warn("Executor not supported")
end
