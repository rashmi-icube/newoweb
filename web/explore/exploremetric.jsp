<%-- 
    Document   : exploremetric
    Created on : 8 Aug, 2016, 4:07:15 PM
    Author     : adoshi
--%>
<%@page import="java.util.List"%>
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
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.icube.owen.initiative.InitiativeHelper"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.Util"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.icube.owen.metrics.MetricsList"%>
<%@page import="org.icube.owen.metrics.Metrics"%>
<%
    String moduleName = "explore";
    String subModuleName = "exploremetric";
    int intEmpid = 0;
    String rEmpid = request.getParameter("eid");
    if(rEmpid != null) {
        intEmpid = Util.getIntValue(rEmpid);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OWEN - Explore Metrics</title>
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
                    <input type="hidden" id="page_no" value="1">
                    <div class="explore-list-of-metrics">
                        <div class="explore-list-of-metrics-header clearfix">
                            <h2>Explore - Metrics</h2>
                            <div class="explore-list-of-metrics-category-selection">
                                <span>Individual</span>
                                <div class="filter-tool">
                                    <img src="/assets/images/filter_disc.png" alt="Toggle tool">
                                </div>
                                <span class="clicked">Team</span>
                            </div>
                        </div>
                        <%  Initiative initiative = (Initiative) ObjectFactory.getInstance("org.icube.owen.initiative.Initiative");
                            Map<Integer, String> indivdualType = initiative.getInitiativeTypeMap(comid, "individual");
                            Map<Integer, String> teamType = initiative.getInitiativeTypeMap(comid, "team");
                            JSONObject indTypeJSON = new JSONObject(indivdualType);
                            JSONObject teamTypeJSON = new JSONObject(teamType);
                            InitiativeHelper iHelper = new InitiativeHelper();
                            java.util.List<java.util.Map<java.lang.String, java.lang.Object>> iList = iHelper.getInitiativeCount(comid);
                            HashMap<Integer, HashMap<String, Integer>> hasmap = Util.getTypeList(iList, "Team");
                            int defaultMetricsId = 0;
                        %>
                        <ul class="switched">
                            <% for (Map.Entry<Integer, HashMap<String, Integer>> entry : hasmap.entrySet()) {
                                    HashMap<String, Integer> hmap = entry.getValue();

                            %>
                            <li>
                                <span><%=teamType.get(entry.getKey())%></span>
<!--                                <div class="chart" id="createStat" data-percent="100">
                                    <div class="chart-score">
                                        <span>100</span>
                                        <span class="up">▴</span>
                                    </div>
                                </div>-->
                        <%
                            String type = request.getParameter("teamtype");
                            int intType = 0;
                            try {
                                intType = Integer.parseInt(type);
                            } catch (Exception ex) {
                            }
                            List<Filter> fList = new ArrayList();
                            if (intType == Constant.INITIATIVES_TEAM) {
                                String[] teamGeography = request.getParameterValues("teamGeography");
                                String[] teamFunction = request.getParameterValues("teamFunction");
                                String[] teamLevel = request.getParameterValues("teamLevel");

                                String[] teamGeographyText = request.getParameterValues("teamGeographyText");
                                String[] teamFunctionText = request.getParameterValues("teamFunctionText");
                                String[] teamLevelText = request.getParameterValues("teamLevelText");
                                int filterFunId = Util.getIntValue(request.getParameter("filterFunId"));
                                int filterLevelId = Util.getIntValue(request.getParameter("filterLevelId"));
                                int filterGeoId = Util.getIntValue(request.getParameter("filterGeoId"));
                                Filter geographyFilter = new Filter();
                                geographyFilter.setFilterName(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                                geographyFilter.setFilterId(filterGeoId);
                                Map<Integer, String> gMap = new HashMap<Integer, String>();
                                for (int i = 0; i < teamGeography.length; i++) {
                                    gMap.put(Util.getIntValue(teamGeography[i]), teamGeographyText[i]);

                                }
                                Util.debugLog("gMap" + gMap);
                                geographyFilter.setFilterValues(gMap);

                                Filter functionFilter = new Filter();
                                functionFilter.setFilterName(Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                                functionFilter.setFilterId(filterFunId);
                                Map<Integer, String> fMap = new HashMap<Integer, String>();
                                for (int i = 0; i < teamFunction.length; i++) {
                                    fMap.put(Util.getIntValue(teamFunction[i]), teamFunctionText[i]);

                                }
                                functionFilter.setFilterValues(fMap);

                                Filter levelFilter = new Filter();
                                levelFilter.setFilterName(Constant.INITIATIVES_LEVEL_FILTER_NAME);
                                levelFilter.setFilterId(filterLevelId);
                                Map<Integer, String> lMap = new HashMap<Integer, String>();
                                for (int i = 0; i < teamLevel.length; i++) {
                                    lMap.put(Util.getIntValue(teamLevel[i]), teamLevelText[i]);

                                }
                                Util.debugLog("lMap" + lMap);
                                levelFilter.setFilterValues(lMap);
                                fList.add(geographyFilter);
                                fList.add(functionFilter);
                                fList.add(levelFilter);
                            }
                            String initiativeType = request.getParameter("initiativeType");
                            List<Metrics> metList = new ArrayList();
                            MetricsList mListObj = (MetricsList) ObjectFactory.getInstance("org.icube.owen.metrics.MetricsList");
                            if (intType == Constant.INITIATIVES_TEAM) {
                                metList = mListObj.getInitiativeMetricsForTeam(comid, Util.getIntValue(initiativeType), fList);
                            } else {
                                Employee emp = (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee");
                                List<Employee> list = new ArrayList();
                                int employeeId = Util.getIntValue(request.getParameter("empid"));
                                list.add(emp.get(comid, employeeId));
                                metList = mListObj.getInitiativeMetricsForIndividual(comid, Util.getIntValue(initiativeType), list);
                            }
                            for (int i = 0; i < metList.size(); i++) {%>
                                <div class="chart" id="createStat<%=(i + 1)%>" data-percent=<%=metList.get(i).getScore() > -1 ? metList.get(i).getScore() : 0%> >
                                    <div class="chart-score">
                                        <% if (metList.get(i).getScore() > -1) {%>
                                        <span><%=metList.get(i).getScore()%></span> 
                                        <% if (metList.get(i).getDirection().equalsIgnoreCase("positive")) { %>   
                                        <span class="up">&#x25B4;</span>
                                        <% } else if (metList.get(i).getDirection().equalsIgnoreCase("negative")) { %>
                                        <span class="down">&#x25BE;</span>
                                        <% } else { %>
                                        <span class="neutral">..</span>
                                        <% } %>
                                        <% } else { %>
                                        <span class="empty"  >
                                            Team size too small.
                                        </span>
                                        <% }%>
                                    </div>
                                </div>
                            <% } %>
                                <div class="current-completed clearfix">
                                    <button data-id="<%=entry.getKey()%>" class="panel-select-metric <%= defaultMetricsId == 0 ? "selected" : ""%>" title="Select <%=teamType.get(entry.getKey())%>">&#x2714;</button>
                                </div>
                            </li>
                            <% if (defaultMetricsId == 0) {
                                        defaultMetricsId = entry.getKey();
                                    }
                                } %> 
                        </ul>
                        <%  hasmap = Util.getTypeList(iList, "Individual"); %>
                        <ul>
                            <% int indMetricsId = 0;
                                for (Map.Entry<Integer, HashMap<String, Integer>> entry : hasmap.entrySet()) {
                                    HashMap<String, Integer> hmap = entry.getValue();%>
                            <li>
                                <span><%=indivdualType.get(entry.getKey())%></span>
                            </li>
                            <% if (indMetricsId == 0) {
                                        indMetricsId = entry.getKey();
                                    }
                                }%> 
                        </ul>
                    </div>
                        
                    <div class="tiSelection">
                        <div class="tiSelectionHeader">
                            <h3>Select category</h3>
                            <button id="tiSelectionResetButton">Reset</button>
                            <button id="tiSelectionExpandCollapseButton">Expand</button>
                        </div>
                        <div class="tiSelected">
                            <div class="tiSelectPeople">
                                <div class="tiSelect">
                                    <%  FilterList fl = new FilterList(); %>
                                    <div class="tiSelectTeams">
                                        <div class="tiSelectTeamsList">
                                            <span>1.</span>
                                            <label for="teamGeography">Select a geography</label>
                                            <select name="teamGeography" id="teamGeography" size="5" required oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                                <%
                                                    Filter filter = fl.getFilterValues(comid, Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                                                    Map<Integer, String> geoitem = filter.getFilterValues();
                                                    for (Map.Entry<Integer, String> entry : geoitem.entrySet()) {%>
                                                <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                <% }%>
                                            </select>
                                            <div class="select-overlay"></div>
                                        </div>
                                        <div class="tiSelectTeamsList">
                                            <span>2.</span>
                                            <label for="teamFunction">Select a function</label>
                                            <select name="teamFunction" id="teamFunction" size="5" required oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                                <%  filter = fl.getFilterValues(comid, Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                                                    Map<Integer, String> funitem = filter.getFilterValues();
                                                    for (Map.Entry<Integer, String> entry : funitem.entrySet()) {%>
                                                <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                <% }%>
                                            </select>
                                            <div class="select-overlay"></div>
                                        </div>
                                        <div class="tiSelectTeamsList">
                                            <span>3.</span>
                                            <label for="teamLevel">Select a level</label>
                                            <select name="teamLevel" id="teamLevel" size="5" required oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                                <%  filter = fl.getFilterValues(comid, Constant.INITIATIVES_LEVEL_FILTER_NAME);
                                                    Map<Integer, String> levelitem = filter.getFilterValues();
                                                    for (Map.Entry<Integer, String> entry : levelitem.entrySet()) {%>
                                                <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                <% }%>
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
                                    <div class="tiSelectIndividuals">
                                        <input type="search" id="fiveSingleName">
                                        <div class="tiSingleIndividualList">
                                        <% if(empObj != null) { %>
                                            <div class="tiSingleIndividualBubble">
                                                <span data-id="<%=intEmpid%>"><%=empObj.getFirstName()+" "+ (empObj.getLastName()!= null ? empObj.getLastName():"") %></span>
                                                <button type="button">x</button>
                                            </div>
                                        <% } %>
                                        </div>
                                    </div>
                                </div>
                                <div class="tiPeople">
                                    <div class="tiPeopleAddMoreTeams">
                                        <button type="button" title="Add one more team" disabled>+1</button>
                                        <div class="tiPeopleCompareTypePopup">
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
                                    <div class="tiPeopleAddTeamsList">
                                        <div class="tiPeopleTeamItem">
                                            <div class="tiPeopleTeamItemName">
                                                <span>Team 1</span>
                                                <button type="button">x</button>
                                            </div>
                                            <div class="tiPeopleTeamItemValues">
                                                <div><span></span></div>
                                                <div><span></span></div>
                                                <div><span></span></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                        
                    <div class="metrics-section" style="margin: 20px auto 20px;">
                        <div class="metrics-header">
                            <h3>Team Selection</h3>
                            <button type="button" style="float: none; font: 14px 'Open Sans Regular', 'Open Sans'; vertical-align: -2px; margin-left: 70px; color: white;" onmouseover="this.style.color='#169bd5'" onmouseout="this.style.color='#FFFFFF'">Reset</button>
                            <button type="button" id="collapse-metrics" onmouseover="this.style.color='#169bd5'" onmouseout="this.style.color='#1e1e1e'">Expand</button>
                        </div>
                        <div class="create-metrics-list" style="padding: 0;">
                            <div class="initiative-which-people" style="height: 180px;">
                                <div class="initiative-which">
                                <!--<div class="initiative-category">
                                    <input type="radio" value="individual" id="chooseIndividual" previousvalue="false">
                                    <label for="chooseIndividual" title="Select individual"><span>✔</span>Individual</label> 

                                    <input type="radio" value="team" id="chooseTeam" previousvalue="checked">
                                    <label for="chooseTeam" title="Select team"><span>✔</span>Team</label>
                                </div>-->
                                    <div class="initiative-choice-team">
                                        <div class="initiative-choice-select">
                                            <span>1.</span>
                                            <label for="teamGeography">Select a geography</label>
                                            <select name="teamGeography" id="teamGeography" size="5" required="" oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                                <option value="0">All</option>
                                                <option value="7">Domestic</option>
                                                <option value="8">International</option>
<!--                                                <option value="9">INTG2</option>
                                                <option value="10">INTG3</option>
                                                <option value="11">INTG4</option>
                                                <option value="12">INTG5</option>-->
                                            </select>
                                            <div class="select-overlay" style="display: none;"></div>
                                        </div>
                                        <div class="initiative-choice-select">
                                            <span>2.</span>
                                            <label for="teamFunction">Select a function</label>
                                            <select name="teamFunction" id="teamFunction" size="5" required="" oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                                <option value="0">All</option>
                                                <option value="1">Operations</option>
                                                <option value="2">Sales</option>
                                                <option value="3">Finance</option>
                                            </select>
                                            <div class="select-overlay" style="display: none;"></div>
                                        </div>
                                        <div class="initiative-choice-select">
                                            <span>3.</span>
                                            <label for="teamLevel">Select a level</label>
                                            <select name="teamLevel" id="teamLevel" size="5" required="" oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                                <option value="0">All</option>
                                                <option value="3">Manager</option>
                                                <option value="4">Associates</option>
<!--                                                <option value="5">State</option>
                                                <option value="6">Zone</option>      -->
                                            </select>
                                            <div class="select-overlay" style="display: none;"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="initiative-people" style="position: absolute;">
                                    <div class="add-more-team">
                                        <button type="button" title="Add one more team">+1</button>
                                        <div class="compare-type-popup" style="top: 0px; display: none;">
                                            <span>Compare by</span>
                                            <div>
                                                <input type="radio" id="team-geography">
                                                <label for="team-geography">Geography</label>
                                            </div>	
                                            <div>										
                                                <input type="radio" id="team-function">
                                                <label for="team-function">Function</label>
                                            </div>
                                            <div>
                                                <input type="radio" id="team-level">
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
                            <div class="initiative-submit-button" style="margin-left: 83%; padding-bottom: 2%;">
                                <button type="submit" title="Compare teams" id="find-visuals" style="margin-top: 0px; width: 100px; height: 35px;">Compare</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="<%=Constant.WEB_ASSETS%>js/easypiechart.js"></script>
        <script>
            $('#createStat').easyPieChart({
                barColor: '#ffb84e',
                lineCap: 'butt',
                lineWidth: 6,
                scaleColor: false,
                trackColor: '#c0c0c0',
                size: 106
            });
        </script>

        <script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/jquery-ui.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/amcharts/amcharts.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/amcharts/serial.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/amcharts/themes/light.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/explore.js"></script>	

    </body>
</html>
