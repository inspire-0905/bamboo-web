define [], () ->

    AppModel = Backbone.Model.extend

        initialize: () ->

        user:

            login: (data) ->
                return AppModel.apiRequest('POST', '/auth/login', ['email', 'password'], data)

            register: (data) ->
                return AppModel.apiRequest('POST', '/auth/register', ['email', 'password', 'realname'], data)

            feeds: (data) ->
                return AppModel.apiRequest('GET', '/feeds', [], data)

    , {

        apiRequest: (type, method, define, data) ->

            baseURL = 'http://api.ctshare.com'

            deferred = $.ajax
                type: type
                url: "#{baseURL}#{method}"
                dataType: 'json'
                jsonp: false
                data: _.pick(data or {}, define)

            returnDeferred = $.Deferred()

            deferred.done (result) ->
                console.log(result)
                if not result.code
                    returnDeferred.resolve(result.data)
                else
                    returnDeferred.reject(result.data)

            .fail (result) ->
                console.log(result)
                returnDeferred.reject('Server or network exception')

            .always () ->
                NProgress.done()

            return returnDeferred
    }

    return AppModel