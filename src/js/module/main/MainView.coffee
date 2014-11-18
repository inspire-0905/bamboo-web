define ['backbone', 'module/main/template'], (Backbone, template) ->

    MainView = Backbone.View.extend

        el: '#main'

        events:

        	'click .write': 'write'

        initialize: () ->

        render: () ->

            that = @
            App.article.list().done (data) ->
                that.$el.html template.page()
            .fail (data) ->
                null
            @$el

        write: () ->

        	workspace.navigate('write', {trigger: true})

    return MainView
