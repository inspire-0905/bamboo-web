define ['backbone', 'module/article/template'], (Backbone, template) ->

    ArticleView = Backbone.View.extend

        el: '#article'

        events: null

        initialize: () ->

        render: () ->

            @$el.html template.page()

    return ArticleView
