Object = require 'object'
Vector = require 'vector'

Paddle = Object:new()

Paddle.width = 100
Paddle.height = 15
Paddle.color = {1, 1, 1}
Paddle.direction = Vector:new(0,0)
Paddle.bounceDirection = true

function Paddle:update(dt)
  prevX = self.x
  self.x = love.mouse.getPosition()
  self.direction = Vector:new(self.x - prevX, 0)
end

function Paddle:getBounceDirection(object)
  local x = (object.x - self.x)/(self.width/2 + object.width)
  local y = 1
  return object.direction
end

return Paddle
