local headers = {}
headers["Content-Type"] = "text/plain"

local NOTE_INSTRUMENT = "flute"
local NOTE_VOLUME = 0.5
local CHAT_NAME = "Turty"
local CHAT_NAME_COLOR_CODE = "§2"

local speaker = peripheral.find("speaker")
local chatBox = peripheral.find("chatBox")

local event, username, message, uuid, isHidden

function speak(text)
    --- Play a non-extreme random flute note
    speaker.playNote(NOTE_INSTRUMENT, NOTE_VOLUME, math.random(5, 18))
    --- Say something :)
    chatBox.sendMessage(text, CHAT_NAME_COLOR_CODE .. CHAT_NAME, "[]", "")
end

while true do
    event, username, message, uuid, isHidden = os.pullEvent("chat")
    local lower_message = string.lower(message)
    if(string.sub(lower_message, 1, 9) == "hey turty" or string.sub(lower_message, 1, 5) == "turty") then
        local response = http.post("http://localhost:8888", message, headers).readAll()
        --- Break the response up into multiple messages if necessary
        local start_index = 0
        local end_index = 0
        local response_length = string.len(response)
        while start_index < response_length do
            if start_index + 250 > response_length then
                end_index = response_length
            else
                end_index = start_index + 250
            end
            speak(string.sub(response, start_index, end_index))
            start_index = end_index + 1
        end
    end
end