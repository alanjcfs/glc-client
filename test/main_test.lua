require("test/test_helper")
require("../main")

describe("main file", function()
  it("has otherPlayers", function()
    assert(type(otherPlayers) == "table")
  end)
end)
