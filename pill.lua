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

-- connects bones i to j with muscles
--local function connectBones(muscles, bones, i, j)
--    table.insert(muscles,
--        globals.world:addJoint('DistanceJoint', bones[i], bones[j],
--            bones[i]:getX(), bones[i]:getY(),
--            bones[j]:getX(), bones[j]:getY(), true))
--end

local Pill = Class{
    init = function(self, pos)
        self.pos = pos

  --      self.bones = {
  --          globals.world:newCircleCollider(pos.x + 7, pos.y + 7, 5),
  --          globals.world:newCircleCollider(pos.x + 7, pos.y - 7, 4),
  --          globals.world:newCircleCollider(pos.x - 7, pos.y + 7, 4),
   --         globals.world:newCircleCollider(pos.x - 7, pos.y - 7, 6)
   --     }
   --     self.muscles = {}

        -- assume: there is more than 4 bones
  --      for i = 1, #self.bones - 1 do
  --          connectBones(self.muscles, self.bones, i, i + 1)
  --      end
  --      connectBones(self.muscles, self.bones, 1, #self.bones)
    end
}

function Pill:update(dt, player)
    -- see hump.vector
    local dir = (player.pos - self.pos):normalize_inplace()
    self.pos = self.pos + dir * Pill.speed * dt


    
end

function Pill:draw()
    love.graphics.draw(self.img, self.pos.x, self.pos.y)
end

function Pill:load()
    self.img = love.graphics.newImage("assets/Pill-soldier-small.png")
end

return Pill