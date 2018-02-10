------------------------
-- Load love
------------------------

function love.load()
    math.randomseed(os.time())
end

------------------------
-- Update
------------------------

function love.update(dt)

end

------------------------
-- Draw
------------------------

function love.draw()
    love.graphics.rectangle( "fill", 10, 20, 100, 200 )
end

------------------------
-- Keypressed
------------------------

function love.keypressed(key)
    if key == "escape" or key == "q" then
        love.event.quit()
    elseif key == "f" then
        love.window.setFullscreen(not love.window.getFullscreen())
    end
end