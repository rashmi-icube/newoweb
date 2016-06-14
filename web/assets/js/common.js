/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function showError(error) {
    $(".errorMsg").html("");
    $.each(error, function (k, v) {
        $('#' + k).parent().append('<div class="errorMsg" style="display: block;">' + v + '</div>');
    });
}
function getValue(id) {
    if ($('#' + id).val() == $('#' + id).attr("placeholder")) {
        return "";
    }
    else {
        return $('#' + id).val();
    }
}

function createInitiative(id) {
    window.location.href = webcontext + "/initiative/create.jsp?a=" + id;
}

function deleteInitative(id) {
    var postStr = "iid=" + id + "&status=Deleted";
    var undo = false;
    $('.initative-list-all').on('click', function(e) {
        if ($(e.target).parent().hasClass('undo-mark')) {
            undo = true;
        }
    });
    setTimeout(function() {
        if (!undo) {
            $.ajax({
                url: webcontext + '/initiative/update.jsp',
                type: 'POST',
                data: postStr,
                error: function () {
                    $('#info').html('<p>An error has occurred</p>');
                },
                dataType: 'json',
                success: function (resp) {
                    if (resp.status === 0) {
                        $('#row_'+id).remove();
                        $('#popup_'+id).remove();
                    }
                }
            });
        }
    }, 8000);
}

function updateStatus(id, status) {
    var postStr = "iid=" + id + "&status=" + status;
    var undo = false;
    $('body').click(function (e) {
        if ($(e.target).parent().hasClass('undo-mark')) {
            undo = true;
        }
    });
    
    setTimeout(function () {
        if (!undo) {
            $.ajax({
                url: webcontext + '/initiative/update.jsp',
                type: 'POST',
                data: postStr,
                error: function () {
                    $('#info').html('<p>An error has occurred</p>');
                },
                dataType: 'json',
                success: function(resp) {
                    if($('.filter-metric').is(':visible')) {
                        getTopList($('.filter-metric .clicked').text());
                    }
                    $('#row_'+id).remove();
                    $('#popup_'+id).remove();
                }
            });
        }
    }, 8000);
}

function updateComments(id, comments, obj) {
    comments = encodeURIComponent(comments);
    var postStr = 'iid=' + id + '&comments=' + comments;
    $.ajax({
        url: webcontext + '/initiative/updatecomments.jsp',
        type: 'POST',
        data: postStr,
        error: function () {
            $('#info').html('<p>An error has occurred</p>');
        },
        dataType: 'json',
        success: function (resp) {
            if (resp.status === 0) {
                $('#popup_' + id).find('.popup-chat-window').html(resp.comments);
                $(obj).prev().val('');
                $(obj).parent().prev('.popup-chat-window').html(resp.comments);
            }
        }
    });
}

function getDataAarray(mat1, mat2, mat1key, mat2kay) {
    var currentQArray = new Array();
    for (var j in mat1) {
        for (var k in mat1[j]) {
            var a = {};
            a["date"] = k;
            a[mat1key] = mat1[j][k];
            a[mat2kay] = mat2[j][k];
            currentQArray.push(a);
        }
    }
    return currentQArray;
}

function generateTimeGraph(divid, dataArray, type1, type2) {
    var chartConfig = {
        "type": "serial",
        "categoryField": "date",
        "dataDateFormat": "YYYY-MM-DD",
        "mouseWheelScrollEnabled": true,
        "mouseWheelZoomEnabled": true,
        "autoMarginOffset": 0,
        "marginBottom": 0,
        "marginLeft": -10,
        "marginTop": 0,
        "plotAreaBorderColor": "#A1A1A1",
        "colors": [
            "#FFB84E",
            "#FFB84E"
        ],
        "borderColor": "#A1A1A1",
        "color": "#A1A1A1",
        "creditsPosition": "bottom-right",
        "fontFamily": "open sans",
        "fontSize": 10,
        "handDrawScatter": 0,
        "handDrawThickness": 0,
        "categoryAxis": {
            "equalSpacing": true,
            "minPeriod": "DD",
            "parseDates": true,
            "axisColor": "#A1A1A1",
            "axisThickness": 0,
            "gridColor": "#A1A1A1",
            "minHorizontalGap": 70,
            "tickLength": 3
        },
        "chartCursor": {
            "enabled": true,
            "categoryBalloonDateFormat": "MMM DD, YYYY",
            "cursorColor": "#FF8000",
            "graphBulletSize": 1,
            "valueLineBalloonEnabled": true,
            "valueZoomable": true
        },
        "chartScrollbar": {
            "enabled": true,
            "autoGridCount": true,
            "dragIconHeight": 20,
            "dragIconWidth": 30
        },
        "trendLines": [],
        "graphs": [
            {
                "animationPlayed": true,
                "bullet": "round",
                "bulletAlpha": 0.53,
                "bulletBorderThickness": 0,
                "bulletSize": 5,
                "id": "AmGraph-1",
                "minBulletSize": 6,
                "title": type1,
                "valueField": type1
            },
            {
                "bullet": "square",
                "bulletBorderAlpha": 0.53,
                "bulletBorderThickness": 0,
                "bulletSize": 5,
                "id": "AmGraph-2",
                "minBulletSize": 5,
                "title": type2,
                "valueField": type2
            }
        ],
        "guides": [],
        "valueAxes": [
            {
                "id": "ValueAxis-1",
                "axisColor": "#A1A1A1",
                "axisThickness": 0,
                "gridColor": "#A1A1A1",
                "tickLength": 2,
                "title": "Axis title",
                "titleBold": false,
                "titleFontSize": 0
            }
        ],
        "allLabels": [],
        "balloon": {
            "color": "#AAB3B3"
        },
        "legend": {
            "enabled": true,
            "align": "right",
            "autoMargins": false,
            "borderColor": "#A1A1A1",
            "bottom": 0,
            "color": "#AAB3B3",
            "fontSize": 10,
            "left": 0,
            "marginLeft": 0,
            "marginRight": 0,
            "position": "right",
            "spacing": 5,
            "textClickEnabled": true,
            "useGraphSettings": true,
            "verticalGap": 0
        },
        "titles": [
            {
                "id": "Title-1",
                "size": 0,
                "text": "Chart Title"
            }
        ],
        "dataProvider": []
    };
    chartConfig.dataProvider = dataArray;
    AmCharts.makeChart(divid, chartConfig);
}

function deleteAlert(id) {
    var postStr = "iid=" + id + "&status=Deleted";
    $.ajax({
        url: webcontext + '/dashboard/alert.jsp',
        type: 'POST',
        data: postStr,
        error: function () {
            $('#info').html('<p>An error has occurred</p>');
        },
        dataType: 'json',
        success: function (resp) {
            if (resp.status === 0) {
            } else {
            }
        }
    });
}

// Used to name file that is exported as csv or image
function getDate() {
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1;
    var yyyy = today.getFullYear();
    if(dd<10){
        dd='0'+dd
    } 
    if(mm<10){
        mm='0'+mm
    } 
    today = dd+'-'+mm+'-'+yyyy;
    return today;
}

function getBarGraph(divid, graphProvider, dataProvider) {
    var name = getDate()+'-Metrics';  
    AmCharts.makeChart(divid, {
        "type": "serial",
        "categoryField": "category",
        "mouseWheelScrollEnabled": true,
        "mouseWheelZoomEnabled": true,
        "autoMarginOffset": 20,
        "plotAreaBorderColor": "A1A1A1",
        "borderColor": "A1A1A1",
        "color": "A1A1A1",
        "fontFamily": "Open Sans",
        "fontSize": 10,
        "handDrawScatter": 0,
        "handDrawThickness": 0,
        "categoryAxis": {
            "gridPosition": "start",
            "axisColor": "#A1A1A1",
            "gridColor": "A1A1A1",
            "titleBold": false,
            "titleFontSize": 0
        },
        "trendLines": [],
        "graphs": graphProvider,
        "guides": [],
        "valueAxes": [
            {
                "id": "ValueAxis-1",
                "axisColor": "#A1A1A1",
                "title": ""
            }
        ],
        "allLabels": [],
        "balloon": {},
        "legend": {
            "enabled": true,
            "align": "right",
            "borderColor": "A1A1A1",
            "color": "A1A1A1",
            "fontSize": 10,
            "position": "right",
            "textClickEnabled": true,
            "useGraphSettings": true
        },
        "titles": [],
        "dataProvider": dataProvider,
        "export": {
		    "enabled": true,
		    "class": "export-main",
            "fileName": name,
    		"menu": [{
		      "format": "CSV",
		      "label": "CSV"
		    }, {
		      "format": "PNG",
		      "label": "Image"
		    }]
        }
    });
}

function getAreaGraph(divid, graphProvider, dataProvider) {
    var name = getDate()+'-Metrics';
    AmCharts.makeChart(divid, {
        "type": "serial",
        "categoryField": "category",
        "mouseWheelScrollEnabled": true,
        "mouseWheelZoomEnabled": true,
        "autoMarginOffset": 20,
        "plotAreaBorderColor": "A1A1A1",
        "borderColor": "A1A1A1",
        "color": "A1A1A1",
        "fontFamily": "Open Sans",
        "fontSize": 10,
        "handDrawScatter": 0,
        "handDrawThickness": 0,
        "categoryAxis": {
            "gridPosition": "start",
            "axisColor": "#A1A1A1",
            "gridColor": "A1A1A1",
            "titleBold": false,
            "titleFontSize": 0
        },
        "chartCursor": {
            "enabled": true,
            "selectWithoutZooming": true
        },
        "chartScrollbar": {
            "enabled": true,
            "dragIconHeight": 20,
            "dragIconWidth": 20,
            "scrollbarHeight": 10
        },
        "trendLines": [],
        "graphs": graphProvider,
        "guides": [],
        "valueAxes": [
            {
                "id": "ValueAxis-1",
                "axisColor": "#A1A1A1",
                "title": ""
            }
        ],
        "allLabels": [],
        "balloon": {},
        "legend": {
            "enabled": true,
            "align": "right",
            "borderColor": "A1A1A1",
            "color": "A1A1A1",
            "fontSize": 10,
            "position": "right",
            "textClickEnabled": true,
            "useGraphSettings": true
        },
        "titles": [],
        "dataProvider": dataProvider,
        "export": {
		    "enabled": true,
		    "class": "export-main",
            "fileName": name,
    		"menu": [{
		      "format": "CSV",
		      "label": "CSV"
		    }, {
		      "format": "PNG",
		      "label": "Image"
		    }]
        }
    });
}

function getLineGraph(divid, graphProvider, dataProvider) {
    var name = getDate()+'-Metrics';
    AmCharts.makeChart(divid, {
        "type": "serial",
        "categoryField": "category",
        "mouseWheelScrollEnabled": true,
        "mouseWheelZoomEnabled": true,
        "autoMarginOffset": 20,
        "plotAreaBorderColor": "A1A1A1",
        "borderColor": "A1A1A1",
        "color": "A1A1A1",
        "fontFamily": "Open Sans",
        "fontSize": 10,
        "handDrawScatter": 0,
        "handDrawThickness": 0,
        "categoryAxis": {
            "gridPosition": "start",
            "axisColor": "#A1A1A1",
            "gridColor": "A1A1A1",
            "titleBold": false,
            "titleFontSize": 0
        },
        "chartCursor": {
            "enabled": true,
            "selectWithoutZooming": true
        },
        "chartScrollbar": {
            "enabled": true,
            "dragIconHeight": 20,
            "dragIconWidth": 20,
            "scrollbarHeight": 10
        },
        "trendLines": [],
        "graphs": graphProvider,
        "guides": [],
        "valueAxes": [
            {
                "id": "ValueAxis-1",
                "axisColor": "#A1A1A1",
                "title": ""
            }
        ],
        "allLabels": [],
        "balloon": {},
        "legend": {
            "enabled": true,
            "align": "right",
            "borderColor": "A1A1A1",
            "color": "A1A1A1",
            "fontSize": 10,
            "position": "right",
            "textClickEnabled": true,
            "useGraphSettings": true
        },
        "titles": [],
        "dataProvider": dataProvider,
        "export": {
		    "enabled": true,
		    "class": "export-main",
            "fileName": name,
    		"menu": [{
		      "format": "CSV",
		      "label": "CSV"
		    }, {
		      "format": "PNG",
		      "label": "Image"
		    }]
        }
    });
}

function getTimeSeriesGraphExplore(divid, graphProvider, dataProvider) {   
    var name = getDate()+'-TimeSeries';
    AmCharts.makeChart(divid, {
        "type": "serial",
        "categoryField": "date",
        "dataDateFormat": "YYYY-MM-DD",
        "plotAreaBorderColor": "#A1A1A1",
        "startEffect": "easeOutSine",
        "borderColor": "#A1A1A1",
        "color": "#A1A1A1",
        "fontFamily": "Open Sans",
        "fontSize": 10,
        "handDrawScatter": 0,
        "handDrawThickness": 0,
        "theme": "default",
        "categoryAxis": {
            "minPeriod": "DD",
            "parseDates": true,
            "axisColor": "#A1A1A1",
            "gridColor": "#A1A1A1",
            "titleBold": false,
            "titleFontSize": 0
        },
        "chartCursor": {
            "enabled": true,
            "categoryBalloonDateFormat": "MMM DD, YYYY",
            "selectWithoutZooming": true
        },
        "chartScrollbar": {
            "enabled": true,
            "dragIconHeight": 20,
            "dragIconWidth": 20,
            "scrollbarHeight": 10
        },
        "trendLines": [],
        "graphs": graphProvider,
        "guides": [],
        "valueAxes": [
            {
                "id": "ValueAxis-1",
                "title": ""
            }
        ],
        "allLabels": [],
        "balloon": {},
        "legend": {
            "enabled": true,
            "align": "right",
            "borderColor": "#A1A1A1",
            "color": "#A1A1A1",
            "fontSize": 10,
            "labelWidth": 1,
            "position": "right",
            "textClickEnabled": true,
            "useGraphSettings": true
        },
        "titles": [],
        "dataProvider": dataProvider,
        "export": {
		    "enabled": true,
		    "class": "export-main",
            "fileName": name,
    		"menu": [{
		      "format": "CSV",
		      "label": "CSV"
		    }, {
		      "format": "PNG",
		      "label": "Image"
		    }]
        }
    });
}

function sortUnique(arr) {
    arr.sort();
    var last_i;
    for (var i=0;i<arr.length;i++)
        if ((last_i = arr.lastIndexOf(arr[i])) !== i)
            arr.splice(i+1, last_i-i);
    return arr;
}