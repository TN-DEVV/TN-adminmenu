local QBCore = exports['qb-core']:GetCoreObject()
local savedCoords = {}

QBCore.Commands.Add('bring', 'Bring a player to you(only Admin)', { { name = 'id', help = 'ID player' }, }, true, function(source, args)
    if args[1] then
        local src = source
        local admin = GetPlayerPed(src)
        local coords = GetEntityCoords(admin) --Admin coords
        local target = GetPlayerPed(tonumber(args[1])) --Player ped
        SetEntityCoords(target, coords)
        savedCoords[tonumber(args[1])]= GetEntityCoords(target) --Save player coords
    end
end, 'admin')

QBCore.Commands.Add('bringback', 'Bring back a player(only Admin)', { { name = 'id', help = 'ID player' }, }, true, function(source, args)
    if args[1] then
        local src = source
        local coords = savedCoords[tonumber(args[1])] --Player saved coords
        local target = GetPlayerPed(tonumber(args[1])) --Player ped
        SetEntityCoords(target, coords)
    end
end, 'admin')

