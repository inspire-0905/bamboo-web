define ['backbone', 'module/index/template'], (Backbone, template) ->

    MainView = Backbone.View.extend

        events:
            'click .submit': 'submit'
        initialize: () ->
        render: () ->
            return template()
        submit: () ->
            # alert('test')

    return MainView