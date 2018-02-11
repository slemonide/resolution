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
        self.img = love.graphics.newImage("assets/8-bit-rectangle-tile.png")

        self.platform = globals.world:newRectangleCollider(x, y, self.img:getHeight(),self.img:getWidth())
        self.platform:setType('static')
        self.platform:setCollisionClass('Platform')

    end

}


function  platform:draw()
    love.graphics.draw(self.img, self.x, self.y, 0, 2, 2)

end



return platform