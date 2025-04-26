-- config.lua
-- This file stores the configuration for the quarry system such as GPS coordinates,
-- parking area, quarry size, etc.

local config = {}

-- Default GPS coordinates (you can override these manually if needed)
config.gpsCoordinates = {
    x = 0,   -- Replace with your actual hub's GPS x-coordinate
    y = 0,   -- Replace with your actual hub's GPS y-coordinate (y will typically be 0)
    z = 0    -- Replace with your actual hub's GPS z-coordinate
}

-- Default parking area location (relative to the Hub)
config.parkingArea = {
    x = config.gpsCoordinates.x + 8,  -- 8 blocks north of the hub (adjust this as needed)
    y = config.gpsCoordinates.y,      -- Same height as the hub
    z = config.gpsCoordinates.z       -- Same z-coordinate as the hub
}

-- Default quarry size (width, length, depth)
config.quarrySize = {
    width = 100,   -- The width of the quarry (adjustable)
    length = 100,  -- The length of the quarry (adjustable)
    depth = 10     -- The depth of the quarry (adjustable)
}

-- Fuel thresholds (if fuel drops below this percentage, an alert will be sent)
config.fuelThreshold = 20  -- Alert when fuel drops below 20%

-- Chunky turtle settings (used for chunk removal during mining)
config.chunkySettings = {
    distance = 10,  -- How many blocks away the chunky turtles should work
    speed = 1       -- Speed at which the chunky turtles operate (1 = slow, 10 = fast)
}

-- Turtle IDs (used for tracking which turtle is which)
config.turtleIds = {
    miner = "turtle_miner_1",  -- Replace with actual turtle IDs for miners
    chunky = "turtle_chunky_1" -- Replace with actual turtle IDs for chunkies
}

-- Default system settings (e.g., automatic start/stop, emergency response)
config.autoStart = true       -- Whether to automatically start quarry mining when the system is initiated
config.autoStop = false      -- Whether to automatically stop quarry mining when it reaches a certain depth or condition

return config