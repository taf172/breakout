Class = {}
Class.__index = Class

function Class:new(type)
  local obj = {}
  self.__index = self
  setmetatable(obj, self)
  return obj
end

return Class
