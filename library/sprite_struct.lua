local listOfSprites = { _list={} }

function listOfSprites:draw()
  for _, v in pairs(listOfSprites._list) do
    love.background:draw(v.draw, v.data_args)
  end
end

function listOfSprites:update()
  for _, v in pairs(listOfSprites._list) do
    v.update()
  end
end

function listOfSprites:append(data)
  table.insert(listOfSprites._list, data)
end

return listOfSprites
