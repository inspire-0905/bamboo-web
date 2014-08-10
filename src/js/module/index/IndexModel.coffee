define ['AppModel'], (AppModel) ->

    IndexModel = Backbone.Model.extend

        initialize: () ->

        login: (data) -> return App.user.login(data)

        register: (data) -> return App.user.register(data)

    return IndexModel