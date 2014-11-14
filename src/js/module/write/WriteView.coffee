define ['backbone', 'ace', 'module/write/template'], (Backbone, ace, template) ->

    WriteView = Backbone.View.extend

        el: '#write'

        events:

            'click .write': 'write'
            'click img': 'selectImg'
            'mouseover li.type': 'focusToolbarInput'
            'click .publish': 'publish'
            'click .edit-view li': 'modeSwitch'

        initialize: () ->

            # markdown converter
            @markdownConverter = new Markdown.Converter()

        isInDomByClass: ($target, className) ->

            return $target[0].nodeName in ['INPUT', 'TEXTAREA'] or $target.hasClass(className) or $target.parents(".#{className}").length

        render: () ->

            that = @

            @$el.html template()

            # editor = new Pen(@$el.find('.content.visual')[0])
            mediumEditor = new MediumEditor('.content.visual', {
                diffTop: -20
            })
            @mediumEditor = mediumEditor

            # ace editor
            aceEditor = ace.edit($('.content.markdown')[0])
            MarkdownMode = ace.require('ace/mode/markdown').Mode
            aceEditor.getSession().setMode(new MarkdownMode())
            aceEditor.setOptions({
                showGutter: false,
                maxLines: Infinity,
                highlightGutterLine: true,
                showPrintMargin: false,
                enableSnippets: false
            })
            aceEditor.getSession().setUseWrapMode(true)
            @aceEditor = aceEditor

            $(document).on 'mouseup', (event) ->

                $target = $(event.target)
                if not (that.isInDomByClass($target, 'content') or
                    that.isInDomByClass($target, 'title') or
                    that.isInDomByClass($target, 'medium-editor-toolbar'))
                        that.aceEditor.focus()
                        that.$el.find('.content.visual').focusEnd()

            @initToolbar()

            @$el

        toImg: (canvas) ->

            $('#xxx')[0].src = canvas.toDataURL()

        # publish: () ->
        #
        #     that = @
        #     html2canvas that.$el.find('.content.visual'), {
        #         letterRendering: true,
        #         useCORS: true,
        #         # width: 100,
        #         # height: 1024,
        #         onrendered: (canvas) ->
        #             that.toImg(canvas)
        #     }

        publish: () ->

            originHTML = @$el.find('.content.visual').html()

            title = @$el.find('.title').text()
            content = toMarkdown(originHTML)

            App.article.update({
                id: 0,
                title: title,
                content: content
            }).done (data) ->
                alert(data)
            .fail (data) ->
                alert(data)

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

                        # $('html, body').animate({
                        #     scrollTop: $focusDom.offset().top - 600;
                        # }, 100)

                        that.initUpload($toolbar) if not that.toolbar

                        that.toolbar = $toolbar
                        that.$focusDom = $focusDom

                        # set toolbar position
                        leftPos = that.$focusDom.offset().left
                        topPos = that.$focusDom.offset().top
                        $toolbar.css('left', leftPos - 80 + 'px').css('top', topPos - 10 + 'px')
                        $toolbar.fadeIn('fast')

                else

                    $toolbar.fadeOut('fast')

        initUpload: ($toolbar) ->

            that = @

            # bind toolbar upload event
            $toolbar.dmUploader({

                url: "#{App.baseURL}/article/upload",
                dataType: 'json',
                allowedTypes: 'image/*',
                headers: {Token: $.localStorage('token')},

                onNewFile: (id, file) ->

                    # show image preview
                    oFReader = new FileReader()
                    oFReader.readAsDataURL(file)

                    oFReader.onload = (oFREvent) ->

                        if that.$focusDom and that.$focusDom.length

                            appendDom = '<img class="preview" data-id="' + id + '" />'

                            if that.$focusDom.prop('tagName') isnt 'P'
                                appendDom = "<p>#{appendDom}</p><p><br/></p>"
                            else
                                appendDom = "#{appendDom}<p><br/></p>"

                            insertRet = document.execCommand('insertHTML', true, appendDom)

                            if not insertRet
                                that.$focusDom.html(appendDom)

                            that.$focusDom.find('.preview')[0].src = oFREvent.target.result

                onUploadSuccess: (id, data) ->

                    if data.status

                        fileName = data.result
                        $imgDom = $('img.preview[data-id="' + id + '"]')
                        $imgDom[0].src = "#{App.baseURL}/#{fileName}"

            })

        modeSwitch: (event) ->

            $target = $(event.currentTarget)

            $visual = @$el.find('.content.visual')
            $markdown = @$el.find('.content.markdown')

            @$el.find('.edit-view li').removeClass('active')
            @$el.find('.content').hide()

            if $target.hasClass('visual')
                @$el.find('.edit-view .visual').addClass('active')
                @$el.find('.content.visual').focusEnd()
                contentHtml = @markdownConverter.makeHtml(@aceEditor.getValue())
                $visual.html(contentHtml)
                $visual.show()
            else
                @$el.find('.edit-view .markdown').addClass('active')
                @aceEditor.setValue(toMarkdown($visual.html()))
                @aceEditor.clearSelection()
                $markdown.show()

        write: () ->

        	workspace.navigate('write', {trigger: true})

    return WriteView
