-- Set turtle's network name
local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(43)
print(modem.getNameLocal())
-- modem.setNameLocal(os.getComputerLabel())

print("Waiting for items...")
while turtle.getItemCount(1) == 0 do
    sleep(0.5)
end
print("Items received!")