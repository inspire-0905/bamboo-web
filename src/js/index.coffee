$ () ->

    $('#submit').on 'click', () ->

    	$('#main').hide()
    	$('#article').show()
    	$('#person-overlay').css('display', 'flex')
    	$('#article').addClass('blur-me')

    $('.avatar').on 'click', () ->

    	$('#person-overlay').css('display', 'flex')
    	$('#article').addClass('blur-me')

    $('.close').on 'click', () ->

    	$('#person-overlay').hide()
    	$('#article').removeClass('blur-me')