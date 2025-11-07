-- Nav.lua -- 
require("state_manager")



function positionDifference(inital, final)
    return {
        x = final.x - inital.x,
        y = final.y - inital.y,
        z = final.z - inital.z
    }
end

function getCurrentDirection()
    local directions = {"north", "east", "south", "west"}
    local starting_Position = {}
    local result
    starting_Position.x, starting_Position.y, starting_Position.z = gps.locate()
    turtle.forward()
    local ending_Position = {}
    ending_Position.x, ending_Position.y, ending_Position.z = gps.locate()
    turtle.back()
    local position_Difference = positionDifference(starting_Position, ending_Position)
    if position_Difference.x > 0 then
        result = "east"
    elseif position_Difference.x < 0 then
        result = "west"
    elseif position_Difference.z > 0 then
        result = "south"
    elseif position_Difference.z < 0 then
        result = "north"
    else
        return nil

    end
    settings.set ("nav.currentDirection", result)
    settings.save()
    print("Facing " .. result)
    return result
end

function turnRight()
    turtle.turnRight()
    local current = settings.get("nav.currentDirection")
    if not current then
        current = getCurrentDirection()
    end
    local directions = {"north", "east", "south", "west"}
    for i, dir in ipairs(directions) do
        if dir == current then
            local newIndex = (i % 4) + 1
            settings.set("nav.currentDirection", directions[newIndex])
            print("Now facing " .. directions[newIndex])
            settings.save()
            return
        end
    end
end

function turnLeft()
    turtle.turnLeft()
    local current = settings.get("nav.currentDirection")
    if not current then
        current = getCurrentDirection()
    end
    local directions = {"north", "east", "south", "west"}
    for i, dir in ipairs(directions) do
        if dir == current then
            local newIndex = (i - 2) % 4 + 1
            settings.set("nav.currentDirection", directions[newIndex])
            print("Now facing " .. directions[newIndex])
            settings.save()
            return
        end
    end
end



function turnTo(direction, offset)
    offset = offset or 0
    local currentDirection = settings.get("nav.currentDirection")
    print(currentDirection)
    if not currentDirection then
        currentDirection = getCurrentDirection()
    end
    local directions = {"north", "east", "south", "west"}
    local currentIndex, targetIndex

    for i, dir in ipairs(directions) do
        if dir == currentDirection then
            currentIndex = i
        end
        if dir == direction then
            targetIndex = i + offset
        end
    end
    local diff = (targetIndex - currentIndex) % 4

    if diff == 1 then
        turnRight()
    elseif diff == 2 then
        turnRight()
        turnRight()
    elseif diff == 3 then
        turnLeft()
    end
end


function moveWaypoint(waypoint_name)
    local waypoint = textutils.unserialize(settings.get("sm.states") )[waypoint_name]
    if not waypoint then
        return false
    end
    moveTo(waypoint.x, waypoint.y, waypoint.z)
    if waypoint.facing then
        turnTo(waypoint.facing)
        end
    return true

end


function moveTo(x, y, z, type)
    local position = {}
    local isMove = true
    position.x, position.y, position.z = gps.locate()
    if not position.x then
        error("GPS signal not found")
    end
    getCurrentDirection()

    while position.x ~= x or position.y ~= y or position.z ~= z do

        if position.y < y then
            isMove = isMove and turtle.up()
            
        elseif position.y > y then
            isMove = isMove and turtle.down()

        elseif position.x < x then
            turnTo("east")
            isMove = isMove and turtle.forward()
            
            
        elseif position.x > x then
            turnTo("west")
            isMove = isMove and turtle.forward()

        elseif position.z < z then
            turnTo("south")
            isMove = isMove and turtle.forward()
            
            
        elseif position.z > z then
            turnTo("north")
            isMove = isMove and turtle.forward()
        
        end
        
        if not isMove then
            error("Movement failed")
        end
        position.x, position.y, position.z = gps.locate()
    end
        


end