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
        AppModel:
            deps: ['backbone']

    paths:
        jquery: 'vender/jquery-2.1.1.min'
        underscore: 'vender/underscore-1.6.min'
        backbone: 'vender/backbone-1.1.2.min'
        handlebars: 'vender/handlebars-1.3.0.min'
        nprogress: 'vender/nprogress/nprogress'
        AppModel: 'module/AppModel'
        IndexView: 'module/index/IndexView'
        MainView: 'module/main/MainView'

require ['backbone', 'handlebars', 'AppModel'], (Backbone, Handlebars, AppModel) ->

    Workspace = Backbone.Router.extend

        routes:

            'main': 'main'
            'index': 'index'
            '': 'index'

        main: () ->

            NProgress.start()
            require ['MainView'], (MainView) ->
                $('.container').hide()
                $container = (new MainView()).render()
                $container.fadeIn()
                NProgress.done()

        index: () ->

            NProgress.start()
            require ['IndexView'], (IndexView) ->
                $('.container').hide()
                $container = (new IndexView()).render()
                $container.fadeIn()
                NProgress.done()

    window.workspace = new Workspace()
    window.App = new AppModel()
    Backbone.history.start({pushState: true})