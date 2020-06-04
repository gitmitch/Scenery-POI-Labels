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

describe("Boxes based on desired coverage area", function()
  it("returns a single box for a small area that fits", function ()
    -- local targetLatitude = 45
    -- local targetLongitude = -120


  end)
  it("returns multiple boxes to cover the desired area")
  it("returns a large number of boxes to cover the desired area")
end)
