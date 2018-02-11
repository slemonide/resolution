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


function Pill:mousepressed()
    local v_dir = vector(
        love.mouse.getX() - love.graphics.getWidth()/2,
        love.mouse.getY() - love.graphics.getHeight()/2 - 50):normalized()

    if (#globals.bullets < CONFIG.MAX_BULLETS) then
        table.insert(globals.bullets, Bullet(
            vector(self.bone:getX(), self.bone:getY()) + v_dir * 5,
            v_dir * CONFIG.BULLET_SPEED))
    else
        globals.bullets.pos = globals.bullets.pos or 1
        globals.bullets[globals.bullets.pos]:remove()
        globals.bullets[globals.bullets.pos] = Bullet(
            vector(self.bone:getX(), self.bone:getY()) + v_dir * 5,
            v_dir * CONFIG.BULLET_SPEED)
        globals.bullets.pos = globals.bullets.pos + 1
        if (globals.bullets.pos > #globals.bullets) then
            globals.bullets.pos = 1
        end

    end
end

function Pill:update(dt)
    if love.keyboard.isDown("g") then
        self:moveLeft()
    elseif love.keyboard.isDown("h") then
        self:moveRight()
    elseif love.mouse.isDown(1) then
        self:mousepressed()
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