--
-- Created by IntelliJ IDEA.
-- User: eylulaygun
-- Date: 2018-02-10
-- Time: 8:06 PM
-- To change this template use File | Settings | File Templates.
--


------------------------------------------------------------------------
-- Music for different stages of the game (8-bit and stomach)
------------------------------------------------------------------------


local Music = Class{
    init = function(self)
        self.mainSound = ripple.newSound("assets/Stomach_Ambiance.wav")
        self.bulletSound = ripple.newSound("assets/Gun_Loop.wav")
        self.badSlimeSound = ripple.newSound("assets/Bad_Slime_Hurt_Vocalization_3.wav")
        self.slimeHitSound = ripple.newSound("assets/Bullet_Hit_Bad_Slime_3.wav")
        self.mainSound:play()

    end

}



function Music:update(dt)

end



return Music