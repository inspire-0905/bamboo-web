define ['backbone', 'module/main/template'], (Backbone, template) ->

    MainView = Backbone.View.extend

        el: '#main'
        events: {}
        initialize: () ->
        render: () ->
            @$el.html template()

    return MainView