-- controller.lua (for Pocket Computer)
-- Handles sending commands to the mainController on the Hub.

local rednet = require("rednet")

-- Function to send a command to the Hub
local function sendCommand(command)
    rednet.send(1, {command = command}, "hub")  -- Assuming hub is listening on channel 1
    print("Command sent to Hub: " .. command)
end

-- Export function to send commands from main.lua
return {
    sendCommand = sendCommand
}