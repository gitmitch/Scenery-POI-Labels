require("poiFetcher")

print("Lua version: " .. _VERSION)

describe("POI Fetcher", function()
  it("should return true", function()
    local result = poiFetcher.fetchPOIs()
    assert.True(result)
  end)

end)