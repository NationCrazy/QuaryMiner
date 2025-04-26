-- /turtles/setup.lua
local vector = require("utils/vector")
local rednetComms = require("utils/rednetComms")
local gpsUtils = require("utils/gpsUtils")

-- Save the config to a local file
local function saveConfig(config)
  local file = fs.open("config.lua", "w")
  file.write("return " .. textutils.serialize(config))
  file.close()
end

-- Set turtle's label (for easier identification)
local function nameTurtle(name)
  if os.setComputerLabel then
    os.setComputerLabel(name)
  end
end

-- Create a simple startup script for the turtle (this will run upon reboot)
local function createStartupScript(role)
  local file = fs.open("startup.lua", "w")
  if role == "miner" then
    file.write([[
      -- Miner startup
      local miner = require("quarryMiner")
      miner.start()
    ]])
  elseif role == "chunky" then
    file.write([[
      -- Chunky follower startup
      local chunky = require("chunkyFollower")
      chunky.follow()
    ]])
  end
  file.close()
end

-- Park turtle at a designated spot (after setup)
local function goToParking(homePos, offset, index)
  local target = vector.new(
    homePos.x + offset.x + index,
    homePos.y + offset.y,
    homePos.z + offset.z
  )

  print("🚙 Parking at: " .. textutils.serialize(target))

  while true do
    local x, y, z = gpsUtils.getPosition()
    if not x then
      print("❌ GPS missing...")
      sleep(1)
      goto continue
    end

    local pos = vector.new(x, y, z)
    local diff = target - pos
    if diff:length() == 0 then break end

    if diff.x ~= 0 then
      if diff.x > 0 then turtle.turnRight() else turtle.turnLeft() end
    elseif diff.z ~= 0 then
      if diff.z > 0 then turtle.turnLeft() else turtle.turnRight() end
    end

    if turtle.detect() then turtle.dig() end
    turtle.forward()

    ::continue::
  end

  print("🅿️ Parked.")
end

-- Main setup process
return function(config, name, role, homePos, offset, index)
  saveConfig(config)          -- Save the config locally to "config.lua"
  nameTurtle(name)            -- Set the turtle's label

  -- Create the startup script (this will be executed when the turtle is rebooted)
  createStartupScript(role)

  -- Move turtle to parking spot
  goToParking(homePos, offset, index)

  print("🚀 Setup complete. Turtle is ready!")
end