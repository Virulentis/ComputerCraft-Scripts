
-- icor.lua --

while true do
    local count = 0
    for i = 1, 4 do
        local isBlock, data, z = turtle.inspect()
        if isBlock and string.find(data.name, "crystal_cluster") then 
            turtle.dig()
        end
    end

    local isBlock, data, z = turtle.inspectUp()
    if isBlock and string.find(data.name, "crystal_cluster") then 
            turtle.digUp()
    end

    turtle.sleep(60)
end

