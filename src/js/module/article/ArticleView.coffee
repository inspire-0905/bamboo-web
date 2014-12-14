define ['backbone', 'module/article/template'], (Backbone, template) ->

    ArticleView = Backbone.View.extend

        el: '#article'

        events: null

        initialize: () ->

        render: (articleId) ->

            that = @
            App.article.get({
                id: articleId
            }).done (data) ->
                that.$el.html template.page(data)
            .fail (data) ->
                null
            @$el

    return ArticleView
