define ['backbone', 'module/person/template'], (Backbone, template) ->

    PersonView = Backbone.View.extend

        el: '#person'
        events: {}
        initialize: () ->
        render: () ->
            @$el.html template()

    return PersonView