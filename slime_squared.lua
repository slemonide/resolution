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

local function distanceJointBone(muscles, bones, bone, j)
    table.insert(muscles,
        globals.world:addJoint('DistanceJoint', bone, bones[j],
            bone:getX(), bone:getY(),
            bones[j]:getX(), bones[j]:getY(), true))
end

local Slime = Class{
    init = function(self, pos)
        self.pos = pos

        local l = 20
        local r = 5

        self.center = globals.world:newCircleCollider(pos.x, pos.y, 10)

        self.bones = {
            globals.world:newCircleCollider(pos.x + l, pos.y + l, 1),
            globals.world:newCircleCollider(pos.x + l, pos.y - l, 1),
            globals.world:newCircleCollider(pos.x - l, pos.y - l, 1),
            globals.world:newCircleCollider(pos.x - l, pos.y + l, 1)
        }

        self.muscles = {}
        distanceJoint(self.muscles, self.bones, 1, 2)
        distanceJoint(self.muscles, self.bones, 2, 3)
        distanceJoint(self.muscles, self.bones, 3, 4)
        distanceJoint(self.muscles, self.bones, 4, 1)

        distanceJoint(self.muscles, self.bones, 1, 3)
        distanceJoint(self.muscles, self.bones, 4, 2)

        distanceJoint(self.muscles, self.bones, 1, 2)
        distanceJoint(self.muscles, self.bones, 2, 3)
        distanceJoint(self.muscles, self.bones, 3, 4)
        distanceJoint(self.muscles, self.bones, 4, 1)

        distanceJointBone(self.muscles, self.bones, self.center, 1)
        distanceJointBone(self.muscles, self.bones, self.center, 2)
        distanceJointBone(self.muscles, self.bones, self.center, 3)
        distanceJointBone(self.muscles, self.bones, self.center, 4)
    end
}

function Slime:moveLeft()
    self.center:applyLinearImpulse(-CONFIG.SLIME_IMPULSE, 0)
end

function Slime:moveRight()
    self.center:applyLinearImpulse(CONFIG.SLIME_IMPULSE, 0)
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
    local curve = love.math.newBezierCurve(vertices)
    love.graphics.setColor(0, 255, 0)
    love.graphics.polygon('fill', vertices)
    love.graphics.setColor(255, 255, 255)
end

return Slime