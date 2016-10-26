var countProgress = 0;
var uniqueEmpArr = [];

$(document).ready(function () {
//    $(window).lazyScript({
//        selectorClass: 'person-pic',
//        callback: jQuery.noop,
//        threshold: 0,
//        scrollInterval: 500
//    });

    showProgressValue(true);
    showSubmitButton();
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
        $('.list-of-people-selected').each(function (i) {
            if ($('.list-of-people-selected')[i].clientHeight >= 348) {
                $(this).parent().slimScrollPopup({
                    height: '400px',
                    width: '272px',
                    color: '#388E3C',
                    railVisible: true,
                    railColor: '#D7D7D7',
                    alwaysVisible: true,
                    touchScrollStep: 50
                });
            } else {
                $(this).parent().slimScrollPopup({
                    destroy: true
                });
            }
        });
    });
    $('.site-nav-next').on('click', function () {
        event.preventDefault();
        var $currentDiv = $('.question_div:visible');
        var $nextDiv = $currentDiv.nextAll("div.question_div").eq(0);
//        var $nextDiv = $currentDiv.parent().nextAll('.swiper-slide').find('div.question_div');
        $(this).addClass('active');
        $('body').css('overflow', 'hidden');
        $currentDiv.hide('slide', {direction: 'left'}, 200);
        $nextDiv.show('slide', {direction: 'right'}, 500, function () {
            $('.site-nav-next').removeClass('active');
            searchIsotope();
            showHideNavigation(this);
            $('body').removeAttr('style');
        });
        $('.list-of-people-selected').each(function (i) {
            if ($('.list-of-people-selected')[i].clientHeight >= 348) {
                $(this).parent().slimScrollPopup({
                    height: '400px',
                    width: '272px',
                    color: '#388E3C',
                    railVisible: true,
                    railColor: '#D7D7D7',
                    alwaysVisible: true,
                    touchScrollStep: 50
                });
            } else {
                $(this).parent().slimScrollPopup({
                    destroy: true
                });
            }
        });
//        clearRatings();
    });
    $(function () {
        if ($('#subModuleName').val() === "ihcl") {
            var swiper = new Swiper('.swiper-container', {
                pagination: '.swiper-pagination',
                paginationType: 'progress',
                nextButton: '.swiper-button-next',
                prevButton: '.swiper-button-prev',
                // DO NOT DEPLOY
                keyboardControl: true,
//                mousewheelControl: true,
//                iOSEdgeSwipeDetection: true,
//            autoHeight: 'true',
                onSlideNextStart: function () {
                    showProgressValue(true);
                    showSubmitButton();
                    if ($('.swiper-slide-active:visible').find('.questionType').val() === "WE") {
                        fetchSmartData($('.swiper-slide-active:visible').find('.questionId').val());
                    }

                },
                onSlidePrevStart: function () {
                    showProgressValue(false);
                    showSubmitButton();
                    if ($('.swiper-slide-active:visible').find('.questionType').val() === "WE") {
                        fetchSmartData($('.swiper-slide-active:visible').find('.questionId').val());
                    }
                },
                slidesPerView: 1
            });
        }
    });

    /****************************************** SURVEY-ME ***********************************************/

    $('.answer-range button').on('click', function (event) {
        $(this).toggleClass('clicked').parent().toggleClass('clicked');
        var quesId = $(this).parent().parent().attr('ques_id');
        $('#resp_val_' + quesId).val($(this).val());
        $(this).parent('div').siblings().removeClass('clicked').children().removeClass('clicked');
        if ($(this).parent().find('.clicked').length === 0) {
            $('#resp_val_' + quesId).val('');
        }
    });

//Create a key value pair for matching keypresses with ME Q value
    var map = {"49": "1", "50": "2", "51": "3", "52": "4", "53": "5", "97": "1", "98": "2", "99": "3", "100": "4", "101": "5"}
    function getKeyValue(k) {
        return map[k];
    }
//Check which key pressed and accordingly highlight on screen
    $(document).keypress(function (e) {

        var key = e.which;
        $(this).find('.answer-range')
        var quesId = $('.answer-range:in-viewport').attr('ques_id');
        //var quesId = $('.answer-range button').parent().parent().attr('ques_id');
        $('#answer-range-' + quesId + ' button[value=' + getKeyValue(key) + ']').toggleClass('clicked').parent().toggleClass('clicked');

        $('#resp_val_' + quesId).val($('.answer-range button').val());
        $('#answer-range-' + quesId + ' button[value=' + getKeyValue(key) + ']').parent('div').siblings().removeClass('clicked').children().removeClass('clicked');
        if ($('#answer-range-' + quesId + ' button[value=' + getKeyValue(key) + ']').parent().find('.clicked').length === 0) {
            $('#resp_val_' + quesId).val('');
        }


    });


    $('.survey-me .submit-circle button').on('click', function (event) {
        var quesId = $(this).val();
        submitMeData(quesId);

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

    if ($('#subModuleName').val() !== "ihcl") {
        $('.search-colleague').on('input', function () {
            fetchOrgnizationSearch($(this).val(), $(this).attr('ques_id'), this);
        });
    }

    if ($('#subModuleName').val() === "ihcl") {
        $('.ihcl-search-button').on('click', function () {
            var quesId = $(this).attr('ques_id');
            fetchOrgnizationSearch($('#ihcl-search-' + quesId).val(), quesId, this);
        });
    }
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
        $('#three-filters-group-' + questionId + ' span:eq(' + i + ')').text(filterName).css('visibility', 'visible').attr('data_id', filterId).attr('filter_type', filterType).attr('filter_type_id', filterTypeId);
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
        ratingStar(this);
    });

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
    $('.mood-range button').on('click', function (event) {
        $(this).toggleClass('clicked').parent().toggleClass('clicked');
        var quesId = $(this).parent().parent().attr('ques_id');
        $('#resp_val_' + quesId).val($(this).val());
        $(this).parent('div').siblings().removeClass('clicked').children().removeClass('clicked');
        if ($(this).parent().find('.clicked').length === 0) {
            $('#resp_val_' + quesId).val('');
        }
    });

    if ($('#subModuleName').val() === "ihcl") {

        $('.submit-circle.app button').on('click', function () {
            var jArray = $('#ques_list').val();
            var jsonObj = $.parseJSON(jArray);

            // check for how many questions have been answered
            var questionsAnswered = [];
            var qList = [];

            jQuery.each(jsonObj, function (index, value) {
                var quesId = value.questionId;
                qList.push(quesId);

                var empArr1 = jQuery.data(document.body, "emp_rating");
                if (empArr1 !== undefined) {
                    jQuery.each(empArr1, function (i, o) {
                        jQuery.each(o, function (k, v) {
                            var id = k.split("_");
                            if (id[0] === quesId.toString()) {
                                questionsAnswered.push(quesId);
                            }
                        });
                    });
                }

                jQuery.each($('.star-rating-total'), function (i, v) {
                    var qId = $(v).attr('ques_id');
                    var rating = $(v).text();
                    if (rating !== '' && rating !== '0' && qId === quesId.toString()) {
                        questionsAnswered.push(quesId);
                    }
                });
                var dataSub = {'resp_val': jQuery('#resp_val_' + quesId).val()};
                if (dataSub.resp_val !== undefined && dataSub.resp_val !== "") {
                    questionsAnswered.push(quesId);
                }
            });

            var totalQuestionLength = qList.length;
            for (var n = 0; n <= qList.length; n++) {
                for (var m = 0; m <= questionsAnswered.length; m++) {
                    if (qList[n] === questionsAnswered[m]) {
                        qList.splice(n, 1);
                    }
                }
            }

            $('.submit-popup-warning-text p').each(function (j) {
                $(this).remove();
            });

            if (qList.length === totalQuestionLength) {
                $('#yesButton').attr('disabled', true);
                $('#yesButton').css('background', '#9e9e9e');
//                    $('#yesButton').css('background','#fafafa');
                $('.submit-popup-warning-text').append('<p> You have not answered any questions. Please select a response to submit </p>');
            } else if (qList.length > 0) {
                $('#yesButton').prop('disabled', true);
//                    $('#yesButton').css('color', '#ffffff');
                $('#yesButton').css('background', '#9e9e9e');
                $('#noButton').text(function (i, oldText) {
                    return oldText === '\u2718 NO' ? 'GO BACK' : oldText;
                });
                $('.submit-popup-warning-text').append('<p> You have ' + qList.length + ' unanswered questions </p>');
            } else {
                $('#yesButton').prop('disabled', false);
                $('#yesButton').css('color', '#ffffff');
                $('#yesButton').css('background', '#4caf50');
                $('#noButton').text(function (i, oldText) {
                    return oldText === 'GO BACK' ? '\u2718 NO' : oldText;
                });
                $('.submit-popup-warning-text').append('<p> You have answered all questions </p>');
            }
//                $('.submit-popup-warning-text').append('<p>You will not be able to take the survey again or change your responses, if you submit your responses now.</p>');

            $('.black_overlay').show();
            $('.submit-popup').show();

            //TO DISABLE PAGE SCROLL IF SUBMIT POPUP VISIBLE
            $('*').not('.submit-popup').bind('touchmove', false);
        });

        //NO BUTTON    
        $('.submit-popup-buttons button:nth-child(even)').on('click', function (event) {
            event.stopPropagation();
            $('.black_overlay').hide();
            $('.submit-popup').hide();
            //TO ENABLE PAGE SCROLL AS SUBMIT BUTTON IS DISMISSED
            $('*').unbind('touchmove', false);
        });

        //YES BUTTON
        $('.submit-popup-buttons button:nth-child(odd)').on('click', function () {
            saveRating();
            //SUBMIT ALL RESPONSES HERE
            var jArray = $('#ques_list').val();
            var jsonObj = $.parseJSON(jArray);
            console.log("jsonObj length : " + jsonObj.length);
            // store the responses for all answered questions
            jQuery.each(jsonObj, function (index, value) {
                var questionId = value.questionId;
                var questionType = value.questionType.value;
                console.log("Submitting Question Type : " + questionType);
                if (questionType === 1) {
                    console.log("Emp ID:: " + $('.usernameapp span').text() + " BEFORE submitting we question : " + questionId);
                    //submit WE answer
                    console.log("Element count ::  " + $('#list-mobile-' + questionId + ' p') + " FOR we question : " + questionId);
                    var count = $('#list-mobile-' + questionId + ' p').length;
                    console.log("Count::  " + count + " FOR we question : " + questionId);

                    //if (count > 0) {
                    console.log("Emp ID:: " + $('.usernameapp span').text() + "submitting we question : " + questionId);
                    submitWeData(questionId);
                    console.log("Emp ID:: " + $('.usernameapp span').text() + "submitted we question : " + questionId);
                    setTimeout(function () {
                        console.log("set timeout after submitted we question : " + questionId);
                    }, 5000);
                    //}
                } else {
                    // submit ME answer
                    console.log("Emp ID:: " + $('.usernameapp span').text() + "submitting me question : " + questionId);
                    submitMeData(questionId);
                    console.log("Emp ID:: " + $('.usernameapp span').text() + "submitted me question : " + questionId);
                    setTimeout(function () {
                        console.log("set timeout after submitted me question : " + questionId);
                    }, 5000);
                }
            });

        });
    }

    if (document.documentElement.clientWidth <= 480) {


        $('.search-colleague').attr('placeholder', 'Search for a colleague');

        $('#chooseMobileFilter').attr('disabled', true);

        $('.mobile-filter-row').on('click', function (event) {
            $(this).children('div').fadeToggle('200');
            $('.no-key-selected-mobile > div').hide();
        });

        $(document).on('click', '.no-key-selected-mobile', function (event) {
            $(this).children('div').fadeToggle('200');
            $(this).children('div').css('position', 'absolute');
            $(this).children('div').css('z-index', '1');
            $(this).children('div').css('top', '0');
            $(this).children('div').css('left', '0');
//            $(this).children('div').css('margin-left', '-200px');
            $('.mobile-filter-row > div').hide();
        });

//        $('.no-key-selected-mobile > div').hide();

        $('#closeFilter').on('click', function () {
            event.stopPropagation();
            $('.mobile-filter-row>div').fadeOut('200');
            if ($('#subModuleName').val() === "ihcl") {
                $('.no-key-selected-mobile').children('div').hide('200');
            }
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
            if ($('input[type=radio]:checked').size() > 0) {
                $('#chooseMobileFilter').attr('disabled', false);
            }
        });

        $(window).scroll(function () {
            if ($(document).height() <= $(window).scrollTop() + $(window).height()) {
                $('.individuals-box').css('max-height', '+=400px');
            }
        });

    }

    $('.survey-we .submit-circle button').on('click', function (event) {
        var quesId = $(this).parent().parent().find('#quesId')[0].value;
        var count = $('#list-mobile-' + quesId + ' p').length;
        if (count > 0) {
//            submitWeData(this);
            submitWeData(quesId);
        } else {
            $('.submit-tooltip').children('.submit-title').hide();
            $('.submit-tooltip').children('.submit-response').show();
            if (document.documentElement.clientWidth <= 480) {
                $('.submit-tooltip').css('visibility', 'visible');
                setTimeout(function () {
                    $('.submit-tooltip').css('visibility', 'hidden');
                }, 400);
            }
        }

//        if ($(this).parent().parent().find('#we_grid_' + quesId).find('.rating-stars .filled').length === 0) {
//            $('.submit-tooltip').children('.submit-title').hide();
//            $('.submit-tooltip').children('.submit-response').show();
//            if (document.documentElement.clientWidth <= 480) {
//                $('.submit-tooltip').css('visibility', 'visible');
//                setTimeout(function () {
//                    $('.submit-tooltip').css('visibility', 'hidden');
//                }, 400);
//            }
//        } else {
//            submitWeData(this);
//        }

        $(this).on('mouseout', function () {
            setTimeout(function () {
                $('.submit-tooltip').children('.submit-title').show();
                $('.submit-tooltip').children('.submit-response').hide();
            }, 400);
        });
    });

    showHideNavigation();
});

if ($('.survey-we').is(':visible')) {
    $(document).keypress(function (e) {
        if (e.which === 13) {
            var quesId = $('.ihcl-search-button').attr('ques_id');
            fetchOrgnizationSearch($('#ihcl-search-' + quesId).val(), quesId, $('.ihcl-search-button'));
            $(".search-colleague").blur();
        }
    });
}

function ratingStar(obj) {
    var row = $(obj).parent();
    var i = $(obj).index();
    var lastStar = $(row).find('.filled:last').index();
    var parent = row.parent().parent();
    var quesId = $(obj).parent().find('#quesId').val();
    var name = $(parent).find('span.individual-cell-name').text().trim();
    var count = $('#list-mobile-' + quesId + ' p').length;

    // clear the ratings for the chosen employee
    if (lastStar === i) {
        // remove the filled class + style
        $(row).children().removeClass('filled');
        $(row).next().text('').removeAttr('style');

        // remove names from the list
        $('#list-desktop-' + quesId + ' p').each(function (j) {
            if ($(this).text() === name) {
                $(this).remove();
            }
        });

        $('#list-mobile-' + quesId + ' p').each(function (j) {
            if ($(this).text() === name) {
                $(this).remove();
            }
        });
        // update the count of the names
        --count;
        $('#count-desktop-' + quesId + ' span').text('');
        $('#count-desktop-' + quesId + ' span').text(count);

        $('#count-mobile-' + quesId + ' span').text('');
        $('#count-mobile-' + quesId + ' span').text(count);

    } else {
        // add or update the stars for the given employee
        $(obj).nextAll().removeClass('filled');
        for (var n = 0; n < i; n++) {
            $(row).children('span:eq(' + n + ')').addClass('filled');
        }
        $(row).next().text(i).css('visibility', 'visible');

        // flag to check whether the list already contains the name of the employee to update the count
        var flag = false;

        // for the first employee that is selected append the employee
        if (($('#list-desktop-' + quesId + ' p').length === 0) && ($('#list-mobile-' + quesId + ' p').length === 0)) {
            ++count;
            $('#list-desktop-' + quesId).append('<p>' + name + '</p>');
            $('#count-desktop-' + quesId + ' span').text(count);

            $('#list-mobile-' + quesId).append('<p>' + name + '</p>');
            $('#count-mobile-' + quesId + ' span').text(count);
        } else {
            // check with the help of the flag and update the list & count accordingly
            $('#list-desktop-' + quesId + ' p').each(function (j) {
                if ($(this).text().trim() === name) {
                    flag = true;
                }
            });

            $('#list-mobile-' + quesId + ' p').each(function (j) {
                if ($(this).text().trim() === name) {
                    flag = true;
                }
            });
            if (!flag) {
                ++count;
                $('#list-desktop-' + quesId).append('<p>' + name + '</p>');
                $('#count-desktop-' + quesId + ' span').text('');
                $('#count-desktop-' + quesId + ' span').text(count);

                $('#list-mobile-' + quesId).append('<p>' + name + '</p>');
                $('#count-mobile-' + quesId + ' span').text('');
                $('#count-mobile-' + quesId + ' span').text(count);
            }
        }
    }
    if ($('#subModuleName').val() === 'ihcl') {
//        if (window.orientation === "90" || window.orientation === "-90") {
        $('.list-of-people-selected').each(function (i) {
            if ($('.list-of-people-selected')[i].clientHeight >= 348) {
                $(this).parent().slimScrollPopup({
                    height: '400px',
                    width: '263px',
                    color: '#388E3C',
                    railVisible: true,
                    railColor: '#D7D7D7',
                    alwaysVisible: true,
                    touchScrollStep: 50
                });
            } else {
                $(this).parent().slimScrollPopup({
                    destroy: true
                });
            }
        });
//        }
    } else {
        $('.list-of-people-selected').each(function (i) {
            if ($('.list-of-people-selected')[i].clientHeight >= 348) {
                $(this).parent().slimScrollPopup({
                    height: '400px',
                    width: '260px',
                    color: '#388E3C',
                    railVisible: true,
                    railColor: '#D7D7D7',
                    alwaysVisible: true,
                    touchScrollStep: 50
                });
            } else {
                $(this).parent().slimScrollPopup({
                    destroy: true
                });
            }
        });
    }
//    saveRating();
}
/** Search functionality using Isotope begins */
function searchIsotope() {
    var qsRegex;
    //Isotope init function
    var $grid = $('.individuals-grid').isotope({
        itemSelector: '.individual-cell',
        layoutMode: 'fitRows'
    });
    $('.individuals-grid').css('top', '0px');
//    for (var i = 0; i < ($('.individuals-grid').length); i++) {
//        if ($('.individuals-grid')[i].style.height.replace("px","") > 400) {
//            if ($('.individuals-grid').width() > 290) {
//                $('.individuals-grid')[i].slimScroll({
//                    height: '400px',
//                    color: '#388E3C',
//                    railVisible: true,
//                    railColor: '#D7D7D7',
//                    alwaysVisible: true,
//                    touchScrollStep: 50
//                });
//            } else {
//                $('.individuals-grid')[i].slimScroll({
//                    destroy: true
//                });
//            }
//        } else {
//            $('.individuals-grid')[i].slimScroll({
//                destroy: true
//            });
//        }
//    }
//Check screen width - Only Desktop must show scroll, NOT Mobile
    if (document.documentElement.clientWidth > 480) {
        //Check for every occurrence of individuals-grid
        $('.individuals-grid').each(function (i) {
            //Check if height of grid>400 - indicates that there are more than 14 people as part of the list
            if ($('.individuals-grid')[i].style.height.replace('px', '') > 400) {
                //Check width of grid
                if ($('.individuals-grid')[i].style.width === '' || $('.individuals-grid')[i].style.width === 'auto' || $('.individuals-grid')[i].style.width.replace('px', '') > 290) {
                    //Attach Slimscroll
                    $(this).slimScroll({
                        height: '400px',
                        color: '#388E3C',
                        railVisible: true,
                        railColor: '#D7D7D7',
                        alwaysVisible: true,
                        touchScrollStep: 50
                    }).one('mousemove', function () {
                        //Check EXACTLY once if the mouse moves on the individuals-grid div visible on screen, and accordingly reset the scrollbar to 0px
                        $(this).next('.slimScrollBar').css('top', '0');
                    });
                } else {
                    $(this).slimScroll({
                        destroy: true
                    });
                }
            } else {
                $(this).slimScroll({
                    destroy: true
                });
            }
        });
        //Destroy slimscroll if the device is a mobile
    } else {
        $('.individuals-grid').slimScroll({
            destroy: true
        });
    }
//    $('.list-of-selected-people-popup').css('top', '0px');

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
        }
    });

    if (empArr !== undefined && empArr.length > 0) {
        jQuery.each(empArr, function (i1, obj1) {
            jQuery.each(obj1, function (ques_emp1, rating1) {
                var updated = false;
                var deleted = false;
                if (uniqueEmpArr.length === 0 && rating1 !== "0") {
                    uniqueEmpArr.push(obj1);
                    updated = true;
                } else {
                    jQuery.each(uniqueEmpArr, function (i2, obj2) {
                        jQuery.each(obj2, function (ques_emp2, rating2) {
                            if (ques_emp1 === ques_emp2) {
                                if (rating1 === "0") {
                                    uniqueEmpArr.splice(i2, 1);
                                    updated = true;
                                    deleted = true;
                                    return false;
                                } else {
                                    uniqueEmpArr.splice(i2, 1);
                                    uniqueEmpArr.push(obj1);
                                    updated = true;
                                }
                            }

                        });
                        if (deleted) {
                            return false;
                        }
                    });
                }
                if (!updated && rating1 !== "0") {
                    uniqueEmpArr.push(obj1);
                }
            });
        });
    }
    empArr = $.merge([], uniqueEmpArr);
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
    var url = "/individual/searchOrgList.jsp";
    if ($('#subModuleName').val() === "ihcl") {
        url = "/ihcl/searchOrgList.jsp";
    }
    currentRequest = jQuery.ajax({
        type: "POST",
        url: url,
        data: query,
        dataType: 'HTML',
        beforeSend: function () {
            if (currentRequest !== null) {
                currentRequest.abort();
            }
        },
        success: function (resp) {
//            console.log("inside the ajax");
            $('.overlay_form').hide();
            $(obj).siblings('.individuals-box').html(resp);
            fetchAndPopulateRating();
            searchIsotope();
            $('#three-filters-group-' + ques + ' span').removeAttr('style').removeAttr('data_id').removeAttr('filter_type').removeAttr('filter_type_id');
            $('.filter-row .filter-menu>ul>li>span').removeClass('highlight');
            $('.filter-row .filter-menu li li span').removeAttr('style');
            $('.mobile-filter-row').removeClass('chosen');
            $('.mobile-filter-row .filter-menu input').prop('checked', false);
//            console.log("after the success of ajax");
        }
    });
}

function fetchFilteredData(questionId) {
    saveRating();
    var filterData = {};
    jQuery.each($('#three-filters-group-' + questionId + ' span'), function (i, v) {
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
    filterData['questionId'] = questionId;
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
            filterData["questionId"] = questionId;
        }
    });
    $('.overlay_form').show();
    jQuery.ajax({
        type: "POST",
        url: "/individual/survey-filter.jsp",
        data: filterData,
        dataType: 'HTML',
        success: function (resp) {
            // console.log("inside ajax");
            $('.overlay_form').hide();
            $('#we_grid_' + questionId).html(resp);
            fetchAndPopulateRating();
            searchIsotope();
            $('.mobile-filter-row>div').hide('200');
            $('.mobile-filter-row').addClass('chosen');
            // console.log("after ajax");
        }
    });
}

function fetchSmartData(questionId) {
    $('.search-colleague').val('');
    saveRating();
    var relId = jQuery('#relation_' + questionId).val();
    var smartData = {'questionId': questionId, 'rel_type': relId};
    $('.overlay_form').show();
    var url = "/individual/survey-filter.jsp";
    if ($('#subModuleName').val() === "ihcl") {
        url = "/ihcl/survey-filter.jsp";
    }
    jQuery.ajax({
        type: "POST",
        url: url,
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
            $('#three-filters-group-' + questionId + ' span').removeAttr('style').removeAttr('data_id').removeAttr('filter_type').removeAttr('filter_type_id');
            $('.mobile-filter-row').removeClass('chosen');
            $('.mobile-filter-row>div').hide('200');
            $('.mobile-filter-row .filter-menu input').prop('checked', false);
        }
    });
}


function clearRatings() {
    jQuery.each($('.star-rating-total'), function (i, v) {
        $(v).text('');
    });
}
function submitMeData(quesId) {
    var remainingQuestions = $('#remaining_ques').val();
    var empid = $('#empid').val();
    console.log("entering submitMeData for quesId : " + quesId + " and empId : " + empid + " remaining questions : " + remainingQuestions);
    if ($('#subModuleName').val() !== "ihcl" && $('.answer-range .clicked').length === 0) {
        console.log("no answer selected to submit for quesId : " + quesId);
        $('.submit-tooltip').children('.submit-title').hide();
        $('.submit-tooltip').css({width: '165px', padding: '5px 0'}).children('.submit-response').show();
        if (document.documentElement.clientWidth <= 480) {
            $('.submit-tooltip').css('visibility', 'visible');
            setTimeout(function () {
                $('.submit-tooltip').css('visibility', 'hidden');
            }, 400);
        }
    } else {
        console.log("answer found for submission for me quesId : " + quesId);
        var dataSub = {'comp_id': jQuery('#comp_id_' + quesId).val(), 'emp_id': jQuery('#emp_id_' + quesId).val(), 'question_id': jQuery('#question_id_' + quesId).val(), 'feedback': jQuery('#feedback_' + quesId).val(), 'resp_val': jQuery('#resp_val_' + quesId).val(), 'rela_val': jQuery('#rela_val_' + quesId).val()};
        console.log("submitMeData dataSub : " + dataSub);
        if (dataSub.resp_val !== undefined && dataSub.resp_val !== "") {
            jQuery.ajax({
                type: "POST",
                url: "/individual/survey-me-submit.jsp",
                data: dataSub,
                dataType: 'JSON',
                async: false,
                success: function (resp) {
                    console.log("submitMeData inside ajax success ");
                    var totalQues = parseInt($('#remaining_ques').val());
                    totalQues = totalQues - 1;
                    $('#remaining_ques').val(totalQues + "");
                    var $currentDiv = $('.question_div:visible');
                    var $nextDiv = $currentDiv.nextAll("div.question_div").eq(0);
                    if ($nextDiv.length) {
                        var remainingQuestions = $('#remaining_ques').val();
                        console.log("submitMeData inside ajax success if there are more me questions " + remainingQuestions);
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
                        console.log("submitMeData inside ajax success if there are no more me questions ");
                        $currentDiv.remove();
                        if ($('#subModuleName').val() === "ihcl") {
                                window.location.href = 'thankyou.jsp';
                        } else {
                            window.location.href = 'dashboard.jsp';
                        }
                    }
                    setTimeout(function () {
                        console.log("set timeout in ajax after successfully submitting me question : " + questionId);
                    }, 5000);
                },
                error: function (resp, err) {
                    console.log("submitMeData error message : " + err);
                }
            });
        }
    }
    console.log("exiting submitMeData button for quesId : " + quesId);
}
function submitWeData(quesId) {
    var empid = $('#empid').val();
    console.log("entering submitWeData ques : " + quesId + " and empId : " + empid);
    var empArr = [];
    var empRating = {};
    console.log("submitWeData analyzing emp_rating");
    var empArr1 = jQuery.data(document.body, "emp_rating");
    if (empArr1 !== undefined) {
        jQuery.each(empArr1, function (i, o) {
            jQuery.each(o, function (k, v) {
                var id = k.split("_");
                if (id[0] === quesId.toString()) {
                    empRating[id[1]] = v;
                    empArr.push(empRating);
                }
            });
        });
    }
    console.log("submitWeData analyzing star rating total");
    jQuery.each($('.star-rating-total'), function (i, v) {
        var qId = $(v).attr('ques_id');
        var empId = $(v).attr('emp_id');
        var rating = $(v).text();
        if (rating !== '' && rating !== '0' && qId === quesId.toString()) {
            empRating[empId] = rating;
            empArr.push(empRating);
        }
    });
    console.log("submitWeData empArr : " + empArr);
    var postData = {'ques_id': quesId, 'emp_rating': JSON.stringify(empRating), 'rela_val': jQuery('#rela_val_' + quesId).val()};
    console.log("submitWeData postData : " + postData);
    $.ajax({
        type: "POST",
        url: "/individual/survey-we-submit.jsp",
        data: postData,
        dataType: 'JSON',
        async: false,
        success: function (resp) {
            console.log("submitWeData inside ajax success ");
            var totalQues = parseInt($('#remaining_ques').val());
            totalQues = totalQues - 1;
            $('#remaining_ques').val(totalQues + "");
            var $currentDiv = $('.question_div:visible');
            var $nextDiv = $currentDiv.nextAll("div.question_div").eq(0);
            if ($nextDiv.length) {
                var remainingQuestions = $('#remaining_ques').val();
                console.log("submitWeData if there are more questions " + remainingQuestions);
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
                //jQuery.data(document.body, "emp_rating", []);
                //clearRatings();
            } else {
                console.log("submitWeData if there are no more questions ");
                //jQuery.data(document.body, "emp_rating", []);
                //clearRatings();
                $currentDiv.remove();
                if ($('#subModuleName').val() === "ihcl") {
                        window.location.href = 'thankyou.jsp';
                } else {
                    if ($('#subModuleName').val() === "ihcl") {
                                window.location.href = 'thankyou.jsp';
                    } else {
                        window.location.href = 'dashboard.jsp';
                    }
                }
            }
            setTimeout(function () {
                console.log("set timeout in ajax after successfully submitting we question : " + questionId);
            }, 5000);
        },
        error: function (resp, err) {
            console.log("submitWeData error message : " + err);
        }
    });
    console.log("exiting submitWeData");
}

function showProgressValue(isPrev) {
    if ($('#subModuleName').val() === "ihcl") {
        var totalQuestions = $('#total_ques').val();
        $('#progress-value span').text('');
        if (isPrev) {
            ++countProgress;
        } else {
            --countProgress;
        }
        $('#progress-value span').text('Question: ' + countProgress + '/' + totalQuestions);
    }
}

function showSubmitButton() {
    if ($('#subModuleName').val() === "ihcl") {
        var visibleQues = $('.swiper-slide-active:visible').find('.question_no').val();
        var totalQuestions = $('#total_ques').val();
        visibleQues = parseInt(visibleQues);
        if (totalQuestions === "1" || totalQuestions - 1 === visibleQues) {
            $('.submit-circle.app').show();
        } else {
            $('.submit-circle.app').hide();
        }
    }
}

function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}
