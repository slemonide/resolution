------------------------------------------------------------------------
-- Hud
------------------------------------------------------------------------

local Hud = Class{
    init = function(self, pos)
    end
}

function Hud:draw()
    love.graphics.setColor(80,80,20)
    local good_slimes = 0
    local bad_slimes = 0

    for _, slime in ipairs(globals.slimes) do
        if slime:isBad() then
            bad_slimes = bad_slimes + 1
        else
            good_slimes = good_slimes + 1
        end
    end

    love.graphics.print("Good slimes: " .. good_slimes, 10, 10, 0, 2, 2)
    love.graphics.print("Bad slimes: " .. bad_slimes, 10, 40, 0, 2, 2)
    love.graphics.setColor(255,255,255)
end

return Hud