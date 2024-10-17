-- Initialize the SavedVariables table
if not SoloShuffleNotifierDB then
    SoloShuffleNotifierDB = {}
end

-- Function to save notification data
local function saveQueueNotification()
    SoloShuffleNotifierDB.lastQueuePop = {
        time = date("%Y-%m-%d %H:%M:%S"),
        message = "Your Solo Shuffle queue popped!"
    }
    Screenshot()
end

-- Function to handle queue events
local function onEvent(self, event, arg1, ...)
   local status, _, _, _, _, queueType, _, _, _, _, _ = GetBattlefieldStatus(arg1)
   if status == "confirm" and queueType == "RATEDSHUFFLE" then
        saveQueueNotification()
    end
end

-- Create a frame to listen for events
local frame = CreateFrame("Frame");
frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
frame:SetScript("OnEvent", onEvent);

-- Slash command for testing
SLASH_SOLOSHUFFLENOTIFIER1 = "/ssnotify";
SlashCmdList["SOLOSHUFFLENOTIFIER"] = function(msg)
    saveQueueNotification()
end
