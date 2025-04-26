-- setup.lua (for Pocket Computer)
-- Initial setup for the pocket computer. Connect to the hub and set up communication.

local rednet = require("rednet")

-- Function to register the pocket computer with the Hub
local function registerWithHub()
    -- Sending a registration message to the Hub with the pocket computer's ID
    rednet.broadcast({command = "register_pocket", pocket_id = os.getComputerID()}, "hub")
    print("Pocket Computer registered with the Hub.")
end

-- Initialize the pocket computer
registerWithHub()