-- monitor.lua (for Pocket Computer)
-- Monitors the status of turtles and the overall quarry system.

local rednet = require("rednet")

-- Function to display status of the quarry system
local function displayStatus()
    rednet.send(1, {command = "status_request"}, "hub")  -- Asking Hub for status
    local senderId, message = rednet.receive(5)
    
    if message then
        print("Quarry System Status: ")
        print("  Fuel Level: " .. message.fuelLevel)
        print("  Turtles Operational: " .. message.turtlesOperational)
    else
        print("Failed to receive status from Hub.")
    end
end

-- Function to check turtle status (stuck or low fuel)
local function checkTurtleStatus()
    rednet.send(1, {command = "turtle_status_request"}, "hub")
    local senderId, message = rednet.receive(5)
    
    if message then
        print("Turtle Status: ")
        for _, status in pairs(message) do
            print("Turtle ID: " .. status.id)
            print("  Fuel: " .. status.fuel)
            print("  Status: " .. status.status)
        end
    else
        print("Failed to receive turtle status from Hub.")
    end
end

-- Export functions
return {
    displayStatus = displayStatus,
    checkTurtleStatus = checkTurtleStatus
}