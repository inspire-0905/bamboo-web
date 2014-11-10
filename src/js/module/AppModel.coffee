define [], () ->

    AppModel = Backbone.Model.extend

        initialize: () ->

        user:

            login: (data) ->
                return AppModel.apiRequest('POST', '/login', ['mail', 'pass'], data)

            register: (data) ->
                return AppModel.apiRequest('POST', '/register', ['mail', 'pass'], data)

    , {

        apiRequest: (type, method, define, data) ->

            baseURL = 'http://localhost:9090'

            token = $.localStorage('token')

            deferred = $.ajax

                type: type
                url: "#{baseURL}#{method}"
                dataType: 'json'
                jsonp: false
                data: JSON.stringify(_.pick(data or {}, define))
                crossDomain: true
                headers: {Token: "#{token}"}

            returnDeferred = $.Deferred()

            deferred.done (data) ->
                console.log(data)
                if data.status
                    returnDeferred.resolve(data.result)
                else
                    returnDeferred.reject(data.result)

            .fail (data) ->
                console.log(data)
                returnDeferred.reject('服务端或网络异常')

            .always () ->
                NProgress.done()

            return returnDeferred
    }

    return AppModel
