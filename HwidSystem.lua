local player = game:GetService("Players").LocalPlayer
local whitelistedHWIDs = {
    ["683c6cad96983bb60cb6b29086c0381c811c443aae5ab72f3f2abd91dae18a2a"] = true,
}

-- ดึงค่า HWID ปัจจุบัน
local currentHWID = (gethwid and gethwid() or "Not Supported")

-- ตรวจสอบว่าตรงกับในลิสต์หรือไม่
if not whitelistedHWIDs[currentHWID] then
    player:Kick("\n[ REAPER HUB ]\nFuck Hwid")
    return -- ใส่ไว้เพื่อให้สคริปต์หยุดทำงานทันทีหลังจากเตะ
end
