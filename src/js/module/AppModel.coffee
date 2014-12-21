define [], () ->

    AppModel = Backbone.Model.extend

        initialize: () ->

        # markdown converter
        mdConvert: new Markdown.Converter()

        notify: (info) ->

            $notify = $('#notify')
            $notify.text(info).css('margin-left', -($notify.width() / 2) - 27).addClass('show')

        baseURL: 'http://localhost:9090'

        user:

            login: (data) ->
                return AppModel.apiRequest('POST', '/user/login', ['mail', 'pass'], data)

            register: (data) ->
                return AppModel.apiRequest('POST', '/user/register', ['mail', 'pass'], data)

        article:

            update: (data) ->
                return AppModel.apiRequest('POST', '/article/update', ['id', 'title', 'content'], data)

            list: () ->
                return AppModel.apiRequest('POST', '/article/list', [])

            remove: (data) ->
                return AppModel.apiRequest('POST', '/article/remove', ['id'], data)

            get: (data) ->
                return AppModel.apiRequest('POST', '/article/get', ['id'], data)

    , {

        apiRequest: (type, method, define, data) ->

            token = $.localStorage('token')

            deferred = $.ajax

                type: type
                url: "#{App.baseURL}#{method}"
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
                    alert(data.result)
                    returnDeferred.reject(data.result)

            .fail (data) ->
                console.log(data)
                returnDeferred.reject('服务端或网络异常')

            .always () ->
                NProgress.done()

            return returnDeferred
    }

    return AppModel
