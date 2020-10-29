Object = require 'object'

Wall = Object:new()
 
function Wall.setWalls(left, right, ceiling, floor)
  local W_WIDTH, W_HEIGHT = love.graphics.getDimensions()
  local walls = {}

  if left > 0 then
    local wall = Wall:new()
    wall.width = left
    wall.height = W_HEIGHT
    wall.x = left/2
    wall.y = W_HEIGHT/2
    table.insert(walls, wall)
  end
  if right > 0 then
    local wall = Wall:new()
    wall.width = right
    wall.height = W_HEIGHT
    wall.x = W_WIDTH - right/2
    wall.y = W_HEIGHT/2
    table.insert(walls, wall)
  end
  if ceiling > 0 then
    local wall = Wall:new()
    wall.width = W_WIDTH
    wall.height = ceiling
    wall.x = W_WIDTH/2
    wall.y = ceiling/2
    table.insert(walls, wall)
  end
  return walls
end

return Wall
