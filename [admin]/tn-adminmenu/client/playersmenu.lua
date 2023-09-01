local soundname = 'Unknown'
local soundrange = 0
local soundvolume = 0
local itemname = 'Unknown'
local itemamount = 0
local banreason = 'Unknown'
local banlength = nil
local kickreason = 'Unknown'
local selectedgroup = nil

BanMenu:AddButton({
    icon = '',
    label = Lang:t("info.reason"),
    value = "reason",
    description = Lang:t("desc.ban_reason"),
    select = function()
        local dialog = exports['qb-input']:ShowInput({
            header = Lang:t("desc.ban_reason"),
            submitText = "Confirm",
            inputs = {
                {
                    text = "VDM",
                    name = "reason",
                    type = "text",
                    isRequired = true
                }
            }
        })
        if dialog then
            banreason = dialog.reason
        end
    end
})
BanMenu:AddSlider({
    icon = '⏲️',
    label = Lang:t("info.length"),
    value = '3600',
    values = {{
        label = Lang:t("time.1hour"),
        value = '3600',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.6hour"),
        value ='21600',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.12hour"),
        value = '43200',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.1day"),
        value = '86400',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.3day"),
        value = '259200',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.1week"),
        value = '604800',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.1month"),
        value = '2678400',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.3month"),
        value = '8035200',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.6month"),
        value = '16070400',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.1year"),
        value = '32140800',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.permenent"),
        value = '99999999999',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.self"),
        value = "self",
        description = Lang:t("time.ban_length")
    }},
    select = function(_, newValue)
        if newValue == "self" then
            local dialog = exports['qb-input']:ShowInput({
                header = 'Ban Length',
                submitText = "Confirm",
                inputs = {
                    {
                        text = "20",
                        name = "lenght",
                        type = "number",
                        isRequired = true
                    }
                }
            })
            if dialog then
                banlength = dialog.lenght
            end
        else
            banlength = newValue
        end
    end
})
BanMenu:AddButton({
    icon = '',
    label = Lang:t("info.confirm"),
    value = "ban",
    description = Lang:t("desc.confirm_ban"),
    select = function()
        if banreason ~= 'Unknown' and banlength ~= nil then
            TriggerServerEvent('qb-admin:server:ban', SelectedPlayer, banlength, banreason)
            banreason = 'Unknown'
            banlength = nil
        else
            QBCore.Functions.Notify(Lang:t("error.invalid_reason_length_ban"), 'error')
        end
    end
})

KickMenu:AddButton({
    icon = '',
    label = Lang:t("info.reason"),
    value = "reason",
    description = Lang:t("desc.kick_reason"),
    select = function()
        local dialog = exports['qb-input']:ShowInput({
            header = Lang:t("desc.kick_reason"),
            submitText = "Confirm",
            inputs = {
                {
                    text = "VDM",
                    name = "reason",
                    type = "text",
                    isRequired = true
                }
            }
        })
        if dialog then
            kickreason = dialog.reason
        end
    end
})
KickMenu:AddButton({
    icon = '',
    label = Lang:t("info.confirm"),
    value = "kick",
    description = Lang:t("desc.confirm_kick"),
    select = function()
        if kickreason ~= 'Unknown' then
            TriggerServerEvent('qb-admin:server:kick', SelectedPlayer, kickreason)
            kickreason = 'Unknown'
        else
            QBCore.Functions.Notify(Lang:t("error.missing_reason"), 'error')
        end
    end
})

PermsMenu:AddSlider({
    icon = '',
    label = 'Group',
    value = 'user',
    values = {{
        label = 'User',
        value = 'user',
        description = 'Group'
    }, {
        label = 'Admin',
        value = 'admin',
        description = 'Group'
    }, {
        label = 'God',
        value = 'god',
        description = 'Group'
    }},
    change = function(_, newValue, _)
        local vcal = newValue
        if vcal == 1 then
            selectedgroup = {}
            selectedgroup[#selectedgroup+1] = {rank = "user", label = "User"}
        elseif vcal == 2 then
            selectedgroup = {}
            selectedgroup[#selectedgroup+1] = {rank = "admin", label = "Admin"}
        elseif vcal == 3 then
            selectedgroup = {}
            selectedgroup[#selectedgroup+1] = {rank = "god", label = "God"}
        end
    end
})

PermsMenu:AddButton({
    icon = '',
    label = Lang:t("info.confirm"),
    value = "giveperms",
    description = 'Give the permission group',
    select = function(_)
        if selectedgroup ~= 'Unknown' then
            TriggerServerEvent('qb-admin:server:setPermissions', SelectedPlayer.id, selectedgroup)
            QBCore.Functions.Notify(Lang:t("success.changed_perm"), 'success')
            selectedgroup = 'Unknown'
        else
            QBCore.Functions.Notify(Lang:t("error.changed_perm_failed"), 'error')
        end
    end
})

GiveMoneyMenu:AddSlider({
    icon = '',
    label = Lang:t("info.money"),
    values = {{
        label = Lang:t("menu.money_bank"),
        value = 'bank',
        description = Lang:t("desc.money_bank")
    }, {
        label = Lang:t("menu.money_cash"),
        value = 'cash',
        description = Lang:t("desc.money_cash")
    }},
    select = function(_, newValue)
        if newValue == 'bank' then
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("desc.moneybank"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "20000",
                        name = "bank",
                        type = "text",
                        isRequired = true
                    }
                }
            })
            if dialog then
                TriggerServerEvent('QBCore:CallCommand', "givemoney", {SelectedPlayer.id, 'bank', tonumber(dialog.bank) })
            end
        else
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("desc.moneycash"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "20000",
                        name = "cash",
                        type = "text",
                        isRequired = true
                    }
                }
            })
            if dialog then
                TriggerServerEvent('QBCore:CallCommand', "givemoney", {SelectedPlayer.id, 'cash', tonumber(dialog.cash) })
            end
        end
    end
})

GiveItemMenu:AddSlider({
    icon = '',
    label = Lang:t("info.item"),
    values = {{
        label = Lang:t("menu.item_list"),
        value = '',
        description = Lang:t("desc.item_list")
    }, {
        label = Lang:t("menu.item_self"),
        value = 'Self',
        description = Lang:t("desc.item_self")
    }},
    select = function(_, newValue)
        if newValue == 'Self' then
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("desc.item_self"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "Lockpick",
                        name = "item",
                        type = "text",
                        isRequired = true
                    }
                }
            })
            if dialog then
                itemname = dialog.item
            end
        else
            local ItemMenu = {
                {
                    header = Lang:t('info.item'),
                    isMenuHeader = true
                }
            }

            for _, v in pairs(QBCore.Shared.Items) do
                ItemMenu[#ItemMenu + 1] = {
                    header = v['label'],
                    txt = "",
                    params = {
                        event = "qb-admin:client:openItemMenu",
                        args = {
                            name = v['name']
                        }
                    }
                }
            end

            exports['qb-menu']:openMenu(ItemMenu)
        end
    end
})
GiveItemMenu:AddButton({
    icon = '',
    label = Lang:t("info.amount"),
    value = "reason",
    description = Lang:t("desc.amount"),
    select = function()
        local dialog = exports['qb-input']:ShowInput({
            header = Lang:t("desc.amount"),
            submitText = "Confirm",
            inputs = {
                {
                    text = "5421",
                    name = "amount",
                    type = "number",
                    isRequired = true
                }
            }
        })
        if dialog then
            itemamount = dialog.amount
        end
    end
})
GiveItemMenu:AddButton({
    icon = '',
    label = Lang:t("info.confirm"),
    value = "kick",
    description = Lang:t("desc.confirm_kick"),
    select = function()
        if itemname ~= 'Unknown' and itemamount ~= 0 then
            TriggerServerEvent('QBCore:CallCommand', "giveitem", {SelectedPlayer.id, itemname, itemamount})
            itemname = 'Unknown'
            itemamount = 0
        else
            QBCore.Functions.Notify(Lang:t("error.give_item"), 'error')
        end
    end
})

SoundMenu:AddButton({
    icon = '',
    label = Lang:t("info.sound"),
    value = "reason",
    description = Lang:t("desc.sound"),
    select = function()
        TriggerServerEvent('qb-admin:server:getsounds')
    end
})
SoundMenu:AddSlider({
    icon = '',
    label = Lang:t("volume.volume"),
    value = '0.5',
    values = {{
        label = Lang:t("volume.01"),
        value = 0.1,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.02"),
        value = 0.2,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.03"),
        value = 0.3,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.04"),
        value = 0.4,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.05"),
        value = 0.5,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.06"),
        value = 0.6,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.07"),
        value = 0.7,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.08"),
        value = 0.8,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.09"),
        value = 0.9,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.1.0"),
        value = 1.0,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.self"),
        value = "self",
        description = Lang:t("volume.volume")
    }},
    description = Lang:t("volume.volume_desc"),
    select = function(_, newValue)
        if newValue == "self" then
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("volume.volume_desc"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "0.6",
                        name = "volume",
                        type = "text",
                        isRequired = true
                    }
                }
            })
            if dialog then
                soundvolume = tonumber(dialog.volume)
            end
        else
            soundvolume = newValue
        end
    end
})
SoundMenu:AddSlider({
    icon = '',
    label = Lang:t("volume.radius"),
    value = '0.5',
    values = {{
        label = Lang:t("volume.10"),
        value = 10,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.20"),
        value = 20,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.30"),
        value = 30,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.40"),
        value = 40,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.50"),
        value = 50,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.60"),
        value = 60,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.70"),
        value = 70,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.80"),
        value = 80,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.90"),
        value = 90,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.100"),
        value = 100,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.self"),
        value = "self",
        description = Lang:t("volume.radius")
    }},
    description = Lang:t("volume.radius_desc"),
    select = function(_, newValue)
        if newValue == "self" then
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("volume.radius_desc"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "30",
                        name = "volume",
                        type = "number",
                        isRequired = true
                    }
                }
            })
            if dialog then
                soundrange = tonumber(dialog.volume)
            end
        else
            soundrange = newValue
        end
    end
})
SoundMenu:AddButton({
    icon = '',
    label = Lang:t("info.confirm_play"),
    value = '',
    description = Lang:t("desc.confirm_play"),
    select = function()
        if soundname ~= 'Unknown' and soundvolume ~= 0 then
            TriggerServerEvent('InteractSound_SV:PlayOnOne', SelectedPlayer.id, soundname, soundvolume)
        else
            QBCore.Functions.Notify(Lang:t("error.give_item"), 'error')
        end
    end
})
SoundMenu:AddButton({
    icon = '',
    label = Lang:t("info.confirm_play_radius"),
    value = '',
    description = Lang:t("desc.confirm_play_radius"),
    select = function()
        if soundname ~= 'Unknown' and soundvolume ~= 0 and soundrange ~= 0 then
            TriggerServerEvent('qb-admin:server:playsound', SelectedPlayer.id, soundname, soundvolume, soundrange)
        else
            QBCore.Functions.Notify(Lang:t("error.give_item"), 'error')
        end
    end
})

function OpenPlayerMenus()
    PlayerDetailMenu:ClearItems()
    MenuV:OpenMenu(PlayerDetailMenu)
    local PlayersButton1 = PlayerDetailMenu:AddButton({
        icon = '🛠️',
        label = Lang:t("menu.player_general"),
        value = PlayerGeneralMenu,
        description = Lang:t("desc.admin_options_desc")
    })
    PlayersButton1:On('select', function()
        PlayerGeneralMenu:ClearItems()
        local elements = {
            [1] = {
                icon = '➡️',
                label = Lang:t("info.goto"),
                value = "goto",
                description = Lang:t("info.goto") .. " " .. SelectedPlayer.name .. Lang:t("info.position")
            },
            [2] = {
                icon = '⬅️',
                label = Lang:t("menu.bring"),
                value = "bring",
                description = Lang:t("menu.bring") .. " " .. SelectedPlayer.name .. " " .. Lang:t("info.your_position")
            },
            [3] = {
                icon = '🏥',
                label = Lang:t("menu.revive"),
                value = "revive",
                description = Lang:t("menu.revive") .. " " .. SelectedPlayer.name
            },
            [4] = {
                icon = '💀',
                label = Lang:t("menu.kill"),
                value = "kill",
                description = Lang:t("menu.kill").. " " .. SelectedPlayer.name
            },
            [5] = {
                icon = '👀',
                label = Lang:t("menu.spectate"),
                value = "spectate",
                description = Lang:t("menu.spectate") .. " " .. SelectedPlayer.name
            },

            [6] = {
                icon = '🥶',
                label = Lang:t("menu.freeze"),
                value = "freeze",
                description = Lang:t("menu.freeze") .. " " .. SelectedPlayer.name
            },
            [7] = {
                icon = '🚗',
                label = Lang:t("menu.sit_in_vehicle"),
                value = "intovehicle",
                description = Lang:t("desc.sit_in_veh_desc") .. " " .. SelectedPlayer.name .. " " .. Lang:t("desc.sit_in_veh_desc2")
            }
        }
        for _, v in ipairs(elements) do
            PlayerGeneralMenu:AddButton({
                icon = v.icon,
                label = ' ' .. v.label,
                value = v.value,
                description = v.description,
                select = function(btn)
                    local values = btn.Value
                    TriggerServerEvent('qb-admin:server:'..values, SelectedPlayer)
                end
            })
        end
        PlayerGeneralMenu:AddButton({
            icon = '🧿',
            label = Lang:t("menu.routingbucket"),
            value = "routingbucket",
            description = Lang:t("desc.routingbucket"),
            select = function()
                local dialog = exports['qb-input']:ShowInput({
                    header = Lang:t("desc.routingbucket"),
                    submitText = "Confirm",
                    inputs = {
                        {
                            text = "5",
                            name = "bucket",
                            type = "number",
                            isRequired = true
                        }
                    }
                })
                if dialog then
                    TriggerServerEvent('qb-admin:server:routingbucket', SelectedPlayer, dialog.bucket)
                end
            end
        })
    end)

    local PlayersButton2 = PlayerDetailMenu:AddButton({
        icon = '🧾',
        label = Lang:t("menu.player_administration"),
        value = PlayerAdminMenu,
        description = Lang:t("desc.player_administration")
    })
    PlayersButton2:On('select', function()
        PlayerAdminMenu:ClearItems()
        local elements = {
            [1] = {
                icon = '🥾',
                label = Lang:t("menu.kick"),
                value = "kick",
                description = Lang:t("menu.kick") .. " " .. SelectedPlayer.name .. " " .. Lang:t("info.reason")
            },
            [2] = {
                icon = '🚫',
                label = Lang:t("menu.ban"),
                value = "ban",
                description = Lang:t("menu.ban") .. " " .. SelectedPlayer.name .. " " .. Lang:t("info.reason")
            },
            [3] = {
                icon = '🎟️',
                label = Lang:t("menu.permissions"),
                value = "perms",
                description = Lang:t("info.give") .. " " .. SelectedPlayer.name .. " " .. Lang:t("menu.permissions")
            }
        }
        for _, v in ipairs(elements) do
            PlayerAdminMenu:AddButton({
                icon = v.icon,
                label = ' ' .. v.label,
                value = v.value,
                description = v.description,
                select = function(btn)
                    local values = btn.Value
                    if values == 'ban' then
                        MenuV:OpenMenu(BanMenu)
                    elseif values == 'kick' then
                        MenuV:OpenMenu(KickMenu)
                    elseif values == 'perms' then
                        MenuV:OpenMenu(PermsMenu)
                    end
                end
            })
        end
    end)

    local PlayersButton3 = PlayerDetailMenu:AddButton({
        icon = '🕹️',
        label = Lang:t("menu.player_extra"),
        value = PlayerExtraMenu,
        description = Lang:t("desc.player_extra_desc")
    })
    PlayersButton3:On('select', function()
        PlayerExtraMenu:ClearItems()
        local elements = {
            [1] = {
                icon = '🎒',
                label = Lang:t("menu.open_inv"),
                value = "inventory",
                description = Lang:t("info.open") .. " " .. SelectedPlayer.name .. Lang:t("info.inventories")
            },
            [2] = {
                icon = '👕',
                label = Lang:t("menu.give_clothing_menu"),
                value = "cloth",
                description = Lang:t("desc.clothing_menu_desc") .. " " .. SelectedPlayer.name
            },
            [3] = {
                icon = '🏒',
                label = Lang:t("menu.give_item_menu"),
                value = "giveitem",
                description = Lang:t("desc.give_item_menu_desc") .. " " .. SelectedPlayer.name
            },
            [4] = {
                icon = ' 💰 ',
                label = Lang:t("menu.give_money_menu"),
                value = "givemoney",
                description = Lang:t("desc.give_money_menu_desc") .. " " .. SelectedPlayer.name
            },
            [5] = {
                icon = '🎵',
                label = Lang:t("menu.play_sound"),
                value = "sound",
                description = Lang:t("desc.play_sound") .. " " .. SelectedPlayer.name
            },
            [6] = {
                icon = '🔇',
                label = Lang:t("menu.mute_player"),
                value = "mute",
                description = Lang:t("desc.mute_player")
            },
        }
        for _, v in ipairs(elements) do
            PlayerExtraMenu:AddButton({
                icon = v.icon,
                label = ' ' .. v.label,
                value = v.value,
                description = v.description,
                select = function(btn)
                    local values = btn.Value
                    if values == 'inventory' then
                        TriggerEvent('qb-admin:client:inventory', SelectedPlayer.id)
                    elseif values == 'giveitem' then
                        MenuV:OpenMenu(GiveItemMenu)
                    elseif values == 'givemoney' then
                        MenuV:OpenMenu(GiveMoneyMenu)
                    elseif values == 'sound' then
                        MenuV:OpenMenu(SoundMenu)
                    elseif values == 'mute' then
                        exports['pma-voice']:toggleMutePlayer(SelectedPlayer.id)
                    else
                        TriggerServerEvent('qb-admin:server:'..values, SelectedPlayer)
                    end
                end
            })
        end
        PlayerExtraMenu:AddSlider({
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
                TriggerServerEvent('qb-admin:server:giveallweapons', newValue, SelectedPlayer.id)
            end
        })
    end)
    local elements = {
        [1] = {
            label = Lang:t("label.name").. ': ' ..SelectedPlayer.name,
            description = Lang:t("desc.player_info"),
            value = 'name'
        },
        [2] = {
            label = Lang:t("label.food").. ': ' ..SelectedPlayer.food.. '%',
            description = Lang:t("desc.player_info"),
            value = 'food'
        },
        [3] = {
            label = Lang:t("label.water").. ': ' ..SelectedPlayer.water.. '%',
            description = Lang:t("desc.player_info"),
            value = 'water'
        },
        [4] = {
            label = Lang:t("label.stress").. ': ' ..SelectedPlayer.stress.. '%',
            description = Lang:t("desc.player_info"),
            value = 'stress'
        },
        [5] = {
            label = Lang:t("label.armor").. ': ' ..SelectedPlayer.armor.. '%',
            description = Lang:t("desc.player_info"),
            value = 'armor'
        },
        [6] = {
            label = Lang:t("label.phone").. ': ' ..SelectedPlayer.phone,
            description = Lang:t("desc.player_info"),
            value = 'phone'
        },
        [7] = {
            label = Lang:t("label.craftingrep").. ': ' ..SelectedPlayer.craftingrep,
            description = Lang:t("desc.player_info"),
            value = 'craftingrep'
        },
        [8] = {
            label = Lang:t("label.dealerrep").. ': ' ..SelectedPlayer.dealerrep,
            description = Lang:t("desc.player_info"),
            value = 'dealerrep'
        },
        [9] = {
            label = Lang:t("label.cash").. ': ' ..SelectedPlayer.cash.. '$',
            description = Lang:t("desc.player_info"),
            value = 'cash'
        },
        [10] = {
            label = Lang:t("label.bank").. ': ' ..SelectedPlayer.bank.. '$',
            description = Lang:t("desc.player_info"),
            value = 'bank'
        },
        [11] = {
            label = Lang:t("label.job").. ': ' ..SelectedPlayer.job,
            description = Lang:t("desc.player_info"),
            value = 'job'
        },
        [12] = {
            label = Lang:t("label.gang").. ': ' ..SelectedPlayer.gang,
            description = Lang:t("desc.player_info"),
            value = 'gang'
        },
        [13] = {
            label = Lang:t("label.radio").. ': ' ..Player(SelectedPlayer.id).state['radioChannel'] or 0,
            description = Lang:t("desc.player_info"),
            value = 'radio'
        },
    }
    for _, v in ipairs(elements) do
        PlayerDetailMenu:AddButton({
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
            select = function(btn)
                local values = btn.Value
                local dialog = exports['qb-input']:ShowInput({
                    header = Lang:t("desc.update_info"),
                    submitText = "Confirm",
                    inputs = {
                        {
                            text = "Logical",
                            name = "data",
                            type = "text",
                            isRequired = true
                        }
                    }
                })
                if dialog then
                    TriggerServerEvent('qb-admin:server:'..values, SelectedPlayer, dialog.data)
                end
                Wait(50)
                QBCore.Functions.TriggerCallback('qb-adminmenu:callback:getplayer', function(player)
                    SelectedPlayer = player
                    PlayerDetailMenu:Close()
                    OpenPlayerMenus()
                end, SelectedPlayer.id)
            end
        })
    end
end

RegisterNetEvent('qb-admin:client:openSoundMenu', function(data)
    soundname = data.name
end)

RegisterNetEvent('qb-admin:client:openItemMenu', function(data)
    itemname = data.name
end)
