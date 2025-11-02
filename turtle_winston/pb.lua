
function pastebin(programName)
    -- Get the pastebin key from settings
    local pastebinKey = settings.get("pb." .. programName)

    if pastebinKey then
        -- Correct pastebin syntax
        if fs.exists(programName .. ".lua") then
            fs.delete(programName .. ".lua")
            print("Removed old version")
        end
        shell.run("pastebin", "get", pastebinKey, programName .. ".lua")
        print("Downloaded " .. programName .. ".lua")
    else
        print("No pastebin key found for " .. programName)
    end
end

local param_1 = arg[2] or ""
local param_2 = arg[3] or ""
local param_3 = arg[4] or ""

pastebin(arg[1])

if not (param_1 == "") then
    shell.run(arg[1], param_1, param_2, param_3)
end