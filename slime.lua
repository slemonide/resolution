------------------------------------------------------------------------
-- Squishy slime
------------------------------------------------------------------------
local Bullet = require("bullet")

-- connects bones i to j with distanceJoint
local function distanceJoint(muscles, bones, i, j)
    table.insert(muscles,
        globals.world:addJoint('DistanceJoint', bones[i], bones[j],
            bones[i]:getX(), bones[i]:getY(),
            bones[j]:getX(), bones[j]:getY(), true))
end

local function ropeJointBone(muscles, bones, size, bone, j)
    table.insert(muscles,
        globals.world:addJoint('RopeJoint', bone, bones[j],
            bone:getX(), bone:getY(),
            bones[j]:getX(), bones[j]:getY(), size, true))
end

local function distanceJointBone(muscles, bones, bone, j)
    table.insert(muscles,
        globals.world:addJoint('DistanceJoint', bone, bones[j],
            bone:getX(), bone:getY(),
            bones[j]:getX(), bones[j]:getY(), true))
end

local Slime = Class{
    init = function(self, pos, size, num_vertices, hp)
        self.lookDir = 0
        self.hp = hp or CONFIG.INITIAL_SLIME_HP
        self.center = globals.world:newCircleCollider(pos.x, pos.y, 10)

        self.bones = {}

        for i = 1, num_vertices do
            table.insert(self.bones,globals.world:newCircleCollider(
                pos.x + size * math.cos(2 * math.pi * i / num_vertices),
                pos.y + size * math.sin(2 * math.pi * i / num_vertices), 1))
        end

        --self.center = self.bones[1]

        self.muscles = {}

        for i = 1, #self.bones - 1 do
            distanceJoint(self.muscles, self.bones, i, i + 1)
        end
        distanceJoint(self.muscles, self.bones, 1, #self.bones)

        for i = 1, #self.bones - 2 do
            distanceJoint(self.muscles, self.bones, i, i + 2)
        end
        distanceJoint(self.muscles, self.bones, 1, #self.bones - 1)
        distanceJoint(self.muscles, self.bones, 2, #self.bones)

        for i = 1, #self.bones - 3 do
            distanceJoint(self.muscles, self.bones, i, i + 3)
        end
        distanceJoint(self.muscles, self.bones, 1, #self.bones - 2)
        distanceJoint(self.muscles, self.bones, 2, #self.bones - 1)
        distanceJoint(self.muscles, self.bones, 3, #self.bones)

        for i = 1, #self.muscles do
            self.muscles[i]:setDampingRatio(100)
        end

        for i = 1, #self.bones do
            if (math.random() > 0.9) then
                ropeJointBone(self.muscles, self.bones, size, self.center, i)
            else
                distanceJointBone(self.muscles, self.bones, self.center, 1)
            end
        end
    end
}

function Slime:canMove()
    return math.abs(globals.surface:getY(self.center:getX()) - self.center:getY()) < 20
end

function Slime:update(dt)
    self.lookDir = (self.lookDir + dt) % (2 * math.pi)

    if (math.random() > 0.9) then
        self:move()
    end

    if (math.random() > 0.9) then
        self:shoot()
    end

    globals.music.badSlimeSound:play()

    -- keep it above the surface
    for i = 1, #self.bones do
        local y = globals.surface:getY(self.bones[i]:getX())
        if self.bones[i]:getY() > y then
            self.bones[i]:setY(y - 3)
        end
    end
end


function Slime:move()
    if self:canMove() then
        local v = vector.fromPolar(self.lookDir, CONFIG.SLIME_JUMP_STRENGTH)
        self.center:applyLinearImpulse(v.x, v.y)
    end
end

function Slime:shoot()
    local v_dir = vector.fromPolar(self.lookDir, 1)

    if (#globals.bullets < CONFIG.MAX_BULLETS) then
        table.insert(globals.bullets, Bullet(
            vector(self.center:getX(), self.center:getY()) + v_dir * 5,
            v_dir * CONFIG.BULLET_SPEED))
    else
        globals.bullets.pos = globals.bullets.pos or 1
        globals.bullets[globals.bullets.pos]:remove()
        globals.bullets[globals.bullets.pos] = Bullet(
            vector(self.center:getX(), self.center:getY()) + v_dir * 5,
            v_dir * CONFIG.BULLET_SPEED)
        globals.bullets.pos = globals.bullets.pos + 1
        if (globals.bullets.pos > #globals.bullets) then
            globals.bullets.pos = 1
        end
    end
end

function Slime:draw()

    -- draw body
    local vertices = {}
    for i = 1, #self.bones do
        table.insert(vertices, self.bones[i]:getX())
        table.insert(vertices, self.bones[i]:getY())
    end
    table.insert(vertices, self.bones[1]:getX())
    table.insert(vertices, self.bones[1]:getY())
    love.graphics.setColor(61, 71, 33)
    love.graphics.polygon('fill', vertices)

    -- draw eyes
    love.graphics.setColor(255,255,255)
    love.graphics.circle("fill", vertices[1], vertices[2], 5)
    love.graphics.circle("fill", vertices[5], vertices[6], 5)

    love.graphics.setColor(255, 255, 255)
end

return Slime