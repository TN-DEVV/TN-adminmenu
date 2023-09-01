local QBCore = exports['qb-core']:GetCoreObject()
local state = false
local adminMarker = {}
local adminData = {}
local myCoords = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('onPlayerLoad', function(playerAdminMarker)
        adminMarker = playerAdminMarker
    end)
end)


RegisterNetEvent('philip-adminduty:AdminDuty', function()
    state = not state
    if state then
        QBCore.Functions.TriggerCallback('philip-adminduty:checkpermission', function(num)
            if num == 1 then
                local model = "akaza"

                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(20)
                end

                SetPlayerModel(PlayerId(), model)
                SetModelAsNoLongerNeeded(model)
                QBCore.Functions.Notify(Lang[Config.Lang].dutyOn, 'primary', 2500)
                TriggerServerEvent("philip-adminduty:setduty",1,true)
            elseif num == 2 then 
                local model = "akaza"

                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(20)
                end
        
                SetPlayerModel(PlayerId(), model)
                SetModelAsNoLongerNeeded(model)
                QBCore.Functions.Notify(Lang[Config.Lang].dutyOn, 'primary', 2500)
                TriggerServerEvent("philip-adminduty:setduty",1,true)
            elseif num == 3 then 
                local model = "akaza"

                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(20)
                end

                SetPlayerModel(PlayerId(), model)
                SetModelAsNoLongerNeeded(model)
                QBCore.Functions.Notify(Lang[Config.Lang].dutyOn, 'primary', 2500)
                TriggerServerEvent("philip-adminduty:setduty",1,true)
            end
        end)
        
    else
        TriggerServerEvent("philip-adminduty:setduty",0,true)
        TriggerServerEvent("qb-clothes:loadPlayerSkin")
        QBCore.Functions.Notify(Lang[Config.Lang].dutyOff, 'primary', 2500)
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

RegisterNetEvent('philip-adminduty:AdminTag', function(data)
    adminMarker = data
end)

CreateThread(function()
    while true do
        local tempAdminData = {}
        myCoords = GetEntityCoords(PlayerPedId())

        for k, v in pairs(adminMarker) do
            
            if v then
                local ped = GetPlayerPed(GetPlayerFromServerId(k))
                tempAdminData[#tempAdminData + 1] = { k, ped}
            end
        end

        adminData = tempAdminData
        Wait(1000)
    end
end)


CreateThread(function() -- Don't change here anything unless you know what you doing!!
    while true do
        if not HasStreamedTextureDictLoaded("logo") then
            RequestStreamedTextureDict("logo", true)
            while not HasStreamedTextureDictLoaded("logo") do
                Wait(1)
            end
        end
        while adminData[1] do
            for i=1, #adminData do
                local target = GetEntityCoords(adminData[i][2])
                if #(myCoords - target) <= Config.DrawDistance then
                    DrawMarker(9, target + vector3(0,0,Config.AdminLogoHeight), 0.0, 0.0, 0.0, 90.0,  0.0, 0.0, 1.0, 0.7, 0.5, 255, 255, 255, 255, Config.LogoBouncing, Config.LogoMovingWithCamera, 2, Config.LogoSpin, "logo", Config.AdminLogo, false)
                end
            end

            Wait(0)
        end
        Wait(1000)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent("philip-adminduty:setduty",0,false)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    TriggerServerEvent("philip-adminduty:setduty",0,false)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        TriggerServerEvent("philip-adminduty:setduty",0,false)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        TriggerServerEvent("philip-adminduty:setduty",0,false)
    end
end)