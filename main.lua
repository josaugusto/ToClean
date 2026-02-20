local sys = require "sys"
local sysutils = require "sysutils"
local console = require "console"

console.title = "ToClean"

local function emptyRecycleBin()
    console.writecolor("white", "Emptying Recycle Bin...")
    sysutils.recyclebin.empty("C:\\")
    console.writecolor("green", "Done!\n")
end

local function deleteTemporaryFiles()
    console.writecolor("white", "Cleaning temporary files...")
    
    local systemTemp = sys.Directory("C:\\Windows\\Temp")
    local windowsUpdate = sys.Directory("C:\\Windows\\SoftwareDistribution\\Download")
    local prefetch = sys.Directory("C:\\Windows\\prefetch")
    local userTemp = sys.Directory(sysutils.folders.LocalAppData .. "\\temp")

    local tempDirectories = {systemTemp, windowsUpdate, prefetch, userTemp}

    for directories in each(tempDirectories) do
	    for item in each(directories) do
            item:remove()
        end
    end
end

local menuChoice = 0

while menuChoice ~= 3 do
    console.clear()
    console.writecolor("green", "1 - Empty Recycle Bin\n")
    console.writecolor("green", "2 - Delete Temporary Files\n")
    console.writecolor("green", "3 - Exit\n")
    console.write("-> ") menuChoice = console.readln()
    
    if menuChoice == '1' then
        emptyRecycleBin()
    elseif menuChoice == '2' then
        deleteTemporaryFiles()
    elseif menuChoice == '3' then 
        sys.exit()
    else
        console.writecolor("red", "Invalid choice!\n")
    end
    sleep(3000)
end
