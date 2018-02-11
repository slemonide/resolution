require("globals")

require("lib.console.console")


------------------------
-- Load love
------------------------

function love.load()
    math.randomseed(os.time())

    background = love.graphics.newImage("assets/Background.jpg")




    globals:load()
end

------------------------
-- Update
------------------------

function love.update(dt)
    globals.world:update(dt)
    globals.slime:update(dt)
    globals.pill:update(dt)

    --globals.bullet:update(dt)


end

------------------------
-- Draw
------------------------

function love.draw()
    love.graphics.draw(background, 0 , 0)
    --globals.world:draw()
    globals.surface:draw()
    globals.pill:draw()
    globals.slime:draw()
    for i, b in ipairs(globals.bullets) do
        b:draw()
    end



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