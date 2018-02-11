--
-- Created by IntelliJ IDEA.
-- User: eylulaygun
-- Date: 2018-02-11
-- Time: 1:11 PM
-- To change this template use File | Settings | File Templates.
--



------------------------------------------------------------------------
-- platforms to jump from for 8bit
------------------------------------------------------------------------


local platform = Class{
    init = function(self, x ,y)
        self.x = x
        self.y = y
        self.img = love.graphics.newImage("assets/8bit-tile-final.png")

        self.platform = globals.world:newRectangleCollider(x, y, 2*self.img:getWidth(),self.img:getHeight())
        self.platform:setType('static')
        self.platform:setCollisionClass('Platform')

        self.borders = {
            globals.world:newLineCollider(1000, -2000, 1000, 0),
            globals.world:newLineCollider(1600, -2000, 1600, 0),
            globals.world:newLineCollider(1000, -2000, 1600, -2000),

        }
        self.borders[1]:setType('static')
        self.borders[2]:setType('static')
        self.borders[3]:setType('static')

    end

}


function  platform:draw()
    love.graphics.draw(self.img, self.x, self.y, 0, 2, 2)

end



return platform