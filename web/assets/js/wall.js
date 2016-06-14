'use strict';
$(document).ready(function () {
	$('nav>ul>li').on('click', function() {
		$(this).addClass('current');
		$(this).siblings('li').removeClass('current');
	});

	$('nav>ul>li:eq(2)').on('click', function(event) {
		event.preventDefault();
		event.stopPropagation();
		$('.create-view-list').slideDown('250');
	});

	$('nav>ul>li li').on('click', function(e) {
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

	$('.filter-tool').on('click', function() {
		$('.filter-metric span').toggleClass('clicked');
		$('.filter-metric img').toggleClass('img-move');    
		$('.my-initatives').toggleClass('animate-list');  
		$('.my-initatives ul').toggleClass('switched');
		$('.my-initatives li').each(function(index, el) {     
			var listItem = $(this);     
			setTimeout(function() {
				listItem.toggleClass('animate-list');
			}, index*25);
		});
        getPeople(1);
        pageArrow = 1;
	});
    
    $('.panel-select-metric').on('click', function() {
        $(this).closest('ul').find('.panel-select-metric').removeClass('selected');
        $(this).addClass('selected');
        getPeople(1);
        pageArrow = 1;
    });

	// Select from geography-function-level filter
	$('.filter-menu li li').on('click', function() {
		$(this).children('span').css('visibility', 'visible');
		$(this).siblings().children('span').removeAttr('style');

		var i = $(this).parents('li').index();
		var filterName = $(this).children('.filter-choice-name').text();        
        var filterId = $(this).children('.filter-choice-name').attr('data_id');
        var filterType = $(this).children('.filter-choice-name').attr('filter_type');
        var filterTypeId = $(this).children('.filter-choice-name').attr('filter_type_id');
		$('.three-filters-group span:eq('+i+')').text(filterName).css('visibility', 'visible').attr('data_id', filterId).attr('filter_type', filterType).attr('filter_type_id', filterTypeId);
        getPeople(1);
        pageArrow = 1;
	});

	$('#clearFilteredList').on('click', function() {
		$('.three-filters-group span').removeAttr('style data_id filter_type filter_type_id');
		$('.filter-menu li li span:first-child').removeAttr('style');
        getPeople(1);
        pageArrow = 1;
	});

	$('.view-data-position button').on('click', function() {
		$(this).addClass('selected').siblings('button').removeClass('selected');
        getPeople(1);
        pageArrow = 1;
	});

	$('.wall-filter-percent span').on('click', function(event) {
		event.stopPropagation();
		$(this).hide().next('form').fadeIn().children().val('').focus();
	});

	$('.wall-filter-percent form').on('submit', function(event) {        
		event.preventDefault();
		var txt = $(this).children().val() + '%';
		$(this).hide().prev('span').text(txt).fadeIn();
        getPeople(1);
        pageArrow = 1;
	});

	$(document).on('click', function() {
		$('.wall-filter-percent form').hide().prev('span').show();
	});

	$('.view-grid-list button').on('click', function() {
		$(this).addClass('selected').siblings('button').removeClass('selected');
	});

	$('#viewByGrid').on('click', function() {
        getPeople(1, 'grid');
		$('.wall-view-list').addClass('wall-view-grid').removeClass('wall-view-list');
	});

	$('#viewByList').on('click', function() {
        getPeople(1);
        $('.wall-view-grid').addClass('wall-view-list').removeClass('wall-view-grid');
	});
    
    if($('.wall-view-cell').length === 0) {
        var text = '<div class="empty-wall">'+
            '<span>Your wall is under construction</span>'+
            '<span>It will be ready as soon as sufficent data becomes available.</span>'+
            '</div>';
        $('.wall-view-people').append(text);
    }

	$('.wall-view-cell:nth-child(n+13)').hide();

	$('.get-person-info').on('click', function() {
		$(this).toggleClass('clicked');
		$(this).next().toggleClass('flip');
	});

	var pageArrow=1;
        $('#scrollUp').on('click', function() {
            if(pageArrow > 1) {
                pageArrow--;
                getPeople(pageArrow);
            }
	});
	$('#scrollDown').on('click', function() {
            pageArrow++;
            getPeople(pageArrow);
	});
    
    function showHideScroll() {
        if(($('.wall-view-cell').length) < 12) {
            $('.scroll-up-down').hide();
        } else {
            $('.scroll-up-down').show();
        }
    }    
    
    showHideScroll();

    function getPeople(pageNo, viewType) {
        var wallStr = '';        
        wallStr = 'dir=' + $('.view-data-position .selected').text().toLowerCase();
        wallStr += '&matid=' + $('.switched .selected').attr('data-id');
        wallStr += '&type=' + $('.filter-metric .clicked').text();
        wallStr += '&perpage=' + 12,
        wallStr += '&percentage=' + ($('.wall-filter-percent span').text()).slice(0,-1);
        wallStr += '&pageno=' + pageNo;
        
        $.each($('.three-filters-group span'), function() {
            var filterId = $(this).attr('data_id'); 
            var filterType = $(this).attr('filter_type');
            var filterTypeId = $(this).attr('filter_type_id');
            var filterVal = $(this).text();
            if(filterType !== undefined) {
                wallStr += "&"+filterType+"="+filterId+"&";
                wallStr += filterType+"_name="+filterVal+"&";
                wallStr += filterType+"_id="+filterTypeId;
            }
        });
        $('.wall-overlay_form').show();
        $.ajax({
            url: '/wall/getList.jsp',
            type: 'POST',
            data: wallStr,
            dataType: 'html',
            success: function(resp) {
                $('.wall-overlay_form').hide();
                if(resp) {
                    if(viewType === 'list') {
                        $('.empty-wall').hide();
                        $('.wall-view-people').append(resp);
                        $('#page_no').val(pageNo);
                    } else {
                        $('.wall-view-people').html(resp);
                        $('#page_no').val(1);
                        if(pageNo === 1) {
                            showHideScroll();
                        }                        
                        if(pageNo > 1) {
                            if($('.wall-view-cell').length < 12) {
                                $('#scrollDown').hide();
                            } else {
                                $('#scrollDown').show();
                            }
                        }
                        
                        $('.get-person-info').on('click', function() {
                            $(this).toggleClass('clicked');
                            $(this).next().toggleClass('flip');
                        });
                    }
                } else {
                    pageArrow--;
                    if(pageNo === 1) {
                        $('.wall-view-people').html(resp);
                        if($('.wall-view-cell').length === 0) {
                            var text = '<div class="empty-wall">'+
                                '<span>Your wall is under construction</span>'+
                                '<span>It will be ready as soon as sufficent data becomes available.</span>'+
                                '</div>';
                            $('.wall-view-people').html(text);
                        }
                    }
                }
            }
        });   
    }    
    
    $('.wall-view-people').scroll(function(){
        var pageNo = parseInt($('#page_no').val());
        var heightDiv = 528;
        heightDiv = heightDiv * pageNo;
        if ($('.wall-view-people').scrollTop() == (heightDiv - $('.wall-view-people').height())){
            getPeople((pageNo+1), 'list');
        }
    });
});
