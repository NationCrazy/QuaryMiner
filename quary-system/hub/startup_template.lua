-- hub/startup_templates.lua
-- Automatically runs when the Hub computer starts up.

-- Start the main controller script to handle commands and monitor the quarry system
if not fs.exists("mainController.lua") then
    print("Error: mainController.lua not found.")
    return
end

-- Run the mainController
os.run({}, "mainController.lua")