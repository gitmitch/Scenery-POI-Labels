require("constants")
require("BoundingBox")


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
  it("works at 180 degrees longitude", function ()
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

describe("Boxes for coverage area", function()
  it("returns a single box for a small area that fits")
  it("returns multiple boxes to cover the desired area")
  it("does not return duplicate boxes")
end)
