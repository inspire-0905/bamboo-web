require.config

    shim:
        underscore:
            exports: '_'
        backbone:
            deps: [
                'underscore'
                'jquery'
            ]
            exports: 'Backbone'
        handlebars:
            exports: 'Handlebars'
        AppView:
            deps: ['handlebars']
            exports: 'AppView'

    paths:
        jquery: 'vender/jquery-2.1.1.min'
        underscore: 'vender/underscore-1.6.min'
        backbone: 'vender/backbone-1.1.2.min'
        handlebars: 'vender/handlebars-1.3.0.min'
        nprogress: 'vender/nprogress/nprogress'
        AppView: 'module/AppView'
        IndexView: 'module/index/IndexView'

require [
    'AppView'
], (AppView) ->

    new AppView()