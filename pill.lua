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
        self.bone = globals.world:newCircleCollider(pos.x, pos.y, 10)
        self.img = love.graphics.newImage("assets/Pill-soldier-small.png")
    end
}

function Pill:moveLeft()
        self.bone:applyLinearImpulse(-CONFIG.PILL_IMPULSE, 0)
end

function Pill:moveRight()
        self.bone:applyLinearImpulse(CONFIG.PILL_IMPULSE, 0)
end


function Pill:mousepressed(x, y, button)
    if button == 1 then
        local startX = self.bone:getX()
        local startY = self.bone:getY()
        local mouseX = x
        local mouseY = y

        local angle = math.atan2((mouseY - startY), (mouseX - startX))

        local bulletDx = bulletSpeed * math.cos(angle)
        local bulletDy = bulletSpeed * math.sin(angle)

        table.insert(bullets, {x = startX, y = startY, dx = bulletDx, dy = bulletDy})
    end
end




function Pill:update(dt)
    if love.keyboard.isDown("g") then
        self:moveLeft()
    elseif love.keyboard.isDown("h") then
        self:moveRight()
    elseif love.mouse.isDown() then
        love.mousepressed()
    end

    -- keep it above the surface

        local y = globals.surface:getY(self.bone:getX())
        if self.bone:getY() > y then
            self.bone:setY(y - 3)
        end

end



function Pill:draw()
    --love.graphics.push()
    --love.graphics.scale(.4,.4)
    love.graphics.draw(self.img, self.bone:getX() - 20 , self.bone:getY() - (self.img:getHeight()*.4), 0, 0.5, 0.5)

    --love.graphics.pop()

end



return Pill