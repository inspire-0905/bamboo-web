require.config

    shim:
        underscore:
            exports: '_'
        jquery_plugin:
            deps: [
                'jquery'
            ]
        backbone:
            deps: [
                'underscore'
                'jquery'
                'jquery_plugin'
            ]
            exports: 'Backbone'
        handlebars:
            exports: 'Handlebars'
        AppModel:
            deps: ['backbone']

    paths:
        jquery: 'vender/jquery-2.1.1.min'
        jquery_plugin: 'vender/jquery.plugin'
        underscore: 'vender/underscore-1.6.min'
        backbone: 'vender/backbone-1.1.2.min'
        handlebars: 'vender/handlebars-1.3.0.min'
        nprogress: 'vender/nprogress/nprogress'

        AppModel: 'module/AppModel'
        IndexView: 'module/index/IndexView'
        MainView: 'module/main/MainView'
        PersonView: 'module/person/PersonView'

require ['backbone', 'handlebars', 'AppModel'], (Backbone, Handlebars, AppModel) ->

    Workspace = Backbone.Router.extend

        routes:

            '': 'index'
            'index': 'index'
            'login': 'login'
            'register': 'register'
            'main': 'main'

        reset: () ->

        render: (viewName, data) ->

            that = @
            NProgress.start()
            that.cachedView = that.cachedView or {}

            require [viewName], (View) ->

                # cache view
                if not that.cachedView[viewName]
                    that.cachedView[viewName] = new View()

                view = that.cachedView[viewName]

                $('.container').hide().empty()
                $container = view.render(data)
                $container.fadeIn()
                NProgress.done()

        index: () ->

            @render('IndexView')

        login: () ->

            @render('IndexView', 'login')

        register: () ->

            @render('IndexView', 'register')

        main: () ->

            @render('PersonView')
            # @render('MainView')

    window.workspace = new Workspace()
    window.App = new AppModel()
    Backbone.history.start({pushState: true})