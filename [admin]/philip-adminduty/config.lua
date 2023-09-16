Config = {
    Lang = 'en',
    Adminped = 'adminped', -- Change this to change admin ped model.
    DrawDistance = 50, -- From how far away should be shown the logo.
    AdminLogo = "logo", -- Name of the logo name in the ytd file!
    AdminLogoHeight = 1.5, -- How height must be the logo above the head!
    LogoSpin = false, -- Change this to false if you don't want the logo to spin and change true if you want the logo to spin.
    LogoMovingWithCamera = true, -- Change this to false if you don't want the logo to look always the player camera direction and change true if you want the logo to look always the player camera direction.
    LogoBouncing = false -- Change this to false if you don't want the logo to be bouncing and change true if you want the logo to be bouncing.
    clothes = "qb-clothing"
    -- NOTE: You can't use LogoSpin and LogoMovingWithCamera at the same time. It's not gonna work!

}

Lang = {
    ['hu'] = {
        dutyOn = 'Beléptél adminszolgálatba!',
        dutyOff = 'Kiléptél adminszolgálatból!',
        dutyOnGlobal = " kilépett az adminszolgálatból!",
        dutyOffGlobal = " adminszolgálatba lépett!"
    },
    ['en'] = {
        dutyOn = 'You are in duty!',
        dutyOff = 'You are no longer in duty!',
        dutyOnGlobal = " has left the duty!",
        dutyOffGlobal = " is in duty!"
    }
}
