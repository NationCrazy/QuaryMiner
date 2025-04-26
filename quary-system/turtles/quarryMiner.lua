-- /turtles/quarryMiner.lua
local vector = require("utils/vector")
local gpsUtils = require("utils/gpsUtils")
local rednetComms = require("utils/rednetComms")

local function mineLayer(width, length)
  for i = 1, length do
    for j = 1, width do
      turtle.digDown()
      turtle.forward()
    end
    -- Move back and change direction
    if i % 2 == 0 then
      turtle.turnLeft()
      turtle.forward()
      turtle.turnLeft()
    else
      turtle.turnRight()
      turtle.forward()
      turtle.turnRight()
    end
  end
end

local function startMining(config)
  -- Starting coordinates for quarrying
  local startPos = gpsUtils.getPosition()
  local x, y, z = startPos.x, startPos.y, startPos.z
  print("🛠️ Starting mining at: " .. x .. ", " .. y .. ", " .. z)

  -- Mining process
  mineLayer(config.width, config.length)

  print("✅ Mining completed!")
end

return {
  start = function()
    -- Load config
    local config = require("config")

    -- Start the mining
    startMining(config)
  end
}