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

        reset: () ->

        render: (viewName) ->

            that = @
            NProgress.start()
            that.cachedView = that.cachedView or {}

            require [viewName], (View) ->

                # cache view
                if not that.cachedView[viewName]
                    that.cachedView[viewName] = new View()

                view = that.cachedView[viewName]

                $('.container').hide().empty()
                $container = view.render()
                $container.fadeIn()
                NProgress.done()

        main: () ->

            @render('MainView')

        index: () ->

            @render('IndexView')

    window.workspace = new Workspace()
    window.App = new AppModel()
    Backbone.history.start({pushState: true})