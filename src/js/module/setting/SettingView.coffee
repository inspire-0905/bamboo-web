define ['backbone', 'module/setting/template'], (Backbone, template) ->

    SettingView = Backbone.View.extend

        className: 'setting'
        events: {}
        initialize: () ->
        render: () ->
            NProgress.start()
            @$el.html template.page({
                mail: $.localStorage('mail'),
                nick: $.localStorage('nick'),
                motto: $.localStorage('motto'),
                link: $.localStorage('link')
            })
            NProgress.done()
            initUploaders('http://api.inkpaper.io/upload')
            @$el

    return SettingView
