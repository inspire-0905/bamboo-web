define ['backbone', 'module/write/template'], (Backbone, template) ->

    WriteView = Backbone.View.extend

        el: '#write'

        events:

        	'click .write': 'write'

        initialize: () ->

        render: () ->

            @$el.html template()

        write: () ->

        	workspace.navigate('write', {trigger: true})

    return WriteView