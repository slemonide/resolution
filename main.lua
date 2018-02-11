require("globals")

require("lib.console.console")


------------------------
-- Load love
------------------------

function love.load()
    math.randomseed(os.time())

    background = love.graphics.newImage("assets/Background.jpg")
    bulletSpeed = 200
    bullets = {}

    globals:load()
end

------------------------
-- Update
------------------------

function love.update(dt)
    globals.world:update(dt)
    globals.slime:update(dt)
    globals.pill:update(dt)

    for i,v in ipairs(bullets) do
        v.x = v.x + (v.dx * dt)
        v.y = v.y + (v.dy * dt)
    end

end

------------------------
-- Draw
------------------------

function love.draw()
    love.graphics.draw(background, 0 , 0)
    globals.world:draw()
    globals.surface:draw()
    globals.pill:draw()
    globals.slime:draw()


    love.graphics.setColor(128, 128, 128)
    for i,v in ipairs(bullets) do
        love.graphics.circle("fill", v.x, v.y, 3)
    end
    love.graphics.setColor(250, 250, 250)
end

------------------------
-- Keypressed
------------------------

function love.keypressed(key)
    if key == "escape" or key == "q" then
        love.event.quit()
    elseif key == "f" then
        love.window.setFullscreen(not love.window.getFullscreen())
    elseif key == "r" then
        globals:load()
    end

    if (key == "`") then console.Show() end
end

function love.mousepressed(x,y, button)
    globals.pill:mousepressed(x,y,button)
end