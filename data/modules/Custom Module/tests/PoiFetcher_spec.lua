require("constants")
require("PoiFetcher")

print("Lua version: " .. _VERSION)

describe("POI Fetcher", function()
  local poiFetcher
    before_each(function()
      poiFetcher = PoiFetcher:new {
        sasl = {
          downloadFileAsync = function ()
            print("downloadFileAsync called")
          end
        }
      }
      stub(poiFetcher.sasl, "downloadFileAsync")
    end)
  describe("Set current origin", function ()
    it("should request POIs from Overpass if this is the first time setting origin", function ()
      poiFetcher:setCurrentOrigin(1, -1, 0)
      assert.stub(poiFetcher.sasl.downloadFileAsync).was.called(1)
    end)
    it("should not re-request POIs if this is a subsequent time setting the origin", function ()
      poiFetcher:setCurrentOrigin(1, -1, 0)
      poiFetcher:setCurrentOrigin(1, -1, 0)
      assert.stub(poiFetcher.sasl.downloadFileAsync).was.called(1)
    end)
  end)
  it("should return true", function()
    local result = poiFetcher:fetchPOIs()
    assert.True(result)
  end)

end)
