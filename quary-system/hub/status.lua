-- status.lua
-- Monitors turtle system, checks fuel levels, sends alerts for stuck turtles.

local rednet = require("rednet")
local config = require("config")
local gps = require("gps")

-- Function to check the fuel levels of all turtles
local function checkFuelLevels()
    print("Checking fuel levels for all turtles...")

    rednet.broadcast({command = "check_fuel"}, "turtleSystem")
end

-- Function to check if any turtle is stuck
local function checkForStuckTurtles()
    print("Checking for stuck turtles...")

    -- Example logic: Ask all turtles if they're stuck and listen for responses
    rednet.broadcast({command = "check_stuck"}, "turtleSystem")
end

-- Function to handle stuck turtle alerts
local function handleStuckTurtle(turtleId)
    print("Turtle " .. turtleId .. " is stuck. Sending rescue command...")

    rednet.send(turtleId, {command = "rescue"}, "turtleSystem")
end

-- Function to handle low fuel alerts
local function handleLowFuel(turtleId)
    print("Turtle " .. turtleId .. " is low on fuel. Sending refuel command...")

    rednet.send(turtleId, {command = "refuel"}, "turtleSystem")
end

-- Function to handle incoming status messages
local function listenForStatusMessages()
    while true do
        local senderId, message = rednet.receive(5)  -- Listen for messages (5-second timeout)
        if message then
            if message.command == "fuel_low" then
                handleLowFuel(senderId)
            elseif message.command == "stuck" then
                handleStuckTurtle(senderId)
            end
        else
            print("No status messages received.")
        end
    end
end

-- Start the status monitoring
listenForStatusMessages()