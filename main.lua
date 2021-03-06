require("globals")

require("lib.console.console")

------------------------
-- Load love
------------------------

function love.load()
    math.randomseed(os.time())

    background = love.graphics.newImage("assets/background-final.png")
    globals:load()
end

------------------------
-- Update
------------------------

function love.update(dt)
    if globals.update_delay > CONFIG.UPDATE_DELAY then
        globals.update_delay = 0
        for i, s in ipairs(globals.slimes) do
            s:update(dt)
        end
        globals.pill:update(dt)
    else
        globals.update_delay = globals.update_delay + dt
    end

    globals.world:update(dt)
    globals.camera:lookAt(globals.pill.bone:getX(), globals.pill.bone:getY() - 50)
    globals.camera:zoomTo(4/math.log(40 + globals.surface:getY(globals.pill.bone:getX()) - globals.pill.bone:getY()))
end

------------------------
-- Draw
------------------------

function love.draw()
    if globals.game_over then
        love.graphics.setColor(200,123,41)
        love.graphics.print("GAME OVER", 40, 50, 0, 6, 6)
    else
        globals.camera:attach()

        globals.eightBit:draw()

        love.graphics.draw(background, 0 , 0)
        --globals.world:draw()
        globals.surface:draw()
        globals.pill:draw()
        for i, s in ipairs(globals.slimes) do
            s:draw()
        end
        for i, b in ipairs(globals.bullets) do
            b:draw()
        end

        globals.camera:detach()

        globals.hud:draw()
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

------------------------
-- Wheelmoved
------------------------

function love.wheelmoved(x, y)
    globals.pill.movingLeft = (y > 0)
end