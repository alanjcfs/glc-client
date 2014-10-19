return {
  update = function()
    local time, direction, startTime, delta, X, Y
    time = love.timer.getTime()
    direction = bullet.direction or "right"
    startTime = bullet.startTime
    delta = time - startTime
    X = bullet.X
    Y = bullet.Y

    -- Add check to ensure bullet stops (or bounces) at obstacles and at another
    -- player.

    -- if bullet hasn't hit an obstacle after two seconds, remove bullet.
    if time > bullet.startTime + 2 then
      print("bullet" .. i .. " from " .. bullet.name .. " didn't hit anything")
      bulletList[i] = nil
    else
      -- update bullet X to move to the direction based on time
      -- uses pSpeed to avoid the bullet being slower than player speed
      if direction == "right" then
        bullet.X = X + delta * pSpeed
      elseif direction == "left" then
        bullet.X = X - delta * pSpeed
      elseif direction == "down" then
        bullet.Y = Y + delta * pSpeed
      elseif direction == "up" then
        bullet.Y = Y - delta * pSpeed
      end
    end

    local currZoneId, currZone = getZoneOffset(bullet.X, bullet.Y)
    if hasCollision(zones[currZoneId], bullet.X, bullet.Y) then
      bulletList[i] = nil
    end
    -- print(bullet.name .. "'s bullet is at " .. bullet.X .. "," .. bullet.Y)
    if not bullet.hitList[myPlayer.name] and isPlayerHitByBullet(playerCoords, bullet) then
      bullet.hitList[myPlayer.name] = true
      myPlayer.hitPoint = myPlayer.hitPoint - bullet.damage

      local currZoneId, currZone = getZoneOffset(playerCoords.x, playerCoords.y)
      if hasCollision(zones[currZoneId], bullet.X, bullet.Y) then
        bulletList[i] = nil
      end

      if myPlayer.hitPoint <= 0 then
        local randomVerb = killVerbs[math.random(1, #killVerbs)]
        local killString = (myPlayer.name .. " was " .. randomVerb .. " by " .. bullet.name)
        print(killString)
        -- TODO: Need a way to send a system event instead.
        glcd.send("chat", {Sender=glcd.name, Message=killString})
        -- Teleport to a random location after player dies.
        px, py = randomZoneLocation()
        updateMyState({X = px, Y = py})
        myPlayer.hitPoint = settings.player.default_hitpoint
      else
        print(myPlayer.name .. " was hit by " .. bullet.name)
      end
    end
  end,
  draw = function()
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.circle("fill", 0, 0, 2, 10)
    love.graphics.pop()
  end
}
