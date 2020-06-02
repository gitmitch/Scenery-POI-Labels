

PoiFetcher = {
  refreshNeeded = true,
  sasl = {},
}

function PoiFetcher:fetchPOIs ()
  return true
end

function PoiFetcher:setCurrentOrigin (latitude, longitude, altitude)
  if self.refreshNeeded then
    self.sasl.downloadFileAsync()
    self.refreshNeeded = false
  end
end

function PoiFetcher:new (o)
  o = o or {}
  self.__index = self
  setmetatable(o, self)
  return o
end

-- poiFetcher = {
--   refreshNeeded = true,

--   fetchPOIs = function ()
--     -- local latitude = globalProperty("sim/flightmodel/position/latitude")
--     -- local longitude = globalProperty("sim/flightmodel/position/longitude")

--     -- sasl.logDebug("poiFetcher coordinates: " .. get(latitude) .. ", " .. get(longitude))

--     return true
--   end,

--   setCurrentOrigin = function (latitude, longitude, altitude)
--     if poiFetcher.refreshNeeded then
--       poiFetcher.sasl.downloadFileAsync()
--       poiFetcher.refreshNeeded = false
--     end
--   end
-- }
