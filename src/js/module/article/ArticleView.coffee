define ['backbone', 'module/article/template'], (Backbone, template) ->

    ArticleView = Backbone.View.extend

        el: '#article'

        events: null

        initialize: () ->

        render: (articleId) ->



            that = @
            NProgress.start()
            App.article.get({
                id: articleId
            }).done (data) ->
                data.content = App.mdConvert.makeHtml(data.content)
                that.$el.html template.page(data)
                NProgress.done()
            .fail (data) ->
                null
            @$el

    return ArticleView
