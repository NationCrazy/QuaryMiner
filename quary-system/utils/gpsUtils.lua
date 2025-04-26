-- /utils/gpsUtils.lua

-- Get current position from GPS
function gps.getPosition()
    local x, y, z = gps.locate(5)  -- 5-second timeout
    if not x then
      error("❌ GPS signal not found.")
    end
    return vector.new(x, y, z)
  end
  
  -- Set position (for checking purposes or when you want to park the turtle)
  function gps.setPosition(x, y, z)
    -- Simple method to "simulate" setting GPS. Turtle moves there manually.
    print("Setting position to: (" .. x .. ", " .. y .. ", " .. z .. ")")
  end
  
  return gps  