$(document).ready(function() {
	$('#username').on('click focus', function(event) {
		event.stopPropagation();
		$(this).prev('label').animate({'top':'0px'}, 100).addClass('done');

		if($('#password').val().length === 0) {
			$('#password').prev('label').animate({'top':'14px'}, 100).removeClass('done');
			$('#password').removeAttr('style');
		}
	});

	$('#password').on('click focus', function(event) {
		event.stopPropagation();
		$(this).prev('label').animate({'top':'0'}, 100).addClass('done');

		if($('#username').val().length === 0) {
			$('#username').prev('label').animate({'top':'14px'}, 100).removeClass('done');
			$('#username').removeAttr('style');
		}
	});

	function autoFill(target) {
		target.prev('label').css('top','0px').addClass('done');
	}

	setTimeout(function() {
        if($('#username').val().length !== 0) {
            autoFill($('#username'));		
        }
        if($('#password').val().length !== 0) {
            autoFill($('#password'));	
            return 0;
        }
        
        var isWebkit = 'WebkitAppearance' in document.documentElement.style;
        if(isWebkit) {
            if($('#password:-webkit-autofill').length !== 0) {
                autoFill($('#password'));		
            }
        }
    }, 100);
    
    $('#password').keypress(function(e) { 
        var s = String.fromCharCode(e.which);
        if(s.toUpperCase() === s && s.toLowerCase() !== s && !e.shiftKey ) {
            $('.caps-warning').show();
        } else {
            $('.caps-warning').hide();
        }
    });

	$(document).on('click', function(event) {
		if($('#username').val().length === 0) {
			$('#username').prev('label').animate({'top':'14px'}, 100).removeClass('done');
			$('#username').removeAttr('style');
		}
		if($('#password').val().length === 0) {
			$('#password').prev('label').animate({'top':'14px'}, 100).removeClass('done');
			$('#password').removeAttr('style');
		}
	});

	$('form span').on('click', function() {
//        if(!($(this).hasClass('clicked'))) {
//            $('.invalid-warning').removeClass('show');
//        } 
		$(this).addClass('clicked').siblings().removeClass('clicked');
		$(this).next().prop('checked', true);
        
		if($(this).hasClass('hr')) {
			$('body').addClass('hrdb');
			$('.login-form h2').addClass('flip');
		} else {
			$('body').removeClass('hrdb');
			$('.login-form h2').removeClass('flip');
		}
	});

	$('.login-form form button').on('click', function(event) {
		event.stopPropagation();
	});

	$('.forgot-pwd').on('click', function(e) {
		e.preventDefault();
		$('.login-form').hide();
		$('.forgot-password-form').show();
		if($('#username').val().length) {
			$('#email').val($('#username').val());
			$('#email').prev('label').css({'top':'0px'}).addClass('done');
		} else {
			$('#email').val('').removeAttr('style');
			$('#email').prev('label').css({'top':'14px'}).removeClass('done');
		}
	});

	$('.forgot-password-form a').on('click', function(e) {
		e.preventDefault();
		$('.forgot-password-form').hide();
        $('.forgot-password-form .invalid-warning').hide();
		$('.login-form').show();
	});
        
        $('#username').on('click', function () {
            setTimeout(function () {
                $('.invalid-warning').fadeOut();
            }, 'slow');
        });
        
        $('#password').on('click', function () {
            setTimeout(function () {
                $('.invalid-warning').fadeOut();
            }, 'slow');
        });
        
        $('#email').on('click', function () {
            setTimeout(function () {
                $('.invalid-warning').fadeOut();
            }, 'slow');
        });

	$('#email').on('click focus', function(event) {
		event.stopPropagation();
		$(this).prev('label').animate({'top':'0px'}, 100).addClass('done');
	});

	$(document).on('click', function(event) {
		if($('#email').val().length === 0) {
			$('#email').removeAttr('style');
			$('#email').prev('label').animate({'top':'14px'}, 100).removeClass('done');
		}
	});

	$('.forgot-password-form form').on('submit', function() {
        event.preventDefault();
        var postData = $('.forgot-password-form form').serialize();
        $.ajax({
            type: "POST",
            url: "/forgotpassword.jsp",
            data: postData,
            dataType: 'JSON',
            success: function(resp){
                if(resp.status === 0) {
                    $('.forgot-password-form').hide();
                    $('.thank-you-msg').show();
                    $('#femail').text($('#email').val());
                } else {
                    $('.forgot-password-form .invalid-warning').show();
                    setTimeout(function() {
                        $('.forgot-password-form .invalid-warning').fadeOut();
                    }, 8000);
                }
            }
        });
	});
});