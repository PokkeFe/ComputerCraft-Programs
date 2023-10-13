---@diagnostic disable: undefined-global

--- PARAMETERS

local MIN_DELAY_IN_S = 120
local MAX_DELAY_IN_S = 1200
local MESSAGES_PATH = "data/messages.txt"
local NOTE_INSTRUMENT = "flute"
local NOTE_VOLUME = 0.5
local CHAT_NAME = "Turty"
local CHAT_NAME_COLOR_CODE = "§2"
local CHAT_RANGE = 12

--- VARS

local speaker = peripheral.find("speaker")
local chatBox = peripheral.find("chatBox")

local is_timer_complete = false
local event, event_timer_id
local timer_id

local messages = {}
local message_count = 0

--- Randomize Seed
math.randomseed(os.time())

--- FUNCTIONS

function speak()
    --- Play a non-extreme random flute note
    speaker.playNote(NOTE_INSTRUMENT, NOTE_VOLUME, math.random(5, 18))
    --- Say something :)
    chatBox.sendMessage(messages[math.random(0, message_count - 1)], CHAT_NAME_COLOR_CODE .. CHAT_NAME, "[]", "", CHAT_RANGE)
end

--- MAIN

--- Load messages to a table
local messages_fh = io.open(MESSAGES_PATH, "r")
if messages_fh == nil then
    os.exit(-1, true)
end
for line in messages_fh:lines() do
    messages[message_count] = line
    message_count = message_count + 1
end
messages_fh:close()

while true do
    --- Set a random delay
    timer_id = os.startTimer(math.random(MIN_DELAY_IN_S, MAX_DELAY_IN_S))
    is_timer_complete = false
    --- Keep pulling timer events until my timer appears
    while not is_timer_complete do
        event, event_timer_id = os.pullEvent("timer")
        if event_timer_id == timer_id then
            --- Mark timer as complete and speak
            is_timer_complete = true
            speak()
        end
    end
    sleep(1)
end
