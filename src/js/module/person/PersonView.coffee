define ['backbone', 'module/person/template'], (Backbone, template) ->

    PersonView = Backbone.View.extend

        el: '#person'
        events: {}
        initialize: () ->
        render: () ->
            @$el.html template()
            initUploaders('http://api.inkpaper.io/upload')
            @$el


    return PersonView