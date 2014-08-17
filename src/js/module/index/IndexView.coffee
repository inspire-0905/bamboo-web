define ['backbone', 'module/index/template', 'module/index/IndexModel'], (Backbone, template, IndexModel) ->

    IndexView = Backbone.View.extend

        el: '#index'

        events:

            'click .submit': 'submit'
            'click .switch .btn': 'switch'

        initialize: () ->

            @model = new IndexModel()

        render: (data) ->

            that = @
            @$el.html template()
            if data is 'login'
                @switch('login')
            else if data is 'register'
                @switch('register')
            _.defer () -> that.$el.find('.mail-input').focus()
            return @$el

        submit: () ->

            NProgress.start()
            # invoke api
            @model.feeds({
                email: 'song@gmail.com',
                password: 'songsong',
                realname: 'songsong'
            }).done (data) ->
                workspace.navigate('main', {trigger: true, replace: false})
            .fail (data) ->
                alert data

        switch: (event) ->

            $switchBtn = @$el.find('.switch')
            $switchBtn.find('.btn').removeClass('active')

            $registerBtn = $switchBtn.find('.register-btn')
            $loginBtn = $switchBtn.find('.login-btn')

            if event is 'login'
                isRegisterState = false
                $loginBtn.addClass('active')
            else if event is 'register'
                isRegisterState = true
                $registerBtn.addClass('active')
            else
                isRegisterState = true
                if $(event.target).hasClass('register-btn')
                    $registerBtn.addClass('active')
                else
                    $loginBtn.addClass('active')
                    isRegisterState = false

            $mailInput = @$el.find('.mail-input')
            $passInput = @$el.find('.pass-input')

            if isRegisterState
                $mailInput.attr('placeholder', '设置邮箱')
                $passInput.attr('placeholder', '设置密码')
                workspace.navigate('register', {trigger: false, replace: true})
            else
                $mailInput.attr('placeholder', '电子邮箱')
                $passInput.attr('placeholder', '登录密码')
                workspace.navigate('login', {trigger: false, replace: true})

            $mailInput.focus()

    return IndexView