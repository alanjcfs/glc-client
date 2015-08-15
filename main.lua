require("conf")
require("util/fs")
require("net/json")
require("geometry/collision")
_ = require("util/underscore")
clock = require("util/clock")
inspect = require("util/inspect")
layer = require("graphics/layer")
console = require("graphics/console")
glcd = require("net/glcd")
handlers = require("net/glcd-handlers")

beginning = require("game/beginning")

function love.load()
  -- Not sure what this does?
  math.randomseed(os.time())

  -- glcd.init()
  -- glcd.setPlayerStatus("ACTIVE")

  beginning.init()

end
