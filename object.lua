Class = require 'class'

Object = Class:new()

Object.color = {1,1,1}
Object.width = 25
Object.height = 25

function Object:new(pos)
  pos = pos or {0, 0}
  local obj = {
    START_X = pos[1],
    START_Y = pos[2],
    x = pos[1],
    y = pos[2],
  }

  self.__index = self
  setmetatable(obj, self)

  return obj
end

function Object:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.rectangle('fill', self.x - self.width/2, self.y - self.height/2, self.width, self.height)
end

function Object:update()
end

function Object:isColliding(obj)

  x1 = self.x - self.width/2
  y1 = self.y - self.height/2
  w1 = self.width
  h1 = self.height

  x2 = obj.x - obj.width/2
  y2 = obj.y - obj.height/2
  w2 = obj.width
  h2 = obj.height

  return x1 < x2+w2
  and x2 < x1+w1
  and y1 < y2+h2
  and y2 < y1+h1
end

return Object
