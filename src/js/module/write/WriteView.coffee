define ['backbone', 'module/write/template'], (Backbone, template) ->

    WriteView = Backbone.View.extend

        el: '#write'

        events:

            'click .write': 'write'
            'click img': 'selectImg'
            'mouseover li.type': 'focusToolbarInput'

        initialize: () ->

        isInDomByClass: ($target, className) ->

            return $target.hasClass(className) or $target.parents(".#{className}").length

        render: () ->

            that = @

            @$el.html template()
            editor = new MediumEditor('.content', {
                diffTop: -20
            })

            $(document).on 'mouseup', (event) ->

                $target = $(event.target)
                if not (that.isInDomByClass($target, 'content') or
                    that.isInDomByClass($target, 'title') or
                    that.isInDomByClass($target, 'medium-editor-toolbar'))
                        that.$el.find('.content').focusEnd()

            @initToolbar()

            @$el

        selectImg: (event) ->

            $img = $(event.target)
            $img.setRangeByDom() #.addClass('selected')

        focusToolbarInput: (event) ->

            $typeBtn = $(event.target)
            $typeBtn.find('input.link').focus()

        initToolbar: () ->

            that = @

            @$el.find('.content').on 'focus keyup mouseup', () ->

                $focusDom = $(document.getSelection().focusNode)
                $toolbar = that.$el.find('.toolbar')

                # show toolbar when time
                if ($focusDom.hasClass('content') or
                    $focusDom.prop('tagName') is 'P' or
                    $focusDom.parents('p').length) and
                    $focusDom.text() is ''

                        $('html, body').animate({
                            scrollTop: $focusDom.offset().top - 600;
                        }, 100)

                        that.initUpload($toolbar) if not that.toolbar

                        that.toolbar = $toolbar
                        that.$focusDom = $focusDom

                        # set toolbar position
                        leftPos = that.$focusDom.offset().left
                        topPos = that.$focusDom.offset().top
                        $toolbar.css('left', leftPos - 80 + 'px').css('top', topPos - 8 + 'px')
                        $toolbar.fadeIn('fast')

                else

                    $toolbar.fadeOut('fast')

        initUpload: ($toolbar) ->

            that = @

            # bind toolbar upload event
            $toolbar.dmUploader({
                
                onNewFile: (id, file) ->

                    # show image preview
                    oFReader = new FileReader()
                    oFReader.readAsDataURL(file)

                    oFReader.onload = (oFREvent) ->

                        if that.$focusDom and that.$focusDom.length

                            appendDom = '<img class="preview" />'

                            if that.$focusDom.prop('tagName') isnt 'P'
                                appendDom = "<p>#{appendDom}</p><p><br/></p>"
                            else    
                                appendDom = "#{appendDom}<p><br/></p>"

                            insertRet = document.execCommand('insertHTML', true, appendDom)

                            if not insertRet
                                that.$focusDom.html(appendDom)

                            that.$focusDom.find('.preview')[0].src = oFREvent.target.result
            })

        write: () ->

        	workspace.navigate('write', {trigger: true})

    return WriteView