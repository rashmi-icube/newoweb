$(document).ready(function () {
    $('.site-nav-prev').on('click', function () {
        event.preventDefault();
        var $currentDiv = $('.question_div:visible');
        var $prevDiv = $currentDiv.prevAll('div.question_div').eq(0);
        $(this).addClass('active');
        $('body').css('overflow', 'hidden');
        $currentDiv.hide('slide', {direction: 'right'}, 200);
        $prevDiv.show('slide', {direction: 'left'}, 500, function () {
            $('.site-nav-prev').removeClass('active');
            searchIsotope();
            showHideNavigation(this);
            $('body').removeAttr('style');
        });

    });

    $('.site-nav-next').on('click', function () {
        event.preventDefault();
        var $currentDiv = $('.question_div:visible');
        var $nextDiv = $currentDiv.nextAll("div.question_div").eq(0);
        $(this).addClass('active');
        $('body').css('overflow', 'hidden');
        $currentDiv.hide('slide', {direction: 'left'}, 200);
        $nextDiv.show('slide', {direction: 'right'}, 500, function () {
            $('.site-nav-next').removeClass('active');
            searchIsotope();
            showHideNavigation(this);
            $('body').removeAttr('style');
        });
    });


    /****************************************** SURVEY-ME ***********************************************/

    $('.answer-range button').on('click', function (event) {
        $(this).toggleClass('clicked').parent().toggleClass('clicked');
        var quesId = $(this).parent().parent().attr('ques_id');
        $('#resp_val_' + quesId).val($(this).val());
        $(this).parent('div').siblings().removeClass('clicked').children().removeClass('clicked');
    });

    $('.survey-me .submit-circle button').on('click', function (event) {
        var quesId = $(this).val();
        if ($('.answer-range .clicked').length === 0) {
            $('.submit-tooltip').children('.submit-title').hide();
            $('.submit-tooltip').css({width: '165px', padding: '5px 0'}).children('.submit-response').show();
            if (document.documentElement.clientWidth <= 480) {
                $('.submit-tooltip').css('visibility', 'visible');
                setTimeout(function () {
                    $('.submit-tooltip').css('visibility', 'hidden');
                }, 400);
            }
        } else {
            var dataSub = {'comp_id': jQuery('#comp_id_' + quesId).val(), 'emp_id': jQuery('#emp_id_' + quesId).val(), 'question_id': jQuery('#question_id_' + quesId).val(), 'feedback': jQuery('#feedback_' + quesId).val(), 'resp_val': jQuery('#resp_val_' + quesId).val(), 'rela_val': jQuery('#rela_val_' + quesId).val()};
            jQuery.ajax({
                type: "POST",
                url: "/individual/survey-me-submit.jsp",
                data: dataSub,
                dataType: 'JSON',
                success: function (resp) {
                    var totalQues = parseInt($('#remaining_ques').val());
                    totalQues = totalQues - 1;
                    $('#remaining_ques').val(totalQues + "");
                    var $currentDiv = $('.question_div:visible');
                    var $nextDiv = $currentDiv.nextAll("div.question_div").eq(0);
                    if ($nextDiv.length) {
                        $('.site-nav a').addClass('active');
                        $('body').css('overflow', 'hidden');
                        $currentDiv.hide('slide', {direction: 'left'}, 200);
                        $nextDiv.show('slide', {direction: 'right'}, 400, function () {
                            $('.site-nav a').removeClass('active');
                            searchIsotope();
                            $currentDiv.remove();
                            showHideNavigation(this);
                            $('body').removeAttr('style');
                        });
                    } else {
                        $currentDiv.remove();
                        window.location.href = 'dashboard.jsp';
                    }
                }
            });
        }

        $(this).on('mouseout', function () {
            setTimeout(function () {
                $('.submit-tooltip').children('.submit-title').show();
                $('.submit-tooltip').children('.submit-response').hide().end().removeAttr('style');
            }, 400);
        });
    });

    /****************************************** SURVEY-WE *******************************************/
    
    if ($('.survey-we').is(':visible')) {
        searchIsotope();
    }

    $('.search-colleague').on('input', function () {
        fetchOrgnizationSearch($(this).val(), $(this).attr('ques_id'), this);
    });

    $('.filter-row .filter-menu li li').on('click', function () {
        $(this).children('span').css('visibility', 'visible');
        $(this).parents('li').children('span').addClass('highlight');
        $(this).siblings().children('span').removeAttr('style');
        $('.search-colleague').val('');
        var filterMenu = $(this).parents('.filter-menu');
        var questionId = filterMenu.attr('ques_id');

        var i = $(this).parents('li').index();
        var filterName = $(this).children('.filter-choice-name').text();
        var filterId = $(this).children('.filter-choice-name').attr('data_id');
        var filterType = $(this).children('.filter-choice-name').attr('filter_type');
        var filterTypeId = $(this).children('.filter-choice-name').attr('filter_type_id');
        $('.three-filters-group span:eq(' + i + ')').text(filterName).css('visibility', 'visible').attr('data_id', filterId).attr('filter_type', filterType).attr('filter_type_id', filterTypeId);
        fetchFilteredData(questionId);
    });

    $('#getSmartList').on('click', function () {
        $('.three-filters-group span').removeAttr('style');
    });

    $('.get-person-info').on('click', function () {
        $(this).toggleClass('flip');
        $(this).next('div').toggleClass('flip');
    });

    $('.rating-star').on('click', function () {
        var row = $(this).parent();
        var i = $(this).index();
        var lastStar = $(row).find('.filled:last').index();
        var total = i + 1;
        //TODO we question bubbles
//                function getInitials() {
//                    //obj.parent;
//                    var parent = row.parent().parent();
//                    var name = $(parent).find('span.individual-cell-name').html().split(' ');
//                    var nameSize = name.length;
//                    var initials = name[0].charAt(0) + '' + name[nameSize - 1].charAt(0);
//                    return initials;
//                }
        if (lastStar === i) {
            $(row).children().removeClass('filled');
            $(row).next().text('0').removeAttr('style');
        } else {
            $(this).nextAll().removeClass('filled');
            for (var n = 0; n <= i; n++) {
                $(row).children('span:eq(' + n + ')').addClass('filled');
            }
            $(row).next().text(total).css('visibility', 'visible');
            //TODO we question bubbles
//                        var personInitials = getInitials();
//                        $('.no-key-selected').append('<p>' + personInitials + '</p>');
        }

//                var arr = [];
//                //var text = $(this).text();
//                var selected = $('.individuals-grid').find('input:checked').length;
//
//                function getInitials(obj) {
//                    var name = obj.parent().find('individual-cell-name').text().split(' ');
//                    var nameSize = name.length;
//                    var initials = name[0].charAt(0) + '' + name[nameSize - 1].charAt(0);
//                    return initials;
//                }
//
//                var personInitials = getInitials($(this));
//
//                if ($(this).) {
//                    //  $(this).css({'background-color': '#4effb8', 'color': '#fff'}).text('?');
//                    //$(this).siblings('input').prop('checked', true);
//
//                    if (selected < 5) {
//                        $('.no-key-selected').append('<p>' + personInitials + '</p>');
//                    } else {
//                        var remaining = selected - 4;
//                        $('.no-key-selected').children('span').remove();
//                        $('.no-key-selected').append('<span>and ' + remaining + ' more</span');
//                    }
//                    arr.push($(this).siblings('input').attr('id'));
//                    var addId = $(this).siblings('input').val();
//                    arrEmpId.push(addId);
//                } else {
//                    $(this).removeAttr('style').text('+');
//                    $(this).siblings('input').prop('checked', false);
//
//                    var tag;
//
//                    $('.no-key-selected p').each(function (i) {
//                        if ($(this).text() === personInitials) {
//                            tag = true;
//                            $(this).remove();
//
//                            if (selected >= 6) {
//                                var newInitials = getInitials($('#' + arr[5]));
//                                $('.no-key-selected p:last-of-type').after('<p>' + newInitials + '</p>');
//                            }
//                            return false;
//                        }
//                    });
//
//                    if (selected === 6) {
//                        $('.no-key-selected').children('span').remove();
//                    } else if ((selected < 6) && !tag) {
//                        $('.no-key-selected').children('p:last-of-type').remove();
//                    } else if (selected > 6) {
//                        var remaining = selected - 6;
//                        $('.no-key-selected').children('span').remove();
//                        $('.no-key-selected').append('<span>and ' + remaining + ' more</span>');
//                    }
//
//                    var removeItem = $(this).siblings('input').attr('id');
//                    arr = jQuery.grep(arr, function (value) {
//                        return value !== removeItem;
//                    });
//                    var removeId = $(this).siblings('input').val();
//                    arrEmpId = jQuery.grep(arrEmpId, function (value) {
//                        return value !== removeId;
//                    });
//                }





    });

//    $('.individuals-grid').css('top', '0px');

//    $('.individuals-prev').on('click', function () {
//        event.preventDefault();
//        if ($('.individuals-grid')[0].style.top !== '0px') {
//            $('.individuals-grid').animate({'top': '+=200px'}, 0);
//        }
//    });
//
//    $('.individuals-next').on('click', function () {
//        event.preventDefault();
//        var height = $('.individuals-grid').height() - 400;
//        var limit;
//        if (height === 0) {
//            limit = height + 'px';
//        } else {
//            limit = '-' + height + 'px';
//        }
//        if ($('.individuals-grid')[0].style.top !== limit) {
//            $('.individuals-grid').animate({'top': '-=200px'}, 0);
//        }
//    });

    // To display filter in tablets
    if ('ontouchstart' in document.documentElement) {
        if (document.documentElement.clientWidth > 480) {
            $('.filter-row .get-filter-list').on('click', function () {
                $('.filter-menu').toggle();
                $('.filter-menu li ul').hide();
            });

            $('.filter-row .filter-menu>ul>li').on('click', function (e) {
                e.stopPropagation();
                if ($(this).find('ul').is(':visible')) {
                    $('.filter-menu li ul').hide();
                } else {
                    $('.filter-menu li ul').hide();
                    $(this).find('ul').show();
                }
            });

            $('.filter-row .filter-menu li li').on('click', function () {
                $('.filter-menu').hide();
            });
        }
    }

    if (document.documentElement.clientWidth <= 480) {
        $('.search-colleague').attr('placeholder', 'Find a colleague to appreciate');

        $('.mobile-filter-row').on('click', function (event) {
            $(this).children('div').fadeToggle('200');
        });

        $('#closeFilter').on('click', function () {
            event.stopPropagation();
            $('.mobile-filter-row>div').fadeOut('200');
        });

        $('#getMobileSmartList').on('click', function () {
            event.stopPropagation();
        });

        $('#chooseMobileFilter').on('click', function () {
            $('.search-colleague').val('');
            var questionId = $(this).parents('.header').next().attr('ques_id');
            fetchFilteredDataMobile(questionId);
        });

        $('.mobile-filter-row .filter-menu>ul>li').on('click', function () {
            event.stopPropagation();
            $(this).children('ul').slideToggle('400');
            $(this).siblings('li').children('ul').slideUp('400');
        });

        $('.mobile-filter-row .filter-menu li li').on('click', function () {
            event.stopPropagation();
        });

        $(window).scroll(function () {
            if ($(document).height() <= $(window).scrollTop() + $(window).height()) {
                $('.individuals-box').css('max-height', '+=400px');
            }
        });
    }

    $('.survey-we .submit-circle button').on('click', function (event) {
        if ($('.rating-stars .filled').length === 0) {
            $('.submit-tooltip').children('.submit-title').hide();
            $('.submit-tooltip').children('.submit-response').show();
            if (document.documentElement.clientWidth <= 480) {
                $('.submit-tooltip').css('visibility', 'visible');
                setTimeout(function () {
                    $('.submit-tooltip').css('visibility', 'hidden');
                }, 400);
            }
        } else {
            submitWeData(this);
        }

        $(this).on('mouseout', function () {
            setTimeout(function () {
                $('.submit-tooltip').children('.submit-title').show();
                $('.submit-tooltip').children('.submit-response').hide();
            }, 400);
        });
    });

    showHideNavigation();
});

/** Search functionality using Isotope begins */
function searchIsotope() {
    var qsRegex;
    //Isotope init function
    var $grid = $('.individuals-grid').isotope({
        itemSelector: '.individual-cell',
        layoutMode: 'fitRows'
    });
    $('.individuals-grid').css('top', '0px');
    $('#scroll-for-individuals-grid').slimScroll({
        height: '400px',
        disableFadeOut: true,
        color: '#388E3C'
    });
//    if ($('.individuals-grid:visible').height() <= 400) {
//        $('.individuals-box-scroll').css('visibility', 'hidden');
//    } else {
//        $('.individuals-box-scroll').removeAttr('style');
//    }
}

// debounce so isotope filtering doesn't happen every millisecond
function debounce(fn, threshold) {
    var timeout;
    return function debounced() {
        if (timeout) {
            clearTimeout(timeout);
        }
        function delayed() {
            fn();
            timeout = null;
        }
        timeout = setTimeout(delayed, threshold || 100);
    };
}

function showHideNavigation(obj) {
    var visibleQues = $('.question_div:visible').find('.question_no');
    var totalQuestions = $('#total_ques').val();
    var remainingQuestions = $('#remaining_ques').val();
    totalQuestions = parseInt(totalQuestions);
    remainingQuestions = parseInt(remainingQuestions);
    $('.site-nav-dash').hide();
    if (visibleQues.val() == 0) {
        $('.site-nav-prev').hide();
        $('.site-nav-next').show();
    } else if (remainingQuestions <= visibleQues.val()) {
        $('.site-nav-prev').hide();
        $('.site-nav-next').hide();
        if ((totalQuestions - 1) > visibleQues.val()) {
            $('.site-nav-next').show();
        }
    } else if ((totalQuestions - 1) == visibleQues.val()) {
        $('.site-nav-prev').show();
        $('.site-nav-next').hide();
        $('.site-nav-dash').show();
    } else {
        $('.site-nav-prev').show();
        $('.site-nav-next').show();
    }
    if (obj != undefined) {
        var prevDiv = $(obj).prevAll("div.question_div").eq(0);
        if (prevDiv.length === 0) {
            $('.site-nav-prev').hide();
        } else {
            $('.site-nav-prev').show();
        }
        var nextDiv = $(obj).nextAll("div.question_div").eq(0);
        if (nextDiv.length === 0) {
            $('.site-nav-next').hide();
            $('.site-nav-dash').show();
        } else {
            $('.site-nav-next').show();
            $('.site-nav-dash').hide();
        }
    }
}

function saveRating() {
    var empArr = jQuery.data(document.body, "emp_rating");
    if (empArr == undefined) {
        empArr = [];
    }
    jQuery.each($('.star-rating-total'), function (i, v) {
        var empRating = {};
        var empId = $(v).attr('emp_id');
        var quesId = $(v).attr('ques_id');
        var rating = $(v).text();
        if (rating !== '') {
            empRating[quesId + '_' + empId] = rating;
            empArr.push(empRating);
            //TODO we question bubbles
//            function getInitials() {
//                var parent = $(this).parent().parent().parent();
//                var name = $(parent).find('span.individual-cell-name').html();
//                var nameSize = name.length;
//                var initials = name[0].charAt(0) + '' + name[nameSize - 1].charAt(0);
//                return initials;
//            }
//            var personInitials = getInitials();
//            $('.no-key-selected').append('<p>' + personInitials + '</p>');

        }
    });
    jQuery.data(document.body, "emp_rating", empArr);
}

function displayRatings(id, score) {
    if (score === '0') {
        score = '';
    }
    var row = $('.star-rating-total#' + id).prev();
    $('.star-rating-total#' + id).text(score).css('visibility', 'visible');
    if (score === '') {
        $('.star-rating-total#' + id).removeAttr('style');
    }
    $(row).children().removeClass('filled');
    for (var n = 0; n < score; n++) {
        $(row).children('span:eq(' + n + ')').addClass('filled');
    }
}

function fetchAndPopulateRating() {
    var empRatingArr = jQuery.data(document.body, "emp_rating");
    if (empRatingArr != undefined) {
        jQuery.each(empRatingArr, function (i, o) {
            jQuery.each(o, function (k, v) {
                displayRatings('rat_' + k, v);
            });
        });
    }
}

function fetchOrgnizationSearch(q, ques, obj) {
    $('.mobile-filter-row .filter-menu li ul').hide();
    saveRating();
    var query = "q=" + q + "&ques=" + ques;
    $('.overlay_form').show();
    var currentRequest = null;
    currentRequest = jQuery.ajax({
        type: "POST",
        url: "/individual/searchOrgList.jsp",
        data: query,
        dataType: 'HTML',
        beforeSend: function () {
            if (currentRequest !== null) {
                currentRequest.abort();
            }
        },
        success: function (resp) {
            $('.overlay_form').hide();
            $(obj).siblings('.individuals-box').html(resp);
            fetchAndPopulateRating();
            searchIsotope();
            $('.three-filters-group span').removeAttr('style').removeAttr('data_id').removeAttr('filter_type').removeAttr('filter_type_id');
            $('.filter-row .filter-menu>ul>li>span').removeClass('highlight');
            $('.filter-row .filter-menu li li span').removeAttr('style');
            $('.mobile-filter-row').removeClass('chosen');
            $('.mobile-filter-row .filter-menu input').prop('checked', false);
        }
    });
}

function fetchFilteredData(questionId) {
    saveRating();
    var filterData = {};
    jQuery.each($('.three-filters-group span'), function (i, v) {
        var filterId = $(v).attr('data_id');
        var filterType = $(v).attr('filter_type');
        var filterTypeId = $(v).attr('filter_type_id');
        var filterVal = $(v).text();
        if (filterType !== undefined) {
            filterData[filterType] = filterId;
            filterData[filterType + "_id"] = filterTypeId;
            filterData[filterType + "_name"] = filterVal;
        }
    });
    var relId = jQuery('#relation_' + questionId).val();
    filterData['question_id'] = questionId;
    filterData['rel_type'] = relId;
    $('.overlay_form').show();
    jQuery.ajax({
        type: "POST",
        url: "/individual/survey-filter.jsp",
        data: filterData,
        dataType: 'HTML',
        success: function (resp) {
            $('.overlay_form').hide();
            jQuery('#we_grid_' + questionId).html(resp);
            fetchAndPopulateRating();
            searchIsotope();
        }
    });
}

function fetchFilteredDataMobile(questionId) {
    saveRating();
    var filterData = {};
    jQuery.each($('.mobile-filter-row .filter-menu>ul>li'), function (i, v) {
        var filterId = $(v).find('input:checked').attr('data_id');
        var filterType = $(v).find('input:checked').attr('filter_type');
        var filterVal = $(v).find('input:checked').next().text();
        var filterTypeId = $(v).find('input:checked').attr('filter_type_id');
        if (filterType !== undefined) {
            filterData[filterType] = filterId;
            filterData[filterType + "_id"] = filterTypeId;
            filterData[filterType + "_name"] = filterVal;
        }
    });
    $('.overlay_form').show();
    jQuery.ajax({
        type: "POST",
        url: "/individual/dashboardsmartlist.jsp",
        data: filterData,
        dataType: 'HTML',
        success: function (resp) {
            $('.overlay_form').hide();
            $('#we_grid_' + questionId).html(resp);
            fetchAndPopulateRating();
            searchIsotope();
            $('.mobile-filter-row>div').hide('200');
            $('.mobile-filter-row').addClass('chosen');
        }
    });
}

function fetchSmartData(questionId) {
    $('.search-colleague').val('');
    saveRating();
    var relId = jQuery('#relation_' + questionId).val();
    var smartData = {'question_id': questionId, 'rel_type': relId};
    $('.overlay_form').show();
    jQuery.ajax({
        type: "POST",
        url: "/individual/survey-filter.jsp",
        data: smartData,
        dataType: 'HTML',
        success: function (resp) {
            $('.overlay_form').hide();
            $('#we_grid_' + questionId).html(resp);
            fetchAndPopulateRating();
            searchIsotope();
            $('.filter-row .filter-menu li li').each(function (i, v) {
                $(v).children('span').css('visibility', 'hidden');
                $(v).children('span.filter-choice-name').css('visibility', 'visible');
            });
            $('.filter-row .filter-menu>ul>li>span').removeClass('highlight');
            $('.three-filters-group span').removeAttr('style').removeAttr('data_id').removeAttr('filter_type').removeAttr('filter_type_id');
            $('.mobile-filter-row').removeClass('chosen');
            $('.mobile-filter-row>div').hide('200');
            $('.mobile-filter-row .filter-menu input').prop('checked', false);
        }
    });
}


function clearRatings() {
    jQuery.each($('.star-rating-total'), function (i, v) {
        $(v).text('');
        //TODO we question bubbles
        //$('.no-key-selected').children('span').remove();
    });
}

function submitWeData(obj) {
    var quesId = $(obj).val();
    var empArr = [];
    var empRating = {};

    var empArr1 = jQuery.data(document.body, "emp_rating");
    if (empArr1 !== undefined) {
        jQuery.each(empArr1, function (i, o) {
            jQuery.each(o, function (k, v) {
                var id = k.split("_");
                empRating[id[1]] = v;
                empArr.push(empRating);
            });
        });
    }

    jQuery.each($('.star-rating-total'), function (i, v) {
        var empId = $(v).attr('emp_id');
        var rating = $(v).text();
        if (rating !== '') {
            empRating[empId] = rating;
            empArr.push(empRating);
        }
    });

    var postData = {'ques_id': quesId, 'emp_rating': JSON.stringify(empRating), 'rela_val': jQuery('#rela_val_' + quesId).val()};
    $.ajax({
        type: "POST",
        url: "/individual/survey-we-submit.jsp",
        data: postData,
        dataType: 'JSON',
        success: function (resp) {
            var totalQues = parseInt($('#remaining_ques').val());
            totalQues = totalQues - 1;
            $('#remaining_ques').val(totalQues + "");
            var $currentDiv = $('.question_div:visible');
            var $nextDiv = $currentDiv.nextAll("div.question_div").eq(0);
            if ($nextDiv.length) {
                $('.site-nav a').addClass('active');
                $('body').css('overflow', 'hidden');
                $currentDiv.hide('slide', {direction: 'left'}, 200);
                $nextDiv.show('slide', {direction: 'right'}, 400, function () {
                    $('.site-nav a').removeClass('active');
                    searchIsotope();
                    $currentDiv.remove();
                    showHideNavigation(this);
                    $('body').removeAttr('style');
                });
                jQuery.data(document.body, "emp_rating", []);
                clearRatings();
            } else {
                jQuery.data(document.body, "emp_rating", []);
                clearRatings();
                $currentDiv.remove();
                window.location.href = 'dashboard.jsp';
            }
        }
    });
}