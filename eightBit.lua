--
-- Created by IntelliJ IDEA.
-- User: eylulaygun
-- Date: 2018-02-11
-- Time: 12:54 PM
-- To change this template use File | Settings | File Templates.
--

------------------------------------------------------------------------
-- Initial state of the game with everything 8bit
------------------------------------------------------------------------
local Platform = require('platform')
local Music = require('music')


local eightBit = Class{
    init = function(self)


        globals.world:addCollisionClass('Platform')


        globals.music.eightBitSound:play()

        self.player = love.graphics.newImage("assets/Pill-soldier-8bit-small.png")
        self.eightBitBackground = love.graphics.newImage("assets/8bit-background.png")
        self.platforms = {
            Platform(1100, -1950),
            Platform(1130, -1800),
            Platform(1170, -1800),
            Platform(1130, -1770),
            Platform(1400, -1700),
            Platform(1230, -1730),

            Platform(1330, -1570),
            Platform(1200, -1550),
            Platform(1430, -1530),
            Platform(1400, -1500),
            Platform(1130, -1570),
            Platform(1130, -1500),



            Platform(1400, -1000),
            Platform(1130, -1270),
            Platform(1130, -1300),

            Platform(1200, -1450),
            Platform(1230, -1430),
            Platform(1470, -1300),
            Platform(1530, -1370),
            Platform(1400, -1350),
            Platform(1230, -1330),
            Platform(1330, -1300),
            Platform(1230, -1270),
            Platform(1130, -1200),


            Platform(1100, -950),
            Platform(1130, -800),
            Platform(1170, -800),
            Platform(1130, -770),
            Platform(1400, -700),
            Platform(1230, -730),

            Platform(1330, -570),
            Platform(1200, -550),
            Platform(1430, -530),
            Platform(1400, -500),
            Platform(1130, -570),
            Platform(1130, -500),



            Platform(1200, -450),
            Platform(1230, -430),
            Platform(1530, -370),

            Platform(1260, -200),
            Platform(1100, -300),
            Platform(1220, -100),
            Platform(1005, -100),
            Platform(100, -90),

        }
    end

}


function eightBit:update(dt)
    --globals.music.swallow:play()
    -- globals.music.eightBitSound:play()

 --  globals.music.eightBitSound:play()

end


function eightBit:draw()
    love.graphics.draw(self.eightBitBackground, 1000 , -2000, 0, 2, 2)

    for i, v in ipairs(self.platforms) do
        v:draw()
        end


end



return eightBit