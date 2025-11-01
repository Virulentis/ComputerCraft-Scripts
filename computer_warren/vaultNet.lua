rednet.open("top")

while true do
    id, message = rednet.receive()
    if id == 1 and message == "refuel" then
        print("refuel incoming!!")

    end
end