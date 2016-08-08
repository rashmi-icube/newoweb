'use strict';
var blankPerson = $('.individual-grid').html();

$(document).ready(function () {
    $('nav>ul>li').on('click', function () {
        $(this).addClass('current');
        $(this).siblings('li').removeClass('current');
    });

    $('nav>ul>li:eq(2)').on('click', function (event) {
        event.preventDefault();
        event.stopPropagation();
        $('.create-view-list1').slideDown('250');
        $('.create-view-list2').slideUp('250');
    });

    $('nav>ul>li:eq(3)').on('click', function (event) {
        event.preventDefault();
        event.stopPropagation();
        $('.create-view-list2').slideDown('250');
        $('.create-view-list1').slideUp('250');
    });

    $('nav>ul>li li').on('click', function (event) {
        event.stopPropagation();
    });

    $('.create-view-list1').children('span').on('click', function (event) {
        event.stopPropagation();
        $(this).parent('div').slideUp('250').find('li ul').hide();
    });

    $('.create-view-list2').children('span').on('click', function (event) {
        event.stopPropagation();
        $(this).parent('div').slideUp('250').find('li ul').hide();
    });

    $(document).click(function () {
        $('.create-view-list1').slideUp('250');
        $('.create-view-list2').slideUp('250');
        $('.user-profile-name ul').hide();
    });

    $('.user-profile-name p a').on('click', function (event) {
        event.stopPropagation();
        event.preventDefault();
        $('.create-view-list').slideUp('250');
        $('.user-profile-name ul').fadeToggle();
    });

    $('#chooseIndividual').click(function () {
        var previousValue = $(this).attr('previousValue');
        var name = $(this).attr('name');

        if (previousValue === 'checked') {
            $(this).removeAttr('checked');
            $(this).attr('previousValue', false);
            $('#findAnIndividual').val('').prop('disabled', true);
            $('#suggestion-box').removeAttr('style');
            $('.found-list').empty();
            $('#findIndividuals').removeClass('enabled').prop('disabled', true);
        } else {
            $('input[name=' + name + ']:radio').attr('previousValue', false);
            $(this).attr('previousValue', 'checked');

            $('#chooseTeam').removeAttr('checked');
            $('#chooseTeam').attr('previousValue', false);
            $('.initiative-choice-select select').prop('disabled', true).val('');
            if (($('.initiative-choice-team select').attr('style')) !== undefined) {
                $('.initiative-choice-select div').removeClass('enable-animate').addClass('disable-animate');
            }

            $('#findAnIndividual').prop('disabled', false);
            $('#findIndividuals').removeClass('enabled').removeAttr('disabled');

            $('#initiativeType').children('option').remove();
            $.each(indTypeJSON, function (key, value) {
                $('#initiativeType').append('<option value=' + key + '>' + value + '</option>');
            });
            $('#initiativeType').show();
        }

        if ($('#metrics-list').children().length) {
            $('#initiativeName, #startDate, #endDate').val('');
            $('#startDate').datepicker('option', 'maxDate', '');
            $('#endDate').datepicker('option', 'minDate', 0);
        }
        $('#collapse-metrics').prop('disabled', true);
        $('.create-metrics-list').slideUp('400', function () {
            $('#metrics-list').empty();
            $('#collapse-metrics').text('Expand');
        });
        $('.search-individual').val('');
        if ($('.individual-grid').is('[style]')) {
            $('.individual-grid').isotope('destroy');
            $('.individual-grid').removeAttr('style').empty().html(blankPerson);
        }
        $('.scrollbar a').hide();
        arr = [];
        $('.no-key-selected').empty();
        $('.create-initiative button').css('visibility', 'hidden');
        $('.addToInitative').removeAttr('style').text('+').siblings('input').prop('checked', false);
    });

    $('#chooseTeam').click(function () {
        var previousValue = $(this).attr('previousValue');
        var name = $(this).attr('name');

        if (previousValue == 'checked') {
            $(this).removeAttr('checked');
            $(this).attr('previousValue', false);
            $('.initiative-choice-select select').prop('disabled', true).val('');
            $('.initiative-choice-select div').removeClass('enable-animate').addClass('disable-animate');
            $('.initiative-choice-select select').css('background-color', 'rgba(242, 242, 242, 0.49)');
            $('#findIndividuals').removeClass('enabled').prop('disabled', true);
        } else {
            $('input[name=' + name + ']:radio').attr('previousValue', false);
            $(this).attr('previousValue', 'checked');
            $('.initiative-choice-select div').removeClass('disable-animate').addClass('enable-animate');

            $('#chooseIndividual').removeAttr('checked');
            $('#chooseIndividual').attr('previousValue', false);
            $('#findAnIndividual').val('').prop('disabled', true);
            $('#suggestion-box').removeAttr('style');
            $('.found-list').empty();
            $('#findIndividuals').removeClass('enabled').removeAttr('disabled');

            $('.initiative-choice-select select').prop('disabled', false);
            $('.initiative-choice-select select').removeAttr('disabled');
            $('.initiative-choice-select select').css('background-color', '#fff');

            $('#initiativeType').children('option').remove();
            $.each(teamTypeJSON, function (key, value) {
                $('#initiativeType').append('<option value=' + key + '>' + value + '</option>');
            });
            $('#initiativeType').show();
        }

        if ($('#metrics-list').children().length) {
            $('#initiativeName, #startDate, #endDate').val('');
            $('#startDate').datepicker('option', 'maxDate', '');
            $('#endDate').datepicker('option', 'minDate', 0);
        }
        $('#collapse-metrics').prop('disabled', true);
        $('.create-metrics-list').slideUp('400', function () {
            $('#metrics-list').empty();
            $('#collapse-metrics').text('Expand');
        });
        $('.search-individual').val('');
        if ($('.individual-grid').is('[style]')) {
            $('.individual-grid').isotope('destroy');
            $('.individual-grid').removeAttr('style').empty().html(blankPerson);
        }
        $('.scrollbar a').hide();
        $('.create-initiative button').css('visibility', 'hidden');
        arr = [];
        $('.no-key-selected').empty();
        $('.addToInitative').removeAttr('style').text('+').siblings('input').prop('checked', false);
    });

    $('#initiativeType').on('change', function () {
        if ($('#searchIndividual')[0].checkValidity() && $('#metrics-list').children().length) {
            $('#findIndividuals').trigger('click');
        }
    });

    $('#findAnIndividual').bind('keypress keydown keyup', function (e) {
        if (e.keyCode === 13 && ($('.found-list').children().length)) {
            e.preventDefault();
        }
    });

    $('.found-list button').on('click', function () {
        $(this).parent('p').remove();
        $('#findAnIndividual').removeAttr('disabled');
        $('#findIndividuals').removeClass('enabled');
    });

    $('.initiative-choice-select select').one('change', function () {
        $('#findIndividuals').addClass('enabled');
    });

    var oldSelect = [], newSelect = [];
    $('.initiative-choice-select select').on('change', function () {
        newSelect = oldSelect;
        oldSelect = [];
        $(this).find('option:selected').each(function (index, el) {
            if ($(el).text() === 'All') {
                $(el).siblings().prop('selected', false);
            }
        });
    });

    $('#findIndividuals').on('click', function () {
        arr = [];
        $('.no-key-selected').empty();
    });

    $('#collapse-metrics').on('click', function () {
        $('.create-metrics-list').slideToggle('400', function () {
            $('#collapse-metrics').text(function (i, text) {
                return text === 'Expand' ? 'Collapse' : 'Expand';
            });
        });
    });

    $('.search-popup button').on('click', function () {
        $(this).next().show('slide', {direction: 'left'}, 500);
    });

    $('.search-individual').on('change keyup paste', function () {
        if ($('#metrics-list').children().length) {
            $('.individual-grid').animate({top: '0px'}, 1);
        }
    });

    $('.info-individual').on('click', function () {
        $(this).prev('.individual-profile').toggleClass('animate-profile');
        $(this).toggleClass('clicked');
    });

    var arr = [];
    $('.individual-grid').find('input:checked').each(function (index, el) {
        arr.push($(el).attr('id'));
    });

    $('.addToInitative').click(function () {
        var text = $(this).text();
        var selected = $('.individual-grid').find('input:checked').length;

        function getInitials(obj) {
            var name = obj.parent().find('figcaption').text().split(' ');
            var nameSize = name.length;
            var initials = name[0].charAt(0) + '' + name[nameSize - 1].charAt(0);
            return initials;
        }

        var personInitials = getInitials($(this));

        if (text === '+') {
            $(this).css({'background-color': '#4effb8', 'color': '#fff'}).text('✔');
            $(this).siblings('input').prop('checked', true);

            if (selected < 5) {
                $('.no-key-selected').append('<p>' + personInitials + '</p>');
            } else {
                var remaining = selected - 4;
                $('.no-key-selected').children('span').remove();
                $('.no-key-selected').append('<span>and ' + remaining + ' more</span');
            }

            arr.push($(this).siblings('input').attr('id'));
            var addId = $(this).siblings('input').val();
            arrEmpId.push(addId);
        } else {
            $(this).removeAttr('style').text('+');
            $(this).siblings('input').prop('checked', false);

            var tag;

            $('.no-key-selected p').each(function (i) {
                if ($(this).text() === personInitials) {
                    tag = true;
                    $(this).remove();

                    if (selected >= 6) {
                        var newInitials = getInitials($('#' + arr[5]));
                        $('.no-key-selected p:last-of-type').after('<p>' + newInitials + '</p>');
                    }

                    return false;
                }
            });

            if (selected === 6) {
                $('.no-key-selected').children('span').remove();
            } else if ((selected < 6) && !tag) {
                $('.no-key-selected').children('p:last-of-type').remove();
            } else if (selected > 6) {
                var remaining = selected - 6;
                $('.no-key-selected').children('span').remove();
                $('.no-key-selected').append('<span>and ' + remaining + ' more</span>');
            }

            var removeItem = $(this).siblings('input').attr('id');
            arr = jQuery.grep(arr, function (value) {
                return value !== removeItem;
            });
            var removeId = $(this).siblings('input').val();
            arrEmpId = jQuery.grep(arrEmpId, function (value) {
                return value !== removeId;
            });
        }
    });

    $('.prev').click(function (event) {
        event.preventDefault();
        if (($('.individual-grid').attr('style').indexOf('top') !== -1) && ($('.individual-grid').attr('style').indexOf('top: 0px') === -1)) {
            $('.individual-grid').animate({top: '+=158px'}, 1);
        }
    });

    $('.next').click(function (event) {
        event.preventDefault();
        var topHeight = ($('.individual-grid').height()) - 316;
        if ($('.individual-grid').attr('style').indexOf('top: -' + topHeight) === -1) {
            $('.individual-grid').animate({top: '-=158px'}, 1);
        }
    });

    $('#cancelInitiative').on('click', function () {
        $('.initiative-category input').removeAttr('checked').attr('previousValue', false);
        $('#initiativeName, .initiative-date input, .initiative-choice-select select').val('');
        //  arr = [];
        //  $('.no-key-selected').empty();
        //  $('.addToInitative').removeAttr('style').text('+').siblings('input').prop('checked', false);
        window.location.href = '../initiative/list.jsp';
    });

    /************************************** VIEW INITATIVE ********************************************/

    $('.filter-tool').on('click', function () {
        $('.filter-metric span').toggleClass('clicked');
        $('.filter-metric img').toggleClass('img-move');
        $('.my-initatives').toggleClass('animate-list');
        $('.my-initatives ul').toggleClass('switched');
        $('.my-initatives li').each(function (index, el) {
            var listItem = $(this);
            setTimeout(function () {
                listItem.toggleClass('animate-list');
            }, index * 25);
        });
        var type = $('.filter-metric').children('.clicked').text();
        var html = "";
        if (type === "Team") {
            $.each(teamTypeJSON, function (key, value) {
                html += "<li><span>&#x2714;</span> <a href='javascript:void(0)' onClick=\"getList('', '" + key + "', this)\">" + value + "</a></li>";
            });
        } else {
            $.each(indTypeJSON, function (key, value) {
                html += "<li><span>&#x2714;</span> <a href='javascript:void(0)' onClick=\"getList('', '" + key + "', this)\">" + value + "</a></li>";
            });
        }
        $("#typelist").html(html);
        getListByCategory(type);
    });

    $('#sort-by').on('click', function (event) {
        event.stopPropagation();
        $('.view-by-list li ul').hide();
        $(this).next('div').slideDown('250');
    });

    $('#sort-by').next('div').children('button').on('click', function () {
        $(this).parent('div').find('li ul').hide();
        $(this).parent('div').slideUp('250');
    });

    $(document).click(function (event) {
        $('.view-by-list').find('li ul').hide();
        $('.view-by-list').slideUp('250');
    });

    $('.sort-by h2 li').on('click', function (event) {
        event.stopPropagation();
    });

    $('.sort-by h2 li li').on('click', function (event) {
        event.stopPropagation();
        $(this).addClass('selected-view').siblings().removeClass('selected-view');
        $(this).parents('li').addClass('selected-view').siblings('.selected-view').removeClass('selected-view').find('.selected-view').removeClass('selected-view');

        var filterName = $(this).children('a').text();
        $('.view-by-filter').show().children('span').text(filterName);
    });

    $('.sort-by h2 li').mouseover(function () {
        $(this).children('ul').slideDown().show().end().siblings().children('ul').hide();
    });

    $('.view-by-filter button').on('click', function () {
        $(this).parent().addClass('view-by-filter-close');
        setTimeout(function () {
            $('.view-by-filter').hide().removeClass('view-by-filter-close');
        }, 250);
        $('.view-by-list').find('.selected-view').removeClass('selected-view');
    });

    $('.search-initiative').on('input', function () {
        var $rows = $('.initative-list-all .initative-list');
        var val = '(?=.*' + $.trim($(this).val()).split(/\s+/).join(')(?=.*') + ').*$',
                reg = RegExp(val, 'i'),
                text;
        $rows.show().filter(function () {
            text = $(this).find('.list-name').text().replace(/\s+/g, ' ');
            return !reg.test(text);
        }).hide();

        if ($('.initative-list-all')[0].scrollHeight > 308) {
            $('.initative-list-all').slimScroll({
                height: '308px',
                alwaysVisible: true,
                color: '#ff9800',
                railColor: '#d7d7d7',
                railOpacity: 0.5,
                railVisible: true
            });
        } else {
            $('.initative-list-all').slimScroll({destroy: true});
            $('.slimScrollBar, .slimScrollRail').remove();
            $('.initative-list-all').removeAttr('style');
        }
    });

    $('#view-all').on('click', function () {
        $('.view-by-filter').hide();
        $('.view-by-list').find('.selected-view').removeClass('selected-view');
    });

    $('.initative-list-all').on('click', '.initative-list', function (event) {
        var id = $(this).attr('id');
        var arr = id.split('_');

        $('.initative-details-popup').html($('#popup_' + arr[1]).html()).show().animate({'top': '80px'}, 400);

        // To show placeholder text for IE
        if (navigator.userAgent.match(/Trident.*rv\:11\./)) {
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

        $('#deletePopup').on('click', function () {
            var target = $(this).parents('.initative-details-popup');
            var init = $('#row_' + $(this).attr('data-id'));
            target.hide('250', function () {
                target.css('top', '-478px');
                // init.addClass('delete-initative-list');
            });

            setTimeout(function () {
                init.after('<div class="undo-mark">Deleted <span><span>| &#x21A9;</span> Undo</span></div>');
                init.hide().removeClass('delete-initative-list');
            }, 300);
            setTimeout(function () {
                init.next().remove();
            }, 8000);
        });

        $('.popup-name button').on('click', function (event) {
            var target = $(this).parents('.initative-details-popup');
            setTimeout(function () {
                target.hide('fast', function () {
                    target.css('top', '-478px');
                });
            }, 250);

            var init = $('#row_' + $(this).attr('data-id'));
            setTimeout(function () {
                init.hide('slide', {direction: 'right'}, function () {
                    init.after('<div class="undo-mark">Completed <span><span>| &#x21A9;</span> Undo</span></div>');
                });
            }, 300);
            setTimeout(function () {
                init.next().remove();
            }, 8000);
        });
    });

    $('.initative-list-all').on('click', '.list-remove', function (event) {
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

    $('.initative-list-all').on('click', '.list-complete', function (event) {
        event.stopPropagation();
        $(this).addClass('finished-look');

        var $target = $(this);
        setTimeout(function () {
            $target.parents('.initative-list').hide('slide', {direction: 'right'}, function () {
                $target.parents('.initative-list').after('<div class="undo-mark">Completed <span><span>| &#x21A9;</span> Undo</span></div>');
            });
        }, 250);
        setTimeout(function () {
            $target.parents('.initative-list').next().remove();
        }, 8000);
    });

    $('.initative-list-all').on('click', '.undo-mark span', function () {
        $(this).parent().hide();
        $(this).parent().prev().show('slide', {direction: 'right'}).find('.list-complete').removeClass('finished-look');
    });

    $(document).keyup(function (e) {
        if (e.keyCode === 27) {
            $('.initative-details-popup').hide().css('top', '-478px');
        }
    });
});

//debounce so filtering doesn't happen every millisecond
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