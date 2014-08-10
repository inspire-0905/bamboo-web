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
                email: '',
                password: ''
            }).done (data) ->
                workspace.navigate('main', {trigger: true})
            .fail (err) ->
                alert JSON.stringify(err)
            .always () ->
                NProgress.done()

    return IndexView