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

        self.bones = {
            globals.world:newCircleCollider(pos.x + 7, pos.y + 7, 5),
            globals.world:newCircleCollider(pos.x + 7, pos.y - 7, 4),
            globals.world:newCircleCollider(pos.x - 7, pos.y + 7, 4),
            globals.world:newCircleCollider(pos.x - 7, pos.y - 7, 6)
        }
        self.muscles = {}

        -- assume: there is more than 4 bones
        for i = 1, #self.bones - 1 do
            connectBones(self.muscles, self.bones, i, i + 1)
        end
        connectBones(self.muscles, self.bones, 1, #self.bones)
    end
}

function Slime:update(dt, player)
    -- see hump.vector
    local dir = (player.pos - self.pos):normalize_inplace()
    self.pos = self.pos + dir * Slime.speed * dt
end

function Slime:draw()
    love.graphics.draw(self.img, self.pos.x, self.pos.y)
end

return Slime