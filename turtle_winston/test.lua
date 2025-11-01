
function excavate()
  turtle.dig()
  turtle.forward()
  refulel all
end

startpos = gps.locate()
direction = 0 -- 0=north, 1=east, 2=south, 3=west


function startup()
    set startpos = {x=0, y=0, z=0}
    set direction = 0 -- 0=north, 1=east, 2=south, 3=west

end


local waypoints = {
    home = {x=0, y=0, z=0},
    mine = {x=10, y=-20, z=5},
    deposit = {x=5, y=0, z=15}
}


-- state_manager.lua --
local StateManager = {}

StateManager.defaults = {
    home = {x = 0, y = 0, z = 0, facing = "north"},
    mine = {x = 100, y = 40, z = 50},
    fuel_station = {x = 25, y = 64, z = -10}
}

function StateManager.saveState(stateData)
    settings.set("turtle.state", textutils.serialize(stateData))
    settings.save()
    print("State saved!")
end

function StateManager.loadState()
    local saved = settings.get("turtle.state")
    if saved then
        return textutils.unserialize(saved)
    else
        return {waypoints = StateManager.defaults, currentTask = "idle"}
    end
end

function StateManager.saveWaypoint(name, x, y, z, facing)
    local state = StateManager.loadState()
    state.waypoints[name] = {x = x, y = y, z = z, facing = facing or "north"}
    StateManager.saveState(state)
end

function StateManager.getWaypoint(name)
    local state = StateManager.loadState()
    return state.waypoints[name]
end

return StateManager


-- utlils.lua --
function center


-- Nav.lua -- 
local Nav = {}

function Nav.PositionDifference(inital, final)
    return {
        x = final.x - inital.x,
        y = final.y - inital.y,
        z = final.z - inital.z
    }
end

function Nav.normalizeface(direction)
    local directions = {"north", "east", "south", "west"}
    local starting_Position = {x = gps.locate()}
    turtle.forward()
    local ending_Position = {x = gps.locate()}
    turtle.back()
    local position_Difference = Nav.PositionDifference(starting_Position, ending_Position)
    if position_Difference.x > 0 then
        return "east"
    elseif position_Difference.x < 0 then
        return "west"
    elseif position_Difference.z > 0 then
        return "south"
    elseif position_Difference.z < 0 then
        return "north"
    else
        return nil

    end
    
end

function Nav.turnTo(direction)
    local currentDirection = Nav.normalizeface(direction)
    local directions = {"north", "east", "south", "west"}
    local currentIndex, targetIndex

    for i, dir in ipairs(directions) do
        if dir == currentDirection then
            currentIndex = i
        end
        if dir == direction then
            targetIndex = i
        end
    end

    local diff = (targetIndex - currentIndex) % 4

    if diff == 1 then
        turtle.turnRight()
    elseif diff == 2 then
        turtle.turnRight()
        turtle.turnRight()
    elseif diff == 3 then
        turtle.turnLeft()
    end
end

function Nav.moveTo(x, y, z)
    local currentX, currentY, currentZ = gps.locate()
    if not currentX then
        error("GPS signal not found")
    end
    Nav.normalizeface(direction)

    while currentX ~= x or currentY ~= y or currentZ ~= z do

    


end


fs.open(arg[1], "w").write(arg[2])
fs.close()


