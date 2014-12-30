define ['backbone', 'module/circle/template'], (Backbone, template) ->

    CircleView = Backbone.View.extend

        className: 'circle'

        events: null

        initialize: () ->

        render: () ->

            NProgress.start()
            @$el.html template.page()
            NProgress.done()
            @$el

    return CircleView
