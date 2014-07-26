$ () ->

    $('#main .submit').on 'click', () ->

    	$('#main').hide()
    	$('#article').show()
    	$('#person-overlay').css('display', 'flex')
    	$('#article').addClass('blur')

    $('.avatar').on 'click', () ->

    	$('#person-overlay').css('display', 'flex')
    	$('#article').addClass('blur')

    $('.close').on 'click', () ->

    	$('#person-overlay').hide()
    	$('#article').removeClass('blur')

    # create editor

    pen = new Pen({
        editor: $('[data-toggle="pen"]')[0],
        debug: true,
        list: ['blockquote', 'p', 'bold', 'italic', 'underline', 'createlink']
    })