-- Called only once when the game is started.
function love.load()
  logging = require("logging")
  logging.log("starting up game lost crash client")
  logging.do_show = true

  dirtyKey = false
  pressedKey = {value = nil, dirtyKey = false}

  tileset = require("zones/Dungeon_sans_npcs")
  loader = require("tileset")
  loader.init(tileset)

  canvas = love.graphics.newCanvas(tileset.width * tileset.tilewidth, tileset.height * tileset.tileheight)
  canvas:setFilter("nearest", "nearest") -- linear interpolation

  -- load the splash screen
  splash = true
  glc = love.graphics.newImage("assets/gamelostcrash.png")
  glc_w, glc_h = glc:getDimensions()
  width, height = love.graphics.getDimensions()

  -- thread/queue for nsq processing
  nsqt = love.thread.newThread("test/test-nsq.lua")
  nsqq = love.thread.newChannel()
  nsqt:start(nsqq)

  scaleX, scaleY = win.width / canvas:getWidth(), win.height / canvas:getHeight()
end

-- Runs continuously. Good idea to put all the computations here. 'dt' is the time difference since the last update.
function love.update(dt)
  if pressedKey.value ~= nil and not pressedKey.dirtyKey then
    logging.log("Button released:"..pressedKey.value)
    pressedKey.dirtyKey = true
  end
end

-- Where all the drawings happen, also runs continuously.
function love.draw()

  -- draw splash screen
  if splash then
    x = width/2 - glc_w/2
    y = height/2 - glc_h/2
    love.graphics.draw(glc, x, y)
    love.graphics.setBackgroundColor(0x62, 0x36, 0xb3)
  else
    love.graphics.setCanvas(canvas) -- draw to this canvas
    loader.draw_tiles()
    love.graphics.setCanvas() -- sets the target canvas back to screen
    love.graphics.draw(canvas, 0, 0, 0, scaleX, scaleY) -- scale the canvas 2x
  end

  logging.display_log()
end

-- Mouse pressed.
function love.mousepressed(x, y, button)
end

-- Mouse released.
function love.mousereleased(x, y, button)
end

-- Keyboard key pressed.
function love.keypressed(key)
end

-- Keyboard key released.
function love.keyreleased(key)
  splash = false
  pressedKey.value = key
  pressedKey.dirtyKey = false
  if key == "escape" then
    love.event.quit()
  elseif key == "ralt" then
    logging.do_show = not logging.do_show
  end
end

-- When user clicks off or on the LOVE window.
function love.focus(f)
end

-- Self-explanatory.
function love.quit()
end

function love.threaderror(thread, errorstr)
  print("Thread error!\n" .. errorstr)
end
