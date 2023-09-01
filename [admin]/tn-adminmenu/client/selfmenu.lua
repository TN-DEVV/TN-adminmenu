SelfMenu:AddCheckbox({
    icon = '🎥',
    label = Lang:t("menu.noclip"),
    description = Lang:t("desc.noclip_desc"),
    onchange = function()
        TriggerServerEvent('QBCore:CallCommand', 'noclip')
    end
})

SelfMenu:AddButton({
    icon = '🏥',
    label = Lang:t("menu.revive"),
    description = Lang:t("desc.revive_desc"),
    select = function()
        TriggerEvent('hospital:client:Revive')
        TriggerServerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Revived himself",
        GetPlayerName(PlayerId()), Admin.citizenid, Admin.source))
    end
})

local Invisible = false
local function ToggleInvisible()
    Invisible = not Invisible
    TriggerServerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Set Invisible to **%s**",
    GetPlayerName(PlayerId()), Admin.citizenid, Admin.source, Invisible))
    if not Invisible then return end
    while Invisible do
        Wait(0)
        SetEntityVisible(PlayerPedId(), false, 0)
    end
    SetEntityVisible(PlayerPedId(), true, 0)
end
SelfMenu:AddCheckbox({
    icon = '👻',
    label = Lang:t("menu.invisible"),
    description = Lang:t("desc.invisible_desc"),
    onchange = function()
        ToggleInvisible()
    end
})

local Godmode = false
local function ToggleGodmode()
    Godmode = not Godmode
    local Player = PlayerId()
    TriggerServerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Set Godmode to **%s**",
    GetPlayerName(Player), Admin.citizenid, Admin.source, Godmode))
    if Godmode then SetPlayerInvincible(Player, true)
    else SetPlayerInvincible(Player, false) end
end
SelfMenu:AddCheckbox({
    icon = '⚡',
    label = Lang:t("menu.god"),
    description = Lang:t("desc.god_desc"),
    onchange = function()
        ToggleGodmode()
    end
})

SelfMenu:AddCheckbox({
    icon = '📋',
    label = Lang:t("menu.names"),
    description = Lang:t("desc.names_desc"),
    onchange = function()
        TriggerServerEvent('QBCore:CallCommand', 'names')
    end
})

SelfMenu:AddCheckbox({
    icon = '📍',
    label = Lang:t("menu.blips"),
    description = Lang:t("desc.blips_desc"),
    onchange = function()
        TriggerServerEvent('QBCore:CallCommand', 'blips')
    end
})

local VehicleGodmode = false
local function ToggleVehicleGodmode()
    VehicleGodmode = not VehicleGodmode
    TriggerServerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Set VehicleGodmode to **%s**",
    GetPlayerName(PlayerId()), Admin.citizenid, Admin.source, VehicleGodmode))
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if VehicleGodmode then
        SetEntityInvincible(vehicle, true)
        SetEntityCanBeDamaged(vehicle, false)
        while VehicleGodmode do
            vehicle = GetVehiclePedIsIn(ped, false)
            SetVehicleBodyHealth(vehicle, 1000.0)
            SetVehicleFixed(vehicle)
            SetVehicleEngineHealth(vehicle, 1000.0)
            Wait(250)
        end
    else
        SetEntityInvincible(vehicle, false)
        SetEntityCanBeDamaged(vehicle, true)
    end
end
SelfMenu:AddCheckbox({
    icon = '🚔',
    label = Lang:t("menu.vehicle_godmode"),
    description = Lang:t("desc.vehicle_godmode"),
    onchange = function()
        ToggleVehicleGodmode()
    end
})

SelfMenu:AddSlider({
    icon = '👷‍♀️',
    label = Lang:t("menu.ped"),
    value = '',
    values = {{
        label = Lang:t("menu.ped"),
        value = 'ped',
        description = Lang:t("desc.ped")
    }, {
        label = Lang:t("menu.reset_ped"),
        value = 'reset',
        description = Lang:t("desc.reset_ped")
    }},
    select = function(_, newValue)
        if newValue == "ped" then
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("desc.ped"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "a_m_m_salton_03",
                        name = "model",
                        type = "text",
                        isRequired = true
                    }
                }
            })
            if dialog then
                TriggerServerEvent('QBCore:CallCommand', "setmodel", {dialog.model})
            end
        else
            ExecuteCommand('refreshskin')
        end
    end
})

local InfiniteAmmo = false
local function ToggleInfiniteammo()
    InfiniteAmmo = not InfiniteAmmo
    TriggerServerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Set InfiniteAmmo to **%s**",
    GetPlayerName(PlayerId()), Admin.citizenid, Admin.source, InfiniteAmmo))
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    if InfiniteAmmo then
        if GetAmmoInPedWeapon(ped, weapon) < 6 then SetAmmoInClip(ped, weapon, 10) Wait(50) end
        while InfiniteAmmo do
            weapon = GetSelectedPedWeapon(ped)
            SetPedInfiniteAmmo(ped, true, weapon)
            RefillAmmoInstantly(ped)
            Wait(250)
        end
    else
        SetPedInfiniteAmmo(ped, false, weapon)
    end
end
SelfMenu:AddCheckbox({
    icon = '🎯',
    label = Lang:t("menu.ammo"),
    description = Lang:t("desc.ammo"),
    onchange = function()
        ToggleInfiniteammo()
    end
})

SelfMenu:AddSlider({
    icon = '🔫',
    label = Lang:t("menu.give_weapons"),
    value = '',
    values = {{
        label = Lang:t("menu.weapon_pistol"),
        value = 'pistol',
        description = Lang:t("desc.give_weapons")
    }, {
        label = Lang:t("menu.weapon_smg"),
        value = 'smg',
        description = Lang:t("desc.give_weapons")
    }, {
        label = Lang:t("menu.weapon_shotgun"),
        value = 'shotgun',
        description = Lang:t("desc.give_weapons")
    }, {
        label = Lang:t("menu.weapon_assault"),
        value = 'assault',
        description = Lang:t("desc.give_weapons")
    }, {
        label = Lang:t("menu.weapon_lmg"),
        value = 'lmg',
        description = Lang:t("desc.give_weapons")
    }, {
        label = Lang:t("menu.weapon_sniper"),
        value = 'sniper',
        description = Lang:t("desc.give_weapons")
    }, {
        label = Lang:t("menu.weapon_heavy"),
        value = 'heavy',
        description = Lang:t("desc.give_weapons")
    }},
    select = function(_, newValue)
        TriggerServerEvent('qb-admin:server:giveallweapons', newValue)
    end
})

SelfMenu:AddButton({
    icon = '👮',
    label = Lang:t("menu.cuff"),
    description = Lang:t("desc.cuff"),
    select = function()
        TriggerEvent('police:client:GetCuffed', Admin.source, true)
        TriggerServerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Un/Cuffed himself",
        GetPlayerName(PlayerId()), Admin.citizenid, Admin.source))
    end
})
