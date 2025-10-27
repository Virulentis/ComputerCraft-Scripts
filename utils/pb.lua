
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

pastebin(arg[1])
