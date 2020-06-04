local constants = require "constants"

local BoundingBox = {
  targetLatitude = 0,
  targetLongitude = 0
}

function BoundingBox:new (o)
  o = o or {}
  self.__index = self
  setmetatable(o, self)

  o:calculateBounds()
  return o
end

function BoundingBox:calculateBounds ()
  -- https://wiki.openstreetmap.org/wiki/Overpass_API/Overpass_QL#Global_bounding_box_.28bbox.29
  -- "The values are, in order: southern-most latitude, western-most longitude, northern-most latitude, eastern-most longitude."

  self.areaInMetersSquared = nil

  local southernLatitude = math.floor(self.targetLatitude)
  local westernLongitude = math.floor(self.targetLongitude)
  local northernLatitude = math.ceil(self.targetLatitude)
  local easternLongitude = math.ceil(self.targetLongitude)

  if southernLatitude == northernLatitude then northernLatitude = southernLatitude + 1 end
  if westernLongitude == easternLongitude then easternLongitude = westernLongitude + 1 end

  if westernLongitude == 180 then
    westernLongitude = 0
    easternLongitude = 1
  end

  if southernLatitude == 90 then
    southernLatitude = 89
    northernLatitude = 90
  end

  self.southernLatitude = southernLatitude
  self.westernLongitude = westernLongitude
  self.northernLatitude = northernLatitude
  self.easternLongitude = easternLongitude
end

local function areaOnEarthInSquareMeters(coordinates)
  -- http://mathforum.org/library/drmath/view/63767.html
  -- WARNING: this function will take the long way around the globe when coordinates traverse the antimeridian.
  -- Instead of traversing the antimeridian, the calculation will traverse the prime meridian, giving a much higher
  -- result than expected. Split your geometry into chunks that you can sum together if you need to calculate an area
  -- that crosses the antimeridian.
  return (math.pi/180.0) * (constants.EARTH_RADIUS_IN_METERS^2) * math.abs(math.sin(math.rad(coordinates.latitude1)) - math.sin(math.rad(coordinates.latitude2))) * math.abs(coordinates.longitude1 - coordinates.longitude2)
end

return {
  BoundingBox = BoundingBox,
  areaOnEarthInSquareMeters = areaOnEarthInSquareMeters
}