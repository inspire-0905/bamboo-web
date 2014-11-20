define ['backbone', 'module/main/template'], (Backbone, template) ->

    MainView = Backbone.View.extend

        el: '#main'

        events:

            'click .write': 'write'
            'click .article-item .remove': 'remove'
            'click .article-item .view': 'view'

        initialize: () ->

        render: () ->

            that = @
            App.article.list().done (data) ->
                that.$el.html template.page({
                    articles: data
                })
            .fail (data) ->
                null
            @$el

        write: () ->

        	workspace.navigate('write', {trigger: true})

        remove: (event) ->

            $articleItem = $(event.currentTarget).parents('.article-item')
            articleId = $articleItem.data('id')
            App.article.remove({
                id: articleId
            }).done (data) ->
                $articleItem.remove()
            .fail (data) ->
                null

        view: (event) ->

            $articleItem = $(event.currentTarget).parents('.article-item')
            articleId = $articleItem.data('id')
            workspace.navigate('article/' + articleId, {trigger: true})

    return MainView
