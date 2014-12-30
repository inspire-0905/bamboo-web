define ['backbone', 'module/index/template'], (Backbone, template) ->

    IndexView = Backbone.View.extend

        el: '#index'

        events:

            'click .submit': 'submit'
            'click .switch .btn': 'switch'
            'keypress .mail-input, .pass-input': 'inputPress'

        render: (data) ->

            that = @
            @$el.html template.page()

            if data is 'login'
                @switch('login')
            else if data is 'register'
                @switch('register')
            _.defer () -> that.$el.find('.mail-input').focus()
            return @$el

        validateEmail: (email) ->

            emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
            emailRegex.test(email)

        showErrorTip: ($dom, tip) ->

            $dom.tipsy({trigger: 'manual', fade: true, gravity: 's'})
                .attr('original-title', tip)
                .tipsy('show')
                .focus()
            _.delay () ->
                $dom.tipsy('hide')
            , 2500

        inputPress: (event) ->

            @submit() if event.keyCode is 13

        submit: () ->

            that = @

            $mail = that.$el.find('.mail-input')
            $pass = that.$el.find('.pass-input')

            mail = $.trim($mail.val())
            pass = $pass.val()

            if @isRegisterState

                if not mail or not @validateEmail(mail)
                    @showErrorTip($mail, '邮箱地址不正确')
                    return

                if not pass or pass.length < 6 or pass.length > 16
                    @showErrorTip($pass, '密码位数在6－16之间')
                    return

            else

                if not mail
                    @showErrorTip($mail, '请输入邮箱')
                    return

                if not pass
                    @showErrorTip($pass, '请输入密码')
                    return

            NProgress.start()

            invoke = if @isRegisterState then App.user.register else App.user.login

            # invoke = @model.feeds

            invoke({
                mail: mail,
                pass: pass
            }).done (data) ->
                $.localStorage('id', data.id)
                $.localStorage('token', data.token)
                $.localStorage('avatar', data.avatar)
                $.localStorage('link', data.link)
                $.localStorage('mail', data.mail)
                $.localStorage('motto', data.motto)
                $.localStorage('nick', data.nick)
                workspace.navigate('main', {trigger: true, replace: false})
            .fail (data) ->
                that.showErrorTip($mail, data)
                $mail.focus()

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

            @isRegisterState = isRegisterState

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
