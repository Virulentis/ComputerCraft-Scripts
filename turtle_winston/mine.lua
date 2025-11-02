require("nav")
require("state_manager")


function mainLoop(row, col)
    local starting_face = getCurrentDirection()
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
    print("position z")
    -- print(pos.z)
    
    local w_pos = loadState(waypoint)
    print("Original Position -> x: "..pos.x.." y: "..pos.y.." z: "..pos.z)
    print("Waypoint Position -> x: "..w_pos.x.." y: "..w_pos.y.." z: "..w_pos.z)
    
    local fuelMovementCost = math.abs(pos.x - w_pos.x) + math.abs(pos.y - w_pos.y) + math.abs(pos.z - w_pos.z)
    print(fuelMovementCost)

end

shouldReturnToBase("operations")
mainLoop(arg[1], arg[2])
