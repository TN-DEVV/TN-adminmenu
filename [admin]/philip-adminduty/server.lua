local QBCore = exports['qb-core']:GetCoreObject()
local adminMarker = {}


QBCore.Commands.Add('atag', 'Admin Tag', {}, false, function(source, args)
    local src = source

    if adminMarker[src] then
        adminMarker[src] = nil
    else
        adminMarker[src] = true
    end
    TriggerClientEvent('philip-adminduty:AdminTag', -1, adminMarker)
end, 'admin')

--[[QBCore.Commands.Add('duty', 'Adminduty', {}, false, function(source, args)
    local src = source
    TriggerClientEvent('philip-adminduty:AdminDuty', src)
    QBCore.Functions.ToggleOptin(src)
end, 'admin')]]

AddEventHandler('playerDropped', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local number = 0
    if adminMarker[src] then
        adminMarker[src] = nil
    end
    TriggerClientEvent('philip-adminduty:AdminTag', -1, adminMarker)
    MySQL.update('UPDATE players SET adminduty = ? WHERE citizenid = ?',{number, citizenid})
end)

QBCore.Functions.CreateCallback('philip-adminduty:onPlayerLoad', function(source, cb)
    cb(adminMarker)
end)

QBCore.Functions.CreateCallback('philip-adminduty:checkpermission', function(source, cb)
    if QBCore.Functions.HasPermission(source, 'god') then
        cb(1)
        --print('god')
    elseif QBCore.Functions.HasPermission(source, 'admin') then
        cb(2)
        --print('admin')
    elseif QBCore.Functions.HasPermission(source, 'user') then
        cb(3)
       -- print('user')
    else
        cb(4)
       -- print('tahchaa')
    end
end)

QBCore.Functions.CreateCallback('philip-adminduty:checkduty', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    local number = MySQL.Sync.fetchScalar('SELECT adminduty FROM players WHERE citizenid = ?', { citizenid })
    if number == 1 then
        cb(false)
    else
        cb(true)
    end
end)

RegisterNetEvent('philip-adminduty:setduty', function(num,bool)
    local src = source
    local number = num
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    MySQL.update('UPDATE players SET adminduty = ? WHERE citizenid = ?',{number, citizenid})
    if bool then
        if number == 1 then
            TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - %s",
            GetPlayerName(src), Player.PlayerData.citizenid, src, "toggle duty to true"))
        else
            TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'red', string.format("**%s** (CitizenID: %s | ID: %s) - %s",
            GetPlayerName(src), Player.PlayerData.citizenid, src, "toggle duty to false"))
        end
    end
end)

function CreateLog(id, source, target)
    local Player = QBCore.Functions.GetPlayer(source)
    local Target = QBCore.Functions.GetPlayer(target)
    local Log = {
        'Used **kill** on',
        'Used **revive** on',
        'Used **freeze** on',
        'Used **spectate** on',
        'Used **goto** on',
        'Used **bring** on',
        'Used **into vehicle** on',
        'Used **clothing** on',
    }
    if not Log[id] then TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', 'Tried to create a log which doesn\'t exist. #'..id) print('Tried to create a log which doesn\'t exist. #'..id) return end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - %s **%s** (CitizenID: %s | ID: %s) [Log #%s]",
    GetPlayerName(source), Player.PlayerData.citizenid, source, Log[id], GetPlayerName(target), Target.PlayerData.citizenid, target, id))
end