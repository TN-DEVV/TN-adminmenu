local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('playerDropped', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local number = 0
    MySQL.update('UPDATE players SET adminduty = ? WHERE citizenid = ?',{number, citizenid})
end)

local function isAdminOnDuty(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    local number = MySQL.Sync.fetchScalar('SELECT adminduty FROM players WHERE citizenid = ?', { citizenid })
    if number == 1 then
        return true
    else
        return false
    end
end

QBCore.Functions.CreateCallback('qb-admin:sv:checkpermission', function(source, cb)
    if QBCore.Functions.HasPermission(source, 'god') then
        cb(1)
    elseif QBCore.Functions.HasPermission(source, 'admin') then
        cb(2)
    elseif QBCore.Functions.HasPermission(source, 'user') then
        cb(3)
    else
        cb(4)
    end
end)

QBCore.Functions.CreateCallback('qb-admin:sv:checkduty', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    local number = MySQL.Sync.fetchScalar('SELECT adminduty FROM players WHERE citizenid = ?', { citizenid })
    if number == 1 then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('qb-admin:sv:setduty', function(num,bool)
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

exports('isAdminOnDuty', function(source) return isAdminOnDuty(source) end)