--
-- Created by IntelliJ IDEA.
-- User: eylulaygun
-- Date: 2018-02-10
-- Time: 4:24 PM
-- To change this template use File | Settings | File Templates.
--

------------------------------------------------------------------------
-- Soldier Pill boi
------------------------------------------------------------------------


local Pill = Class{
    init = function(self, pos)
        self.pos = pos
        self.bone = globals.world:newCircleCollider(
                    pos.x + l * math.cos(2*math.pi/8*i),
                    pos.y + l * math.sin(2*math.pi/8*i), r)
        end


}

function Pill:moveLeft()
        self.bone:applyLinearImpulse(-CONFIG.PILL_IMPULSE, 0)
end

function Pill:moveRight()

        self.bone:applyLinearImpulse(CONFIG.PILL_IMPULSE, 0)
end
function Pill:update(dt)
    if love.keyboard.isDown("a") then
        self:moveLeft()
    elseif love.keyboard.isDown("d") then
        self:moveRight()
    end

    -- keep it above the surface

        local y = globals.surface:getY(self.bone:getX())
        if self.bone:getY() > y then
            self.bone:setY(y - 3)
        end

end



function Pill:draw()
    love.graphics.draw(self.img, self.pos.x, self.pos.y)
end

function Pill:load()
    self.img = love.graphics.newImage("assets/Pill-soldier-small.png")
end

return Pill