------------------------------------------------------------------------
-- Squishy slime
------------------------------------------------------------------------

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
    init = function(self, pos, size, num_vertices)
        self.pos = pos

        self.center = globals.world:newCircleCollider(pos.x, pos.y, 10)

        self.bones = {}

        for i = 1, num_vertices do
            table.insert(self.bones,globals.world:newCircleCollider(
                pos.x + size * math.cos(2 * math.pi * i / num_vertices),
                pos.y + size * math.sin(2 * math.pi * i / num_vertices), 1))
        end

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

function Slime:moveLeft()
    if self:canMove() then
        self.center:applyLinearImpulse(-CONFIG.SLIME_IMPULSE, 0)
    end
end

function Slime:moveRight()
    if self:canMove() then
        self.center:applyLinearImpulse(CONFIG.SLIME_IMPULSE, 0)
    end
end
function Slime:update(dt)
    if love.keyboard.isDown("a") then
        self:moveLeft()
    elseif love.keyboard.isDown("d") then
        self:moveRight()
    end

    -- keep it above the surface
    for i = 1, #self.bones do
        local y = globals.surface:getY(self.bones[i]:getX())
        if self.bones[i]:getY() > y then
            self.bones[i]:setY(y - 3)
        end
    end
end

function Slime:draw()
    local vertices = {}
    for i = 1, #self.bones do
        table.insert(vertices, self.bones[i]:getX())
        table.insert(vertices, self.bones[i]:getY())
    end
    table.insert(vertices, self.bones[1]:getX())
    table.insert(vertices, self.bones[1]:getY())
    love.graphics.setColor(0, 255, 0)
    love.graphics.polygon('fill', vertices)
    love.graphics.setColor(255, 255, 255)
end

return Slime