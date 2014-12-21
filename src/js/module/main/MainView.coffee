define ['backbone', 'module/main/template', 'SettingView'], (Backbone, template, SettingView) ->

    MainView = Backbone.View.extend

        el: '#main'

        events:

            'click .write': 'write'
            'click .article-item .remove': 'remove'
            'click .article-item': 'view'
            'click .tool .item': 'switch'

        initialize: () ->

            # that = @
            # $(window).scroll () ->
            #
            #     currentTop = $(this).scrollTop()
            #     $logo = that.$el.find('.logo')
            #     gapTop = 60
            #     if currentTop < gapTop
            #         $logo.css('opacity', 1)
            #     if currentTop > gapTop
            #         $logo.css('opacity', 0)

        render: (data) ->

            that = @

            that.$el.html template.page()

            if data is 'setting'
                @switchTo('setting')
            else
                @switchTo('main')
            @$el

        switch: (event) ->

            $item = $(event.currentTarget)
            viewName = $item.data('id')
            @switchTo(viewName)

        switchTo: (name) ->

            that = @

            workspace.navigate(name, {trigger: false, replace: true})

            if name is 'setting'

                that.$el.find('.main').html (new SettingView()).render()

            else

                NProgress.start()
                App.article.list().done (data) ->
                    data = _.map data, (item) ->
                        $origin = $(App.mdConvert.makeHtml(item.content))
                        firstImg = $origin.find('img')[0]
                        item.content = $origin.text()
                        item.thematic = firstImg.src if firstImg
                        return item
                    that.$el.find('.main').html template.articles({
                        articles: data
                    })
                    NProgress.done()
                .fail (data) ->
                    null

            that.$el.find('.tool .item').removeClass('selected')
            that.$el.find('.tool .item[data-id="' + name + '"]').addClass('selected')

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

            $articleItem = $(event.currentTarget) #.parents('.article-item')
            articleId = $articleItem.data('id')
            workspace.navigate('article/' + articleId, {trigger: true})

    return MainView
