jQuery(document).ready(function($) {
	$('nav>ul>li').on('click', function() {
		$(this).addClass('current');
		$(this).siblings('li').removeClass('current');
	});

	$('nav>ul>li:eq(2)').on('click', function(event) {
		event.preventDefault();
        event.stopPropagation(); 
		$('.create-view-list').slideDown('250');
	});
    
    $('nav>ul>li li').on('click', function(event) { 
        event.stopPropagation(); 
    });

	$('.create-view-list').children('span').on('click', function(event) {
		event.stopPropagation();
		$(this).parent('div').slideUp('250').find('li ul').hide();
	});

	$(document).click(function(){
        $('.create-view-list').slideUp('250');
		$('.user-profile-name ul').hide();
	});

	$('.user-profile-name p a').on('click', function(event) {
		event.stopPropagation();
		event.preventDefault();
		$('.user-profile-name ul').fadeToggle();
	});

	$('.compare-filter-type').on('click', function(event) {
        event.stopPropagation();
        $('.compare-score-name ul:visible').hide();
        
		if($(this).next('div').is(':visible') === true ) {
			$(this).next('div').hide();
		} else {
			$(this).next('div').show().siblings('div').hide();
			if($(this).next('div').find('ul').length > 3) {
				$(this).next('div').find('ul:nth-child(-n+3)').css('display', 'inline-block').show();
				$(this).next('div').find('ul:nth-child(n+4)').hide();
				$(this).next('div').find('.next-compare-list').css('display', 'inline-block').show();
				$(this).next('div').find('.prev-compare-list').hide();
			}
            
            //Remove 'All' option from the box
            $(this).next('div').find('li').filter(function() { 
                return $(this).text() === 'All';
            }).remove();
		}		
	});
    
    $(document).on('click', function(e) {
        $('.compare-filter-box').hide();
    });

	$('.compare-filter-box .next-compare-list').on('click', function() {
		var shownList = $(this).prev('div').children('ul:visible');

		if(shownList.eq(2).next('ul').next('ul').length<1) {
			$(this).hide();
		} 
		$(this).siblings('button').css('display', 'inline-block').show();

		shownList.eq(2).next('ul').css('display', 'inline-block').show();
		shownList.eq(0).hide();
	});

	$('.compare-filter-box .prev-compare-list').on('click', function() {
		var shownList = $(this).next('div').children('ul:visible');

		if(shownList.eq(0).prev('ul').prev('ul').length<1) {
			$(this).hide();
		} 
		$(this).siblings('button').css('display', 'inline-block').show();

		shownList.eq(0).prev('ul').css('display', 'inline-block').show();
		shownList.eq(2).hide();

	});

	$(document).on('click', function(event) {
		$('.compare-score-name ul:visible').hide();
	});

	$('.compare-score-box button').on('click', function(event) {
		event.stopPropagation();
        $('.compare-filter-box').hide();
		$(this).next('ul').slideToggle('300');
	});

	$('.focus-areas-header button').on('click', function() {
		var target = $('.initative-list-all');
		var divHeight = target.get(0).scrollHeight;

		if($(this).text() === 'Expand') {
			if(divHeight>132) {
				target.css({
				 	'height': '132px',
				 	'max-height': '264px'
				});

				if(divHeight>264) {
					target.animate({height : '264px'}, 400, function() {
						$('.focus-areas-header button').text('Collapse');
					});
				} else {
					target.animate({height : divHeight}, 400, function() {
						$('.focus-areas-header button').text('Collapse');
					});
				}

				$('.alerts-area-body').animate({height: 0}, 400, function() {
					$('.alerts-area-body').children('.alert-item').hide();
					$('.alerts-area-header button').text('Expand');
				});
			}
		} else if($(this).text() === 'Collapse') {
			target.animate({height : '132px'}, 400, function() {
				target.removeAttr('style');
				$('.focus-areas-header button').text('Expand');
			});

			var noOfOtherItems = $('.alerts-area-body').children('div').length;
			var otherDivHeight = noOfOtherItems * 44;

			if(otherDivHeight<132) {
				$('.alerts-area-body').animate({height: otherDivHeight}, 400, function() {
					$('.alerts-area-body').removeAttr('style');
					$('.alerts-area-body').children('.alert-item:nth-child(-n+' + noOfOtherItems + ')').show();
					$('.alerts-area-header button').text('Expand');
				});
			} else {
				$('.alerts-area-body').animate({height: '132px'}, 400, function() {
					$('.alerts-area-body').removeAttr('style');
					$('.alerts-area-body').children('.alert-item:nth-child(-n+3)').show();
					$('.alerts-area-header button').text('Expand');
				});
			}
		}		
	});
    
    if($('.initative-list').length === 0) {
        var text = '<div class="empty-focus-alert">'+
            '<span>The universe is infinite. Yet, this list is empty. You should do things like</span>'+
            '<span><span>&nbsp; i. Explore</span><span>&nbsp;ii. Setup a new initiative</span><span>iii. Ask your organisation to take a quick survey</span></span>'+
            '</div>';
        $('.initative-list-all').append(text);
    }
    
    $('.initative-list-all').on('click', '.initative-list', function(event) { 
        var id = $(this).attr('id');
        var arr = id.split('_');
        $('.initative-details-popup').html($('#popup_'+arr[1]).html()).show().animate({'top': '80px'}, 400);
        
        // To show placeholder text for IE
        if(navigator.userAgent.match(/Trident.*rv\:11\./)) {
            $('textarea').val('');
        }
                       
        $('.do-more-incomplete>button').on('click', function (event) {
            event.stopPropagation();
            $('.initative-details-popup').hide().css('top', '-478px');
        });
              
        $('.do-more-incomplete div>button').on('click', function (event) {
            $(this).toggleClass('active');
            $(this).next('ul').slideToggle('fast');
        });
        
        $('#deletePopup').on('click', function() {
            var target = $(this).parents('.initative-details-popup');
            target.hide('fast', function() {
                target.css('top', '-478px');
            });
            
            var init = $('#row_'+$(this).attr('data-id'));
            setTimeout(function() {            
                init.after('<div class="undo-mark">Deleted <span><span>| &#x21A9;</span> Undo</span></div>');
                init.hide().removeClass('delete-initative-list');
            }, 300);
            setTimeout(function() {
                init.next().remove();
            }, 8000);
        });

        $('.popup-name button').on('click', function (event) {
            var target = $(this).parents('.initative-details-popup');
            target.addClass('animate-popup');
            target.hide('fast', function() {
                target.removeClass('animate-popup').css('top', '-478px');
                target.parents('.initative-list').hide('slide', {direction: 'right'});
            });
            
            var init = $('#row_'+$(this).attr('data-id'));
            setTimeout(function() {  
                init.hide('slide', {direction: 'right'}, function() {
                    init.after('<div class="undo-mark">Completed <span><span>| &#x21A9;</span> Undo</span></div>');
                });  
            }, 300);
            setTimeout(function() {
                init.next().remove();
            }, 8000);  
        });
    });

    $('.initative-list-all').on('click', '.list-remove', function(event) {
        event.stopPropagation();
        $(this).parents('.initative-list').addClass('delete-initative-list');

        var $target = $(this);
        setTimeout(function () {            
            $target.parents('.initative-list').after('<div class="undo-mark">Deleted <span><span>| &#x21A9;</span> Undo</span></div>');
            $target.parents('.initative-list').hide().removeClass('delete-initative-list');
        }, 250);

        setTimeout(function () {
            $target.parents('.initative-list').next().remove();
        }, 8000);
    });
    
    $('.initative-list-all').on('click', '.list-complete', function(event) {
        event.stopPropagation();
        $(this).addClass('finished-look');

        var $target = $(this);
        setTimeout(function () {
            $target.parents('.initative-list').hide('slide', {direction: 'right'}, function() {
                $target.parents('.initative-list').after('<div class="undo-mark">Completed <span><span>| &#x21A9;</span> Undo</span></div>');
            });  
        }, 250);
        setTimeout(function () {
            $target.parents('.initative-list').next().remove();
        }, 8000);
    });
    
    $('.initative-list-all').on('click', '.undo-mark', function() {
        $(this).hide();
        $(this).prev().show('slide', {direction: 'right'}).find('.list-complete').removeClass('finished-look');
    });
    
    $(document).keyup(function(e) { 
        if (e.keyCode === 27) {
            $('.initative-details-popup').hide().css('top', '-478px');
        }
    });

	$('.alerts-area-header button').on('click', function() {
		var target = $(this).parent('div').next('div');

		var noOfItems = target.children('div').length;
		var divHeight = noOfItems * 44;

		if($(this).text() === 'Expand') {
			if(divHeight>132) {
				target.css({
				 	'height': '132px',
				 	'max-height': 'none'
				});

				if(divHeight>264) {
					target.animate({height : divHeight}, 400, function() {
						$(this).children('.alert-item').show();
						$('.alerts-area-header button').text('Collapse');
					});
				} else {
					target.animate({height : divHeight}, 400, function() {
						$(this).children('.alert-item').show();
						$('.alerts-area-header button').text('Collapse');
					});
				}

				$('.initative-list-all').animate({height: 0}, 400, function() {
					$('.focus-areas-header button').text('Expand');
				});
			}
		} else {
			target.animate({height : '132px'}, 400, function() {
				target.removeAttr('style');
				$(this).children('.alert-item:nth-child(n+4)').hide();
				$('.alerts-area-header button').text('Expand');
			});

			var otherDivHeight = $('.initative-list-all').get(0).scrollHeight;

			if(otherDivHeight<132) {
				$('.initative-list-all').animate({height: otherDivHeight}, 400, function() {
					$('.initative-list-all').removeAttr('style');
					$('.focus-areas-header button').text('Expand');
				});
			} else {
				$('.initative-list-all').animate({height: '132'}, 400, function() {
					$('.initative-list-all').removeAttr('style');
					$('.focus-areas-header button').text('Expand');
				});
			}
		}		
	});
    
    if($('.alert-item').length === 0) {
        var text = '<div class="empty-focus-alert">'+
            '<span>No alerts for you</span>'+
            '<span>You have managed your people well. Good job!!</span>'+
            '</div>';
        $('.alerts-area-body').append(text);
    }

	$('.alert-people-icon').on('click', function() {
        $('.alert-people-list:visible').hide();
		$(this).next('div').show();
	});

	$('.close-alert-people').on('click', function() {
		$(this).parents('.alert-people-list').hide();
	});
    
    $(document).keyup(function(e) { 
        if (e.keyCode === 27) {
            $('.alert-people-list:visible').hide();
        }
    });

	$('.alert-remove').on('click', function(event) {
		$(this).parents('.alert-item').hide('slide', {direction: 'up'}, 400, function() {
			$(this).remove();
		});
	});
});	