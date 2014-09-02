define ['backbone', 'module/write/template'], (Backbone, template) ->

    WriteView = Backbone.View.extend

        el: '#write'

        events:

        	'click .write': 'write'

        initialize: () ->

        render: () ->

            that = @

            @$el.html template()
            editor = new MediumEditor('.content')

            @$el.find('.content').on 'keyup mouseup', () ->
                $focusDom = $(document.getSelection().focusNode)
                $toolbar = that.$el.find('.toolbar')
                if $focusDom.prop('tagName') is 'P' and $focusDom.text() is ''
                    $toolbar.show()
                    leftPos = $focusDom.offset().left
                    topPos = $focusDom.offset().top
                    $toolbar.css('left', leftPos - 80 + 'px').css('top', topPos - 8 + 'px')
                else
                    $toolbar.hide()

            @$el

        write: () ->

        	workspace.navigate('write', {trigger: true})

    return WriteView