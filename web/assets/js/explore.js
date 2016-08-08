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


    var chartinline;
    function createAmChartinline(chartId, stronglyagree, agree, neutral, disagree, stronglydisagree) {
        chartinline = AmCharts.makeChart(chartId,
                {
                    "type": "serial",
                    "categoryField": "category",
                    "columnWidth": 0.6,
                    "rotate": true,
                    "autoDisplay": true,
                    "autoMarginOffset": 0,
                    "autoMargins": false,
                    "marginBottom": 0,
                    "marginLeft": 0,
                    "marginRight": 0,
                    "marginTop": 0,
                    "plotAreaBorderColor": "#A1A1A1",
                    "startDuration": 1,
                    "startEffect": "easeOutSine",
                    "color": "#A1A1A1",
                    "fontFamily": "Open Sans",
                    "fontSize": 10,
                    "categoryAxis": {
                        "gridPosition": "start",
                        "axisThickness": 0,
                        "labelsEnabled": false
                    },
                    "trendLines": [],
                    "graphs": [
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-1",
                            "fillColors": "#d32f2f",
                            "lineColor": "#d32f2f",
                            "title": "Strongly Disagree",
                            "type": "column",
                            "valueField": "Strongly Disagree"
                        },
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-2",
                            "fillColors": "#FF9800",
                            "lineColor": "#FF9800",
                            "title": "Disagree",
                            "type": "column",
                            "valueField": "Disagree"
                        },
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-3",
                            "fillColors": "#9E9E9E",
                            "lineColor": "#9E9E9E",
                            "title": "Neutral",
                            "type": "column",
                            "valueField": "Neutral"
                        },
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-4",
                            "fillColors": "#29B6F6",
                            "lineColor": "#29B6F6",
                            "title": "Agree",
                            "type": "column",
                            "valueField": "Agree"
                        },
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-5",
                            "fillColors": "#5C6BC0",
                            "lineColor": "#5C6BC0",
                            "title": "Strongly Agree",
                            "type": "column",
                            "valueField": "Strongly Agree"
                        }
                    ],
                    "guides": [],
                    "valueAxes": [
                        {
                            "id": "ValueAxis-1",
                            "stackType": "100%",
                            "axisThickness": 0,
                            "title": ""
                        }
                    ],
                    "allLabels": [],
                    "balloon": {},
                    "legend": {
                        "enabled": false,
                        "autoMargins": false,
                        "forceWidth": false,
                        "useGraphSettings": false,
                        "combineLegend": true,
                        "reversedOrder": false,
                        "rollOverGraphAlpha": 0.65,
                        "spacing": 0,
                        "textClickEnabled": true
                    },
                    "titles": [
                        {
                            "id": "Title-1",
                            "size": 15,
                            "text": ""
                        }
                    ],
                    "dataProvider": [
                        {
                            "category": "I have a clear understanding of my job and what is expected of me",
                            "Strongly Disagree": stronglydisagree,
                            "Disagree": disagree,
                            "Neutral": neutral,
                            "Agree": agree,
                            "Strongly Agree": stronglyagree
                        }
                    ]
                }
        );
    }
    //$(this).on("pagecontainerload", function () {
    var inlineChartIdArray = ['chartdiv1', 'chartdiv3', 'chartdiv5', 'chartdiv7', 'chartdiv9', 'chartdiv11', 'chartdiv13', 'chartdiv15'];
    jQuery.each(inlineChartIdArray, function (i, chartId) {
        //var chartId = $(this).parents('tr').next('tr').find('div').attr('id');
        var stronglyagree = $('#' + chartId).find('#stronglyagree').val();
        var agree = $('#' + chartId).find('#agree').val();
        var neutral = $('#' + chartId).find('#neutral').val();
        var disagree = $('#' + chartId).find('#disagree').val();
        var stronglydisagree = $('#' + chartId).find('#stronglydisagree').val();
        createAmChartinline(chartId, stronglyagree, agree, neutral, disagree, stronglydisagree);
//        chartinline.write(chartId);
//       chart.handleResize();
    });


    var chartcollapsibleOrg;
    function createAmChartOrg(chartId, stronglyagree, agree, neutral, disagree, stronglydisagree) {
        chartcollapsibleOrg = AmCharts.makeChart(chartId,
                {
                    "type": "serial",
                    "categoryField": "category",
                    "columnWidth": 1,
                    "rotate": true,
                    "autoDisplay": true,
                    "autoMarginOffset": 0,
                    "autoMargins": true,
//                        "marginBottom": 0,
//                        "marginLeft": 0,
//                        "marginRight": 0,
//                        "marginTop": 0,
                    "plotAreaBorderColor": "#A1A1A1",
                    "startDuration": 1,
                    "startEffect": "easeOutSine",
                    "color": "#A1A1A1",
                    "fontFamily": "Open Sans",
                    "fontSize": 10,
                    "categoryAxis": {
                        "gridPosition": "start",
                        "axisThickness": 0,
                        "labelsEnabled": false
                    },
                    "trendLines": [],
                    "graphs": [
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-1",
                            "fillColors": "#d32f2f",
                            "lineColor": "#d32f2f",
                            "title": "Strongly Disagree",
                            "type": "column",
                            "valueField": "Strongly Disagree"
                        },
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-2",
                            "fillColors": "#FF9800",
                            "lineColor": "#FF9800",
                            "title": "Disagree",
                            "type": "column",
                            "valueField": "Disagree"
                        },
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-3",
                            "fillColors": "#9E9E9E",
                            "lineColor": "#9E9E9E",
                            "title": "Neutral",
                            "type": "column",
                            "valueField": "Neutral"
                        },
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-4",
                            "fillColors": "#29B6F6",
                            "lineColor": "#29B6F6",
                            "title": "Agree",
                            "type": "column",
                            "valueField": "Agree"
                        },
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-5",
                            "fillColors": "#5C6BC0",
                            "lineColor": "#5C6BC0",
                            "title": "Strongly Agree",
                            "type": "column",
                            "valueField": "Strongly Agree"
                        }
                    ],
                    "guides": [],
                    "valueAxes": [
                        {
                            "id": "ValueAxis-1",
                            "stackType": "100%",
                            "axisThickness": 0,
                            "title": ""
                        }
                    ],
                    "allLabels": [],
                    "balloon": {},
                    "legend": {
                        "enabled": true,
                        "autoMargins": false,
                        "forceWidth": false,
                        "useGraphSettings": false,
                        "combineLegend": true,
                        "reversedOrder": false,
                        "rollOverGraphAlpha": 0.65,
                        "spacing": 0,
                        "textClickEnabled": true
                    },
                    "titles": [
                        {
                            "id": "Title-1",
                            "size": 15,
                            "text": ""
                        }
                    ],
                    "dataProvider": [
                        {
                            "category": "I have a clear understanding of my job and what is expected of me",
                            "Strongly Disagree": stronglydisagree,
                            "Disagree": disagree,
                            "Neutral": neutral,
                            "Agree": agree,
                            "Strongly Agree": stronglyagree
                        }
                    ]
                }, 1000 //Delay for chart to appear on screen, after div expands
                );
    }

    var chartcollapsibleTeam;
    function createAmChartTeams(chartId, stronglyagree, agree, neutral, disagree, stronglydisagree) {
        chartcollapsibleTeam = AmCharts.makeChart(chartId,
                {
                    "type": "serial",
                    "categoryField": "category",
                    "columnWidth": 0.5,
                    "rotate": true,
                    "autoDisplay": true,
                    "autoMarginOffset": 0,
                    "autoMargins": true,
//                        "marginBottom": 0,
//                        "marginLeft": 0,
//                        "marginRight": 0,
//                        "marginTop": 0,
                    "plotAreaBorderColor": "#A1A1A1",
                    "startDuration": 1,
                    "startEffect": "easeOutSine",
                    "color": "#A1A1A1",
                    "fontFamily": "Open Sans",
                    "fontSize": 10,
                    "categoryAxis": {
                        "gridPosition": "start",
                        "axisThickness": 0,
                        "labelsEnabled": true
                    },
                    "trendLines": [],
                    "graphs": [
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-1",
                            "fillColors": "#d32f2f",
                            "lineColor": "#d32f2f",
                            "title": "Strongly Disagree",
                            "type": "column",
                            "valueField": "Strongly Disagree"
                        },
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-2",
                            "fillColors": "#FF9800",
                            "lineColor": "#FF9800",
                            "title": "Disagree",
                            "type": "column",
                            "valueField": "Disagree"
                        },
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-3",
                            "fillColors": "#9E9E9E",
                            "lineColor": "#9E9E9E",
                            "title": "Neutral",
                            "type": "column",
                            "valueField": "Neutral"
                        },
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-4",
                            "fillColors": "#29B6F6",
                            "lineColor": "#29B6F6",
                            "title": "Agree",
                            "type": "column",
                            "valueField": "Agree"
                        },
                        {
                            "balloonText": "[[title]]: [[value]]",
                            "fillAlphas": 1,
                            "id": "AmGraph-5",
                            "fillColors": "#5C6BC0",
                            "lineColor": "#5C6BC0",
                            "title": "Strongly Agree",
                            "type": "column",
                            "valueField": "Strongly Agree"
                        }
                    ],
                    "guides": [],
                    "valueAxes": [
                        {
                            "id": "ValueAxis-1",
                            "stackType": "100%",
                            "axisThickness": 0,
                            "title": ""
                        }
                    ],
                    "allLabels": [],
                    "balloon": {},
                    "legend": {
                        "enabled": true,
                        "autoMargins": false,
                        "forceWidth": false,
                        "useGraphSettings": false,
                        "combineLegend": true,
                        "reversedOrder": false,
                        "rollOverGraphAlpha": 0.65,
                        "spacing": 0,
                        "textClickEnabled": true
                    },
                    "titles": [
                        {
                            "id": "Title-1",
                            "size": 15,
                            "text": ""
                        }
                    ],
                    "dataProvider": [
                        {
                            "category": "Team 1",
                            "Strongly Disagree": stronglydisagree,
                            "Disagree": disagree,
                            "Neutral": neutral,
                            "Agree": agree,
                            "Strongly Agree": stronglyagree
                        },
                        {
                            "category": "Team 2",
                            "Strongly Disagree": Math.floor(Math.random() * 20),
                            "Disagree": Math.floor(Math.random() * 20),
                            "Neutral": Math.floor(Math.random() * 20),
                            "Agree": Math.floor(Math.random() * 20),
                            "Strongly Agree": Math.floor(Math.random() * 20)
                        },
                        {
                            "category": "Team 3",
                            "Strongly Disagree": Math.floor(Math.random() * 20),
                            "Disagree": Math.floor(Math.random() * 20),
                            "Neutral": Math.floor(Math.random() * 20),
                            "Agree": Math.floor(Math.random() * 20),
                            "Strongly Agree": Math.floor(Math.random() * 20)
                        },
                        {
                            "category": "Team 4",
                            "Strongly Disagree": Math.floor(Math.random() * 20),
                            "Disagree": Math.floor(Math.random() * 20),
                            "Neutral": Math.floor(Math.random() * 20),
                            "Agree": Math.floor(Math.random() * 20),
                            "Strongly Agree": Math.floor(Math.random() * 20)
                        },
                        {
                            "category": "Team 5",
                            "Strongly Disagree": Math.floor(Math.random() * 20),
                            "Disagree": Math.floor(Math.random() * 20),
                            "Neutral": Math.floor(Math.random() * 20),
                            "Agree": Math.floor(Math.random() * 20),
                            "Strongly Agree": Math.floor(Math.random() * 20)
                        }
                    ]
                }, 1000 //Delay for chart to appear on screen, after div expands
                );
    }

    var chartMap = new Object();
    $('.explore-by-question table a').on('click', function () {
        $(this).parents('tr').next('tr').find('div').slideToggle('400');
//       chart.handleResize();
        if ($(this).text() === 'View details') {
            $(this).text('Collapse').attr('title', 'Collapse');
            var chartId = $(this).parents('tr').next('tr').find('div').attr('id');
            var stronglyagree = $('#' + chartId).find('#stronglyagree').val();
            var agree = $('#' + chartId).find('#agree').val();
            var neutral = $('#' + chartId).find('#neutral').val();
            var disagree = $('#' + chartId).find('#disagree').val();
            var stronglydisagree = $('#' + chartId).find('#stronglydisagree').val();
            if (chartMap[chartId] === undefined) {
                if (chartId.replace(/^\D+/g, '') > 8) {
                    createAmChartTeams(chartId, stronglyagree, agree, neutral, disagree, stronglydisagree);
                    chartMap[chartId] = chartcollapsibleTeam;
                } else {
                    createAmChartOrg(chartId, stronglyagree, agree, neutral, disagree, stronglydisagree);
                    chartMap[chartId] = chartcollapsibleOrg;
//                chartcollapsibleOrg.write(chartId);
                }
            } else {
                chartMap[chartId].invalidateSize();
            }
        } else {
            $(this).text('View details').attr('title', 'View details');
        }
    });


    $('.user-profile-name p a').on('click', function (event) {
        event.stopPropagation();
        event.preventDefault();
        $('.user-profile-name ul').fadeToggle();
    });

    $('#chooseIndividual').click(function () {
        var previousValue = $(this).attr('previousValue');
        if (previousValue !== 'checked') {
            $(this).attr('previousValue', 'checked');
            $('#chooseTeam').attr('previousValue', false).removeAttr('checked');

            $(this).next('label').children('span').removeAttr('style');
            $('.initiative-choice-team').css('top', '15px').hide();
            $('.initiative-people').hide();
            $('.initiative-choice-single').show();

            $('.team-item').slice(1).remove();
            $('.team-item').find('.team-three-filters span').text('');
            $('.initiative-choice-select select').each(function (index, el) {
                $(el).removeAttr('disabled').val('').next('div').hide();
            });
        }

        $('.visual-metrics-menu .visual-metric-choose>div').empty();
        $.each(indTypeJSON, function (key, value) {
            $('.visual-metrics-menu .visual-metric-choose>div').append('<div>' +
                    '<input type="checkbox" name="explore-metric" value="' + key + '"  id="' + key + '" checked required oninvalid="setCustomValidity(\'Please choose atleast one metric.\')" onchange="setCustomValidity(\'\')"> ' +
                    '<label for="' + key + '">' + value + '</label>' +
                    '</div>');
        });

        $('.visual-time-menu .visual-metric-choose>div').empty();
        $.each(indTypeJSON, function (key, value) {
            if ((key == 1) || (key == 6)) {
                $('.visual-time-menu .visual-metric-choose>div').append('<div>' +
                        '<input type="radio" name="explore-metric" value="' + key + '" id="' + key + '" checked> ' +
                        '<label for="' + key + '">' + value + '</label>' +
                        '</div>');
            } else {
                $('.visual-time-menu .visual-metric-choose>div').append('<div>' +
                        '<input type="radio" name="explore-metric" value="' + key + '"  id="' + key + '"> ' +
                        '<label for="' + key + '">' + value + '</label>' +
                        '</div>');
            }
        });

        $('.visual-network-menu .visual-graph-choose select').find('option[value="Team"]').remove();
        $('.visual-graph-warning').hide();
        $('#visual-graph').empty();
    });

    $('#chooseTeam').attr('previousValue', 'checked');

    $('#chooseTeam').click(function () {
        var previousValue = $(this).attr('previousValue');
        if (previousValue !== 'checked') {
            $(this).attr('previousValue', 'checked');
            $('#chooseIndividual').attr('previousValue', false).removeAttr('checked');

            $(this).next('label').children('span').removeAttr('style');
            $('.initiative-choice-single').hide();
            $('.initiative-choice-team').show().animate({'top': '0px'}, 200);
            $('.initiative-choice-team').find('option:disabled').removeAttr('disabled');
            $('.initiative-people').show();

            $('.single-name-list').empty().siblings().removeAttr('style');
        }

        $('.visual-metrics-menu .visual-metric-choose>div').empty();
        $.each(teamTypeJSON, function (key, value) {
            $('.visual-metrics-menu .visual-metric-choose>div').append('<div>' +
                    '<input type="checkbox" name="explore-metric" value="' + key + '" id="' + key + '" checked required oninvalid="setCustomValidity(\'Please choose atleast one metric.\')" onchange="setCustomValidity(\'\')"> ' +
                    '<label for="' + key + '">' + value + '</label>' +
                    '</div>');
        });

        $('.visual-time-menu .visual-metric-choose>div').empty();
        $.each(teamTypeJSON, function (key, value) {
            if ((key == 1) || (key == 6)) {
                $('.visual-time-menu .visual-metric-choose>div').append('<div>' +
                        '<input type="radio" name="explore-metric" value="' + key + '" id="' + key + '" checked> ' +
                        '<label for="' + key + '">' + value + '</label>' +
                        '</div>');
            } else {
                $('.visual-time-menu .visual-metric-choose>div').append('<div>' +
                        '<input type="radio" name="explore-metric" value="' + key + '" id="' + key + '"> ' +
                        '<label for="' + key + '">' + value + '</label>' +
                        '</div>');
            }
        });

        if (!($('.visual-network-menu .visual-graph-choose select').find('option[value="Team"]').length)) {
            $('.visual-network-menu .visual-graph-choose select').prepend('<option value="Team">Team</option>');
            $('.visual-network-menu .visual-graph-choose select').val('Team');
        }
        ;
        $('#visual-graph').empty();
    });

    $('.initiative-choice-select select').on('change', function () {
        var i = $(this).parent('div').index();
        var val = $(this).children('option:selected').text();
        var id = $(this).val();
        $('.team-item:last').find('.team-three-filters div:eq(' + i + ')').children('span').text(val);
        $('.team-item:last').find('.team-three-filters div:eq(' + i + ')').children('span').attr('data-id', id);

        var enable = true;
        $('.team-item:last .team-three-filters div').each(function (index, el) {
            if ($(el).children('span').text().length === 0) {
                enable = false;
            }
        });

        if (enable && ($('.add-team-list').children().length < 5)) {
            $('.add-more-team button').removeAttr('disabled');
        }
    });

    $('.add-more-team button').on('click', function (event) {
        event.stopPropagation();

        //Exit if no options left to choose in the filter
        if ($('.team-item:last').index() > 0) {
            if (($('.initiative-choice-select select:enabled').find('option:enabled').length - 1) === 0) {
                return 0;
            }
        } else {
            // Exit if first team is All-All-All combo
            var yesAll = true;
            $('.initiative-choice-select select').each(function () {
                if ($(this).val() !== '0') {
                    yesAll = false;
                }
            });
            if (yesAll) {
                return 0;
            }
        }

        if ($('.add-team-list').children().length < 5) {
            var insert = true;
            $('.team-item:last .team-three-filters div').each(function (index, el) {
                if ($(el).children('span').text().length === 0) {
                    insert = false;
                }
            });
            if (insert) {
                var itemNo = ($('.add-team-list').children().length) + 1;
                var newItem = $('.team-item:first').clone(true);

                $(newItem).find('.team-name span').text('Team ' + itemNo);
                $(newItem).find('.team-three-filters span').text('');
                newItem.appendTo('.add-team-list');
            }

            if ($('.team-item:last').index() === 1) {
                $('.compare-type-popup input').prop('disabled', false);
                $('.team-item:first .team-three-filters div').each(function (index, el) {
                    if ($(el).children('span').text() === 'All') {
                        $('.compare-type-popup').find('div:eq(' + index + ') input').prop('disabled', true);
                    }
                });

                $('.initiative-choice-select select').prop('disabled', 'true').next('div').show();

                $('.initiative-choice-select select').each(function () {
                    $(this).find('option:first').prop('disabled', true);
                });

                $('.compare-type-popup').show().animate({'top': '42px'}, 200);
            }
            ;

            if ($('.team-item:last').index() > 1) {
                $('.initiative-choice-select select:enabled').val('');

                $('.initiative-choice-select select').each(function () {
                    $(this).find('option:first').prop('disabled', true);
                });

                var i = $('.initiative-choice-select select:enabled').parent().index();
                $('.team-item:last .team-three-filters div').each(function (index, el) {
                    var same = $(el).parents('.team-item').prevAll('div:first-child').find('.team-three-filters div:eq(' + index + ') span').text();
                    if (index !== i) {
                        $(el).children('span').text(same);
                    } else {
                        $(el).children('span').text('');
                    }
                });

                $('.team-item:nth-last-child(2) .team-three-filters div').each(function (index, el) {
                    if (index === i) {
                        var chosen = $(el).find('span').attr('data-id');
                        $('.initiative-choice-select select:enabled').find('option[value="' + chosen + '"]').prop('disabled', true);
                    }
                });

                if ($('.add-team-list').children().length === 5) {
                    $('.add-more-team button').prop('disabled', true);
                }
            }
            ;
        }
    });

    $('.compare-type-popup input').on('click', function () {
        $('.compare-type-popup').animate({'top': '0'}, 200, function () {
            $(this).hide();
        });

        var i = ($(this).parent('div').index()) - 1;
        $('.team-item:last .team-three-filters div').each(function (index, el) {
            var same = $(el).parents('.team-item').prevAll('div:first-child').find('.team-three-filters div:eq(' + index + ') span').text();
            if (index !== i) {
                $(el).children('span').text(same);
            } else {
                $(el).children('span').text('').removeAttr('data-id');
            }
        });

        $('.initiative-choice-select').each(function (index, el) {
            if (index !== i) {
                $(el).children('select').prop('disabled', 'true').next('div').show();
            } else {
                $(el).children('select').removeAttr('disabled').val('').next('div').hide();
                var chosen = $('.team-item:first .team-three-filters div:eq(' + i + ') span').attr('data-id');
                $(el).find('option[value="' + chosen + '"]').prop('disabled', true);
            }
        });
    });

    $(document).click(function (event) {
        $('.compare-type-popup').animate({'top': '0'}, 200, function () {
            $(this).hide();
            $(this).find('input').removeAttr('checked');
        });
    });

    $('.team-name button').on('click', function () {
        if ($('.add-team-list').children().length === 1) {
            $(this).parent().next().find('span').text('').removeAttr('data-id');
            $('.initiative-choice-select select').val('');

            if ($('.visual-graph-warning').is(':visible')) {
                $('.visual-graph-warning').fadeOut();
            }
        } else {
            if ($('.visual-graph-warning').is(':visible')) {
                var removed = $(this).parents('.team-item').index();
                var index = arr_no_data.indexOf((removed + 1).toString());
                if (index > -1) {
                    arr_no_data.splice(index, 1);
                }

                for (i = 0; i < arr_no_data.length; i++) {
                    if (arr_no_data[i] >= (removed + 1)) {
                        arr_no_data[i] = (arr_no_data[i] - 1).toString();
                    }
                }

                var errorStr = '<span class="bold">Warning:</span> Team ';
                if (arr_no_data.length === 0) {
                    $('.visual-graph-warning').fadeOut();
                } else if (arr_no_data.length === 1) {
                    errorStr += '<span class="bold">' + arr_no_data[0] + '</span> size too small.';
                } else if (arr_no_data.length === 2) {
                    errorStr += '<span class="bold">' + arr_no_data[0] + '</span> and <span class="bold">' + arr_no_data[1] + '</span> size too small.';
                } else {
                    for (i = 0; i < arr_no_data.length - 1; i++) {
                        errorStr += '<span class="bold">' + arr_no_data[i] + '</span>, ';
                    }
                    errorStr += 'and <span class="bold">' + arr_no_data[arr_no_data.length - 1] + '</span> size too small.';
                }
                $('.warning-text').empty().append(errorStr).parent().show();
            }

            $(this).parents('.team-item').nextAll().each(function (index, el) {
                var newName = $(el).index();
                $(el).find('.team-name span').text('Team ' + newName);
            });

            // Enable the filter option disabled on creating that team
            var activeFilter = $('.initiative-choice-select select:enabled').parent().index();
            var deadOption = $(this).parents('.team-item').find('.team-three-filters div:eq(' + activeFilter + ')').find('span').attr('data-id');
            $('.initiative-choice-select select:enabled').find('option[value=' + deadOption + ']').removeAttr('disabled');

            $(this).parents('.team-item').remove();
            // Enable the filter option disabled by the last team 
            var deadOption2 = $('.team-item:last').find('.team-three-filters div:eq(' + activeFilter + ')').find('span').attr('data-id');
            $('.initiative-choice-select select:enabled').find('option[value=' + deadOption2 + ']').removeAttr('disabled');
        }

        $('.add-more-team button').removeAttr('disabled');
        if ($('.add-team-list').children().length < 2) {
            var activeFilter = $('.initiative-choice-select select:enabled').parent().index();
            var deadOption = $(this).parents('.team-item').find('.team-three-filters div:eq(' + activeFilter + ')').find('span').attr('data-id');
            $('.initiative-choice-select select:enabled').find('option[value=' + deadOption + ']').removeAttr('disabled');

            $('.initiative-choice-select select').removeAttr('disabled').next('div').hide();
            $('.initiative-choice-select select').each(function () {
                $(this).find('option').prop('disabled', false);
            });
        }
    });

    $('.data-visual-header a').on('click', function (event) {
        event.preventDefault();
        $(this).parent('li').addClass('current').siblings().removeClass('current');
        var i = $(this).parent('li').index();
        $('.visual-choose>div:visible').hide();
        $('.visual-choose>div:eq(' + i + ')').show('slide', {direction: 'left'});

        $('.amcharts-export-menu, .action-export-menu').hide();

        // Remove create initiative button from Network tab
        if (i === 2) {
            $('#visual-create').css('visibility', 'hidden');
        } else {
            $('#visual-create').removeAttr('style');
        }
        callAjax = true;
    });

    $('.data-visual-header button').on('click', function () {
        if ($(this).text() === 'Expand') {
            $('#visual-graph').addClass('expanded');
            $('.initiative-which-people').slideUp('400', function () {
                $('.data-visual-header button').text('Collapse');
            });
        } else if ($(this).text() === 'Collapse') {
            $('#visual-graph').removeClass('expanded');
            $('.initiative-which-people').slideDown('400', function () {
                $('.data-visual-header button').text('Expand');
            });
        }
    });

    $('.metrics-header button').on('click', function () {
        if ($(this).text() === 'Expand') {
            $('.create-metrics-list').show('slow');
            $('#collapse-metrics').text('Collapse');
        } else if ($(this).text() === 'Collapse') {
            $('.create-metrics-list').hide('slow');
            $('#collapse-metrics').text('Expand');
        }
    });

    $('.initiative-submit-button button').on('click', function () {
        $('.create-metrics-list').hide('slow');
        $('#collapse-metrics').text('Expand');
    });

    $('.panel-select-metric').on('click', function () {
        $(this).closest('ul').find('.panel-select-metric').removeClass('selected');
        $(this).addClass('selected');
    });

    $('#clear-metric, #clear-time, #clear-network').on('click', function () {
        if ($(this).text() === 'Clear All') {
            $(this).parent('div').prev().find('input').removeAttr('checked');
            $(this).text('Select All');
        } else if ($(this).text() === 'Select All') {
            $(this).parent('div').prev().find('input').prop('checked', true);
            $(this).text('Clear All');
        }
    });

    $('.visual-metrics-menu input, .visual-network-menu input').on('change', function () {
        if ($(this).is(':checked') && $('.find-visuals-error').is(':visible')) {
            $('.find-visuals-error p').hide();
        }
    });

    $('#network-metric1').prop('checked', true);

    $('#visual-export').on('click', function (event) {
        if ($('.data-visual-header .current').index() < 2) {
            if ($('.amcharts-legend-div').length) {
                var target = $('.amcharts-export-menu');
                if ($('.amcharts-export-menu>span').length === 0) {
                    $(target).prepend('<span>Export as</span>');
                }
                $(target).toggle();

                if ($('.visual-graph-warning').is(':visible')) {
                    $(target).css('top', '11px');
                } else {
                    $(target).css('top', '50px');
                }

                $('.amcharts-export-menu li').on('click', function () {
                    $(target).hide();
                });
            }
        } else {
            $(this).next('div').toggle();
            $('.action-export-menu a').on('click', function () {
                event.preventDefault();
                downloadCanvasAsPng();
                $('.action-export-menu').hide();
            });
        }
    });
});

function downloadCanvasAsPng() {
    ReImg.fromCanvas(document.querySelector('canvas')).downloadPng();
}

