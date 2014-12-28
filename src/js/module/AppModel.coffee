define [], () ->

    AppModel = Backbone.Model.extend

        initialize: () ->

        # markdown converter
        mdConvert: new Markdown.Converter()

        notify: (info) ->

            $notify = $('#notify')
            clearTimeout(@notifyTimer) if @notifyTimer
            $notify.text(info).css('margin-left', -($notify.width() / 2) - 27).addClass('show')
            @notifyTimer = setTimeout () ->
                $notify.removeClass('show')
            , 2000

        baseURL: 'http://localhost:9090'

        user:

            login: (data) ->
                return AppModel.apiRequest('POST', '/user/login', ['mail', 'pass'], data)

            register: (data) ->
                return AppModel.apiRequest('POST', '/user/register', ['mail', 'pass'], data)

            config: (data) ->
                return AppModel.apiRequest('POST', '/user/config', ['key', 'value'], data)

        article:

            update: (data) ->
                return AppModel.apiRequest('POST', '/article/update', ['articleId', 'title', 'content'], data)

            list: () ->
                return AppModel.apiRequest('POST', '/article/list', [])

            remove: (data) ->
                return AppModel.apiRequest('POST', '/article/remove', ['articleId'], data)

            get: (data) ->
                return AppModel.apiRequest('POST', '/article/get', ['articleId'], data)

            like: (data) ->
                return AppModel.apiRequest('POST', '/article/like', ['articleId', 'like'], data)

            favarite: (data) ->
                return AppModel.apiRequest('POST', '/article/favarite', ['articleId', 'favarite'], data)

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
                    App.notify(data.result)
                    returnDeferred.reject(data.result)

            .fail (data) ->
                console.log(data)
                returnDeferred.reject('服务端或网络异常')

            .always () ->
                NProgress.done()

            return returnDeferred
    }

    return AppModel
