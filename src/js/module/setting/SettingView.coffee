define ['backbone', 'module/setting/template'], (Backbone, template) ->

    SettingView = Backbone.View.extend

        className: 'setting'

        events:

            'click .write': 'write'
            'click #mail_confirm': 'updateMail'
            'click #link_confirm': 'updateLink'
            'click #pass_confirm': 'updatePass'
            'click #name_confirm': 'updateName'
            'change #nick': 'updateNick'
            'change #motto': 'updateMotto'
            'change #avatar': 'updateAvatar'

        initialize: () ->

        updateValue: (key, value) ->

            App.user.config({
                key: key
                value: value
            }).done (data) ->
                $.localStorage(key, value)
                App.notify('修改成功')

        updateMail: () ->

            mail = $('#mail').val()
            @updateValue('mail', mail)

        updateLink: () ->

            link = $('#link').val()
            @updateValue('link', link)

        updateNick: () ->

            nick = $('#nick').val()
            @updateValue('nick', nick)

        updateMotto: () ->

            motto = $('#motto').val()
            @updateValue('motto', motto)

        render: (callback) ->

            NProgress.start()
            @$el.html template.page({
                name: $.localStorage('name'),
                mail: $.localStorage('mail'),
                nick: $.localStorage('nick'),
                motto: $.localStorage('motto'),
                link: $.localStorage('link'),
                avatar: $.localStorage('avatar')
            })
            NProgress.done()
            callback(@$el)

        updateAvatar: (event) ->

            that = @

            file = event.target.files[0]
            if not /image\/\w+/.test(file.type)
                App.notify('请选择图片')
                return
            reader = new FileReader()
            reader.readAsDataURL(file)
            reader.onload = (event) ->
                that.$el.find('img.preview')[0].src = @result
                that.updateValue('avatar', @result)

        updateName: (event) ->

            name = $('#name').val()
            @updateValue('name', name)

    return SettingView
