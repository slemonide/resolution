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
    init = function()
        sound = ripple.newSound("assets/Stomach_Ambiance.wav")
        sound:play()
    end

}



function Music:update(dt)

end



return Music