fx_version 'cerulean'
game 'gta5'

author 'DON'
version '1.1.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- Change to the language you want
    'config.lua',
}

client_scripts {
    '@menuv/menuv.lua',
    'client/noclip.lua',
    'client/blipsnames.lua',
    'client/main.lua',
    'client/selfmenu.lua',
    'client/playersmenu.lua',
    'client/servermenu.lua',
    'client/vehiclemenu.lua',
    'client/entity_view.lua',
    'client/duty.lua',
    'entityhashes/entity.lua',
    'client/devmenu.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/commands.lua',
    'server/playersmenu.lua',
    'server/duty.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/index.js'
}

dependency 'menuv'

lua54 'yes'
