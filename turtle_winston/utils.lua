
function dropAllItemsDown(restrict_value)
    restrict_value = restrict_value or 99
    local starting_slot = turtle.getSelectedSlot()
    for i = 1, 16 do
        if not (i == restrict_value) then
            turtle.select(i)
            turtle.dropDown()
        end
    end
    turtle.select(starting_slot)


end


function suckUpAndRefuel()
    local starting_slot = turtle.getSelectedSlot()
    while (turtle.getFuelLimit() - 100 ) > turtle.getFuelLevel() do
        turtle.select(1)
        turtle.suckUp(64)
        turtle.refuel(64)
    end
    turtle.dropUp()
    turtle.select(starting_slot)
end