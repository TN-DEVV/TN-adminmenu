local savedCoords = {}
QBCore.Commands.Add('blips', Lang:t("commands.blips_for_player"), {}, false, function(source)
    local src = source
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Use Command', 'green', '('..GetPlayerName(source)..' | ID: '..source..') command :/blips ', false) 
    TriggerClientEvent('qb-admin:client:toggleBlips', src)
end, 'admin')

QBCore.Commands.Add('coords', Lang:t("commands.coords_dev_command"), {}, false, function(source)
    local src = source
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Use Command', 'green', '('..GetPlayerName(source)..' | ID: '..source..') command :/coords ', false) 
    TriggerClientEvent('qb-admin:client:ToggleCoords', src)
end, 'god')

QBCore.Commands.Add('names', Lang:t("commands.player_name_overhead"), {}, false, function(source)
    local src = source
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Use Command', 'green', '('..GetPlayerName(source)..' | ID: '..source..') command :/names ', false) 
    TriggerClientEvent('qb-admin:client:toggleNames', src)
end, 'admin')

QBCore.Commands.Add('noclip', Lang:t("commands.toogle_noclip"), {}, false, function(source)
    local src = source
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Use Command', 'green', '('..GetPlayerName(source)..' | ID: '..source..') command :/noclip ', false) 
    if not (QBCore.Functions.HasPermission(src, commands['noclip'])) then NoPerms(src) return end

    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local number = MySQL.Sync.fetchScalar('SELECT adminduty FROM players WHERE citizenid = ?', { citizenid })
    if number == 1 then
        TriggerClientEvent('qb-admin:client:ToggleNoClip', src)
    else
        TriggerClientEvent('QBCore:Notify', source, "tu doit etre on duty", 'error')
    end
end)

QBCore.Commands.Add('admincar', Lang:t("commands.save_vehicle_garage"), {}, false, function(source)
    local src = source
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Use Command', 'green', '('..GetPlayerName(source)..' | ID: '..source..') command :/admincar ', false) 
    if not (QBCore.Functions.HasPermission(src, events['savecar'])) then NoPerms(src) return end
    TriggerClientEvent('qb-admin:client:SaveCar', src)
end)

QBCore.Commands.Add('announce', Lang:t("commands.make_announcement"), {}, false, function(source, args)
    if not (QBCore.Functions.HasPermission(source, commands['announce'])) then NoPerms(source) return end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Use Command', 'green', '('..GetPlayerName(source)..' | ID: '..source..') command :/admincar ', false) 
    local msg = table.concat(args, ' ')
    if msg == '' then return end
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message announce"><i class="fas fa-shield-alt"></i> <b><span style="color: #e3a71b">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;"></span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
        args = {"Announcement", msg}
    })
end)

QBCore.Commands.Add('bring', Lang:t("commands.bring"), { { name = 'id', help = 'ID player' }, }, true, function(source, args)
    if args[1] then
        local src = source
        local admin = GetPlayerPed(src)
        local coords = GetEntityCoords(admin) --Admin coords
        local target = GetPlayerPed(tonumber(args[1])) --Player ped
        SetEntityCoords(target, coords)
        savedCoords[tonumber(args[1])]= GetEntityCoords(target) --Save player coords
    end
end, 'admin')

QBCore.Commands.Add('bringback', Lang:t("commands.bringback"), { { name = 'id', help = 'ID player' }, }, true, function(source, args)
    if args[1] then
        local src = source
        local coords = savedCoords[tonumber(args[1])] --Player saved coords
        local target = GetPlayerPed(tonumber(args[1])) --Player ped
        SetEntityCoords(target, coords)
    end
end, 'admin')

QBCore.Commands.Add('bringall', Lang:t("commands.bringall"), {}, false, function(source)
    local src = source
    if not (QBCore.Functions.HasPermission(source, commands['bringall'])) then NoPerms(src) return end
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin) --Admin coords
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v then
            local target = GetPlayerPed(v.PlayerData.source) --Player ped
            SetEntityCoords(target, coords)
        end
    end
end)

local function getnumplayers()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v then
            amount += 1
        end
    end
    return amount
end

local function getnumstaff()
    MySQL.Async.fetchScalar('SELECT COUNT(adminduty) FROM players WHERE adminduty = ?',{ 1 }, function(result)
        return result
    end)
end

QBCore.Commands.Add('admin', Lang:t("commands.open_admin"), {}, false, function(source)
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Use Command', 'green', '('..GetPlayerName(source)..' | ID: '..source..') command :/admin ', false)    
    if not (QBCore.Functions.HasPermission(source, events['usemenu'])) then NoPerms(source) return end
    local src = source
    MySQL.Async.fetchScalar('SELECT COUNT(adminduty) FROM players WHERE adminduty = ?',{ 1 }, function(result)        
        local numplayers = getnumplayers()
        local numstaff = result
        TriggerClientEvent("qb-admin:client:openMenu", source, numplayers, numstaff)
    end)
end)

QBCore.Commands.Add('maxmods', Lang:t("desc.max_mod_desc"), {}, false, function(source)
    if not (QBCore.Functions.HasPermission(source, events['maxmods'])) then NoPerms(source) return end
    local src = source
    TriggerClientEvent('qb-admin:client:maxmodVehicle', src)
end)

QBCore.Commands.Add("skin", "open clothes menu", {{name='id', help='Id of the Player (empty for yourself)'}}, false, function(source, args)
    local target = tonumber(args[1])
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Use Command', 'green', '('..GetPlayerName(source)..' | ID: '..source..') command :/admincar ', false) 
    if target == nil then
    	TriggerClientEvent("qb-clothing:client:openMenu", source)
    else
        local trg = QBCore.Functions.GetPlayer(target)
        if trg ~= nil then
            TriggerClientEvent("qb-clothing:client:openMenu", target)
        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
        end
    end
end, "admin")

--[[QBCore.Commands.Add('report', Lang:t("info.admin_report"), {{name='message', help='Message'}}, true, function(source, args)
    local src = source
    local msg = table.concat(args, ' ')
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerEvent('qb-admin:server:SendReport', GetPlayerName(src), src, msg)
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report', 'green', '**'..GetPlayerName(source)..'** (CitizenID: '..Player.PlayerData.citizenid..' | ID: '..source..') **Report:** ' ..msg, false)
end)]]

QBCore.Commands.Add('staffchat', Lang:t("commands.staffchat_message"), {{name='message', help='Message'}}, true, function(source, args)
    if not (QBCore.Functions.HasPermission(source, commands['staffchat'])) then NoPerms(source) return end

    local msg = table.concat(args, ' ')
    TriggerEvent('qb-admin:server:Staffchat:addMessage', GetPlayerName(source), msg)
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Use Command', 'green', '('..GetPlayerName(source)..' | ID: '..source..') command :/staffchat '..msg, false) 

end)

QBCore.Commands.Add('s', Lang:t("commands.staffchat_message"), {{name='message', help='Message'}}, true, function(source, args)
    if not (QBCore.Functions.HasPermission(source, commands['staffchat'])) then NoPerms(source) return end

    local msg = table.concat(args, ' ')
    TriggerEvent('qb-admin:server:Staffchat:addMessage', GetPlayerName(source), msg)
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Use Command', 'green', '('..GetPlayerName(source)..' | ID: '..source..') command :/staffchat '..msg, false) 
end)


QBCore.Commands.Add('reportr', Lang:t("commands.reply_to_report"), {{name='id', help='Player'}, {name = 'message', help = 'Message to respond with'}}, false, function(source, args)
    local src = source

    if not (QBCore.Functions.HasPermission(src, events['reports'])) then NoPerms(src) return end

    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if msg == '' then return end
    if not OtherPlayer then return TriggerClientEvent('QBCore:Notify', src, 'Player is not online', 'error') end
    TriggerClientEvent('chat:addMessage', playerId, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Admin Response', msg}
    })
    TriggerClientEvent('chat:addMessage', src, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Report Response ('..playerId..')', msg}
    })
    TriggerClientEvent('QBCore:Notify', src, 'Reply Sent')
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report Reply', 'red', '**'..GetPlayerName(src)..'** replied on: **'..OtherPlayer.PlayerData.name.. ' **(ID: '..OtherPlayer.PlayerData.source..') **Message:** ' ..msg, false)
end)

QBCore.Commands.Add('setmodel', Lang:t("commands.change_ped_model"), {{name='model', help='Name of the model'}, {name='id', help='Id of the Player (empty for yourself)'}}, false, function(source, args)
    if not (QBCore.Functions.HasPermission(source, commands['setmodel'])) then NoPerms(source) return end

    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= '' then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.failed_set_model"), 'error')
    end
end)

--- Only really works with QBCore permissions for now.
QBCore.Commands.Add('reporttoggle', Lang:t("commands.report_toggle"), {}, false, function(source)
    local src = source

    if not (QBCore.Functions.HasPermission(src, commands['reporttoggle'])) then NoPerms(src) return end

    QBCore.Functions.ToggleOptin(src)
    if QBCore.Functions.IsOptin(src) then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.receive_reports"), 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_receive_report"), 'error')
    end
end)

QBCore.Commands.Add('kickall', Lang:t("commands.kick_all"), {}, false, function(source, args)
    local src = source

    if not (QBCore.Functions.HasPermission(src, commands['kickall'])) then NoPerms(src) return end

    local reason = table.concat(args, ' ')
    if reason and reason ~= '' then
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player then
                DropPlayer(Player.PlayerData.source, reason)
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("info.no_reason_specified"), 'error')
    end
end)

QBCore.Commands.Add('setammo', Lang:t("commands.ammo_amount_set"), {{name='amount', help='Amount of bullets, for example: 20'}, {name='weapon', help='Name of the weapen, for example: WEAPON_VINTAGEPISTOL'}}, false, function(source, args)
    local src = source
    local weapon = args[2]
    local amount = tonumber(args[1])

    if not (QBCore.Functions.HasPermission(src, commands['setammo'])) then NoPerms(src) return end

    if weapon ~= nil then
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
    else
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, 'current', amount)
    end
end)

QBCore.Commands.Add('warn', Lang:t("commands.warn_a_player"), {{name='ID', help='Player'}, {name='Reason', help='Mention a reason'}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local myName = senderPlayer.PlayerData.name
    local warnId = 'WARN-'..math.random(1111, 9999)
    if targetPlayer ~= nil then
		TriggerClientEvent('chat:addMessage', targetPlayer.PlayerData.source, { args = { "SYSTEM", Lang:t("info.warning_chat_message")..GetPlayerName(source).."," .. Lang:t("info.reason") .. ": "..msg }, color = 255, 0, 0 })
		TriggerClientEvent('chat:addMessage', source, { args = { "SYSTEM", Lang:t("info.warning_staff_message")..GetPlayerName(targetPlayer.PlayerData.source)..", for: "..msg }, color = 255, 0, 0 })
        MySQL.Async.insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)', {
            senderPlayer.PlayerData.license,
            targetPlayer.PlayerData.license,
            msg,
            warnId
        })
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
    end
end, 'admin')

QBCore.Commands.Add('checkwarns', Lang:t("commands.check_player_warning"), {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local result = MySQL.Sync.fetchAll('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' has '..tablelength(result)..' warnings!')
    else
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local warnings = MySQL.Sync.fetchAll('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        local selectedWarning = tonumber(args[2])
        if warnings[selectedWarning] ~= nil then
            local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
            TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' has been warned by '..sender.PlayerData.name..', Reason: '..warnings[selectedWarning].reason)
        end
    end
end, 'admin')

QBCore.Commands.Add('delwarn', Lang:t("commands.delete_player_warning"), {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local warnings = MySQL.Sync.fetchAll('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
    local selectedWarning = tonumber(args[2])
    if warnings[selectedWarning] ~= nil then
        local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
        TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', 'You have deleted warning ('..selectedWarning..') , Reason: '..warnings[selectedWarning].reason)
        MySQL.Async.execute('DELETE FROM player_warns WHERE warnId = ?', { warnings[selectedWarning].warnId })
    end
end, 'admin')