------------------------------------------------------------------------
-- Soldier Pill boi
------------------------------------------------------------------------
local Bullet = require("bullet")

local Pill = Class{
    init = function(self, pos)
        self.bone = globals.world:newCircleCollider(pos.x, pos.y, 10)
        self.bone:setMass(2)
        self.img = love.graphics.newImage("assets/Pill-soldier-small.png")
    end
}

function Pill:canMove()
    return math.abs(globals.surface:getY(self.bone:getX()) - self.bone:getY()) < 20
end

function Pill:moveLeft()
    if self:canMove() then
        self.bone:applyLinearImpulse(-CONFIG.PILL_IMPULSE, 0)
    end
end

function Pill:moveRight()
    if self:canMove() then
        self.bone:applyLinearImpulse(CONFIG.PILL_IMPULSE, 0)
    end
end


function Pill:mousepressed(x, y, button)
    if button == 1 then
        local startX = self.bone:getX()
        local startY = self.bone:getY()
        local mouseX = x
        local mouseY = y

        local angle = math.atan2((mouseY - startY), (mouseX - startX))

        local bulletDx = CONFIG.BULLET_SPEED * math.cos(angle)
        local bulletDy = CONFIG.BULLET_SPEED * math.sin(angle)

        table.insert(globals.bullets,
            Bullet(
                vector(self.bone:getX(),self.bone:getY()),
                vector(bulletDx,bulletDy)
            ))
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
    love.graphics.draw(self.img, self.bone:getX() - 20 , self.bone:getY() - (self.img:getHeight()*.4), 0, 0.5, 0.5)

end



return Pill