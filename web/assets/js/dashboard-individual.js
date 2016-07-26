$(document).ready(function() {
    if(document.documentElement.clientWidth > 480) { 
       
        $('.appreciateMetric').on('click', function() {
            $('#selectedmetid').val($(this).attr('data-id'));
            clearRatings();
            fetchSmartData();

            $('.appreciateMetric').removeClass('selected');
            $(this).addClass('selected');
            $('.search-colleague').val('');
            $('.initiatives-feed').hide('slide', {direction: 'up'}, function() {
                $('.people-list-box').show();
                searchIndividual();                  
                setTimeout(function() {
                    $('.individuals-grid').css('top', '0px');
                }, 400);
            });
        }); 

        if($('.initiatives-list').height() > 352) {                
            $('.initiatives-list').slimScroll({
                height: '352px',
                alwaysVisible: true,
                color: '#4caf50',
                railColor: '#d7d7d7',
                railOpacity: 0.5,
                railVisible: true
            });
        } 
                                    
        if($('.activity-list').height() > 352) {                
            $('.activity-list').slimScroll({
                height: '352px',
                alwaysVisible: true,
                color: '#4caf50',
                railColor: '#d7d7d7',
                railOpacity: 0.5,
                railVisible: true
            });
        } else {
            $('.activity-list').css('min-height', 352);
        }
        
        $('.initiatives-list').on('click', '.initiative-row', function(event) { 
            var id = $(this).attr('id');
            var arr = id.split('_');
            $('.initiative-details-popup').html($('#popup_'+arr[1]).html()).show().animate({'top': '80px'}, 400);
            
            $('.do-more-incomplete button').on('click', function(event) {
                event.stopPropagation();
                $('.initiative-details-popup').hide().css('top', '-478px');
            });
            
            // To show placeholder text for IE
            if(navigator.userAgent.match(/Trident.*rv\:11\./)) {
                $('textarea').val('');
            }
        });
    }
    
	$('.search-popup button').on('click', function() {
		$(this).next().show('slide', { direction: 'left' }, 500);
	});

    //var $rows = $('.initiative-row');
	$('.search-initiative').on('input', function() {
        var $rows = $('.initiative-row');
        var val = '(?=.*' + $.trim($(this).val()).split(/\s+/).join(')(?=.*') + ').*$',
         reg = RegExp(val, 'i'),
         text;

        $rows.show().filter(function() {
          text = $(this).find('.initiative-title').text().replace(/\s+/g, ' ');
          return !reg.test(text);
        }).hide();

        if($('.initiatives-list')[0].scrollHeight > 352) {
            $('.initiatives-list').slimScroll({
                height: '352px',
                alwaysVisible: true,
                color: '#4caf50',
                railColor: '#d7d7d7',
                railOpacity: 0.5,
                railVisible: true
            });
        } else {
            $('.initiatives-list').slimScroll({destroy: true});
            $('.my-initiatives .slimScrollBar, .my-initiatives .slimScrollRail').remove();
            $('.initiatives-list').removeAttr('style');
        }
	});

	$('#sortByDate').on('click', function() {
        var $content = $('.initiatives-list'),
        $elements = $('.initiative-row');
    
        if($(this).hasClass('selected')) {
            var elements = $.sortByDate($elements, 'DESC');
            var html = '';
            for(var i = 0; i< elements.length; ++i ) {
              html += elements[i].html;
            }
            $content.children('.initiative-row').remove();
            $content.append(html);

            $(this).removeClass('selected');
        }
        else {
            var elements = $.sortByDate($elements, 'ASC');
            var html = '';
            for(var i = 0; i < elements.length; ++i) {
              html += elements[i].html;
            }
            $content.children('.initiative-row').remove();
            $content.append(html);

            $(this).addClass('selected');
        }
    });
            
    function compareAsc(a,b) {
      if (a.time < b.time)
        return -1;
      else if (a.time > b.time)
        return 1;
      else 
        return 0;
    }
    function compareDesc(a,b) {
      if (a.time < b.time)
        return 1;
      else if (a.time > b.time)
        return -1;
      else 
        return 0;
    }
            
    $.sortByDate = function(elements, order) {
        var arr = [];
        elements.each(function() {
            var obj = {},
             $el = $(this),
             time = $el.find('.initiative-date').attr('title'),
             date = new Date($.trim(time)),
             timestamp = date.getTime();

            obj.html = $el[0].outerHTML;
            obj.time = timestamp;
            arr.push(obj);
        });
        var sorted;
        if(order === 'ASC') {
          sorted = arr.sort(compareAsc);
        }
        else {
          sorted = arr.sort(compareDesc); 
        }
        return sorted;
    };    

    $(document).keyup(function(e) {
        if(e.keyCode === 27) { 
            $('.initiative-details-popup').hide().css('top', '-478px');
        }
    });
    
    $('.search-colleague').on('input', function(){
        fetchOrgnizationSearch($(this).val());
    });
        
    if($('.initiative-row').length === 0) {
        var text = '<div class="no-initiative">'+
            '<span>The universe is infinite. Yet, this list is empty. You should do things like</span>'+
            '<span><span>&nbsp; i. Appreciate someone</span><span>&nbsp;ii. Take a quick survey</span><span>iii. Setup your profile on the Settings page</span></span>'+
            '</div>';
        $('.initiatives-list').append(text);
    }
    
    if($('.activity-group').length === 0) {
        var text = '<div class="no-activity">'+
            '<span>Nothing to report.</span>'+
            '<span>Appreciate someone and check back later</span>'+
            '</div>';
        $('.activity-list').append(text);
    }

	$('#closeGroupAppreciate').on('click', function() {
		$('.people-list-box').hide('slide', {direction: 'up'}, function() {
			$('.initiatives-feed').show();
            $('.appreciateMetric').removeClass('selected');
		});
	});

    $('.filter-row .filter-menu li li').on('click', function() {
		$(this).children('span:first-child').css('visibility', 'visible');
        $(this).parents('li').children('span').addClass('highlight');
		$(this).siblings().children('span').removeAttr('style');
		var i = $(this).parents('li').index();
		var filterName = $(this).children('.filter-choice-name').text();
        var filterId = $(this).children('.filter-choice-name').attr('data_id');
        var filterType = $(this).children('.filter-choice-name').attr('filter_type');
        var filterTypeId = $(this).children('.filter-choice-name').attr('filter_type_id');
		$('.three-filters-group span:eq('+i+')').text(filterName).css('visibility', 'visible').attr('data_id', filterId).attr('filter_type', filterType).attr('filter_type_id', filterTypeId);
        $('.search-colleague').val('');
        fetchFilteredData();
	});
            
	$('.get-person-info').on('click', function() {
		$(this).toggleClass('flip');
		$(this).next('div').toggleClass('flip');
	});

	$('.rating-star').on('click', function() {
		var row = $(this).parent();
		var i = $(this).index();
		var lastStar = $(row).find('.filled:last').index();
		var total = i+1;
		if(lastStar === i) {
			$(row).children().removeClass('filled');
			$(row).next().text('0').removeAttr('style');
		} else {
			$(this).nextAll().removeClass('filled');
			for(var n=0; n<=i; n++) {
				$(row).children('span:eq('+n+')').addClass('filled');
			}
			$(row).next().text(total).css('visibility', 'visible');
		}
        saveRating();
	});

	$('.individuals-prev').on('click', function() {
		event.preventDefault();
		if($('.individuals-grid')[0].style.top !== '0px') {
			$('.individuals-grid').animate({'top':'+=200px'}, 0);
		}
	});

	$('.individuals-next').on('click', function() {
		event.preventDefault();
		var height = $('.individuals-grid').height() - 400;
		var limit;
		if(height === 0) {
			limit = height + 'px';
		} else {
			limit = '-' + height + 'px';
		}
		if($('.individuals-grid')[0].style.top !== limit) {
			$('.individuals-grid').animate({'top':'-=200px'}, 0);
		}
	});

	$('.dashboard .submit-circle button').on('click', function(event) {
        var empArr = jQuery.data(document.body, "emp_rating");
		if(empArr.length === 0) {
            if (document.documentElement.clientWidth <= 480) {
                $('.submit-tooltip').css('visibility', 'visible');
                 setTimeout(function() {
                    $('.submit-tooltip').css('visibility', 'hidden'); 
                }, 400);
            }
			$('.submit-tooltip').children('.submit-title').hide();
			$('.submit-tooltip').children('.submit-response').show();
		} else {
            if (document.documentElement.clientWidth <= 480) {
                $('.submit-tooltip').removeAttr('style');
            }
			submitAppreciation();
		}

		$(this).on('mouseout', function() {
			setTimeout(function() {
				$('.submit-tooltip').children('.submit-title').show();
				$('.submit-tooltip').children('.submit-response').hide();
			}, 400);
		});
	});
    
    // To display filter in tablets
    if ('ontouchstart' in document.documentElement) {
        if (document.documentElement.clientWidth > 480) {
            $('.filter-row .get-filter-list').on('click', function() {
                $('.filter-menu').toggle();
                $('.filter-menu li ul').hide();
            });
            
            $('.filter-row .filter-menu>ul>li').on('click', function(e) {
                e.stopPropagation();
                if($(this).find('ul').is(':visible')) {
                    $('.filter-menu li ul').hide();
                } else {
                    $('.filter-menu li ul').hide();
                    $(this).find('ul').show();
                }
            });
            
            $('.filter-row .filter-menu li li').on('click', function() {
                $('.filter-menu').hide();
            });
        }
    }

    if (document.documentElement.clientWidth <= 480) {
        $('header li').on('click', function() {
            event.preventDefault();
            $(this).addClass('current').siblings().removeClass('current');

            if($(this).index() > 0 && $(this).index() < 4) {
                if($(this).index() === 1) {
                  $('.main .wrapper').attr('class', 'wrapper dashboard').addClass('metrics');
                  window.location.href='dashboard.jsp';
                }
                if($(this).index() === 2) {
                  $('.main .wrapper').attr('class', 'wrapper dashboard').addClass('initiatives');
                  window.location.hash = 'initiatives';
                }
                if($(this).index() === 3) {
                  $('.main .wrapper').attr('class', 'wrapper dashboard').addClass('notification');
                  window.location.hash = 'notification';
                }
                $('.people-list-box').hide();
                $('.settings-sign-page').hide('slide', {direction: 'right'}, 400);
                $('body').removeAttr('style');
                $(window).off('touchmove');
            }
            else if($(this).index() === 0)  {
                window.location.href= 'survey.jsp';
            }
            else if($(this).index() === 4) {
                $('.settings-sign-page').show('slide', {direction: 'right'}, 400);
                var marginLeft = $('.settings-sign-page div:first').offset().left;
                $('.settings-sign-page div:nth-child(3) a').offset({left: marginLeft});
                $('body').css('overflow', 'hidden');
            }
        });
        
    
        $('.appreciateMetric').on('click', function() {
            $('#selectedmetid').val($(this).attr('data-id'));
            clearRatings();
            fetchSmartData();
            $('.search-colleague').val('');
            $('.mobile-filter-row').removeClass('chosen');
            $('.mobile-filter-row>div').hide();
            $('.mobile-filter-row .filter-menu input').prop('checked', false);
            
            var titleName = $(this).parent().find('.panel-name').text();
            var titleText = '<div class="page-title">' +
             '<button id="goToMetrics">' +
             '<img src="../assets/images/individual_settings_back_icon.png" alt="Back" width="25" height="25">'+
             '</button>' +
             '<img src="../assets/images/individual_panel_'+titleName.toLowerCase()+'_pic.png" alt="'+titleName+'" width="50" height="50">'+
             '<span>' + titleName + '</span>' +
             '</div>';
            $('.people-list-box').find('.page-title').remove();
            $('.people-list-box').prepend(titleText);
            $('.people-list-box').show('slide', {direction: 'right'}, 400);
            searchIndividual();     

            $('#goToMetrics').on('click', function() {
              $('.people-list-box').hide('slide', {direction: 'right'}, 400, function() {
                  $('.panels-timeseries').removeAttr('style');
              });
            });
            
            $('.panels-timeseries').hide();
        });
        
        $('.search-colleague').attr('placeholder', 'Search for a colleague');

        $('.mobile-filter-row').on('click', function(event) {
          $(this).children('div').fadeToggle('200');
          $('.no-key-selected-mobile > div').hide();
        });
        
        $(document).on('click', '.no-key-selected-mobile', function (event) {
//        $('.no-key-selected-mobile').on('click', function (event) {
            $(this).children('div').fadeToggle('200');
            $(this).children('div').css('position', 'absolute');
            $(this).children('div').css('z-index', '1');
            $(this).children('div').css('margin-left', '-200px');
            $('.mobile-filter-row > div').hide();
        });
        
        $('#closeFilter').on('click', function(){
            event.stopPropagation();
            $('.mobile-filter-row>div').fadeOut('200', function() {
                $('.mobile-filter-row .filter-menu li ul').hide();
            });
        });
        
        $('#chooseMobileFilter').on('click', function() {
            $('.search-colleague').val('');
            fetchFilteredDataMobile();
            $('.mobile-filter-row .filter-menu li ul').hide();
        });
        
        $('.mobile-filter-row .filter-menu>ul>li').on('click', function() {
            event.stopPropagation();
            $(this).children('ul').slideToggle('400');
            $(this).siblings('li').children('ul').slideUp('400');
        });
        
        $('.mobile-filter-row .filter-menu li li').on('click', function() {
            event.stopPropagation();
        });

        $(window).scroll(function () {
            if ($(document).height() <= $(window).scrollTop() + $(window).height()) {
                $('.individuals-box').css('max-height', '+=400px');
            }
        }); 

        $('.initiatives-list').on('click', '.initiative-row', function(event) {
            var id = $(this).attr('id');
            var arr = id.split('_');
            $('.initiative-details-popup').html($('#popup_'+arr[1]).html()).show('slide', {direction: 'right'}, 400);
            $('.initiative-details-popup .details-calendar-type-two').find('.calendar-due-date').remove();
            $('.initiative-details-popup .calendar-due-date').appendTo('.details-calendar-type-two div'); 
            $('.popup-header .goToInitiatives').remove();
            $('.popup-header').prepend('<button class="goToInitiatives">' +
              '<img src="../assets/images/individual_settings_back_icon.png" alt="Back" width="25" height="25">'+
              '</button>');
            $('.popup-chat-box button').text(''); 
            
            $('#popup-score_'+arr[1]).find('ul').slick({ 
                slidesToShow: 3,
                slidesToScroll: 2,
                slide: 'li',
                arrows: false,               
                infinite: false,
                variableWidth: true
            });
            
            $('.goToInitiatives').on('click', function() {
              $('.initiative-details-popup').hide('slide', {direction: 'right'}, 400);
            });
        });
        
        if (document.documentElement.clientWidth <= 480) {
            $('.initiative-row').on('click', function () {
                $('.initiatives-list').hide();
            });
            $('.initiative-details-popup').on('click', '.goToInitiatives',function () {
                $('.initiatives-list').show();
            });
        }
    }
});

/* Search functionality using Isotope begins */
function searchIndividual() {
    var qsRegex;
    // init Isotope
    var $grid = $('.individuals-grid').isotope({
      itemSelector: '.individual-cell',
      layoutMode: 'fitRows'
    }); 
    $('.individuals-grid').css('top', '0px');
//    Slimscroll for individuals-grid
    if ($('.individuals-grid').height()>400){
         if($('.individuals-grid').width()>290){ 
        $('.individuals-grid').slimScroll({
            height: '400px',
            color: '#388E3C',
            railVisible: true,
            railColor: '#D7D7D7',
            alwaysVisible: true,
            touchScrollStep: 50
        });
        } else {
            $('.individuals-grid').slimScroll({
                destroy: true
            });
        }
    } else{ 
        $('.individuals-grid').slimScroll({
                destroy: true
            });
    }
//    Slimscroll for List of Individuals selected to be appreciated
    if ($('.list-of-people-selected').height() > 400) {
            $('.no-key-selected').slimScrollPopupDashboard({
                height: '400px',
                width: '286px',
                color: '#388E3C',
                railVisible: true,
                railColor: '#D7D7D7',
                alwaysVisible: true,
                touchScrollStep: 50
            });
            $('.no-key-selected').css('margin-right','0');
    } else {
        $('.list-of-people-selected').slimScrollPopupDashboard({
            destroy: true
        });
    }
    
//    if($('.individuals-grid').height() <= 400) {
//        $('.individuals-box-scroll').css('visibility', 'hidden');
//    } else {
//        $('.individuals-box-scroll').removeAttr('style');
//    }
}
// debounce so filtering doesn't happen every millisecond
function debounce( fn, threshold ) {
  var timeout;
  return function debounced() {
    if(timeout) {
      clearTimeout( timeout );
    }
    function delayed() {
      fn();
      timeout = null;
    }
    timeout = setTimeout( delayed, threshold || 100 );
  };
}

function saveRating() {
    var empArr = jQuery.data(document.body, "emp_rating");
    if(empArr == undefined) {
        empArr = [];
    }
    jQuery.each($('.star-rating-total'), function(i,v) {
        var empRating = {};
        var empId = $(v).attr('emp_id');
        var quesId = $(v).attr('ques_id');
        var rating = $(v).text();
        if(rating !== '' && rating > 0) {
            empRating[quesId + '_' + empId] = rating;
            empArr.push(empRating);
        }else {
            jQuery.each(empArr, function(n,o) {
                if(o != undefined) {
                    jQuery.each(o, function(k,v) {
                        if(k.split("_")[1] == empId) {
                            empArr.splice(n,1);
                        }
                    });
                }
            });
        }
    });
    jQuery.data(document.body, "emp_rating", empArr);
}

function clearRatings() {
    jQuery.each($('.star-rating-total'), function(i,v) {
        $(v).text('');
    });
    jQuery.data(document.body, "emp_rating", []);
}

function displayRatings(id, score) {
    if(score === '0') { 
        score = ''; 
    }
	var row = $('.star-rating-total#'+id).prev();
    $('.star-rating-total#'+id).text(score).css('visibility', 'visible');
    if(score === '') {
        $('.star-rating-total#'+id).removeAttr('style');
    }
    $(row).children().removeClass('filled');
	for(var n=0; n<score; n++) {
		$(row).children('span:eq('+n+')').addClass('filled');
	}
}

function fetchAndPopulateRating() {
    var empRatingArr = jQuery.data(document.body, "emp_rating");
    if(empRatingArr != undefined) {
        jQuery.each(empRatingArr, function(i,o){
            jQuery.each(o, function(k, v){
               displayRatings('rat_'+k, v); 
            });
        });
    }
}

function fetchOrgnizationSearch(q) {
    $('.mobile-filter-row .filter-menu li ul').hide();
    saveRating();
    var mid = $('#selectedmetid').val();
    var query = "q="+q+"&mid="+mid;
    $('.overlay_form').show();
    var currentRequest = null;
    currentRequest = $.ajax({
        type: "POST",
        url: "/individual/searchOrgList.jsp",
        data: query,
        dataType: 'HTML',
        beforeSend : function()    {           
            if(currentRequest !== null) {
                currentRequest.abort();
            }
        },
        success: function(resp){
            $('.overlay_form').hide();
            $('.individuals-box').html(resp);
            fetchAndPopulateRating();
            searchIndividual();
            $('.three-filters-group span').removeAttr('style').removeAttr('data_id').removeAttr('filter_type').removeAttr('filter_type_id');
            $('.filter-row .filter-menu>ul>li>span').removeClass('highlight');
            $('.filter-row .filter-menu li li span').removeAttr('style');
            $('.mobile-filter-row').removeClass('chosen');
            $('.mobile-filter-row .filter-menu input').prop('checked', false);
        }
    });
}

function fetchFilteredData() {
    saveRating();
    var filterData = {};
    $.each($('.three-filters-group span'), function(i, v) {
       var filterId = $(v).attr('data_id'); 
       var filterType = $(v).attr('filter_type');
       var filterTypeId = $(v).attr('filter_type_id');
       var filterVal = $(v).text();
       if(filterType !== undefined) {
        filterData[filterType] = filterId;
        filterData[filterType+"_id"] = filterTypeId;
        filterData[filterType+"_name"] = filterVal;
       }
    });
    $('.overlay_form').show();
    $.ajax({
        type: "POST",
        url: "/individual/dashboardsmartlist.jsp",
        data: filterData,
        dataType: 'HTML',
        success: function(resp){
            $('.overlay_form').hide();
            $('.individuals-box').html(resp);
            fetchAndPopulateRating();
            searchIndividual();
        }
    });
}

function fetchFilteredDataMobile() {
    saveRating();
    var filterData = {};
    $.each($('.mobile-filter-row .filter-menu>ul>li'), function(i, v) {
       var filterId = $(v).find('input:checked').attr('data_id'); 
       var filterType = $(v).find('input:checked').attr('filter_type');
       var filterVal = $(v).find('input:checked').next().text();
       var filterTypeId =$(v).find('input:checked').attr('filter_type_id');
       if(filterType !== undefined) {
        filterData[filterType] = filterId;
        filterData[filterType+"_id"] = filterTypeId;
        filterData[filterType+"_name"] = filterVal;
       }
    });
    $('.overlay_form').show();
    $.ajax({
        type: "POST",
        url: "/individual/dashboardsmartlist.jsp",
        data: filterData,
        dataType: 'HTML',
        success: function(resp){
            $('.overlay_form').hide();
            $('.mobile-filter-row').addClass('chosen');
            $('.individuals-box').html(resp);
            fetchAndPopulateRating();
            searchIndividual();
        }
    });
}

function fetchSmartData() {
    $('.search-colleague').val('');
    $('.mobile-filter-row .filter-menu li ul').hide();
    saveRating();
    var smartData = {'mid':$('#selectedmetid').val()};
    $('.overlay_form').show();
    $.ajax({
        type: "POST",
        url: "/individual/dashboardsmartlist.jsp",
        data: smartData,
        dataType: 'HTML',
        success: function(resp){
            $('.overlay_form').hide();
            $('.individuals-box').html(resp);
            fetchAndPopulateRating();
            searchIndividual();
            $('.three-filters-group span').removeAttr('style').removeAttr('data_id').removeAttr('filter_type').removeAttr('filter_type_id');
            $('.filter-row .filter-menu>ul>li>span').removeClass('highlight');
            $('.filter-row .filter-menu li li span').removeAttr('style');
            $('.mobile-filter-row').removeClass('chosen');
            $('.mobile-filter-row .filter-menu input').prop('checked', false);
        }
    });
}

function submitAppreciation() {
    var empArr = [];
    var empRating = {};
    var savedRating = jQuery.data(document.body, "emp_rating");
    jQuery.each(savedRating, function(i,o){
        jQuery.each(o, function(k, v){
            if(v > 0) {
                empRating[k.split("_")[1]] = v;
                empArr.push(empRating); 
            }
        });
    });
    var postData = {'mid':$('#selectedmetid').val(), 'emp_rating':JSON.stringify(empRating)};
    $.ajax({
        type: "POST",
        url: "/individual/saveappreciation.jsp",
        data: postData,
        dataType: 'JSON',
        success: function(resp){
            if (document.documentElement.clientWidth <= 480) {
                $('.people-list-box').hide('slide', {direction: 'right'}, 400, function() {
                  $('.panels-timeseries').removeAttr('style');
                });
            } else {
                $('.people-list-box').hide('slide', {direction: 'up'}, function() {
                    $('.initiatives-feed').show();
                    $('.appreciateMetric').removeClass('selected');
                });
           }
           jQuery.data(document.body, "emp_rating", []);
           clearRatings();
        }
    });
}