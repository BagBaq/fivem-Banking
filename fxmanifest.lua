fx_version 'cerulean'
game 'gta5'

ui_page('gui/index.html')

shared_scripts { 
	'config.lua'
}

server_scripts {
    'server.lua'
}

client_scripts {
    'client.lua'
}

files {
    'gui/index.html',
    'gui/script.js',
    'gui/style.css',
    'gui/img/logo.png'
}
