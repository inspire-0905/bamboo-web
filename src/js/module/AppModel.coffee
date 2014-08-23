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

            baseURL = 'http://api.inkpaper.io'

            token = $.localStorage('token')

            data = _.extend _.pick(data or {}, define), {token: token}

            deferred = $.ajax
                type: type
                url: "#{baseURL}#{method}"
                dataType: 'json'
                jsonp: false
                data: data

            returnDeferred = $.Deferred()

            deferred.done (result) ->
                console.log(result)
                if not result.code
                    returnDeferred.resolve(result.data)
                else
                    returnDeferred.reject(result.data)

            .fail (result) ->
                console.log(result)
                returnDeferred.reject('服务端或网络异常')

            .always () ->
                NProgress.done()

            return returnDeferred
    }

    return AppModel