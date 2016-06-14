/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    $('.notif-box').on('click', function(event) {
        event.stopPropagation();
		$('.settings-sign-popup').hide();
        $('.num-view-notif').toggle();
    });
    
    $('.user-small-pic .profimg').on('click', function(event) {
		event.stopPropagation();
        $('.num-view-notif').hide();
		$(this).next().toggle();
	});
  
    $(document).on('click', function() {
        $('.num-view-notif').hide();
		$('.settings-sign-popup').hide();
	});
    
    $('#setUserDetails').on('click', function() {
		window.location.href = "profile.jsp";
	});
    
//    $('#signOut').on('click', function() {
//		window.location.href = "login.jsp";
//	});

    window.onorientationchange = function() { 
        window.location.reload();
    };
    
	$('#mobileSettings').on('click', function() {
		event.preventDefault();
        $(this).addClass('current').siblings().removeClass('current');
		$('.settings-sign-page').show('slide', {direction: 'right'}, 400);

		var marginLeft = $('.settings-sign-page div:first').offset().left;
		$('.settings-sign-page div:nth-child(3) a').offset({left: marginLeft});
        $('body').css('overflow', 'hidden');
        $(window).on('touchmove', function(e) {
            e.preventDefault();
            e.stopPropagation();
        }, false);
	});
    
    $('#mobileSettings div a').on('click', function() {
        event.stopPropagation();
    });
});