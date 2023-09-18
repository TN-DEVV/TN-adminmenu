local QBCore = exports['qb-core']:GetCoreObject()
local state = false

RegisterNetEvent('qb-admin:cl:AdminDuty', function()
    state = not state
    if state then
        QBCore.Functions.TriggerCallback('qb-admin:sv:checkpermission', function(num)
            if num == 1 then
                local model = godped
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(20)
                end
                SetPlayerModel(PlayerId(), model)
                SetModelAsNoLongerNeeded(model)
                QBCore.Functions.Notify(Lang:t("info.dutyOn"), 'primary', 2500)
                TriggerServerEvent("qb-admin:sv:setduty",1,true)
            elseif num == 2 then 
                local model = adminped
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(20)
                end
                SetPlayerModel(PlayerId(), model)
                SetModelAsNoLongerNeeded(model)
                QBCore.Functions.Notify(Lang:t("info.dutyOn"), 'primary', 2500)
                TriggerServerEvent("qb-admin:sv:setduty",1,true)
            end
        end)
    else
        TriggerServerEvent("qb-admin:sv:setduty",0,true)
        if clothes == "qb-clothes" then
            TriggerServerEvent("qb-clothes:loadPlayerSkin")
        elseif clothes == "qb-clothing" then
            local health = GetEntityHealth(PlayerPedId())
            local model
            local gender = QBCore.Functions.GetPlayerData().charinfo.gender
            local maxhealth = GetEntityMaxHealth(PlayerPedId())
            if gender == 1 then -- Gender is ONE for FEMALE
                model = GetHashKey("mp_f_freemode_01") -- Female Model
            else
                model = GetHashKey("mp_m_freemode_01") -- Male Model
            end
            RequestModel(model)
            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
            Citizen.Wait(1000) -- Safety Delay
            TriggerServerEvent("qb-clothes:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES
            TriggerServerEvent("qb-clothing:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES - Event 2
            SetPedMaxHealth(PlayerId(), maxhealth)
            Citizen.Wait(1000) -- Safety Delay
            SetEntityHealth(PlayerPedId(), health)
        elseif clothes == "illenium-appearance" then
            TriggerEvent("illenium-appearance:client:reloadSkin")
        end
        QBCore.Functions.Notify(Lang:t("info.dutyOff"), 'primary', 2500)
        Citizen.Wait(1000) 
        QBCore.Functions.TriggerCallback('SmallTattoos:GetPlayerTattoos', function(tattooList)
            if tattooList then
                for k, v in pairs(tattooList) do
                    SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
                end
            end
        end)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent("qb-admin:sv:setduty",0,false)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    TriggerServerEvent("qb-admin:sv:setduty",0,false)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        TriggerServerEvent("qb-admin:sv:setduty",0,false)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        TriggerServerEvent("qb-admin:sv:setduty",0,false)
    end
end)

local function isAdminOnDuty()
    local isduty = false
    QBCore.Functions.TriggerCallback('qb-admin:sv:checkduty', function(bool)
        isduty = bool
    end)
    return isduty
end

exports('isAdminOnDuty', function() return isAdminOnDuty() end)