define ['backbone', 'module/main/template'], (Backbone, template) ->

    MainView = Backbone.View.extend

        el: '#main'

        events:

        	'click .write': 'write'

        initialize: () ->

        render: () ->

            @$el.html template()

        write: () ->

        	workspace.navigate('write', {trigger: true})

    return MainView