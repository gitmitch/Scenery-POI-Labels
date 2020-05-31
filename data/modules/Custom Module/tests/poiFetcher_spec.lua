require("poiFetcher")

describe("POI Fetcher", function()
  it("should return true", function()
    local result = poiFetcher.fetchPOIs()
    assert.True(result)
  end)
end)