-- turtle.lua (installer)
local peripheral = require("peripheral")
local http = require("http")
local fs = require("fs")

-- Settings
local HUB_PROTOCOL = "quarry_hub"
local TIMEOUT = 5
local REPO_BASE = nil -- Set via hub response
local role, name, config = nil, nil, {}

-- UTILS
local function waitForGPS()
  print("📡 Locating position via GPS...")
  local x, y, z = gps.locate(5)
  if not x then error("❌ GPS not found!") end
  return vector.new(x, y, z)
end

local function getModem()
  for _, side in ipairs({"left","right","top","bottom","front","back"}) do
    if peripheral.getType(side) == "modem" then
      rednet.open(side)
      return true
    end
  end
  error("❌ No wireless modem found.")
end

local function download(path, to)
  local url = REPO_BASE .. path
  print("⬇ Downloading " .. path)
  shell.run("wget", "-f", url, to)
end

-- MAIN START
local pos = waitForGPS()
getModem()

-- Send registration request
local myID = os.getComputerID()
print("🔗 Connecting to hub...")
rednet.broadcast({
  type = "register",
  id = myID,
  pos = {x=pos.x, y=pos.y, z=pos.z},
}, HUB_PROTOCOL)

local hubID, msg = rednet.receive(HUB_PROTOCOL, TIMEOUT)
if not msg or not msg.repo then
  error("❌ No hub response. Is it running?")
end

name = msg.name
role = msg.role
config = msg.config
REPO_BASE = msg.repo:match("/$") and msg.repo or (msg.repo .. "/")

print("✅ Registered as " .. name .. " (" .. role .. ")")

-- Download shared utils
download("utils/vector.lua", "utils/vector.lua")
download("utils/gpsUtils.lua", "utils/gpsUtils.lua")
download("utils/rednetComms.lua", "utils/rednetComms.lua")
download("turtles/setup.lua", "setup.lua")

-- Role-specific files
if role == "miner" then
  download("turtles/quarryMiner.lua", "quarryMiner.lua")
  download("startup_templates/miner_startup.lua", "startup.lua")
elseif role == "chunky" then
  download("turtles/chunkyFollower.lua", "chunkyFollower.lua")
  download("startup_templates/chunky_startup.lua", "startup.lua")
else
  error("❌ Unknown role: " .. tostring(role))
end

print("🚀 Setup complete. Rebooting...")
sleep(1)
os.reboot()