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

        baseURL: "http://#{location.hostname}:9090"

        circles: [
            {
                name: "电影",
                desc: "光影魅力，影评推荐",
                icon: "film"
            },
            {
                name: "音乐",
                desc: "光影魅力，影评推荐",
                icon: "music-tone-alt"
            },
            {
                name: "二次元",
                desc: "光影魅力，影评推荐",
                icon: "ghost"
            },
            {
                name: "摄影",
                desc: "光影魅力，影评推荐",
                icon: "camera"
            },
            {
                name: "旅行",
                desc: "光影魅力，影评推荐",
                icon: "pointer"
            },
            {
                name: "产品",
                desc: "光影魅力，影评推荐",
                icon: "rocket"
            },
            {
                name: "想法",
                desc: "光影魅力，影评推荐",
                icon: "bulb"
            },
            {
                name: "游戏",
                desc: "光影魅力，影评推荐",
                icon: "game-controller"
            },
            {
                name: "绘画",
                desc: "光影魅力，影评推荐",
                icon: "pencil"
            },
            {
                name: "程序",
                desc: "光影魅力，影评推荐",
                icon: "screen-desktop"
            },
            {
                name: "阅读",
                desc: "光影魅力，影评推荐",
                icon: "eyeglasses"
            },
            {
                name: "设计",
                desc: "光影魅力，影评推荐",
                icon: "layers"
            },
            {
                name: "美食",
                desc: "光影魅力，影评推荐",
                icon: "cup"
            },
            {
                name: "生活",
                desc: "光影魅力，影评推荐",
                icon: "handbag"
            }
        ]

        user:

            login: (data) ->
                return AppModel.apiRequest('POST', '/user/login', ['mail', 'pass'], data)

            register: (data) ->
                return AppModel.apiRequest('POST', '/user/register', ['mail', 'pass'], data)

            config: (data) ->
                return AppModel.apiRequest('POST', '/user/config', ['key', 'value'], data)

            info: () ->
                return AppModel.apiRequest('POST', '/user/info', [])

            timeline: () ->
                return AppModel.apiRequest('POST', '/user/timeline', [])

        article:

            update: (data) ->
                return AppModel.apiRequest('POST', '/article/update', ['articleId', 'title', 'content', 'circles', 'public'], data)

            list: (data) ->
                return AppModel.apiRequest('POST', '/article/list', ['filter'], data)

            remove: (data) ->
                return AppModel.apiRequest('POST', '/article/remove', ['articleId'], data)

            get: (data) ->
                return AppModel.apiRequest('POST', '/article/get', ['articleId'], data)

            like: (data) ->
                return AppModel.apiRequest('POST', '/article/like', ['articleId', 'like'], data)

            favarite: (data) ->
                return AppModel.apiRequest('POST', '/article/favarite', ['articleId', 'favarite'], data)

        circle:

            focus: (data) ->
                return AppModel.apiRequest('POST', '/circle/focus', ['circle', 'focus'], data)

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
                if data.status
                    returnDeferred.resolve(data.result)
                else
                    App.notify(data.result)
                    returnDeferred.reject(data.result)

            .fail (data) ->
                App.notify('服务端或网络异常')
                returnDeferred.reject('服务端或网络异常')

            .always () ->
                NProgress.done()

            return returnDeferred
    }

    return AppModel
