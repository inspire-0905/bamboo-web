define ['backbone', 'module/index/template', 'module/index/IndexModel'], (Backbone, template, IndexModel) ->

    IndexView = Backbone.View.extend

        el: '#index'

        events:
            'click .submit': 'submit'

        initialize: () ->
            @model = new IndexModel()

        render: () ->
            @$el.html template()

        submit: () ->

            NProgress.start()
            # invoke api
            @model.login({
                email: 'imeoer@gmail.com',
                password: 'songsong',
                realname: 'songsong'
            }).done (data) ->
                workspace.navigate('main', {trigger: true})
            .fail (data) ->
                alert data

    return IndexView