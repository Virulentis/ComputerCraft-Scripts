-- state_manager.lua --

function saveState(state_name)
    local states = textutils.unserialize(settings.get("sm.states") )
    if not states then
        states = {}
    end
    local pos = {}
    pos.x, pos.y, pos.z = gps.locate()
    states[state_name] = {
       x = pos.x,
       y = pos.y,
       z = pos.z,
       facing = settings.get("nav.currentDirection")
    }
    settings.set("sm.states", textutils.serialize(states))
    settings.save()
    print("State saved! x:"..pos.x.." y:"..pos.y.." z: "..pos.z)
end

function loadState(state_name)
    local state = textutils.unserialize(settings.get("sm.states") )[state_name]
    return {
        x = state.x, 
        y = state.y, 
        z = state.z, 
        facing = state.facing
    }
end

-- saveState(arg[1])