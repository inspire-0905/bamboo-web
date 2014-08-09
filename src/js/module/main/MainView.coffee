define ['backbone', 'module/index/template'], (Backbone, template) ->

    MainView = Backbone.View.extend

        el: '#main'
        events: {}
        initialize: () ->
        render: () ->
            @$el.html template()

    return MainView