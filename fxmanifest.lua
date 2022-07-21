fx_version 'cerulean'
game 'gta5'

ui_page('gui/index.html')

shared_scripts { 
	'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

client_scripts {
    'client.lua'
}

files {
    'gui/index.html',
    'gui/script.js',
    'gui/style.css'
}
