local player = game:GetService("Players").LocalPlayer
local whitelistedHWIDs = {
    ["683c6cad96983bb60cb6b29086c0381c811c443aae5ab72f3f2abd91dae18a2e"] = true, -- Admin Hwid
    ["77fdce4ece1ef4c77770464485958b9f6b44a36fb4fff3d54b12a30e59e51177"] = true, -- พวกกาก
    ["none"] = false
}


local currentHWID = (gethwid and gethwid() or "Not Supported")

-- ตรวจสอบ: ถ้า "ไม่พบ" HWID ในลิสต์
if not whitelistedHWIDs[currentHWID] then
    player:Kick("\n[ REAPER HUB ]\nUnauthorized Access")
    error("Execution Stopped: HWID Mismatch") -- หยุดเฉพาะคนที่ HWID ผิด
end
