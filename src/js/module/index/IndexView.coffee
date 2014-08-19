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

            @$el.find('.mail-input').tipsy({trigger: 'manual', fade: true, gravity: 's'})
            @showErrorTip = _.throttle () ->
                $input = that.$el.find('.mail-input')
                $input.tipsy('show')
                _.delay () ->
                    $input.tipsy('hide')
                , 2500
            , 1

            if data is 'login'
                @switch('login')
            else if data is 'register'
                @switch('register')
            _.defer () -> that.$el.find('.mail-input').focus()
            return @$el

        submit: () ->

            that = @

            NProgress.start()
            # invoke api

            invoke = if @isRegisterState then @model.register else @model.login

            invoke({
                email: that.$el.find('.mail-input').val(),
                password: that.$el.find('.mail-pass').val()
            }).done (data) ->
                workspace.navigate('main', {trigger: true, replace: false})
            .fail (data) ->
                that.$el.find('.mail-input').attr('original-title', data)
                that.showErrorTip()

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