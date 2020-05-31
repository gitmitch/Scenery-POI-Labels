include("poiFetcher.lua")

SL_TIME_INCREMENT = 1

local previousTime = os.time()

sasl.setLogLevel(LOG_DEBUG)

function onPlaneLoaded()

  sasl.logDebug("************************* plane loaded *********************************")

end

function update()
  local currentTime = os.time()
  if(currentTime >= previousTime + SL_TIME_INCREMENT) then
    sasl.logDebug("update triggered time: " .. currentTime)
    poiFetcher.fetchPOIs()
    previousTime = currentTime
  end
  
end

components = {

}