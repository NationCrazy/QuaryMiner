-- /utils/vector.lua
local vector = {}

-- Vector constructor
function vector.new(x, y, z)
  return {x = x, y = y, z = z}
end

-- Subtraction (vector difference)
function vector.sub(v1, v2)
  return vector.new(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)
end

-- Addition (vector sum)
function vector.add(v1, v2)
  return vector.new(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)
end

-- Length (distance between two vectors)
function vector.length(v)
  return math.sqrt(v.x^2 + v.y^2 + v.z^2)
end

-- Serialization for easy saving
function vector.serialize(v)
  return "vector.new(" .. v.x .. ", " .. v.y .. ", " .. v.z .. ")"
end

return vector