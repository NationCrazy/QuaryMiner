-- main.lua (for Pocket Computer)
-- Main interface to control and monitor the quarry system.

local rednet = require("rednet")
local controller = require("controller")
local monitor = require("monitor")

-- Menu options for controlling the quarry system
local function displayMenu()
    print("Quarry System Control")
    print("1. Start Quarry")
    print("2. Stop Quarry")
    print("3. Monitor Quarry Status")
    print("4. Check Turtle Status")
    print("5. Exit")
end

local function handleUserInput()
    while true do
        displayMenu()
        local choice = tonumber(read())
        
        if choice == 1 then
            controller.sendCommand("start_quarry")
        elseif choice == 2 then
            controller.sendCommand("stop_quarry")
        elseif choice == 3 then
            monitor.displayStatus()
        elseif choice == 4 then
            monitor.checkTurtleStatus()
        elseif choice == 5 then
            print("Exiting program...")
            break
        else
            print("Invalid option, try again.")
        end
    end
end

-- Start the program
handleUserInput()