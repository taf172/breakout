Class = require 'class'

Vector = Class:new()

function Vector:new(x,y)
  local obj = {
    x = x or 0,
    y = y or 0,
    length = math.sqrt(x*x + y*y),
    direction = math.atan(x/y),
  }

  self.__index = self
  setmetatable(obj, self)

  return obj
end

function Vector.__add(a, b)
  return Vector:new(a.x + b.x, a.y + b.y)
end

function Vector.__sub(a, b)
  return Vector:new(a.x - b.x, a.y - b.y)
end

function Vector.__mul(a, b)
  if type(a) == "number" then
    return Vector:new(b.x * a, b.y * a)
  elseif type(b) == "number" then
    return Vector:new(a.x * b, a.y * b)
  else
    return Vector:new(a.x * b.x, a.y * b.y)
  end
end

function Vector:unit()
  return Vector:new(self.x/self.length, self.y/self.length)
end

function Vector:randDirection(range)
  local range = range
  local min = range[1]
  local max = range[2]
  randDir = math.rad(math.random(min, max))
  return Vector:new(math.cos(randDir), -math.sin(randDir))
end

return Vector
