------------------------------------------------------------------------
-- Bullets that are shot by the soldier pill using mouse
------------------------------------------------------------------------

local Bullet = Class{
    init = function(self, pos, v, bad)
        self.bone = globals.world:newCircleCollider(pos.x, pos.y, 3)
        self.bone:setLinearVelocity(v.x , v.y)
        self.bone:setRestitution(0.8)
        self.bone:setCollisionClass(bad and 'Bad Bullet' or 'Good Bullet')
    end
}

function Bullet:remove()
    self.bone:destroy()
end

function Bullet:update(dt)

end

function Bullet:draw()
    love.graphics.setColor(128, 128, 128)
    love.graphics.circle("fill", self.bone:getX(), self.bone:getY(), 3)
    love.graphics.setColor(255, 255, 255)
end

return Bullet