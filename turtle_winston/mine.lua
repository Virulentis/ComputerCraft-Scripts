require("nav")
require("state_manager")
require("utils")

function mainLoop(row, col)
    local starting_face = getCurrentDirection()
    local 
    row = tonumber(row)
    col = tonumber(col)
    print("col: "..col.." row: "..row)
    local isLastTurnRight = true 
    while true do
        for i = 1, row do
            for j = 1, col - 1 do
                turtle.dig()
                turtle.forward() 
            end
            
            shouldReturnToBase("operations")
            if i < row then
                if isLastTurnRight then
                    turnRight()
                    turtle.dig()
                    turtle.forward()
                    turnRight()
                    isLastTurnRight = false
                else
                    turnLeft()
                    turtle.dig()
                    turtle.forward()
                    turnLeft()
                    isLastTurnRight = true
                end
            end
            
        end
        turnLeft()
        turnLeft()
        
        turtle.digDown()
        turtle.down()
    end
end

function shouldReturnToBase(waypoint)

    local pos = {}
    pos.x, pos.y, pos.z = gps.locate()
    local w_pos = loadState(waypoint)
    
    local fuelMovementCost = math.abs(pos.x - w_pos.x) + math.abs(pos.y - w_pos.y) + math.abs(pos.z - w_pos.z)
    if fuelMovementCost + 200 > turtle.getFuelLevel() then
        saveState("temp_pos")
        moveWaypoint(waypoint)
        dropAllItemsDown()
        suckUpAndRefuel()
        moveWaypoint("temp_pos")
    end
    

end

mainLoop(arg[1], arg[2])
