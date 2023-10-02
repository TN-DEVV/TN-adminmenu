QBCore = exports['qb-core']:GetCoreObject()
local ShowBlips = false
local ShowNames = false
local NetCheck1 = false
local NetCheck2 = false
local DutyBlips = {}

CreateThread(function()
    while true do   
        local hash = GetEntityModel(PlayerPedId())
        if DutyBlips then
            for k, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end        
        DutyBlips = {}  
        if NetCheck1 or NetCheck2 then
            if hash == -896031543 then
                TriggerServerEvent('qb-admin:server:GetPlayersForBlips')
            else
                ShowNames = false
                NetCheck2 = false
                ---------------------------------------
                ShowBlips = false
                NetCheck1 = false
                ----------------------------------------
                TriggerEvent('QBCore:Notify', Lang:t("error.blips_name_anticheat"),"error")
            end 
        end 
        Wait(1000)
    end
end)

RegisterNetEvent('qb-admin:client:toggleBlips', function()
    if not ShowBlips then
        ShowBlips = true
        NetCheck1 = true
        QBCore.Functions.Notify(Lang:t("success.blips_activated"), "success")
    else
        ShowBlips = false
        QBCore.Functions.Notify(Lang:t("error.blips_deactivated"), "error")
    end
end)

RegisterNetEvent('qb-admin:client:toggleNames', function()
    if not ShowNames then
        ShowNames = true
        NetCheck2 = true
        QBCore.Functions.Notify(Lang:t("success.names_activated"), "success")
    else
        ShowNames = false
        QBCore.Functions.Notify(Lang:t("error.names_deactivated"), "error")
    end
end)

RegisterNetEvent('qb-admin:client:Show', function(players)
    for k, player in pairs(players) do
        local playeridx = GetPlayerFromServerId(player.source)
        local ped = GetPlayerPed(playeridx)
        local blip = GetBlipFromEntity(ped)
        local playerLocation = player.location
        local name = 'ID: '..GetPlayerServerId(playeridx)..' | '..player.name
        

        local Tag = CreateFakeMpGamerTag(ped, name, false, false, "", false)
        SetMpGamerTagAlpha(Tag, 0, 255) -- Sets "MP_TAG_GAMER_NAME" bar alpha to 100% (not needed just as a fail safe)
        SetMpGamerTagAlpha(Tag, 2, 255) -- Sets "MP_TAG_HEALTH_ARMOUR" bar alpha to 100%
        SetMpGamerTagAlpha(Tag, 4, 255) -- Sets "MP_TAG_AUDIO_ICON" bar alpha to 100%
        SetMpGamerTagAlpha(Tag, 6, 255) -- Sets "MP_TAG_PASSIVE_MODE" bar alpha to 100%
        SetMpGamerTagHealthBarColour(Tag, 25)  --https://wiki.rage.mp/index.php?title=Fonts_and_Colors

        if ShowNames then
            SetMpGamerTagVisibility(Tag, 0, true) -- Activates the player ID Char name and FiveM name
            SetMpGamerTagVisibility(Tag, 2, true) -- Activates the health (and armor if they have it on) bar below the player names
            if GetPlayerInvincible(playeridx) then
                SetMpGamerTagVisibility(Tag, 6, true) -- If player is in godmode a circle with a line through it will show up
            else
                SetMpGamerTagVisibility(Tag, 6, false)
            end
        else
            SetMpGamerTagVisibility(Tag, 0, false)
            SetMpGamerTagVisibility(Tag, 2, false)
            SetMpGamerTagVisibility(Tag, 4, false)
            SetMpGamerTagVisibility(Tag, 6, false)
            RemoveMpGamerTag(Tag) -- Unloads the tags till you activate it again
            NetCheck2 = false
        end

        -- Blips Logic
        if ShowBlips then
            if not DoesBlipExist(blip) then
                if NetworkIsPlayerActive(playeridx) then
                    blip = AddBlipForEntity(ped)
                else
                    blip = AddBlipForCoord(playerLocation.x, playerLocation.y, playerLocation.z)
                end
                SetBlipSprite(blip, 1)
                ShowHeadingIndicatorOnBlip(blip, true)
                SetBlipRotation(blip, math.ceil(playerLocation.w))
                SetBlipScale(blip, 1.0)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(name)
                EndTextCommandSetBlipName(blip)
                DutyBlips[#DutyBlips+1] = blip
            end
        
            if GetBlipFromEntity(PlayerPedId()) == blip then
                -- Ensure we remove our own blip.
                RemoveBlip(blip)
            end   
        end
    end
end)
