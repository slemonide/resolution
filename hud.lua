------------------------------------------------------------------------
-- Hud
------------------------------------------------------------------------

local Pill = Class{
    init = function(self, pos)
        self.bone = globals.world:newCircleCollider(pos.x, pos.y, 10)
        self.bone:setMass(2)
        self.img = love.graphics.newImage("assets/Pill-soldier-small.png")
        self.movingLeft = true
    end
}