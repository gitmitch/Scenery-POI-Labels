local constants = require "constants"
local boundingBoxModule = require "BoundingBox"
local BoundingBox = boundingBoxModule.BoundingBox


describe("Bounding box from coordinates", function()
  it("returns coordinates of corners of a box that contain the target coordinates, ver1", function()
    local targetLat = 45.6 -- test that this is not rounded naively
    local targetLon = -122.4 -- test that this is not rounded naively
    local expectedSouthernLat = 45
    local expectedWesternLon = -123
    local expectedNorthernLat = 46
    local expectedEasternLon = -122

    local box = BoundingBox:new({
      targetLatitude = targetLat,
      targetLongitude = targetLon
    })

    assert.are.equal(expectedSouthernLat, box.southernLatitude)
    assert.are.equal(expectedWesternLon, box.westernLongitude)
    assert.are.equal(expectedNorthernLat, box.northernLatitude)
    assert.are.equal(expectedEasternLon, box.easternLongitude)

  end)
  it("returns coordinates of corners of a box that contain the target coordinates, ver2", function()
    local targetLat = 45.4 -- test that this is not rounded naively
    local targetLon = -122.6 -- test that this is not rounded naively
    local expectedSouthernLat = 45
    local expectedWesternLon = -123
    local expectedNorthernLat = 46
    local expectedEasternLon = -122

    local box = BoundingBox:new({
      targetLatitude = targetLat,
      targetLongitude = targetLon
    })

    assert.are.equal(expectedSouthernLat, box.southernLatitude)
    assert.are.equal(expectedWesternLon, box.westernLongitude)
    assert.are.equal(expectedNorthernLat, box.northernLatitude)
    assert.are.equal(expectedEasternLon, box.easternLongitude)
  end)
  it("returns coordinates of corners of a box that contain the target coordinates, boundary conditions version", function()
    -- if given integral coordinates, those coordinates should form the southern- and western-most bounds of the box
    local targetLat = 45.0
    local targetLon = -122.0
    local expectedSouthernLat = 45
    local expectedWesternLon = -122
    local expectedNorthernLat = 46
    local expectedEasternLon = -121

    local box = BoundingBox:new({
      targetLatitude = targetLat,
      targetLongitude = targetLon
    })

    assert.are.equal(expectedSouthernLat, box.southernLatitude)
    assert.are.equal(expectedWesternLon, box.westernLongitude)
    assert.are.equal(expectedNorthernLat, box.northernLatitude)
    assert.are.equal(expectedEasternLon, box.easternLongitude)
  end)
  it("works at the equator and prime meridian, ver1", function ()
    local targetLat = 0
    local targetLon = 0
    local expectedSouthernLat = 0
    local expectedWesternLon = 0
    local expectedNorthernLat = 1
    local expectedEasternLon = 1

    local box = BoundingBox:new({
      targetLatitude = targetLat,
      targetLongitude = targetLon
    })

    assert.are.equal(expectedSouthernLat, box.southernLatitude)
    assert.are.equal(expectedWesternLon, box.westernLongitude)
    assert.are.equal(expectedNorthernLat, box.northernLatitude)
    assert.are.equal(expectedEasternLon, box.easternLongitude)
  end)
  it("works at the equator and prime meridian, ver2", function ()
    local targetLat = -1
    local targetLon = -1
    local expectedSouthernLat = -1
    local expectedWesternLon = -1
    local expectedNorthernLat = 0
    local expectedEasternLon = 0

    local box = BoundingBox:new({
      targetLatitude = targetLat,
      targetLongitude = targetLon
    })

    assert.are.equal(expectedSouthernLat, box.southernLatitude)
    assert.are.equal(expectedWesternLon, box.westernLongitude)
    assert.are.equal(expectedNorthernLat, box.northernLatitude)
    assert.are.equal(expectedEasternLon, box.easternLongitude)
  end)
  it("works at the north pole", function ()
    local targetLat = 90
    local targetLon = 0
    local expectedSouthernLat = 89
    local expectedWesternLon = 0
    local expectedNorthernLat = 90
    local expectedEasternLon = 1

    local box = BoundingBox:new({
      targetLatitude = targetLat,
      targetLongitude = targetLon
    })

    assert.are.equal(expectedSouthernLat, box.southernLatitude)
    assert.are.equal(expectedWesternLon, box.westernLongitude)
    assert.are.equal(expectedNorthernLat, box.northernLatitude)
    assert.are.equal(expectedEasternLon, box.easternLongitude)
  end)
  it("works at the south pole", function ()
    local targetLat = -90
    local targetLon = 0
    local expectedSouthernLat = -90
    local expectedWesternLon = 0
    local expectedNorthernLat = -89
    local expectedEasternLon = 1

    local box = BoundingBox:new({
      targetLatitude = targetLat,
      targetLongitude = targetLon
    })

    assert.are.equal(expectedSouthernLat, box.southernLatitude)
    assert.are.equal(expectedWesternLon, box.westernLongitude)
    assert.are.equal(expectedNorthernLat, box.northernLatitude)
    assert.are.equal(expectedEasternLon, box.easternLongitude)
  end)
  it("works at the antimeridian", function ()
    local targetLat = 0
    local targetLon = 180
    local expectedSouthernLat = 0
    local expectedWesternLon = 0
    local expectedNorthernLat = 1
    local expectedEasternLon = 1

    local box = BoundingBox:new({
      targetLatitude = targetLat,
      targetLongitude = targetLon
    })

    assert.are.equal(expectedSouthernLat, box.southernLatitude)
    assert.are.equal(expectedWesternLon, box.westernLongitude)
    assert.are.equal(expectedNorthernLat, box.northernLatitude)
    assert.are.equal(expectedEasternLon, box.easternLongitude)
  end)
end)

describe("Area within coordinates", function()
  -- http://mathforum.org/library/drmath/view/63767.html
  it("calculates the area of Colorado", function ()
    -- https://www.google.com/search?q=area+of+colorado+in+square+kilometers

    local area = boundingBoxModule.areaOnEarthInSquareMeters({
      latitude1 = 41,
      longitude1 = -102.05,
      latitude2 = 37,
      longitude2 = -109.05
    })

    local difference = math.abs(area - 268993.86 * 1000000)
    assert.is_true(difference <= 3000)
  end)
  it("calculates the area of another example", function()
    -- https://www.mathworks.com/help/map/ref/areaquad.html
    local area = boundingBoxModule.areaOnEarthInSquareMeters({
      latitude1 = 30,
      longitude1 = -25,
      latitude2 = 45,
      longitude2 = 60
    })

    local difference = math.abs(area - 12471130.46 * 1000000)
    assert.is_true(difference <= 3000)
  end)
  it("calculates the area near the prime meridian", function()
    local area = boundingBoxModule.areaOnEarthInSquareMeters({
      latitude1 = 0,
      longitude1 = 1,
      latitude2 = 1,
      longitude2 = -1
    })

    local difference = math.abs(area - 24727.37 * 1000000)
    assert.is_true(difference <= 3000)
  end)
  it("takes the long way around the globe instead of crossing the antimeridian", function()
    local area = boundingBoxModule.areaOnEarthInSquareMeters({
      latitude1 = 0,
      longitude1 = 179,
      latitude2 = 1,
      longitude2 = -179
    })

    local difference = math.abs(area - 4426198.87 * 1000000)
    assert.is_true(difference <= 3000)
  end)
end)

describe("Great circle distance calculator", function()
  it("calculates great circle distance along a latitude", function()
    local distanceInMeters = boundingBoxModule.greatCircleDistanceInMeters(45.5, -120.5, 45.5, -121)
    local difference = math.abs(39.0 - distanceInMeters/1000)
    assert.is_true(difference <= 1)
  end)
  it("calculates great circle distance along a longitude", function()
    local distanceInMeters = boundingBoxModule.greatCircleDistanceInMeters(45.5, -120, 46.5, -120)
    local difference = math.abs(111.0 - distanceInMeters/1000)
    assert.is_true(difference <= 1)
  end)
  it("calculates great circle distance along an arbitrary path", function()
    local distanceInMeters = boundingBoxModule.greatCircleDistanceInMeters(45, -120, 46, -121)
    local difference = math.abs(136.0 - distanceInMeters/1000)
    assert.is_true(difference <= 1)
  end)
end)

local function setContainsBox(table, box)
  for i=1, #table do
    if table[i].southernLatitude == box.southernLatitude
      and table[i].westernLongitude == box.westernLongitude
      and table[i].northernLatitude == box.northernLatitude
      and table[i].easternLongitude == box.easternLongitude then return true end
  end
  return false
end

describe("Coordinates at a given distance away along latitude/longitude line", function()
  -- https://gis.stackexchange.com/questions/142326/calculating-longitude-length-in-miles
  it("works along a latitude for one degree of longitude", function ()
    local latitude = 37.26383
    local distanceInMeters = 88000
    local expectedDegreesOfLongitude = 1

    local actualDegreesOfLongitude = boundingBoxModule.longitudeDegreesAway(latitude, distanceInMeters)
    local difference = math.abs(expectedDegreesOfLongitude - actualDegreesOfLongitude)
    assert.is_true(difference <= 0.01)
  end)
  it("works along a latitude for many degrees of longitude", function ()
    local latitude = 10
    local distanceInMeters = 10^6
    local expectedDegreesOfLongitude = 9.123

    local actualDegreesOfLongitude = boundingBoxModule.longitudeDegreesAway(latitude, distanceInMeters)
    local difference = math.abs(expectedDegreesOfLongitude - actualDegreesOfLongitude)
    assert.is_true(difference <= 0.01)
  end)
  it("works along a longitude for one degree of latitude", function ()
    local distanceInMeters = 111000

    local actualDegreesOfLatitude = boundingBoxModule.latitudeDegreesAway(distanceInMeters)
    local difference = math.abs(actualDegreesOfLatitude - 1)
    assert.is_true(difference < 0.01)
  end)
  it("works along a longitude for many degrees of latitude", function()
    local distanceInMeters = 10^6

    local actualDegreesOfLatitude = boundingBoxModule.latitudeDegreesAway(distanceInMeters)
    local difference = math.abs(actualDegreesOfLatitude - 9)
    assert.is_true(difference < 0.01)
  end)
end)

-- describe("Boxes based on desired coverage area", function()
--   it("returns a single box for a small area that fits", function ()
--     local targetLatitude = 45.5
--     local targetLongitude = 120.5
--     local desiredCoverageAreaInMeters = 38000

--     local expectedNumberOfBoxes = 1
--     local expectedBox = BoundingBox:new({
--       targetLatitude = targetLatitude,
--       targetLongitude = targetLongitude
--     })

--     areaBoxes = boundingBoxModule.boxesForCoverageArea(targetLatitude, targetLongitude, desiredCoverageAreaInMeters)
--     assert.are.equal(1, #areaBoxes)
--     assert.are.same(expectedBox, areaBoxes[1])
--   end)
--   it("returns multiple boxes to cover the desired area along latitudes", function ()
--     local targetLatitude = 45.5
--     local targetLongitude = 120.5
--     local desiredCoverageAreaInMeters = 55000

--     local expectedNumberOfBoxes = 3
--     local expectedBoxes = {
--       BoundingBox:new({
--         targetLatitude = targetLatitude,
--         targetLongitude = targetLongitude
--       }),
--       BoundingBox:new({
--         targetLatitude = targetLatitude,
--         targetLongitude = targetLongitude-1
--       }),
--       BoundingBox:new({
--         targetLatitude = targetLatitude,
--         targetLongitude = targetLongitude+1
--       })
--     }

--     areaBoxes = boundingBoxModule.boxesForCoverageArea(targetLatitude, targetLongitude, desiredCoverageAreaInMeters)
--     assert.are.equal(3, #areaBoxes)
--     for i=1, #expectedBoxes do
--       assert.is_true(setContainsBox(areaBoxes, expectedBoxes[i]))
--     end
--   end)
--   it("returns multiple boxes to cover the desired area along longitudes")
--   it("returns a large number of boxes to cover the desired area")
-- end)
