require("poiFetcher")

SL_TIME_INCREMENT = 1

local previousTime = os.time()

sasl.setLogLevel(LOG_DEBUG)
sasl.logDebug("lua version: " .. _VERSION)

function onPlaneLoaded()

  sasl.logDebug("************************* plane loaded *********************************")

end

function update()
  local currentTime = os.time()
  if(currentTime >= previousTime + SL_TIME_INCREMENT) then
    sasl.logDebug("update triggered time: " .. currentTime)
    previousTime = currentTime
  end
  
end

components = {

}