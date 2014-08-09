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

    paths:
        jquery: 'vender/jquery-2.1.1.min'
        underscore: 'vender/underscore-1.6.min'
        backbone: 'vender/backbone-1.1.2.min'
        handlebars: 'vender/handlebars-1.3.0.min'
        nprogress: 'vender/nprogress/nprogress'
        IndexView: 'module/index/IndexView'
        MainView: 'module/main/MainView'

require ['backbone', 'handlebars'], () ->

    Workspace = Backbone.Router.extend

        routes:
            'main': 'main'
            'index': 'index'
            '': 'index'
        main: () ->
            NProgress.start()
            require ['MainView'], (MainView) ->
                $('.container').empty()
                (new MainView()).render()
                NProgress.done()
        index: () ->
            NProgress.start()
            require ['IndexView'], (IndexView) ->
                $('.container').empty()
                (new IndexView()).render()
                NProgress.done()

    window.workspace = new Workspace()
    Backbone.history.start({pushState: true})