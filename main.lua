-- IDEA: DRUMMER FOX IS CUTE

Object = require 'object'
Paddle = require 'paddle'
Ball = require 'ball'
Brick = require 'brick'
Wall = require 'wall'

math.randomseed(os.time())

function love.load()
  -- Love settings
  love.window.setVSync(1)
  love.mouse.setVisible(false)

  -- Static variables
  W_WIDTH, W_HEIGHT = love.graphics.getDimensions()

  BALL_START_POSITION = {W_WIDTH/2, W_HEIGHT - 200}
  PADDLE_START_POSITION = {W_WIDTH/2, W_HEIGHT - 50}
  BRICK_LINE = W_HEIGHT/2

  -- Init objects
  paddle = Paddle:new(PADDLE_START_POSITION)
  ball = Ball:new(BALL_START_POSITION)
  walls = Wall.setWalls(10, 10, 10, 0)
  bricks = Brick.setBricks(6, 7, BRICK_LINE)

  MAX_SCORE = 42
  score = 0
  lives = 3

  -- Init sounds
  BREAK_SOUND = love.audio.newSource("sfx_sounds_impact7.wav", "static")
  BOUNCE_SOUND = love.audio.newSource("sfx_sounds_impact1.wav", "static")
  LOSE_LIFE_SOUND = love.audio.newSource("sfx_sounds_damage1.wav", "static")
  playSound = false

  -- Define gamestates
  gameStart = true
  gameActive = false
  gameOver = false
  gameWin = false

end

function love.draw()
  if gameStart then
    love.graphics.print("CLICK TO START", W_WIDTH/2 - 50, W_HEIGHT - 125)
  end
  if gameOver then
    love.graphics.print("GAME OVER!", W_WIDTH/2 - 50, W_HEIGHT - 125)
  end
  if gameWin then
    love.graphics.print("YOU WIN!", W_WIDTH/2 - 50, W_HEIGHT - 125)
  end

  -- Render ball and paddle
  paddle:draw()
  ball:draw()

  for k in pairs(walls) do
    walls[k]:draw()
  end

  for k in pairs(bricks) do
    if bricks[k].active then
      bricks[k]:draw()
    end
  end

  -- Print score and lives
  love.graphics.print("Lives: "..lives.."    Score: "..score, W_WIDTH - 150, 20)
end

function love.update(dt)

  if gameActive then

    -- Gamestate Checks
    if lives == 0 then
      gameOver = true
      gameActive = false
    end
    if score == MAX_SCORE then
      gameWin = true
      gameActive = false
    end

    -- Update objects
    paddle:update(dt)
    ball:update(dt)
    for k in pairs(bricks) do
      bricks[k]:update(dt)
    end

    -- Check for ball collisions
    if ball:isColliding(paddle) then
      ball:handleCollision(paddle)
      ball.speed = ball.speed + ball.speed*ball.SPEED_MULTI
      playSound = BOUNCE_SOUND
    end
    for k in pairs(walls) do
      if ball:isColliding(walls[k]) then
        ball:handleCollision(walls[k])
        playSound = BOUNCE_SOUND
      end
    end
    for k in pairs(bricks) do
      local brick = bricks[k]
      if brick.active and ball:isColliding(brick) then
        ball:handleCollision(brick)
        brick.hit = true
        playSound = BREAK_SOUND
        score = score + 1
      end
    end
    if ball.y > W_HEIGHT then
      ball:respawn()
      playSound = LOSE_LIFE_SOUND
      lives = lives - 1
    end

    -- Play sound
    if playSound then
      playSound:play()
      playSound = false
    end
  else
    paddle:update(dt)
  end

end

function love.mousepressed(x, y, button, isTouch)
  if ball.paused then
    ball.paused = false
  end
  if gameStart then
    gameStart = false
    gameActive = true
  end
end

function love.keypressed(key, scancode, isrepeat)
  if key == 'r' then
    ball:respawn()
  end
end
