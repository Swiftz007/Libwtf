local player = game:GetService("Players").LocalPlayer
local whitelistedHWIDs = {
    ["683c6cad96983bb60cb6b29086c0381x813c443aae5ab72f3f2abd91dae18a2a"] = true, -- เปลี่ยนเป็น HWID ของคนที่อนุญาต
}

-- ดึงค่า HWID ปัจจุบัน
local currentHWID = (gethwid and gethwid() or "Not Supported")

-- ตรวจสอบว่าตรงกับในลิสต์หรือไม่
if not whitelistedHWIDs[currentHWID] then
    player:Kick("\n[ REAPER HUB ]\nFuck Hwid")
    return -- ใส่ไว้เพื่อให้สคริปต์หยุดทำงานทันทีหลังจากเตะ
end

task.wait(3)

-- ส่วนของสคริปต์หลัก (ถ้า HWID ตรงจะเริ่มทำงานที่นี่)
print("Welcome to Reaper Hub!")
