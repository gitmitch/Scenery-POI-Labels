

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
