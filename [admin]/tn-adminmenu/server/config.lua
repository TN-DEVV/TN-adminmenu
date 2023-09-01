--- If this is somehow something else besides interact-sound. Please so change the name of the event that
--- is triggered when using the play sound option in the menu.
SoundScriptName = 'interact-sound' -- Name of the sound script that you are using
SoundPath = '/client/html/sounds' -- Where the sounds are located
Linux = false -- Wether or not if you use linux. Very important!

--- Who should be able to trigger each NetEvent on the server side?
events = {
    ['kill'] = 'admin',
    ['revive'] = 'admin',
    ['freeze'] = 'god',
    ['spectate'] = 'admin',
    ['goto'] = 'admin',
    ['bring'] = 'admin',
    ['intovehicle'] = 'admin',
    ['kick'] = 'admin',
    ['ban'] = 'admin',
    ['setPermissions'] = 'god',
    ['cloth'] = 'mod',
    ['spawnVehicle'] = 'admin',
    ['savecar'] = 'god',
    ['platecar'] = 'god',
    ['playsound'] = 'god',
    ['usemenu'] = 'mod',
    ['routingbucket'] = 'god',
    ['getradiolist'] = 'god',
    ['playerinformation'] = 'god',
    ['giveallweapons'] = 'god',
    ['reports'] = 'mod',
    ['staffchat'] = 'mod',
    ['maxmods'] = 'god',
}

--- Who should be able to trigger each command on the server side?
commands = {
    ['blips'] = 'admin',
    ['names'] = 'admin',
    ['coords'] = 'god',
    ['noclip'] = 'admin',
    ['announce'] = 'admin',
    ['staffchat'] = 'admin',
    ['warn'] = 'admin',
    ['delwarn'] = 'god',
    ['setmodel'] = 'admin',
    ['setammo'] = 'god',
    ['kickall'] = 'god',
}

--- Permission hierarchy order from top to bottom.
PermissionOrder = {
    'god',
    'admin',
    'mod'
}

--- Decides which guns to give when doing "Give All Weapons" tab.
Weaponlist = {
    ['pistol'] = {
        'weapon_pistol',
        'weapon_pistol_mk2',
        'weapon_combatpistol',
        'weapon_appistol',
        'weapon_stungun',
        'weapon_pistol50',
        'weapon_snspistol',
        'weapon_heavypistol',
        'weapon_vintagepistol',
        'weapon_flaregun',
        'weapon_marksmanpistol',
        'weapon_revolver',
        'weapon_revolver_mk2',
        'weapon_doubleaction',
        'weapon_snspistol_mk2',
        'weapon_raypistol',
        'weapon_ceramicpistol',
        'weapon_navyrevolver',
        'weapon_gadgetpistol',
    },
    ['smg'] = {
        'weapon_microsmg',
        'weapon_smg',
        'weapon_smg_mk2',
        'weapon_assaultsmg',
        'weapon_combatpdw',
        'weapon_machinepistol',
        'weapon_minismg',
        'weapon_raycarbine',
    },
    ['shotgun'] = {
        'weapon_pumpshotgun',
        'weapon_sawnoffshotgun',
        'weapon_assaultshotgun',
        'weapon_bullpupshotgun',
        'weapon_musket',
        'weapon_heavyshotgun',
        'weapon_dbshotgun',
        'weapon_autoshotgun',
        'weapon_pumpshotgun_mk2',
        'weapon_combatshotgun',
    },
    ['assault'] = {
        'weapon_assaultrifle',
        'weapon_assaultrifle_mk2',
        'weapon_carbinerifle',
        'weapon_carbinerifle_mk2',
        'weapon_advancedrifle',
        'weapon_specialcarbine',
        'weapon_bullpuprifle',
        'weapon_compactrifle',
        'weapon_specialcarbine_mk2',
        'weapon_bullpuprifle_mk2',
        'weapon_militaryrifle',
    },
    ['lmg'] = {
        'weapon_mg',
        'weapon_combatmg',
        'weapon_gusenberg',
        'weapon_combatmg_mk2',
    },
    ['sniper'] = {
        'weapon_sniperrifle',
        'weapon_heavysniper',
        'weapon_marksmanrifle',
        'weapon_remotesniper',
        'weapon_heavysniper_mk2',
        'weapon_marksmanrifle_mk2',
    },
    ['heavy'] = {
        'weapon_rpg',
        'weapon_grenadelauncher',
        'weapon_grenadelauncher_smoke',
        'weapon_minigun',
        'weapon_firework',
        'weapon_railgun',
        'weapon_hominglauncher',
        'weapon_compactlauncher',
        'weapon_rayminigun',
    }
}
