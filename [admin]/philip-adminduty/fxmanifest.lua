fx_version 'cerulean'
lua54 'yes'
game 'gta5' 

description '[QB] philip-adminduty'
version '1.0.0'
author 'Philip#1790'


client_script 'client.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

shared_script 'config.lua'