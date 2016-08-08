<%-- 
    Document   : explore
    Created on : Feb 23, 2016, 7:38:29 PM
    Author     : fermion10
--%>

<%@page import="java.util.List"%>
<%@page import="org.icube.owen.dashboard.Alert"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.Util"%>
<%@page import="java.util.Map"%>
<%@page import="org.icube.owen.filter.FilterList"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.icube.owen.explore.ExploreHelper"%>
<%
    String moduleName = "explore";
    String subModuleName = "explore";
    int intEmpid = 0;
    String rEmpid = request.getParameter("eid");
    if(rEmpid != null) {
        intEmpid = Util.getIntValue(rEmpid);
    }
    String alertid = request.getParameter("a") != null ?  request.getParameter("a") : "";
    
%> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>OWEN - Explore</title>
        <link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>js/amcharts/plugins/export/export.css">
        <link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/vis.min.css">
        <link rel="apple-touch-icon" sizes="57x57" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="72x72" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="114x114" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="120x120" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="144x144" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="152x152" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-152x152.png">
        <link rel="apple-touch-icon" sizes="180x180" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-180x180.png">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/android-icon-192x192.png" sizes="192x192">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/favicon-16x16.png" sizes="16x16">
        <link rel="manifest" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/manifest.json">
        <meta name="msapplication-TileColor" content="#da532c">
        <meta name="msapplication-TileImage" content="<%=Constant.WEB_ASSETS%>images/favicon_HR/ms-icon-144x144.png">
    </head>
    
    <body>	
        <div class="overlay_form"><img src="<%=Constant.WEB_ASSETS%>images/ajax-loader.gif"></div>
    
        <div class="container">
            <%@include file="../header.jsp" %>
            <div class="main">
			<div class="wrapper">
				<div class="explore-box">
					<div class="explore-header">
						<h3>Explore</h3>
					</div>
                    <form name="metrics-graph" id="metrics-graph">
                        <div class="initiative-which-people">
                            <div class="initiative-which">
                                <div class="initiative-category">
                                    <input type="radio" value="individual" id="chooseIndividual" <%= intEmpid != 0 ? "checked": ""%> />
                                    <label for="chooseIndividual" title="Select individual"><span>&#x2714;</span>Individual</label> 

                                    <input type="radio" value="team" id="chooseTeam" <%= intEmpid == 0 ? "checked": ""%>  />
                                    <label for="chooseTeam" title="Select team"><span>&#x2714;</span>Team</label>
                                </div>
                                <%  FilterList fl = new FilterList(); %>
                                <div class="initiative-choice-team">	
                                    <div class="initiative-choice-select">
                                        <span>1.</span>
                                        <label for="teamGeography">Select a geography</label>
                                        <select name="teamGeography" id="teamGeography" size="5" required oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                            <%
                                                Filter filter = fl.getFilterValues(comid,Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                                                Map <Integer,String>  geoitem = filter.getFilterValues();
                                                for (Map.Entry<Integer, String> entry : geoitem.entrySet()) { %>
                                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                <% } %>
                                        </select>
                                        <div class="select-overlay"></div>
                                    </div>
                                    <div class="initiative-choice-select">
                                        <span>2.</span>
                                        <label for="teamFunction">Select a function</label>
                                        <select name="teamFunction" id="teamFunction" size="5" required oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                            <%  filter = fl.getFilterValues(comid,Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                                                Map <Integer,String>  funitem = filter.getFilterValues();
                                                for (Map.Entry<Integer, String> entry : funitem.entrySet()) { %>
                                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                <% } %>
                                        </select>
                                        <div class="select-overlay"></div>
                                    </div>
                                    <div class="initiative-choice-select">
                                        <span>3.</span>
                                        <label for="teamLevel">Select a level</label>
                                        <select name="teamLevel" id="teamLevel" size="5" required oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                   <%           filter = fl.getFilterValues(comid,Constant.INITIATIVES_LEVEL_FILTER_NAME);
                                                Map <Integer,String>  levelitem =  filter.getFilterValues();
                                                for (Map.Entry<Integer, String> entry : levelitem.entrySet()) { %>
                                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                <% } %>
                                        </select>
                                        <div class="select-overlay"></div>
                                    </div>
                                </div>	
                                 <% 
                                      Employee empObj = null;          
                                      if(intEmpid != 0 ){
                                          empObj = (new Employee()).get(comid,intEmpid);
                                      }
                                 %>       
                                <div class="initiative-choice-single">
                                    <input type="search" id="fiveSingleName">
                                    <div class="single-name-list">
                                        <% if(empObj != null) { %>
                                            <div class="single-name-bubble"><span data-id="<%=intEmpid%>"><%=empObj.getFirstName()+" "+ (empObj.getLastName()!= null ? empObj.getLastName():"") %></span><button type="button">x</button></div>
                                        <% } %>
                                    </div>
                                    <select id="suggestion-box" size="5"></select>
                                </div>
                            </div>

                            <div class="initiative-people">
                                <div class="add-more-team">
                                    <button type="button" title="Add one more team" disabled>+1</button>
                                    <div class="compare-type-popup">
                                        <span>Compare by</span>
                                        <div>
                                            <input type="radio" id="team-geography" />
                                            <label for="team-geography">Geography</label>
                                        </div>	
                                        <div>										
                                            <input type="radio" id="team-function" />
                                            <label for="team-function">Function</label>
                                        </div>
                                        <div>
                                            <input type="radio" id="team-level" />
                                            <label for="team-level">Level</label>
                                        </div>
                                    </div>
                                </div>	
                                <div class="add-team-list">
                                    <div class="team-item">
                                        <div class="team-name">
                                            <span>Team 1</span>
                                            <button type="button">x</button>
                                        </div>
                                        <div class="team-three-filters">
                                            <div><span></span></div>
                                            <div><span></span></div>
                                            <div><span></span></div>
                                        </div>
                                    </div>
                                </div>
                            </div>	
                        </div>	

                        <div class="data-visual">
                            <div class="data-visual-header clearfix">
                                <ul>
                                    <li class="current"><a href="#" title="Metrics">Metrics</a></li>	
                                    <li><a href="#" title="Time series">Time series</a></li>	
                                    <li><a href="#" title="Network">Network</a></li>	
                                </ul>

                                <button type="button" title="Expand focus areas">Expand</button>
                            </div>

                            <div class="visual-choose-graph">
                                <div class="visual-choose">
                                        <div class="visual-metrics-menu">
                                            <div>
                                                <div class="visual-metric-choose">
                                                    <span>Choose a metric</span>	
                                                    <%
                                                        Initiative initiative =  (Initiative) ObjectFactory.getInstance("org.icube.owen.initiative.Initiative");
                                                        Map <Integer,String> indivdualType =  initiative.getInitiativeTypeMap(comid,"Individual");
                                                        Map <Integer,String> teamType =  initiative.getInitiativeTypeMap(comid,"Team");
                                                        JSONObject indTypeJSON = new JSONObject(indivdualType);
                                                        JSONObject teamTypeJSON = new JSONObject(teamType);
                                                       
                                                    %>
                                                    <script>
                                                        var indTypeJSON = <%=indTypeJSON%>;
                                                        var teamTypeJSON = <%=teamTypeJSON%>;
                                                    </script>
                                                    <div>
                                                        <% for (Map.Entry<Integer, String> teamEntry : teamType.entrySet()) { %>
                                                        <div>					
                                                            <input type="checkbox" name="explore-metric" value="<%=teamEntry.getKey() %>" id="explore-<%=teamEntry.getKey() %>" checked required oninvalid="setCustomValidity('Please choose atleast one metric.')" onchange="setCustomValidity('')" data-errormessage='Please choose atleast one metric.'>
                                                            <label for="explore-<%=teamEntry.getKey() %>"><%=teamEntry.getValue() %></label>	
                                                        </div>	
                                                        <% } %>
                                                    </div>
                                                </div>
                                                <div class="visual-graph-choose">
                                                    <span>Choose a visualization</span>	
                                                    <select id="explore-graph" name="explore-graph">
                                                        <option value="Area">Area</option>
                                                        <option value="Bar" selected="selected">Bar</option>
                                                        <option value="Line">Line</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div>
                                                <button type="button" id="clear-metric">Clear All</button>
                                            </div>	
                                        </div>
                                        <div class="visual-time-menu">
                                            <div>
                                                <div class="visual-metric-choose">
                                                    <span>Choose a metric</span>	
                                                    <div>
                                                         <% for (Map.Entry<Integer, String> teamEntry : teamType.entrySet()) { %>
                                                        <div>					
                                                            <input type="radio" name="explore-metric" value="<%=teamEntry.getKey() %>" id="<%=teamEntry.getKey() %>" <%=teamEntry.getKey() == 6 ?"checked" :""%>>
                                                            <label for="<%=teamEntry.getKey() %>"><%=teamEntry.getValue() %></label> 
                                                        </div>	
                                                        <% } %>
                                                    </div>
                                                </div>
                                                <div class="visual-graph-choose">
                                                    <span>Choose a visualization</span>	
                                                    <select id="explore-graph" name="explore-graph">
                                                        <option value="Area">Area</option>
                                                        <option value="Bar" selected="selected">Bar</option>
                                                        <option value="Line">Line</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div>
                                                <!--  <button type="button" id="clear-time">Clear All</button> -->
                                            </div>	
                                        </div>

                                        <div class="visual-network-menu">
                                            <div>
                                                <div class="visual-metric-choose">
                                                    <span>Type of relationship</span>
                                                    <%
                                                        ExploreHelper eHelperObj = (ExploreHelper) ObjectFactory.getInstance("org.icube.owen.explore.ExploreHelper");
                                                        Map<Integer,String> relMap = eHelperObj.getRelationshipTypeMap(comid);
                                                    %>
                                                    <div>
                                                        <% for (Map.Entry<Integer, String> entry : relMap.entrySet()) { %>
                                                        <div>					
                                                            <input type="checkbox" class="network-metric-check" name="explore-performance" value="<%=entry.getKey()%>" id="network-metric<%=entry.getKey()%>" required oninvalid="setCustomValidity('Please choose atleast one relationship.')" onchange="setCustomValidity('')" data-errormessage='Please choose atleast one relationship.'>
                                                            <label for="network-metric<%=entry.getKey()%>"><%=entry.getValue()%></label>	
                                                        </div>	
                                                        <% } %>
                                                    </div>
                                                </div>
                                                <div class="visual-graph-choose">
                                                    <span>Group by</span>	
                                                    <select id="cluster-graph" name="cluster-graph">
                                                        <option value="Team">Team</option>
                                                        <option value="Geography">Geography</option>
                                                        <option value="Function">Function</option>
                                                        <option value="Level">Level</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div>
                                                <button type="button" id="clear-network">Select All</button>
                                            </div>	
                                        </div>         

                                    <button type="submit" id="find-visuals" onClick="getGraph(event)">Go</button>
                                </div>

                                <div class="visual-graph-container">
                                    <div class="visual-graph-warning">
                                        <span>i</span>
                                        <span class="warning-text"></span>
                                    </div>
                                    <div id="visual-graph">								
                                    </div>
                                </div>

                                <div class="visual-actions">
                                    <button type="button" id="visual-create" title="Create an initiative">+</button>
                                    <div>
                                        <button type="button" id="visual-export"><img src="<%=Constant.WEB_ASSETS%>images/export_icon.png" width="21" title="Export As"></button>
                                        <div class="action-export-menu">
                                            <span>Export as</span>
                                            <ul>
                                                <li><a href="#">Image</a></li>
                                            </ul>
                                        </div>	
                                    </div>	
                                </div>
                            </div>

                        </div>
                    </form>               
				</div>
			</div>
		</div>
	</div>
	<script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
    <script src="<%=Constant.WEB_ASSETS%>js/jquery-ui.js"></script>
    
	<script src="<%=Constant.WEB_ASSETS%>js/amcharts/amcharts.js"></script>
	<script src="<%=Constant.WEB_ASSETS%>js/amcharts/serial.js"></script>
	<script src="<%=Constant.WEB_ASSETS%>js/amcharts/themes/light.js"></script>
	<script src="<%=Constant.WEB_ASSETS%>js/amcharts/plugins/export/export.js"></script>
    
    <!-- Webshim script to enable HTML5 form validation in Safari --> 
    <script>
        (function() {
          var loadScript = function(src, loadCallback) {
            var s = document.createElement('script');
            s.type = 'text/javascript';
            s.src = src;
            s.onload = loadCallback;
            document.body.appendChild(s);
          };
          var isSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;

          if (isSafari) {
            loadScript('<%=Constant.WEB_ASSETS%>js/js-webshim/minified/polyfiller.js', function () {
                webshims.setOptions('forms', {
                  overrideMessages: true,
                  replaceValidationUI: false
                });
                webshims.setOptions({
                  waitReady: true
                });
                webshims.polyfill();
            });
          }
        })();
    </script>
    
	<script>
        var callAjax = true;
        
        function selectEmployee(obj) {
            var personName = $(obj).text();
            var pId = $('#suggestion-box').val();
            $('#fiveSingleName').val('');
            $('#suggestion-box').hide();

            $('.single-name-list').append(
              '<div class="single-name-bubble">'+
              '<span data-id="' + pId + '">' + personName + '</span><button type="button">x</button>'+
              '</div>'
            );
            callAjax = true;

            var takenSpace = $('.single-name-list').width() + 26;
            $('#fiveSingleName').css('padding-left', takenSpace);
            var leftSpace = $('.single-name-list').width() + 30;
            $('#suggestion-box').css('left', leftSpace);
    
            $('.single-name-bubble button').on('click', function() {
                var lessTakenSpace = $('.single-name-list').width() + 26 - $(this).parent().outerWidth(true);
                var lessLeftSpace = lessTakenSpace + 4;
                $(this).parent('div').remove();
                $('.initiative-choice-single input').css('padding-left', lessTakenSpace);                
                $('#suggestion-box').css('left', lessLeftSpace);
                callAjax = true;
            });
        }
        
        $(document).ready(function() {
            // Remove end individual from input on Backspace
            $('#fiveSingleName').on('keydown', function(e) {
                if(e.which === 8 && !($('#fiveSingleName').val().length)) {
                    $('.single-name-bubble:last').find('button').trigger('click');                    
                }
            });
            
            $('#fiveSingleName').on('keyup', function(e) {
                $.ajax({
                    type: 'POST',
                    url: '<%=Constant.WEB_CONTEXT%>/initiative/searchIndividual.jsp',
                    data: 'keywords='+$(this).val(),
                    success: function(data){
                        $('#suggestion-box').show().html(data);

                        //Collect data-ids of individuals selected and overall employees
                        var personList = [];
                        $('.single-name-bubble span').each(function() {
                            personList.push($(this).attr('data-id'));
                        });
                        var empList = [];
                        $('#suggestion-box option').each(function() {
                            empList.push($(this).val());
                        });
                        // Remove individuals previously selected
                        for(var e=0; e<empList.length; e++) {
                            for(var p=0; p<personList.length; p++) {
                                if(personList[p] === empList[e]) {
                                    $('#suggestion-box option[value="'+empList[e]+'"]').remove();
                                }
                            }
                        }

                        if(data==='') {
                            $('#suggestion-box').hide();
                        }

                        $('#fiveSingleName').on('keyup' ,function(e){
                            if(e.which === 40) {
                                $('#suggestion-box').focus();
                            }
                        });
                    }
                });
            });
            
            $('#suggestion-box').on('keypress', function(e){
                if(e.which === 13) {
                    e.preventDefault();
                    if($(this).val()) {
                        selectEmployee($(this).find('option:selected'));
                    }
                }
            }); 

            $('#suggestion-box').on('click', function(e){
                if($(this).val()) {
                    selectEmployee($(this).find('option:selected'));
                }
            }); 
        });
        
        
        var arr_no_data = new Array();
        var graphArray;
        var oldArr, newArr;
        var teamColor, teamNode, teamEdge,teamImage;
        function getGraph(event) {
            var graphType = 'metrics';
            var tab = $('.data-visual-header li.current').index();
            if(tab === 0) {
                graphType = 'metrics'; 
            } else if(tab === 1) {
                graphType = 'time';
            } else if(tab === 2) {
                graphType = 'network';
            }
            
            var type;
            if($('.initiative-category input:checked').val() === 'team') {
                type = 1;
            } else if($('.initiative-category input:checked').val() === 'individual') {
                type = 0;
            }
            
            // If no individuals are selected, throw error 
            if(type===0 && !($('.single-name-bubble').length)) {
                $('#fiveSingleName')[0].setCustomValidity('Please fill in this field.');
                return 0;
            } else if(type===0 && ($('.single-name-bubble').length)) {
                $('#fiveSingleName')[0].setCustomValidity('');
            }
            
            //If second team is empty
            if(type===1 && $('.team-item').length === 2) {
                var secondEmpty = true;
                $('.team-item:eq(1)').find('.team-three-filters span').each(function() {
                    if(!$(this).is(':empty')) {
                        secondEmpty = false;
                    }
                });
                if(secondEmpty) {
                     $('.team-item:eq(1)').find('.team-name button').trigger('click');
                }
            }
            
            // If no teams are selected, throw error 
            if(type===1) {
                var empty = false;
                $('.initiative-choice-select').each(function() {
                    target = $(this).find('select')[0];
                    if($(this).find('select:enabled').val() === null) {
                        empty = true;
                    } 
                });
                
                if(empty) {
                    return 0;
                }
            }
            
            // If no metric type chosen in metrics tab, throw error
            var reqMetric = $('.visual-metrics-menu :checkbox[required]');
            reqMetric.change(function(){
                if(reqMetric.is(':checked')) {
                    reqMetric.removeAttr('required');
                } else {
                    reqMetric.attr('required', 'required');
                }
            });            
            if(graphType === 'metrics') {
                if($('.visual-metrics-menu .visual-metric-choose input:checked').length === 0) {
                    return 0;
                }
            } 
            
            // If no relationship type chosen in Network tab, throw error
            var reqNetwork = $('.visual-network-menu :checkbox[required]');
            reqNetwork.change(function(){
                if(reqNetwork.is(':checked')) {
                    reqNetwork.removeAttr('required');
                } else {
                    reqNetwork.attr('required', 'required');
                }
            });    
            if(graphType === 'network') {
                if($('.visual-network-menu .visual-metric-choose input:checked').length === 0) {
                    return 0;
                }
            }
                        
            $('.visual-graph-warning').hide();
            
            var postStr = $('#metrics-graph').serialize();
            var noOfTeams = $('.add-team-list').children().length,
            noOfIndividuals = $('.single-name-list').children().length;
            if(type === 1) {
                for(var i=0; i<noOfTeams; i++) {
                    var team = "";
                    for(j=0; j<3; j++) {
                        var tid = $('.team-item:eq('+i+') .team-three-filters span:eq('+j+')').attr('data-id');
                        var tText = $('.team-item:eq('+i+') .team-three-filters span:eq('+j+')').text();
                        team += tid+"#"+tText+"|";
                    }
                    postStr += "&team="+team;
                }
            } else if(type === 0) {
                for(var i=0; i<noOfIndividuals; i++) {
                    var empId = $('.single-name-bubble:eq('+i+') span').attr('data-id');
                    postStr += "&emp=" + empId;
                }
            }             
            if(graphType === 'network') {
                $('.network-metric-check:checked').each(function(index, el) {
                    postStr += "&relMap=" + $(el).val();
                });
            }            
            postStr +="&gtype="+graphType+"&type="+type;
            
            // Find set of teams added through their data-ids
            function getTeam() {
                var a = [];
                $('.add-team-list .team-item').each(function(index, el) {
                    var x = [];
                    for(var n=0; n<3; n++) {
                        x.push($(el).find('.team-three-filters div:eq('+n+') span').attr('data-id'));
                    }
                    a.push(x);
                });
                return a;
            }   
            newArr = getTeam();   
            
            // Checks if team selection on current Go and previous Go are same. If not, make ajax call.
            function equalArray(a, b) {
                return JSON.stringify(a) === JSON.stringify(b);
            }            
            if(!equalArray(newArr, oldArr)) {
                callAjax = true;
            } 
            
            if(callAjax) {
                event.preventDefault();
                $('.overlay_form').show();
                oldArr = getTeam();
                $.ajax({
                    url: '<%=Constant.WEB_CONTEXT%>/explore/getmetrics.jsp',
                    type: 'POST',
                    data: postStr,
                    error: function() {
                        $('#info').html('<p>An error has occurred</p>');
                    },
                    dataType: 'json',
                    success: function(resp) {
                        $('.overlay_form').hide();
                        if(graphType === 'network') {
                            if(type === 1) {
                                teamColor = resp.teamcolor;
                                teamImage = resp.teamImage;
                            }
                            teamNode = resp.node;
                            teamEdge = resp.edge;
                            draw(resp.edge, resp.node);
                        } else {
                            graphArray = resp.graph;
                            callAjax = false;
                            displayGraph();
                        }
                    }
                }); 
            } else {
                event.preventDefault();
                displayGraph();
            }
        }
        
        function displayGraph() {
            var metricsChosen = [];
            var dataProvider = [];
            var graphProvider = [];
            var inittype;
            if($('.initiative-category input:checked').val() === 'team') {
                inittype = 1;
            } else if($('.initiative-category input:checked').val() === 'individual') {
                inittype = 0;
            }  
            var tab = $('.data-visual-header li.current').index();
            var type = $('#explore-graph').val();
            if(tab === 0) {
                $('.visual-metrics-menu .visual-metric-choose>div input:checked').each(function(i, el) {
                    metricsChosen.push($(el).next().text());
                });
                
                arr_no_data = new Array();
                for(j=0; j<graphArray.length; j++) {
                    var arr = new Array();
                    if(graphArray[j]['data'] !== 'NO_DATA') {
                        if(Object.keys(graphArray[j]['data']).length > 0) {
                            arr['id'] = "AmGraph-"+j;
                            arr['title'] = graphArray[j]['title'];
                            arr['valueField'] = graphArray[j]['valueField'];
                            arr['balloonText'] = "[[title]]  [[category]]:[[value]]";
                            if(tab === 0 && type==='Bar') {
                                arr['type'] ="column";
                                arr['fillAlphas'] = 1;
                            }
                            else if(tab === 0 && type==='Area') {
                                 arr['lineAlpha'] = 1;
                                 arr['fillAlphas'] = 0.7;
                            } else if(tab === 0 && type==='Line') {
                                 arr['bullet'] = "round";
                            } 

                            graphProvider.push(arr);
                        }
                    } else {
                        arr_no_data.push(graphArray[j]['name']);
                    }
                }
                
                // Show error if team size is too small
                if(arr_no_data.length > 0 && inittype == 1) {
                    arr_no_data.sort();
                    var errorStr = '<span class="bold">Warning:</span> Team ';
                    if(arr_no_data.length === 1) {
                        errorStr+='<span class="bold">'+arr_no_data[0]+'</span> size too small.';
                    } else if(arr_no_data.length === 2) {
                        errorStr+='<span class="bold">'+arr_no_data[0]+'</span> and <span class="bold">'+arr_no_data[1]+'</span> size too small.';
                    } else {
                        for(i=0; i< arr_no_data.length-1; i++) {
                            errorStr+='<span class="bold">'+arr_no_data[i]+'</span>, ';
                        }
                        errorStr+='and <span class="bold">'+arr_no_data[arr_no_data.length-1]+'</span> size too small.';
                    }
                    $('.warning-text').empty().append(errorStr).parent().show();
                }
                
                for(i=0; i< metricsChosen.length; i++) {
                    var obj = {};
                    obj['category'] = metricsChosen[i];
                    for(j=0; j<graphArray.length; j++) {
                        for(key in graphArray[j]['data']){
                            if(key == metricsChosen[i] ) {
                                obj[graphArray[j]['valueField']] = graphArray[j]['data'][key];
                            }
                        }
                    }
                    dataProvider.push(obj);
                }
                
                var dataFlag = false;
                for(var i=0; i<dataProvider.length; i++) {
                    var keys = Object.keys(dataProvider[i]);
                    for(var j=1; j<keys.length; j++) {
                        if(dataProvider[i][keys[j]] !== 0) {
                            dataFlag = true;
                            break;
                        }
                    }
                }                
                if(($.isEmptyObject(dataProvider)) || !dataFlag) {
                    var text = '<div class="empty-chart">'+
                        '<span>You must be new in here.</span>'+
                        '<span>Charts will appear as soon as employees start answering surveys.</span>'+
                        '</div>';
                    $('#visual-graph').html(text);
                    return 0;
                }
                
                if(tab === 0 && type==='Bar') {
                    getBarGraph("visual-graph", graphProvider, dataProvider);
                } else if(tab === 0 && type==='Area') { 
                    getAreaGraph("visual-graph", graphProvider, dataProvider);
                } else if(tab === 0 && type==='Line') { 
                    getLineGraph("visual-graph", graphProvider, dataProvider);
                }
            } else if(tab === 1) {
                $('.visual-time-menu .visual-metric-choose>div input:checked').each(function(i, el) {
                    metricsChosen.push($(el).next().text());
                });
                
                for(i=0; i< metricsChosen.length; i++){
                    for(j=0; j<graphArray.length; j++) {
                        if(graphArray[j]['data-avail'] === 'DATA') {
                            if(metricsChosen[i] ===  graphArray[j]['type']) {
                                var arr = new Array();
                                arr['balloonText'] = graphArray[j]['valueField']+": [[value]]";
                                arr['lineColor'] = graphArray[j]['lineColor'];
                                arr['bullet'] = graphArray[j]['bullet'];
                                arr['id'] = "AmGraph-"+j;
                                arr['title'] = graphArray[j]['title'];
                                arr['valueField'] = graphArray[j]['valueField'];
                                graphProvider.push(arr);
                            }
                        }
                        
                    }
                }
                
                var dataArry  = new Array();
                arr_no_data = new Array();
                for(j=0; j<graphArray.length; j++) {
                    if(graphArray[j]['data-avail'] === 'DATA') {
                        for(i=0; i< metricsChosen.length; i++){
                            if(metricsChosen[i] ===  graphArray[j]['type']) {
                                for(key in graphArray[j]['data']){
                                    var date = key;
                                    if(dataArry[date] !== undefined) {
                                        arr = dataArry[date];
                                        arr[graphArray[j]['valueField']] = graphArray[j]['data'][date];
                                        dataArry[date] = arr;
                                    } else {
                                        var arr = new Array();
                                        arr[graphArray[j]['valueField']] = graphArray[j]['data'][date];
                                        dataArry[date] = arr;
                                    } 
                                }
                            }
                        }   
                    }
                    else {
                        arr_no_data.push(graphArray[j]['name']);
                   }
                }
                
                // Show error if team size is too small
                if(arr_no_data.length > 0  && inittype == 1) {
                    arr_no_data = sortUnique(arr_no_data);
                    var errorStr = '<span class="bold">Warning:</span> Team ';
                    if(arr_no_data.length === 1) {
                        errorStr+='<span class="bold">'+arr_no_data[0]+'</span> size too small.';
                    } else if(arr_no_data.length === 2) {
                        errorStr+='<span class="bold">'+arr_no_data[0]+'</span> and <span class="bold">'+arr_no_data[1]+'</span> size too small.';
                    } else {
                        for(i=0; i< arr_no_data.length-1; i++) {
                            errorStr+='<span class="bold">'+arr_no_data[i]+'</span>, ';
                        }
                        errorStr+='and <span class="bold">'+arr_no_data[arr_no_data.length-1]+'</span> size too small.';
                    }
                    $('.warning-text').empty().append(errorStr).parent().show();
                }
                
                var sortDataArray = Array();
                keys = Object.keys(dataArry), i, len = keys.length;
                keys.sort();
                for (i = 0; i < len; i++) {
                  k = keys[i];
                  sortDataArray[k] = dataArry[k];
                }
                for(key in sortDataArray) {
                    var obj = {};
                    obj['date'] = key;
                    for(key1 in sortDataArray[key]) {
                           obj[key1] = sortDataArray[key][key1];
                    }
                    dataProvider.push(obj);
                }
                
                var dataFlag2 = false;
                for(var i=0; i<dataProvider.length; i++) {
                    var keys2 = Object.keys(dataProvider[i]);
                    if(dataProvider[i][keys2[1]] !== 0) {
                        dataFlag2 = true;
                        break;
                    }
                }
                
                if(jQuery.isEmptyObject(dataProvider) || !(dataFlag2)) {
                    var text = '<div class="empty-chart">'+
                        '<span>You must be new in here.</span>'+
                        '<span>Charts will appear as soon as employees start answering surveys.</span>'+
                        '</div>';
                    $('#visual-graph').html(text);
                    return 0;
                }
 
                getTimeSeriesGraphExplore("visual-graph", graphProvider, dataProvider);
            }
        }
	</script>
    
    <script src="<%=Constant.WEB_ASSETS%>js/vis.min.js"></script>
    <script>
        var network;
        var allNodes, allEdges;
        var highlightActive = false;
        
		function draw(edgeSet, NodeSet) { 
            if(jQuery.isEmptyObject(NodeSet)) {
                var text = '<div class="empty-chart">'+
                    '<span>Oops. Looks like there is no one here.</span>'+
                    '</div>';
                $('#visual-graph').html(text);
                return 0;
            }
            
            // create an array with nodes
            var nodes = new vis.DataSet(NodeSet);
            // create an array with edges
            var edges = new vis.DataSet(edgeSet);

            var container = document.getElementById('visual-graph');
            var data = {
              nodes: nodes,
              edges: edges
            };
            var options = {
                nodes: {
                    shape: 'dot',
                    scaling: {
                        customScalingFunction: function (min, max, total, value) {
                          return value/total;
                        },
                        min:5,
                        max:150
                    }
                },
                interaction: {hover:true},
                layout: {
                    randomSeed:8,
                    improvedLayout:false
                },
                physics: {maxVelocity: 5}
            }; 
            
            network = new vis.Network(container, data, options);
            
            // get a JSON object
            allNodes = nodes.get({returnType:"Object"});
            allEdges = edges.get({returnType:"Object"}); 
            
            network.on("click", neighbourhoodHighlight);            
            function neighbourhoodHighlight(params) {
                // if something is selected:
                if (params.nodes.length > 0) {
                    highlightActive = true;
                    var i,j;
                    var selectedNode = params.nodes[0];
                    var degrees = 2;

                    // mark all nodes as hard to read.
                    for (var nodeId in allNodes) {                      
                      allNodes[nodeId].color = 'rgba(200,200,200,0.5)';
                      if (allNodes[nodeId].hiddenLabel === undefined) {
                        allNodes[nodeId].hiddenLabel = allNodes[nodeId].label;
                        allNodes[nodeId].label = undefined;
                      }
                    }
                    for(var e in allEdges) {                        
                        allEdges[e].color = 'rgba(200,200,200,0.5)';                        
                    }
                    
                    var connectedNodes = network.getConnectedNodes(selectedNode);
                    var allConnectedNodes = [];

                    // get the second degree nodes
                    for (i=1; i<degrees; i++) {
                      for (j=0; j<connectedNodes.length; j++) {
                        allConnectedNodes = allConnectedNodes.concat(network.getConnectedNodes(connectedNodes[j]));
                      }
                    }
                    // all second degree nodes get a different color and their label back
                    for (i = 0; i < allConnectedNodes.length; i++) {
                        allNodes[allConnectedNodes[i]].color = 'rgba(150,150,150,0.75)';
                        if (allNodes[allConnectedNodes[i]].hiddenLabel !== undefined) {
                          allNodes[allConnectedNodes[i]].label = allNodes[allConnectedNodes[i]].hiddenLabel;
                          allNodes[allConnectedNodes[i]].hiddenLabel = undefined;
                        }
                        for(var e in allEdges) {
                            if(allEdges[e].from === allConnectedNodes[i]) {
                                allEdges[e].color = 'rgba(150,150,150,0.75)';
                            }
                        }
                    }

                    // all first degree nodes get their own color and their label back
                    for (i = 0; i < connectedNodes.length; i++) {
                        allNodes[connectedNodes[i]].color = allNodes[connectedNodes[i]].oldColor;
                        if (allNodes[connectedNodes[i]].hiddenLabel !== undefined) {
                          allNodes[connectedNodes[i]].label = allNodes[connectedNodes[i]].hiddenLabel;
                          allNodes[connectedNodes[i]].hiddenLabel = undefined;
                        }
                        for(var e in allEdges) {
                            if(allEdges[e].from === allConnectedNodes[i]) {
                                allEdges[e].color = 'rgba(150,150,150,0.75)';
                            }
                        }
                    }

                    // the main node gets its own color and its label back.
                    allNodes[selectedNode].color = allNodes[selectedNode].oldColor;
                    if(allNodes[selectedNode].hiddenLabel !== undefined) {
                      allNodes[selectedNode].label = allNodes[selectedNode].hiddenLabel;
                      allNodes[selectedNode].hiddenLabel = undefined;
                    }
                    for(var e in allEdges) {
                        if(allEdges[e].from == selectedNode || allEdges[e].to == selectedNode) {
                            allEdges[e].color = allEdges[e].oldColor;
                        }
                    }
                }
                else if (highlightActive === true) {
                  // reset all nodes
                  for (var nodeId in allNodes) {
                    allNodes[nodeId].color = allNodes[nodeId].oldColor;
                    if (allNodes[nodeId].hiddenLabel !== undefined) {
                      allNodes[nodeId].label = allNodes[nodeId].hiddenLabel;
                      allNodes[nodeId].hiddenLabel = undefined;
                    }
                  }
                  for(var e in allEdges) {
                    allEdges[e].color = allEdges[e].oldColor;
                  }
                  highlightActive = false;
                }

                // transform the object into an array
                var updateArray = [];
                for (nodeId in allNodes) {
                  if (allNodes.hasOwnProperty(nodeId)) {
                    updateArray.push(allNodes[nodeId]);
                  }
                }
                nodes.update(updateArray);
                            
                var updateArray2 = [];
                for (e in allEdges) {
                  if (allEdges.hasOwnProperty(e)) {
                      updateArray2.push(allEdges[e]);
                  }
                }
                edges.update(updateArray2);
            }
            
            network.on("selectNode", function(params) {
                if (params.nodes.length == 1) {
                    if (network.isCluster(params.nodes[0]) == true) {
                      network.openCluster(params.nodes[0]);
                    }
                }
            });

            function clusterByGeo() {
                network.setData(data);
                var geography = [
                    <% for (Map.Entry<Integer, String> entry : geoitem.entrySet()) { %>
                        '<%=entry.getValue()%>',
                    <% } %>
                ];
                var clusterOptionsByData;

                for (var i = 0; i < geography.length; i++) {
                    var geo = geography[i];
                    clusterOptionsByData = {
                        joinCondition: function (childOptions) {
                          return childOptions.geography == geo; 
                        },
                        processProperties: function (clusterOptions, childNodes, childEdges) {
                            var totalMass = 0;
                            var totalValue = 0;
                            for (var i = 0; i < childNodes.length; i++) {
                                totalMass += childNodes[i].mass;
                                totalValue = childNodes[i].value
                                            ? totalValue + childNodes[i].value
                                            : totalValue;
                            }
                            clusterOptions.mass = totalMass;
                            if (totalValue > 0) {
                                clusterOptions.value = totalValue;
                            }
                            return clusterOptions;
                        },
                        clusterNodeProperties: {
                            id: 'cluster:'+geo, 
                            borderWidth: 3, 
                            label:'Geography: '+geo,
                            shape: 'circularImage',
                            image: '<%=Constant.WEB_ASSETS%>images/network-cluster.png'
                        }
                    };
                    network.cluster(clusterOptionsByData);
                }
            }

            function clusterByFunction() {
                network.setData(data);
                var functions = [
                    <% for (Map.Entry<Integer, String> entry : funitem.entrySet()) { %>
                        '<%=entry.getValue()%>',
                    <% } %>
                ];
                var clusterOptionsByData;

                for (var i = 0; i < functions.length; i++) {
                    var func = functions[i];
                    clusterOptionsByData = {
                        joinCondition: function (childOptions) {
                          return childOptions.function === func; 
                        },
                        processProperties: function (clusterOptions, childNodes, childEdges) {
                            var totalMass = 0;
                            var totalValue = 0;
                            for (var i = 0; i < childNodes.length; i++) {
                                totalMass += childNodes[i].mass;
                                totalValue = childNodes[i].value
                                            ? totalValue + childNodes[i].value
                                            : totalValue;
                            }
                            clusterOptions.mass = totalMass;
                            if (totalValue > 0) {
                                clusterOptions.value = totalValue;
                            }
                            return clusterOptions;
                        },
                        clusterNodeProperties: {
                            id: 'cluster:'+func, 
                            borderWidth: 3, 
                            label:'Function: '+func,
                            shape: 'circularImage',
                            image: '<%=Constant.WEB_ASSETS%>images/network-cluster.png'
                        }
                    };
                    network.cluster(clusterOptionsByData);
                }
            }

            function clusterByLevel() {
                network.setData(data);
                var levels = [
                    <% for (Map.Entry<Integer, String> entry : levelitem.entrySet()) { %>
                        '<%=entry.getValue()%>',
                    <% } %>
                ];
                var clusterOptionsByData;

                for (var i = 0; i < levels.length; i++) {
                    var level = levels[i];
                    clusterOptionsByData = {
                        joinCondition: function (childOptions) {
                          return childOptions.level === level; 
                        },
                        processProperties: function (clusterOptions, childNodes, childEdges) {
                            var totalMass = 0;
                            var totalValue = 0;
                            for (var i = 0; i < childNodes.length; i++) {
                                totalMass += childNodes[i].mass;
                                totalValue = childNodes[i].value
                                            ? totalValue + childNodes[i].value
                                            : totalValue;
                            }
                            clusterOptions.mass = totalMass;
                            if (totalValue > 0) {
                                clusterOptions.value = totalValue;
                            }
                            return clusterOptions;
                        },
                        clusterNodeProperties: {
                            id: 'cluster:'+level, 
                            borderWidth: 3, 
                            label:'Level: '+level,
                            shape: 'circularImage',
                            image: '<%=Constant.WEB_ASSETS%>images/network-cluster.png'
                        }
                    };
                    network.cluster(clusterOptionsByData);
                }
            }

            function clusterByTeam() {
                network.setData(data);
                var teams = [];
                var colors = [];
                var images = [];

                $.each(teamColor, function(key, value ) {
                    teams.push(key);
                    colors.push(value);
                });
                $.each(teamImage, function(key, value ) {
                    images.push(value);
                });
                
                var clusterOptionsByData;
                for (var i = 0; i < teams.length; i++) {
                    var team = teams[i];
                    var color = colors[i];
                    var image = images[i];
                    clusterOptionsByData = {
                        joinCondition: function (childOptions) {
                            return childOptions.team == team; 
                        },
                        processProperties: function (clusterOptions, childNodes, childEdges) {
                            var totalMass = 0;
                            var totalValue = 0;
                            for (var i = 0; i < childNodes.length; i++) {
                                totalMass += childNodes[i].mass;
                                totalValue = childNodes[i].value
                                            ? totalValue + childNodes[i].value
                                            : totalValue;
                            }
                            clusterOptions.mass = totalMass;
                            if (totalValue > 0) {
                                clusterOptions.value = totalValue;
                            }
                            return clusterOptions;
                        },
                        clusterNodeProperties: {
                            id: 'cluster:'+team, 
                            borderWidth: 3, 
                            color: color,
                            label: team,
                            shape: 'circularImage',
                            image: image
                        }
                    };
                    network.cluster(clusterOptionsByData);
                }
            }
            
            if($('.visual-network-menu #cluster-graph').val() === 'Geography') {
                clusterByGeo();
            }
            else if($('.visual-network-menu #cluster-graph').val() === 'Function') {
                clusterByFunction();
            }
            else if($('.visual-network-menu #cluster-graph').val() === 'Level') {
                clusterByLevel();
            }
            else if($('.visual-network-menu #cluster-graph').val() === 'Team') {
                clusterByTeam();
            }
        } 
                 
        $('#cluster-graph').on('change', function() {
            draw(teamEdge, teamNode);           
        });
    
        //To create an initiative, with selected teams or individual
        $('#visual-create').on('click', function() {
            var form = document.createElement("form");
            form.setAttribute("method", "post");
            var type;
            if($('.initiative-category input:checked').val() === 'team') {
                type = 1;
            } else if($('.initiative-category input:checked').val() === 'individual') {
                type = 0;
            }
            var noOfTeams = $('.add-team-list').children().length;
            
            
            var tab = $('.data-visual-header li.current').index();
            
            var selmatid = "";
            if(tab == 0) {
                selmatid = $('.visual-metrics-menu .visual-metric-choose input:checked:first').val();
            } else if(tab == 1) {
                selmatid = $('.visual-time-menu .visual-metric-choose input:checked:first').val();
            }
            if(type === 1) {
                for(var i=0; i<noOfTeams; i++) {
                    var team = "";
                    for(j=0; j<3; j++) {
                        var tid = $('.team-item:eq('+i+') .team-three-filters span:eq('+j+')').attr('data-id');
                        var tText = $('.team-item:eq('+i+') .team-three-filters span:eq('+j+')').text();
                        
                        if(!tid) {
                         $('#find-visuals').trigger('click');   
                            return;
                        }
                        team += tid+"#"+tText+"|";
                    }
                    var hiddenField = document.createElement("input");
                    hiddenField.setAttribute("type", "hidden");
                    hiddenField.setAttribute("name", 'team');
                    hiddenField.setAttribute("value", team);
                    form.appendChild(hiddenField);
                }
            } else if(type === 0) {
                var empId = $('.single-name-bubble:eq(0) span').attr('data-id');
                if(!empId) {
                    $('#find-visuals').trigger('click');   
                       return;
                }
                var hiddenField = document.createElement("input");
                hiddenField.setAttribute("type", "hidden");
                hiddenField.setAttribute("name", 'emp_id');
                hiddenField.setAttribute("value", empId);
                form.appendChild(hiddenField);
            }
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", 'c');
            hiddenField.setAttribute("value", type);
            form.appendChild(hiddenField);
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", 't');
            hiddenField.setAttribute("value", selmatid);
            form.appendChild(hiddenField);
            form.setAttribute("action", '<%=Constant.WEB_CONTEXT%>/initiative/create.jsp');
            document.body.appendChild(form);
            form.submit();
        });
	</script>        
    <script src="<%=Constant.WEB_ASSETS%>js/reimg.js"></script>   
    
	<script src="<%=Constant.WEB_ASSETS%>js/explore.js"></script>	
    
    <script> 
    <% if(intEmpid  != 0 ) { %>
        setTimeout(function() {
            $('#chooseIndividual').trigger('click');    
            
            var takenSpace = $('.single-name-list').width() + 26;
            $('#fiveSingleName').css('padding-left', takenSpace);
            var leftSpace = $('.single-name-list').width() + 30;
            $('#suggestion-box').css('left', leftSpace);
        }, 50);
        
        $('.single-name-bubble button').on('click', function() {
            var lessTakenSpace = $('.single-name-list').width() + 26 - $(this).parent().outerWidth(true);
            var lessLeftSpace = lessTakenSpace + 4;
            $(this).parent('div').remove();
            $('.initiative-choice-single input').css('padding-left', lessTakenSpace);                
            $('#suggestion-box').css('left', lessLeftSpace);
        });
    <% } 
    
    // Prepopulate select box and team bubble if redirected from Dashboard page
    if(alertid != null && !alertid.equals("")) {
        Alert alert = new Alert();
        alert = alert.get(comid,Util.getIntValue(alertid));
        List<Filter> alertFilter = alert.getFilterList();
        for(int i=0; i<alertFilter.size(); i++) {
           if(alertFilter.get(i).getFilterName().equals(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME)) {
               out.println("var geoId = "+alertFilter.get(i).getFilterValues().keySet().iterator().next()+";");
           } else if(alertFilter.get(i).getFilterName().equals(Constant.INITIATIVES_FUNCTION_FILTER_NAME)) {
                out.println("var funId = "+alertFilter.get(i).getFilterValues().keySet().iterator().next()+";");
           } else if(alertFilter.get(i).getFilterName().equals(Constant.INITIATIVES_LEVEL_FILTER_NAME)) {
                out.println("var levelId = "+alertFilter.get(i).getFilterValues().keySet().iterator().next()+";");
           }
        } %>
        $('#teamGeography').val(geoId);
        $('#teamFunction').val(funId);
        $('#teamLevel').val(levelId);
        $('.add-more-team button').removeAttr('disabled');

        $('.initiative-choice-select select').each(function() {
            var i = $(this).parent('div').index();
            var val = $(this).children('option:selected').text();
            var id = $(this).val();
            $('.team-item').find('.team-three-filters div:eq(' + i +')').children('span').text(val);
            $('.team-item').find('.team-three-filters div:eq(' + i +')').children('span').attr('data-id', id);
        });   
    <% } %>
    </script>
    
</body>
</html>