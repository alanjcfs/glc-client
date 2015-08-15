local function init()
  local console = require("graphics/console")
  local randomQuote = require("util/random_quote")
  console.log("** starting game lost crash client")
  console.log(randomQuote())
  console.show()
end

return {
  init = init
}
