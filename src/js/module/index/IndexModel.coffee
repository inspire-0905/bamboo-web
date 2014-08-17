define ['AppModel'], (AppModel) ->

    IndexModel = Backbone.Model.extend

        initialize: () ->

        login: (data) -> return App.user.login(data)

        register: (data) -> return App.user.register(data)

        feeds: (data) -> return App.user.feeds(data)

    return IndexModel