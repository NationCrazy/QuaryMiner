-- /turtles/chunkyFollower.lua
local gpsUtils = require("utils/gpsUtils")
local rednetComms = require("utils/rednetComms")

local function followMiner()
  local minerPos = gpsUtils.getPosition()
  print("Following miner at position: " .. textutils.serialize(minerPos))

  -- Wait for miner to finish a layer
  while true do
    -- Check if miner has finished layer
    local x, y, z = gpsUtils.getPosition()
    if x == minerPos.x and z == minerPos.z then
      turtle.turnRight() -- Just for simplicity in the example
      turtle.forward()
      break
    end
  end
end

return {
  follow = function()
    followMiner()
  end
}