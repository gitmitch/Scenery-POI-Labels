require("constants")
require("poiFetcher")
require("customLogger")

debugLogger("module loaded")

local previousTime = os.time()

function update()
  local currentTime = os.time()
  if(currentTime >= previousTime + SL_TIME_INCREMENT) then
    debugLogger("update triggered time: " .. currentTime)
    previousTime = currentTime
  end

end

components = {

}
