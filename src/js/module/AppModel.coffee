define [], () ->

    AppModel = Backbone.Model.extend

        initialize: () ->

        user:

            login: (data) ->
                return AppModel.apiRequest('POST', '/auth/login', ['email', 'password'], data)

            register: (data) ->
                return AppModel.apiRequest('POST', '/auth/register', ['email', 'password', 'realname'], data)

    , {

        apiRequest: (type, method, define, data) ->

            baseURL = 'http://api.ctshare.com'

            data = {} if not data

            return $.ajax
                type: type
                url: "#{baseURL}#{method}"
                dataType: 'JSON',
                jsonp: false
                data: JSON.stringify _.pick(data, define)
    }

    return AppModel