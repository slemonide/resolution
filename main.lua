require("globals")

require("lib.console.console")

------------------------
-- Load love
------------------------

function love.load()
    math.randomseed(os.time())

    background = love.graphics.newImage("assets/Background.png")

    globals:load()
end

------------------------
-- Update
------------------------

function love.update(dt)
    globals.world:update(dt)
end

------------------------
-- Draw
------------------------

function love.draw()

    love.graphics.draw(background, 0 , 0)
    globals.world:draw()
    --globals.surface:draw()
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