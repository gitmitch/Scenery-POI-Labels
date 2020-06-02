require("constants")

if not DEBUG_LOG_PATH then DEBUG_LOG_PATH = "/Users/mitch/temp/scenery-labels.log" end

function debugLogger(message)
  if DEBUG_LOGGING_ENABLED then
    local logLine = os.date("%x", os.time()) .. ": " .. message .. "\n"
    local logFile = io.open(DEBUG_LOG_PATH, "a")
    if not logFile then return end
    logFile:write(logLine)
    logFile:close()
  end
end
