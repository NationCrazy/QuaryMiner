-- turtles/startup_templates.lua
-- Automatically runs when the turtle starts up.

-- Check if setup has been run
if not fs.exists("setup.lua") then
    print("Error: setup.lua not found.")
    return
end

-- Run setup script to configure the turtle
os.run({}, "setup.lua")

-- Check if the quarry miner script exists
if fs.exists("quarryMiner.lua") then
    -- Start the quarry miner script if this is a miner turtle
    os.run({}, "quarryMiner.lua")
elseif fs.exists("chunkyFollower.lua") then
    -- Start the chunky follower script if this is a chunky turtle
    os.run({}, "chunkyFollower.lua")
else
    print("Error: No valid mining script found.")
end