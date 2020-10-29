Object = require 'object'
Vector = require 'vector'

Ball = Object:new()

-- Static Variables
Ball.START_SPEED = 125
Ball.MAX_SPEED = 1500
Ball.DIR_SPREAD = {225, 315}
Ball.SPEED_MULTI = 1/10

-- Variables
Ball.width = 10
Ball.height = 10
Ball.direction = Vector:randDirection(Ball.DIR_SPREAD)
Ball.speed = Ball.START_SPEED
Ball.paused = true
Ball.colliding = false

-- Methods
function Ball:update(dt)

  -- Freeze if paused
  if self.paused then return end

  -- Cap speed
  if self.speed > self.MAX_SPEED then
    self.speed = self.MAX_SPEED
  end

  -- Track position at previous time step
  local prevX = self.x
  local prevY = self.y

  -- Update position
  local x = self.x
  local y = self.y
  local d = self.direction:unit()
  local speed = self.speed

  self.x = x + d.x*speed*dt
  self.y = y + d.y*speed*dt
end

function Ball:respawn()
  self.paused = true
  self.x = self.START_X
  self.y = self.START_Y
  self.speed = self.START_SPEED
  self.direction = Vector:randDirection(self.DIR_SPREAD)
end

function Ball:handleCollision(object)
  local d = self.direction

  -- Determine relevent corner
  local x_dir = 1
  local y_dir = 1
  if d.x < 0 then x_dir = -1 end
  if d.y < 0 then y_dir = -1 end

  local self_x = self.x + x_dir*self.width/2
  local self_y = self.y + y_dir*self.height/2
  local obj_x = object.x - x_dir*object.width/2
  local obj_y = object.y - y_dir*object.height/2

  -- Determine collision times
  col_dx = -(obj_x - self_x)/d.x
  col_dy = -(obj_y - self_y)/d.y

  -- Place at collision position and change direction
  if col_dx < col_dy then
    self.x = obj_x - x_dir*self.width/2
    self.y = self.y - d.y*col_dx
    self.direction = d*Vector:new(-1, 1)
  elseif col_dy < col_dx  then
    self.y = obj_y - y_dir*self.height/2
    self.x = self.x - d.x*col_dy
    self.direction = d*Vector:new(1, -1)
  else
    self.x = obj_x - x_dir*self.width/2
    self.y = obj_y - y_dir*self.height/2
    self.direction = d*Vector:new(-1, -1)
  end

  -- If object gives special direction set to that
  if object.bounceDirection then
    self.direction = object:getBounceDirection(self)
  end
end

return Ball
