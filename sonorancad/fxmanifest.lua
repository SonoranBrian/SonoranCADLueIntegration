fx_version 'cerulean'
games {'gta5'}

author 'Sonoran CAD'
description 'Sonoran CAD FiveM Integration'
version '2.9.34'

server_scripts {
    'core/http.js'
    ,'core/unzipper/unzip.js'
    ,'core/image.js'
    ,'core/logging.lua'
    ,'core/shared_functions.lua'
    ,'core/configuration.lua'
    ,'core/server.lua'
    ,'core/commands.lua'
    ,'core/httpd.lua'
    ,'core/unittracking.lua'
    ,'core/updater.lua'
    ,'core/apicheck.lua'
    ,'plugins/**/config_*.lua'
    ,'core/plugin_loader.lua'
    ,'plugins/**/sv_*.lua'
    ,'plugins/**/sv_*.js'
    ,'core/screenshot.lua'
               }
client_scripts {
    'core/logging.lua'
    ,'core/headshots.lua'
    ,'core/shared_functions.lua'
    ,'core/client.lua'
    ,'core/lighting.lua'
    ,'plugins/**/config_*.lua'
    ,'plugins/**/cl_*.lua'
    ,'plugins/**/cl_*.js'
}

ui_page 'core/client_nui/index.html'

files {
    'stream/**/*.ytyp',
    'core/client_nui/index.html',
    'core/client_nui/js/*.js',
    'core/client_nui/sounds/*.mp3',
    'core/client_nui/img/logo.gif'
}

data_file 'DLC_ITYP_REQUEST' 'stream/**/*.ytyp'
