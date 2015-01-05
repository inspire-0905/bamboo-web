define ['backbone', 'module/main/template', 'SettingView', 'CircleView'], (Backbone, template, SettingView, CircleView) ->

    MainView = Backbone.View.extend

        el: '#main'

        events:

            'click .write': 'write'
            'click .article-item .remove': 'remove'
            'click .article-item .edit': 'edit'
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

        render: (callback, data) ->

            that = @

            that.callback = callback

            that.$el.html template.page({
                id: $.localStorage('id'),
                mail: $.localStorage('mail'),
                nick: $.localStorage('nick'),
                motto: $.localStorage('motto'),
                link: $.localStorage('link'),
                avatar: $.localStorage('avatar')
            })

            @switchTo(data)

        switch: (event) ->

            $item = $(event.currentTarget)
            viewName = $item.data('id')
            @switchTo(viewName)

        switchTo: (name) ->

            that = @

            name = 'main' if not name

            workspace.navigate(name, {trigger: false, replace: true})

            $parent = that.$el.find('.main')

            if name is 'setting'

                settingView = new SettingView()
                settingView.render ($container) ->
                    $parent.html($container)
                    that.callback(that.$el)

            else if name is 'circle'

                circleView = new CircleView()
                circleView.render ($container) ->
                    $parent.html($container)
                    that.callback(that.$el)

            else if name in ['private', 'public', 'favarite']

                NProgress.start()
                App.article.list({
                    filter: name
                }).done (data) ->
                    that.renderList(data)
                    NProgress.done()
                that.callback(that.$el)

            else

                NProgress.start()
                App.user.timeline().done (data) ->
                    that.renderList(data)
                    NProgress.done()
                that.callback(that.$el)

            that.$el.find('.tool .item').removeClass('selected')
            that.$el.find('.tool .item[data-id="' + name + '"]').addClass('selected')

        renderList: (data) ->

            that = @

            data = _.map data, (item) ->
                $origin = $(App.mdConvert.makeHtml(item.content))
                firstImg = $origin.find('img')[0]
                item.content = $origin.text()
                item.thematic = firstImg.src if firstImg
                return item
            that.$el.find('.main').html template.articles({
                articles: data
            })

        write: () ->

        	workspace.navigate('edit/new', {trigger: true})

        remove: (event) ->

            $articleItem = $(event.currentTarget).parents('.article-item')
            articleId = $articleItem.data('id')
            App.article.remove({
                articleId: articleId
            }).done (data) ->
                $articleItem.remove()
            .fail (data) ->
                null
            return false

        edit: (event) ->

            $articleItem = $(event.currentTarget).parents('.article-item')
            articleId = $articleItem.data('id')
            workspace.navigate('edit/' + articleId, {trigger: true})
            return false

        view: (event) ->

            $articleItem = $(event.currentTarget) #.parents('.article-item')
            articleId = $articleItem.data('id')
            workspace.navigate('article/' + articleId, {trigger: true})

    return MainView
