RegisterNetEvent('qb-admin:server:name', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local Player = QBCore.Functions.GetPlayer(src)
    local NewInfo = {}

    if not (QBCore.Functions.HasPermission(src, events['playerinformation'])) then return end
    if not type_check({tostring(Input), 'string'}) then return end
    if not TargetInfo then return end

    for token in string.gmatch(Input, "[^%s]+") do
        NewInfo[#NewInfo + 1] = token
    end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) name to %s %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, NewInfo[1], NewInfo[2]))
    TargetInfo.PlayerData.charinfo.firstname = NewInfo[1]
    if next(NewInfo, 1) then TargetInfo.PlayerData.charinfo.lastname = NewInfo[2] end
    QBCore.Player.CheckPlayerData(Target.id, TargetInfo.PlayerData)
end)

RegisterNetEvent('qb-admin:server:food', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local Player = QBCore.Functions.GetPlayer(src)

    if not (QBCore.Functions.HasPermission(src, events['playerinformation']) ) then return end
    if not type_check({tonumber(Input), 'number'}) then return end
    if not TargetInfo then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) hunger to %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, Input))
    TargetInfo.Functions.SetMetaData('hunger', tonumber(Input))
end)

RegisterNetEvent('qb-admin:server:water', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local Player = QBCore.Functions.GetPlayer(src)

    if not (QBCore.Functions.HasPermission(src, events['playerinformation']) ) then return end
    if not type_check({tonumber(Input), 'number'}) then return end
    if not TargetInfo then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) thirst to %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, Input))
    TargetInfo.Functions.SetMetaData('thirst', tonumber(Input))
end)

RegisterNetEvent('qb-admin:server:stress', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local Player = QBCore.Functions.GetPlayer(src)

    if not (QBCore.Functions.HasPermission(src, events['playerinformation']) ) then return end
    if not type_check({tonumber(Input), 'number'}) then return end
    if not TargetInfo then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) stress to %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, Input))
    TargetInfo.Functions.SetMetaData('stress', tonumber(Input))
end)

RegisterNetEvent('qb-admin:server:armor', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local Player = QBCore.Functions.GetPlayer(src)

    if not (QBCore.Functions.HasPermission(src, events['playerinformation']) ) then return end
    if not type_check({tonumber(Input), 'number'}) then return end
    if not TargetInfo then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) armor to %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, Input))
    TargetInfo.Functions.SetMetaData('armor', tonumber(Input))
end)

RegisterNetEvent('qb-admin:server:phone', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local Player = QBCore.Functions.GetPlayer(src)

    if not (QBCore.Functions.HasPermission(src, events['playerinformation']) ) then return end
    if not type_check({tostring(Input), 'string'}) then return end
    if not TargetInfo then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) phone number to %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, Input))
    TargetInfo.PlayerData.charinfo.phone = Input
    QBCore.Player.CheckPlayerData(Target.id, TargetInfo.PlayerData)
end)

RegisterNetEvent('qb-admin:server:craftingrep', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local Player = QBCore.Functions.GetPlayer(src)

    if not (QBCore.Functions.HasPermission(src, events['playerinformation']) ) then return end
    if not type_check({tonumber(Input), 'number'}) then return end
    if not TargetInfo then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) craftingrep to %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, Input))
    TargetInfo.Functions.SetMetaData('craftingrep', tonumber(Input))
end)

RegisterNetEvent('qb-admin:server:dealerrep', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local Player = QBCore.Functions.GetPlayer(src)

    if not (QBCore.Functions.HasPermission(src, events['playerinformation']) ) then return end
    if not type_check({tonumber(Input), 'number'}) then return end
    if not TargetInfo then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) dealerrep to %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, Input))
    TargetInfo.Functions.SetMetaData('dealerrep', tonumber(Input))
end)

RegisterNetEvent('qb-admin:server:cash', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local Player = QBCore.Functions.GetPlayer(src)

    if not (QBCore.Functions.HasPermission(src, events['playerinformation']) ) then return end
    if not type_check({tonumber(Input), 'number'}) then return end
    if not TargetInfo then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) cash to %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, Input))
    TargetInfo.PlayerData.money['cash'] = tonumber(Input)
    QBCore.Player.CheckPlayerData(Target.id, TargetInfo.PlayerData)
end)

RegisterNetEvent('qb-admin:server:bank', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local Player = QBCore.Functions.GetPlayer(src)

    if not (QBCore.Functions.HasPermission(src, events['playerinformation']) ) then return end
    if not type_check({tonumber(Input), 'number'}) then return end
    if not TargetInfo then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) bank to %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, Input))
    TargetInfo.PlayerData.money['bank'] = tonumber(Input)
    QBCore.Player.CheckPlayerData(Target.id, TargetInfo.PlayerData)
end)

RegisterNetEvent('qb-admin:server:job', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local NewInfo = {}
    local Player = QBCore.Functions.GetPlayer(src)

    if not (QBCore.Functions.HasPermission(src, events['playerinformation']) ) then return end
    if not type_check({tostring(Input), 'string'}) then return end
    if not TargetInfo then return end

    for token in string.gmatch(Input, "[^%s]+") do
        NewInfo[#NewInfo + 1] = token
    end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) job to %s %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, NewInfo[1], NewInfo[2]))
    if next(NewInfo, 1) then TargetInfo.Functions.SetJob(NewInfo[1], tonumber(NewInfo[2])) return end
    TargetInfo.Functions.SetJob(NewInfo[1])
end)

RegisterNetEvent('qb-admin:server:gang', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local NewInfo = {}
    local Player = QBCore.Functions.GetPlayer(src)

    if not (QBCore.Functions.HasPermission(src, events['playerinformation']) ) then return end
    if not type_check({tostring(Input), 'string'}) then return end
    if not TargetInfo then return end

    for token in string.gmatch(Input, "[^%s]+") do
        NewInfo[#NewInfo + 1] = token
    end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) gang to %s %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, NewInfo[1], NewInfo[2]))
    if next(NewInfo, 1) then TargetInfo.Functions.SetGang(NewInfo[1], tonumber(NewInfo[2])) return end
    TargetInfo.Functions.SetGang(NewInfo[1])
end)

RegisterNetEvent('qb-admin:server:radio', function(Target, Input)
    local src = source
    local TargetInfo = QBCore.Functions.GetPlayer(Target.id)
    local Player = QBCore.Functions.GetPlayer(src)

    if not (QBCore.Functions.HasPermission(src, events['playerinformation']) ) then return end
    if not type_check({tonumber(Input), 'number'}) then return end
    if not TargetInfo then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'green', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) radio to %s",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(Target.id), TargetInfo.PlayerData.citizenid, Target.id, Input))
    exports['pma-voice']:setPlayerRadio(Target.id, tonumber(Input))
end)
