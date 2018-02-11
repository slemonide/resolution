------------------------------------------------------------------------
-- Squishy slime
------------------------------------------------------------------------
local Bullet = require("bullet")

local Slime = Class{
    init = function(self, pos, size, num_vertices)
        self.lookDir = 0
        self.hp = 0 -- 0 is bad, > 50 is good

        self.sides = {
            globals.world:newRectangleCollider(pos.x - size, pos.y - size, 1, size),
            globals.world:newRectangleCollider(pos.x - size, pos.y - size, size, 1),
            globals.world:newRectangleCollider(pos.x - size, pos.y + size, size, 1),
            globals.world:newRectangleCollider(pos.x + size, pos.y - size, 1, size)
        }

        for _, side in ipairs(self.sides) do
            side:setRestitution(0.8)
            side:setCollisionClass('Slime')
        end

        self.center = self.sides[1]

        self.joints = {
            globals.world:addJoint('RevoluteJoint', self.sides[1], self.sides[2],
                pos.x - size, pos.y - size, false),
            globals.world:addJoint('RevoluteJoint', self.sides[2], self.sides[4],
                pos.x + size, pos.y - size, false),
            globals.world:addJoint('RevoluteJoint', self.sides[3], self.sides[1],
                pos.x - size, pos.y + size, false),
            globals.world:addJoint('RevoluteJoint', self.sides[4], self.sides[3],
                pos.x + size, pos.y + size, false)
        }

        for _,joint in ipairs(self.joints) do
            joint:setLimits(-math.pi*0.2, math.pi*0.2)
            joint:setLimitsEnabled(true)
        end
    end
}

function Slime:canMove()
    return math.abs(globals.surface:getY(self.center:getX()) - self.center:getY()) < 40
end

function Slime:update(dt)
    self.lookDir = (self.lookDir + dt) % (2 * math.pi)

    if (math.random() > 0.9) then
        self:move()
    end

    if (math.random() > 0.9) then
        self:shoot()
    end


    -- keep it above the surface
    for i = 1, #self.sides do
        local y = globals.surface:getY(self.sides[i]:getX())
        if self.sides[i]:getY() > y then
            self.sides[i]:setY(y - 3)
        end
    end

    -- handle damage
    for _, side in ipairs(self.sides) do
        if side:enter('Good Bullet') then -- comes from goodSlime or player(pill)
            local initialState = self:isBad()
            self.hp = math.min(self.hp + 5, 100)
            if initialState ~= self:isBad() then
                globals.music:goodSlime()
            end
            globals.music:slimeIsShot()

        end

        if side:enter('Bad Bullet') then --badBullet comes from badSlime
            self.hp = math.max(self.hp - 1, 0)
        end
    end
end


function Slime:move()
    if self:canMove() then
        local v = vector.fromPolar(self.lookDir, CONFIG.SLIME_JUMP_STRENGTH)
        self.center:applyLinearImpulse(v.x, v.y)
    end
end

function Slime:isBad()
    return self.hp < 50
end

function Slime:shoot()
    local v_dir = vector.fromPolar(self.lookDir, 1)

    if (#globals.bullets < CONFIG.MAX_BULLETS) then
        table.insert(globals.bullets, Bullet(
            vector(self.center:getX(), self.center:getY()) + v_dir * 5,
            v_dir * CONFIG.BULLET_SPEED, self:isBad()))
    else
        globals.bullets.pos = globals.bullets.pos or 1
        globals.bullets[globals.bullets.pos]:remove()
        globals.bullets[globals.bullets.pos] = Bullet(
            vector(self.center:getX(), self.center:getY()) + v_dir * 5,
            v_dir * CONFIG.BULLET_SPEED, self:isBad())
        globals.bullets.pos = globals.bullets.pos + 1
        if (globals.bullets.pos > #globals.bullets) then
            globals.bullets.pos = 1
        end
    end
end

function Slime:draw()

    -- draw body
    local center = vector(
        (self.sides[1]:getX() + self.sides[2]:getX() + self.sides[3]:getX() + self.sides[4]:getX())/4,
        (self.sides[1]:getY() + self.sides[2]:getY() + self.sides[3]:getY() + self.sides[4]:getY())/4)

    local centers2 = {
        vector(
            (self.sides[1]:getX() + self.sides[2]:getX())/2,
            (self.sides[1]:getY() + self.sides[2]:getY())/2
        ),
        vector(
            (self.sides[2]:getX() + self.sides[4]:getX())/2,
            (self.sides[2]:getY() + self.sides[4]:getY())/2
        ),
        vector(
            (self.sides[3]:getX() + self.sides[4]:getX())/2,
            (self.sides[3]:getY() + self.sides[4]:getY())/2
        ),
        vector(
            (self.sides[3]:getX() + self.sides[1]:getX())/2,
            (self.sides[3]:getY() + self.sides[1]:getY())/2
        )
    }

    local new_points = {
        (centers2[1] - center) * 1.4 + center,
        (centers2[2] - center) * 1.4 + center,
        (centers2[3] - center) * 1.4 + center,
        (centers2[4] - center) * 1.4 + center
    }

    local vertices = {
        self.sides[1]:getX(), self.sides[1]:getY(),
        new_points[1].x, new_points[1].y,
        self.sides[2]:getX(), self.sides[2]:getY(),
        new_points[2].x, new_points[2].y,
        self.sides[4]:getX(), self.sides[4]:getY(),
        new_points[3].x, new_points[3].y,
        self.sides[3]:getX(), self.sides[3]:getY(),
        new_points[4].x, new_points[4].y
    }

    local color = (CONFIG.SLIME_GOOD_COLOR - CONFIG.SLIME_BAD_COLOR) * self.hp/100 + CONFIG.SLIME_BAD_COLOR

    love.graphics.setColor(color.x, color.y, 33)
    love.graphics.polygon('fill', vertices)

    -- draw eyes
    love.graphics.setColor(255,255,255)
    love.graphics.circle("fill", center.x + 10, center.y - 10, 5)
    love.graphics.circle("fill", center.x - 10, center.y - 10, 5)
    love.graphics.setColor(0,0,255)
    love.graphics.circle("fill", center.x + 10, center.y - 8, 2)
    love.graphics.circle("fill", center.x - 10, center.y - 8, 2)

    love.graphics.setColor(255, 255, 255)
end

return Slime