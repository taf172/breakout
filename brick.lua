Object = require 'object'

Brick = Object:new()

-- Static Variables
Brick.GAP = 15


-- Variables
Brick.width = 75
Brick.height = 25
Brick.hit = false
Brick.active = true

-- Methods
function Brick:update(dt)

  -- Check if hit
  if self.hit then
    self.active = false
    self.hit = false
  end

end

-- Static Methods
function Brick.setBricks(rows, columns, height)
  local bricks = {}
  local total_width = columns*(Brick.GAP + Brick.width)-Brick.GAP
  local start_x = love.graphics.getWidth()/2 - total_width/2 + Brick.width/2
  local start_y = height - Brick.height/2

  for i=1, rows, 1 do
    local y = start_y - (Brick.height + Brick.GAP)*(i-1)
    for j=1, columns, 1 do
      local x = start_x + (Brick.width + Brick.GAP)*(j-1)
      table.insert(bricks, Brick:new({x, y}))
    end
  end

  return bricks
end

return Brick
