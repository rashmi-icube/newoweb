jQuery(document).ready(function ($) {
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
        $('.user-profile-name ul').fadeToggle();
    });

    if ($('.no-current-ques').length > 0) {
        $('.question-date-response a').css('visibility', 'hidden');
    }

    $('.question-date-response a').on('click', function () {
        if ($(this).text() === 'View responses') {
            $('.collapse-question').removeClass('show-view').addClass('show-collapse');
            $('.view-question').css('visibility', 'hidden');
            $('.view-question span').removeAttr('style');
            $(this).text('Collapse').attr('title', 'Collapse');
        } else {
            $('.collapse-question').removeClass('show-collapse').addClass('show-view');
            $('#chartdiv').html('');
            $('.view-question').css('visibility', 'visible');
            $('.view-question span').css({
                position: 'relative',
                top: '-15px',
                transition: 'transform 0.3s linear 0.3s',
                transform: 'translateY(15px)'
            });
            $(this).text('View responses').attr('title', 'View responses');
        }
    });

    $('#questionFrequency option').each(function () {
        var str = $(this).text();
        var formatText = str.charAt(0).toUpperCase() + str.substr(1).toLowerCase();
        $(this).text(formatText);
    });

    $('.completed-questions-header h3').on('click', function (event) {
        event.stopPropagation();
        $(this).next('div').slideDown('250');
    });

    $('.completed-questions-menu h3').on('click', function () {
        $(this).parent('div').slideUp('250');
    });
    $(document).on('click', function () {
        $('.completed-questions-menu').slideUp('250');
    });

    $('.completed-questions-menu li').on('click', function () {
        $(this).addClass('selected').siblings().removeClass('selected');
        var name = $(this).clone().children().remove().end().text();
        $('.completed-questions-header h3 span').text(name);

        $('.search-question').val('');
    });

    $('.search-popup button').on('click', function () {
        $(this).next().show('slide', {direction: 'left'}, 500);
    });

    $('.search-question').on('input', function () {
        var $rows = $('.completed-questions table:visible .question-name-date');
        var val = '(?=.*' + $.trim($(this).val()).split(/\s+/).join(')(?=.*') + ').*$',
                reg = RegExp(val, 'i'),
                text;
        $rows.show().filter(function () {
            text = $(this).find('.question-name').text().replace(/\s+/g, ' ');
            return !reg.test(text);
        }).hide();
    });

    $('.completed-questions table a').on('click', function () {
        $(this).parents('tr').next('tr').find('div').slideToggle('400');
        var chartId = $(this).parents('tr').next('tr').find('div').attr('id');

        if ($(this).text() === 'View responses') {
            $(this).text('Collapse').attr('title', 'Collapse');
        } else {
            $('#' + chartId).html('');
            $(this).text('View responses').attr('title', 'View responses');
        }
    });
});

function generateGraph(divid, dataArray, obj) {
    if ($(obj).text() === 'View responses') {
        var chartConfig = {
            "type": "serial",
            "categoryField": "category",
            "columnSpacing": 10,
            "columnWidth": 0.47,
            "dataDateFormat": "YYYY-MM-DD",
            "mouseWheelScrollEnabled": true,
            "autoMarginOffset": 0,
            "marginLeft": 0,
            "marginTop": 0,
            "plotAreaBorderColor": "#A1A1A1",
            "startDuration": 1,
            "startEffect": "bounce",
            "borderColor": "#A1A1A1",
            "color": "#A1A1A1",
            "fontFamily": "Open Sans",
            "fontSize": 10,
            "handDrawScatter": 0,
            "handDrawThickness": 0,
            "categoryAxis": {
                "gridPosition": "start",
                "parseDates": true,
                "axisColor": "#A1A1A1",
                "gridColor": "#A1A1A1",
                "minHorizontalGap": 74,
                "titleBold": false,
                "titleFontSize": 0
            },
            "chartCursor": {
                "enabled": true
            },
            "trendLines": [],
            "graphs": [
                {
                    "fillAlphas": 1,
                    "id": "AmGraph-1",
                    "title": "graph 1",
                    "type": "column",
                    "valueField": "column-1",
                    "visibleInLegend": false
                }
            ],
            "guides": [],
            "valueAxes": [
                {
                    "id": "ValueAxis-1",
                    "axisColor": "#A1A1A1",
                    "minimum": 0,
                    "title": "",
                    "integersOnly": true
                }
            ],
            "allLabels": [],
            "balloon": {
                "color": "#888888",
                "shadowColor": "#A1A1A1"
            },
            "titles": [
                {
                    "id": "Title-1",
                    "size": 0,
                    "text": ""
                }
            ],
            "dataProvider": []
        };

        chartConfig.dataProvider = dataArray;
        AmCharts.makeChart(divid, chartConfig, 1000);
    }
}