require("nav")
require("state_manager")


function mainLoop(row, col)
    local starting_face = getCurrentDirection()
    row = tonumber(row)
    col = tonumber(col)
    while true do
        for i = 0, row do
            for j = 0, col do
                
                if (j + 1) < col then
                    turtle.dig()
                    turtle.forward() 
                end
            end
            if (i % 2) == 0 then
                turnTo(starting_face, 2)
            else
                turnTo(starting_face)
            end
        end
        turnTo(starting_face)
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
