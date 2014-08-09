define ['backbone', 'module/index/template'], (Backbone, template) ->

    IndexView = Backbone.View.extend

        el: '#index'
        events:
            'click .submit': 'submit'
        initialize: () ->
        render: () ->
            @$el.html template()
        submit: () ->
            alert(1)
            NProgress.start()

    return IndexView