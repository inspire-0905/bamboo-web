define ['backbone', 'module/main/template'], (Backbone, template) ->

    MainView = Backbone.View.extend

        el: '#main'

        events:

        	'click .write': 'write'

        initialize: () ->

        render: () ->

            @$el.html template()
            App.article.list().done (data) ->
                alert(JSON.stringify(data))
            .fail (data) ->
                alert(data)
            @$el

        write: () ->

        	workspace.navigate('write', {trigger: true})

    return MainView
