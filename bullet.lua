--
-- Created by IntelliJ IDEA.
-- User: eylulaygun
-- Date: 2018-02-10
-- Time: 6:44 PM
-- To change this template use File | Settings | File Templates.
--
------------------------------------------------------------------------
-- Bullets that are shot by the soldier pill using mouse
------------------------------------------------------------------------



local Bullet = Class{
    init = function(self, pos, v)
        self.pos = pos
        self.bone = globals.world:newCircleCollider(pos.x, pos.y, 3)
        self.bone:setLinearVelocity( v.x , v.y)
        self.bone:setMass(100)
    end
}




function Bullet:update(dt)

end



function Bullet:draw()
    love.graphics.setColor(128, 128, 128)
    love.graphics.circle("fill", self.bone:getX(), self.bone:getY(), 3)
    love.graphics.setColor(255, 255, 255)


end



return Bullet