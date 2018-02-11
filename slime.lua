------------------------------------------------------------------------
-- Squishy slime
------------------------------------------------------------------------

-- connects bones i to j with muscles
local function connectBones(muscles, bones, i, j)
    table.insert(muscles,
        globals.world:addJoint('DistanceJoint', bones[i], bones[j],
            bones[i]:getX(), bones[i]:getY(),
            bones[j]:getX(), bones[j]:getY(), true))
end

local Slime = Class{
    init = function(self, pos)
        self.pos = pos

        local l = 20
        local r = 5

        self.bones = {}
        for i = 0,7 do
            table.insert(self.bones,
                globals.world:newCircleCollider(
                    pos.x + l * math.cos(2*math.pi/8*i),
                    pos.y + l * math.sin(2*math.pi/8*i), r))
        end

        self.muscles = {}
        -- assume: there is more than 4 bones
        for i = 1, #self.bones - 1 do
            connectBones(self.muscles, self.bones, i, i + 1)
        end
        connectBones(self.muscles, self.bones, 1, #self.bones)

        self.eyes = {
            globals.world:newCircleCollider(pos.x, pos.y, r * 1.3),
            globals.world:newCircleCollider(pos.x + l*0.8 * math.cos(math.pi/4), pos.y + l*0.7 * math.sin(math.pi/4), r * 1.3)
        }

        table.insert(self.bones, self.eyes[1])
        table.insert(self.bones, self.eyes[2])

        connectBones(self.muscles, self.bones, #self.bones - 1, #self.bones)

        connectBones(self.muscles, self.bones, 1, #self.bones)
        connectBones(self.muscles, self.bones, 3, #self.bones)
        connectBones(self.muscles, self.bones, 5, #self.bones)
        connectBones(self.muscles, self.bones, 7, #self.bones)

        connectBones(self.muscles, self.bones, 2, #self.bones - 1)
        connectBones(self.muscles, self.bones, 4, #self.bones - 1)
        connectBones(self.muscles, self.bones, 6, #self.bones - 1)
        connectBones(self.muscles, self.bones, 8, #self.bones - 1)
    end
}

function Slime:moveLeft()
    for i = 1, #self.bones do
        self.bones[i]:applyLinearImpulse(-CONFIG.SLIME_IMPULSE, 0)
    end
end

function Slime:moveRight()
    for i = 1, #self.bones do
        self.bones[i]:applyLinearImpulse(CONFIG.SLIME_IMPULSE, 0)
    end
end
function Slime:update(dt)
    if love.keyboard.isDown("a") then
        self:moveLeft()
    elseif love.keyboard.isDown("d") then
        self:moveRight()
    end

    -- keep it above the surface
    --for i = 1, #self.bones do
        --if self.bones[i]:get
end

function Slime:draw()
    -- TODO: finish
end

return Slime