local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-admin:client:bringTp')
AddEventHandler('qb-admin:client:bringTp', function(coords)
    local ped = GetPlayerPed(-1)
    SetEntityCoords(ped, coords.x, coords.y, coords.z)
end)