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
        self.bulletSound = ripple.newSound("assets/Single_Gun_Shot.wav")
        self.machineGun = ripple.newSound("assets/Gun_Loop.wav")
        self.badSlimeSound = ripple.newSound("assets/Bad_Slime_Hurt_Vocalization_3.wav")
        self.slimeHitSound = ripple.newSound("assets/Bullet_Hit_Bad_Slime_3.wav")

        self.eightBitSound = ripple.newSound("assets/MUSIC bacteria battle 8bit loop ScottV1.wav")
        self.swallow = ripple.newSound("assets/Game_Start_Swallow.wav")
        self.jumpSound = ripple.newSound("assets/Player_Jump.wav")
        self.goodSlimeSound = ripple.newSound("assets/Good_Slime_Vocalization_2.wav")


       -- self.mainSound:play()

    end

}

function Music:eightBitGame()
    self.eightBitSound:play()
end

function Music:mainGame()
    self.mainSound:play()
end

function Music:jump()
    self.jumpSound:play()
end

function Music:gun()
    self.bulletSound:play()

end

function Music:slimeSound()
    self.badSlimeSound:play()
end


function Music:slimeIsShot()
    self.slimeHitSound:play()
end

function Music:goodSlime()
    self.goodSlimeSound:play()
end



return Music