<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.icube.owen.filter.FilterList"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.NavigableMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.TreeMap"%>
<%@page import="org.icube.owen.dashboard.ActivityFeed"%>
<%@page import="java.util.Date"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="java.util.Map"%>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.metrics.Metrics"%>
<%@page import="org.icube.owen.dashboard.IndividualDashboardHelper"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.icube.owen.survey.Question"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.survey.QuestionType"%>
<%@page import="java.util.List"%>
<%
    String moduleName = "dashboard";
    String subModuleName = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>OWEN - Dashboard</title>
	<link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/slick.css">
	<link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/individual.css">
    <link rel="apple-touch-icon" sizes="57x57" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-180x180.png">
    <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon/favicon-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon/android-icon-192x192.png" sizes="192x192">
    <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon/favicon-96x96.png" sizes="96x96">
    <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon/favicon-16x16.png" sizes="16x16">
    <link rel="manifest" href="<%=Constant.WEB_ASSETS%>images/favicon/manifest.json">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="msapplication-TileImage" content="<%=Constant.WEB_ASSETS%>images/favicon/ms-icon-144x144.png">
</head>

<body>
    <div class="container">
        <%@include file="header.jsp" %>

        <div class="site-nav">
            <a class="site-nav-prev" href="survey.jsp" title="Go to Survey">&#x276F;</a>
        </div>

        <div class="main">
            <div class="wrapper dashboard">
                <script>
                    if (document.documentElement.clientWidth <= 480) {
                        var type = window.location.hash.substr(1);
                        if(type === "initiatives") {
                            $('header li:eq(2)').addClass('current').siblings().removeClass('current');
                            $('.main .wrapper').attr('class', 'wrapper dashboard').addClass('initiatives');
                        }
                        else if(type === "notification") {
                            $('header li:eq(3)').addClass('current').siblings().removeClass('current');					
                            $('.main .wrapper').attr('class', 'wrapper dashboard').addClass('notification');
                        }
                        else {
                            $('header li:eq(1)').addClass('current').siblings().removeClass('current');
                            $('.main .wrapper').attr('class', 'wrapper dashboard').addClass('metrics');
                        }
                    }
                </script>

                <div class="panels-timeseries">
                <% 
                    IndividualDashboardHelper iDashboard =  (IndividualDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.IndividualDashboardHelper");
                    List<Metrics> topMetList = iDashboard.getIndividualMetrics(comid, empid);
                    for(int i=0; i<topMetList.size(); i++) {
                %>                    
                    <div class="panel clearfix">
                        <img src="<%=Constant.WEB_ASSETS%>images/individual_<%=Util.getInitiativeTypeImage(topMetList.get(i).getName(), Constant.INITIATIVES_CATEGORY_INDIVIDUAL)%>" alt="<%=topMetList.get(i).getName() %>" width="30" height="30">
                        <span class="panel-name"><%=topMetList.get(i).getName() %></span>
                        <span class="panel-score"><%=topMetList.get(i).getScore()%></span>
                        <button class="appreciateMetric" title="Appreciate for <%=topMetList.get(i).getName() %>" data-id="<%=topMetList.get(i).getId()%>"></button>
                    </div>
                <% } %>        
                    <div id="timeseriesChart">
                    </div>
                </div>

                <div class="initiatives-people-list">
                    <div class="initiatives-feed">
                        <div class="my-initiatives">
                            <div class="header">
                                <h3>My initiatives</h3>
                                <div class="search-popup">
                                    <button>&#x1F50D;</button>						
                                    <input type="search" placeholder="Search" class="search-initiative">
                                </div>
                                <button id="sortByDate">&#x21C5;</button>
                            </div>	
                           
                            <div class="initiative-details-popup"></div>
                            
                            <div class="initiatives-list">
                                <%
                                Initiative initiative =  (Initiative) ObjectFactory.getInstance("org.icube.owen.initiative.Initiative");
                                Map <Integer,String> indivdualType =  initiative.getInitiativeTypeMap(comid,"individual");
                                JSONObject indTypeJSON = new JSONObject(indivdualType);
                                Map <Integer,String> teamType =  initiative.getInitiativeTypeMap(comid,"team");
                                List<Initiative> iListArray = iDashboard.getIndividualInitiativeList(comid,empid);
                                for (int iCnt = 0; iCnt < iListArray.size(); iCnt++) {
                                    Initiative iObj = iListArray.get(iCnt);
                                    List<Metrics> metList = iObj.getInitiativeMetrics();
                                    int score = 0;
                                    String direction = "";
                                    for(int i=0; i <metList.size(); i++) {
                                        if(metList.get(i).getId() == iObj.getInitiativeTypeId()) {
                                            score = metList.get(i).getScore();
                                            direction = metList.get(i).getDirection();
                                        }
                                    }
                                    %>  
                                    
                                <div class="initiative-row" id="row_<%=iObj.getInitiativeId()%>">
                                    <div class="initiative-pic">	
                                        <div class="initiative-pic-cell">						
                                            <img src="<%=Constant.WEB_ASSETS%>images/<%=iObj.getInitiativeCategory().equals("Team") ? Util.getInitiativeTypeImage(teamType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory()) : Util.getInitiativeTypeImage(indivdualType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory()) %>" width="28" alt="Initiative 1">
                                        </div>
                                        <div class="initiative-pic-popup">
                                            <img src="<%=Constant.WEB_ASSETS%>images/<%=iObj.getInitiativeCategory().equals("Team") ? Util.getInitiativeTypeImage(teamType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory()) : Util.getInitiativeTypeImage(indivdualType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory()) %>" width="28" height="28" alt="Initiative 2">
                                            <span><%=iObj.getInitiativeCategory().equals("Team") ? teamType.get(iObj.getInitiativeTypeId()) : indivdualType.get(iObj.getInitiativeTypeId()) %></span>
                                        </div>
                                    </div>
                                    <span class="initiative-title"><%=iObj.getInitiativeName()%></span>
                                    <span class="initiative-date <%=Util.checkDateBefore( new java.util.Date(),iObj.getInitiativeEndDate())?"red":""%>" title="<%=Util.getDisplayDateFormat(iObj.getInitiativeEndDate(), "dd MMM yyy")%>"><%=Util.getDisplayDateFormat(iObj.getInitiativeEndDate(), "dd MMM")%></span>                                
                                    
                                    <span class="initiative-score"><%=score%><% if(direction.equalsIgnoreCase("positive")) { %><span class="up"></span><% } else if(direction.equalsIgnoreCase("negative")) { %><span class="down"></span><% } else { %><span class="neutral">..</span><% } %></span>
                                </div>

                                <div style="display:none" id="popup_<%=iObj.getInitiativeId()%>">
                                    <div class="popup-header clearfix">
                                        <%
                                        Employee emp = (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee");
                                        if(iObj.getCreatedByEmpId() != 0 ) {
                                        emp = emp.get(comid, iObj.getCreatedByEmpId() );
                                    %>
                                    <span class="details-user"><%=emp.getFirstName().substring(0, 1) + (emp.getLastName() != null ? emp.getLastName().substring(0, 1) : "")%></span>
                                    <% } else { %>
                                    <span class="details-user">AA</span>
                                    <% } %>
                                        <div class="details-calendar-type">
                                            <img src="<%=Constant.WEB_ASSETS%>images/initiative_details_popup_date.png" alt="Date" width="30" height="30">
                                            <div>
                                                <span>Due Date</span>
                                                <span class="<%=Util.checkDateBefore(new java.util.Date(),iObj.getInitiativeEndDate())?"red ":""%>calendar-due-date"><%=Util.getDisplayDateFormat(iObj.getInitiativeEndDate(), "dd MMM, yyyy")%></span>
                                            </div>
                                        </div>
                                        <div class="details-calendar-type details-calendar-type-two">
                                            <img src="<%=Constant.WEB_ASSETS%>images/<%=iObj.getInitiativeCategory().equals("Team") ? Util.getInitiativeTypeImage(teamType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory()) : Util.getInitiativeTypeImage(indivdualType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory()) %>" width="36">
                                            <div>
                                                <span>Type of Initiative</span>
                                                <span><%=iObj.getInitiativeCategory().equals("Team") ? teamType.get(iObj.getInitiativeTypeId()) : indivdualType.get(iObj.getInitiativeTypeId()) %></span>
                                            </div>
                                        </div>
                                        <div class="do-more-incomplete">
                                            <button title="Close the initative">x</button>
                                        </div>
                                    </div>

                                    <div class="popup-name">
                                        <h3><%=iObj.getInitiativeName()%></h3>
                                    </div>
                                    <div class="popup-score-chat">
                                        <div class="wrapper">										
                                            <div class="popup-score" id="popup-score_<%=iObj.getInitiativeId()%>">
                                                <ul>
                                                <% for(int i=0; i < metList.size(); i++) { %>
                                                    <li <%= metList.get(i).getId()==iObj.getInitiativeTypeId() ? "class=\"clicked\"" : "" %> >
                                                        <span class="score-no"><%=metList.get(i).getScore() %><% if(metList.get(i).getDirection().equalsIgnoreCase("positive")) { %><span class="up"></span><% } else if(metList.get(i).getDirection().equalsIgnoreCase("negative")) { %><span class="down"></span><% } else { %><span class="neutral">..</span><% } %></span>
                                                        <span class="score-name"><%=metList.get(i).getName()%></span>
                                                    </li>
                                                   <% } %> 
                                                </ul>
                                            </div>
                                            <div class="popup-key">
                                                <span>Key Individuals</span>
                                                <div>
                                                    <% List<Employee> keyIndividual = iObj.getOwnerOfList();
                                                        for (int i = 0; i < keyIndividual.size(); i++) {
                                                    %>
                                                    <span><%=keyIndividual.get(i).getFirstName().substring(0, 1) + (keyIndividual.get(i).getLastName() != null ? keyIndividual.get(i).getLastName().substring(0, 1) : "")%></span>
                                                    <% }
                                                    %>
                                                </div>
                                            </div>
                                            <div class="popup-chat-window">
                                                <%=iObj.getInitiativeComment()%>
                                            </div>
                                            <% if(iObj.getInitiativeStatus().equalsIgnoreCase("active") || iObj.getInitiativeStatus().equalsIgnoreCase("pending")) { %>
                                            <div class="popup-chat-box">
                                                <span>Me</span>
                                                <textarea name="initative-chat" id="initative-chat-<%=iObj.getInitiativeId()%>" placeholder="Write a comment"  onKeyPress="enterComment(event, this)"></textarea>
                                                <button type="button" title="Comment" id="updateComments" onClick="updateComments('<%=iObj.getInitiativeId()%>', $('#initative-chat-<%=iObj.getInitiativeId()%>').val(), this)">Comment</button>
                                            </div>
                                            <% } else { %>
                                                <div class="popup-chat-box">
                                                    <span>Me</span>
                                                    <textarea name="initative-chat" id="initative-chat-<%=iObj.getInitiativeId()%>" placeholder="Write a comment" disabled></textarea>
                                                    <button type="button" title="Comment" id="updateComments" disabled>Comment</button>
                                                </div>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>        
                                <% }%>
                            </div>
                        </div>

                        <div class="activity-feed">
                            <div class="header">
                                <h3>Activity Feed</h3>
                            </div>
                            
                            <div class="activity-list">
                                <%
                                NavigableMap<Date,List<ActivityFeed>> mapActivity = (new TreeMap<Date,List<ActivityFeed>>(iDashboard.getActivityFeedList(comid, empid, 1))).descendingMap();
                                Date todayDate = new Date();
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
                                String currentDate = sdf.format(todayDate);
                                for (Map.Entry<Date,List<ActivityFeed>> entry : mapActivity.entrySet()) {
                                    String actDate = sdf.format(entry.getKey());
                                    String dispDate = Util.getDisplayDateFormat(entry.getKey(), "MMM dd");
                                    
                                %>
                                <div class="activity-group">
                                    <div class="activity-date"><%=currentDate.equals(actDate)? "TODAY" : dispDate%> </div>
                                    <% 
                                        List<ActivityFeed> listActivty = entry.getValue();
                                        for(int aCnt=0; aCnt<listActivty.size(); aCnt++) {
                                            ActivityFeed aFeed = listActivty.get(aCnt);
                                          %>
                                          <div class="activity-item">
                                            <div class="activity-img">
                                                <% if (aFeed.getActivityType().equals("Appreciation")) { %>
                                                <img src="<%=Constant.WEB_ASSETS%>images/panel_appreciate_hover.png" alt="<%=aFeed.getActivityType()%>" width="35" height="35">
                                                <% } else { %>
                                                    <span>I</span>
                                                <% } %>
                                            </div>
                                            <div>
                                                <span class="activity-title"><%=aFeed.getHeaderText() %></span>
                                                <p class="activity-details">
                                                    <%=aFeed.getBodyText() %></span>
                                                </p>
                                            </div>
                                        </div>
                                          <% } %>
                                </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" id="selectedmetid">
                    <div class="people-list-box clearfix">
                        <p style = "font: 14px Open Sans Regular, Open Sans; color: #333; padding-bottom: 10px;"><b>Tip: </b> Indicate frequency of collaboration/level of appreciation by the number of stars</p>
                        <input class="search-colleague" type="search" placeholder="&#x1F50D; Search for a colleague you would like to appreciate">
                        <button>&#x1F50D;</button>

                        <button type="button" id="closeGroupAppreciate">x</button>

                        <div class="mobile-filter-row">
                            <div>
                                <div class="header">
                                    <button id="closeFilter"><img src="<%=Constant.WEB_ASSETS%>images/button_filter_back.png" alt="Back button"></button>
                                    <span>Filter</span>
                                    <div>
                                        <button id="getMobileSmartList" onclick="fetchSmartData();">Smart</button>
                                        <button id="chooseMobileFilter"><img src="<%=Constant.WEB_ASSETS%>images/button_filter__icon_tick.png" alt="Smart List"></button> 
                                    </div>
                                </div>
                                <div class="filter-menu">
                                    <ul>
                                        <li>
                                            <span>Geography</span>
                                            <ul>
                                                <%
                                                FilterList fl = new FilterList();
                                                Filter geoFilter = fl.getFilterValues(comid,Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                                                Map <Integer,String>  geoitem = geoFilter.getFilterValues();
                                                for (Map.Entry<Integer, String> entry : geoitem.entrySet()) { %>
                                                <li>
                                                    <input type="radio" id="filterGeography_<%=entry.getKey()%>" name="filter-geography" filter_type="Geography" data_id="<%=entry.getKey()%>" filter_type_id="<%=geoFilter.getFilterId() %>">
                                                    <label for="filterGeography_<%=entry.getKey()%>"><%=entry.getValue()%></label>
                                                </li>    
                                                <% } %>
                                            </ul>
                                        </li>
                                        <li>
                                            <span>Function</span>
                                            <ul>
                                                <%
                                                Filter funFilter = fl.getFilterValues(comid,Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                                                Map <Integer,String>  funitem = funFilter.getFilterValues();
                                                for (Map.Entry<Integer, String> entry : funitem.entrySet()) { %>
                                                    <li>
                                                    <input type="radio" id="filterFunction_<%=entry.getKey()%>" name="filter-function" filter_type="Function" data_id="<%=entry.getKey()%>" filter_type_id="<%=funFilter.getFilterId() %>">
                                                    <label for="filterFunction_<%=entry.getKey()%>"><%=entry.getValue()%></label>
                                                </li>
                                                <% } %>
                                            </ul>
                                        </li>
                                        <li>
                                            <span>Level</span>
                                            <ul>
                                                 <%
                                                Filter levelFilter = fl.getFilterValues(comid,Constant.INITIATIVES_LEVEL_FILTER_NAME);
                                                Map <Integer,String>  levelitem =  levelFilter.getFilterValues();
                                                for (Map.Entry<Integer, String> entry : levelitem.entrySet()) { %>
                                                    <li>
                                                    <input type="radio" id="filterLevel_<%=entry.getKey()%>" name="filter-level" filter_type="Level" data_id="<%=entry.getKey()%>" filter_type_id="<%=levelFilter.getFilterId() %>">
                                                    <label for="filterLevel_<%=entry.getKey()%>"><%=entry.getValue()%></label>
                                                </li>
                                                <% } %>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>            

                        <div class="filter-row">
                            <div class="get-filter-list">
                                <button id="getFilteredList">Filter &#x25BE;</button>
                                <div class="filter-menu" >
                                    <ul>
                                        <li>
                                            <span>Geography <span>&#x203A;</span></span>
                                            <ul><%
                                                for (Map.Entry<Integer, String> entry : geoitem.entrySet()) { %>
                                                    <li><span>&#x2714;</span> <span class="filter-choice-name" filter_type="Geography" data_id="<%=entry.getKey()%>"  filter_type_id="<%=geoFilter.getFilterId() %>"><%=entry.getValue()%></span></li>
                                                <% } %>
                                            </ul>
                                        </li>
                                        <li>
                                            <span>Function <span>&#x203A;</span></span>
                                            <ul>
                                                <%
                                                for (Map.Entry<Integer, String> entry : funitem.entrySet()) { %>
                                                    <li><span>&#x2714;</span> <span class="filter-choice-name" filter_type="Function" data_id="<%=entry.getKey()%>"  filter_type_id="<%=funFilter.getFilterId() %>"><%=entry.getValue()%></span></li>   
                                                <% } %>
                                            </ul>
                                        </li>
                                        <li>
                                            <span>Level <span>&#x203A;</span></span>
                                            <ul>
                                                <%
                                                for (Map.Entry<Integer, String> entry : levelitem.entrySet()) { %>
                                                    <li><span>&#x2714;</span> <span class="filter-choice-name" filter_type="Level" data_id="<%=entry.getKey()%>"  filter_type_id="<%=levelFilter.getFilterId() %>"><%=entry.getValue()%></span></li>   
                                                <% } %>
                                            </ul>
                                        </li>
                                    </ul>
                            </div>
                            </div>
                            <button id="getSmartList" onclick="fetchSmartData();">Smart</button>
                            <input type="hidden" id="" value="" />
                            <div class="three-filters-group">
                                <span></span>
                                <span></span>
                                <span></span>
                            </div> 
                        </div>
                                            
                        <div class="individuals-box">	
                            <div class="overlay_form"><img src="<%=Constant.WEB_ASSETS%>images/ajax-loader.gif"></div>	
                            
                            <div class="individuals-grid">
                            </div>
                        </div>
                        <div class="individuals-box-scroll">
                            <a href="#" title="Previous" class="individuals-prev"></a>
                            <a href="#" title="Next" class="individuals-next"></a>
                        </div>

                        <div class="submit-circle">
                            <button>&#x2714;</button>
                            <div class="submit-tooltip">
                                <span class="submit-title"><span>SUBMIT</span> this response</span>
                                <span class="submit-response">Please select a response</span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script src="<%=Constant.WEB_ASSETS%>js/jquery-ui.js"></script>
	<script src="<%=Constant.WEB_ASSETS%>js/amcharts/amcharts.js"></script>
	<script src="<%=Constant.WEB_ASSETS%>js/amcharts/serial.js"></script>	
	<script src="<%=Constant.WEB_ASSETS%>js/amcharts/themes/light.js"></script>    
	<script src="<%=Constant.WEB_ASSETS%>js/isotope.pkgd.min.js"></script>
    <script src="<%=Constant.WEB_ASSETS%>js/jquery.slimscroll.min.js"></script>	
    <script src="<%=Constant.WEB_ASSETS%>js/slick.min.js"></script>
	<script src="<%=Constant.WEB_ASSETS%>js/dashboard-individual.js"></script>
    <script type="text/javascript">    
        <% 
            Map<Integer, List<Map<java.util.Date,Integer>>> list1 =iDashboard.getIndividualMetricsTimeSeries(comid, empid);
            Map<Integer, List<Map<String,Integer>>> newlist1 = new HashMap<Integer, List<Map<String,Integer>>>();
            for (Map.Entry<Integer, List<Map<java.util.Date, Integer>>> entry : list1.entrySet()) {
                Integer key = entry.getKey();
                List<Map<java.util.Date, Integer>> mapLits = entry.getValue();
                List<Map<String, Integer>> newmapLits = new ArrayList<Map<String, Integer>>();
                for (int i = 0; i < mapLits.size(); i++) {
                    Map<java.util.Date, Integer> datamap = mapLits.get(i);
                    Map<String, Integer> newdatamap = new HashMap<String, Integer>();
                    for (Map.Entry<java.util.Date, Integer> entry1 : datamap.entrySet()) {
                        Date date1 = entry1.getKey();
                        String date = Util.getDisplayDateFormat(date1, "YYYY-MM-dd");
                        Integer data1  = entry1.getValue();
                        newdatamap.put(date, data1);
                    }
                    newmapLits.add(newdatamap);
                }
                newlist1.put(key, newmapLits);
            }
            JSONObject obj=new JSONObject(newlist1);
            out.println("var timeArray = JSON.parse('"+obj+"');");
        %>
            
        var indTypeJSON = <%=indTypeJSON%>;
        $(document).ready(function() {
            if(document.documentElement.clientWidth > 480) { 
                function getDataAarrayIndividual(mat1, mat2,mat3, mat1key, mat2kay,mat3kay) {
                    var currentQArray = new Array();
                    for (var j in mat1) {
                        for (var k in mat1[j]) {
                            var a = {};
                            a["date"] = k;
                            a[mat1key] = mat1[j][k];
                            a[mat2kay] = mat2[j][k];
                            a[mat3kay] = mat3[j][k];
                            currentQArray.push(a);
                        }
                    }
                    return currentQArray;
                } 

                function generateTimeGraphIndividual(divid, dataArray, type1, type2, type3) {
                    var chartConfig = {
                        "type": "serial",
                        "categoryField": "date",
                        "dataDateFormat": "YYYY-MM-DD",
                        "mouseWheelScrollEnabled": true,
                        "mouseWheelZoomEnabled": true,
                        "marginTop": 0,
                        "plotAreaBorderColor": "#B6B6B6",
                        "startEffect": "easeOutSine",
                        "borderColor": "#B6B6B6",
                        "color": "#B6B6B6",
                        "fontFamily": "Open Sans",
                        "fontSize": 10,
                        "handDrawScatter": 0,
                        "handDrawThickness": 0,
                        "theme": "default",
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
                            "valueLineEnabled": true,
                            "valueZoomable": true
                        },
                        "chartScrollbar": {
                            "enabled": true,
                            "autoGridCount": true,
                            "dragIconHeight": 20,
                            "dragIconWidth": 20
                        },
                        "trendLines": [],
                        "graphs": [
                            {
                                "bullet": "square",
                                "id": "AmGraph-1",
                                "title": type1,
                                "valueField": type1
                            },
                            {
                                "bullet": "round",
                                "id": "AmGraph-2",
                                "title": type2,
                                "valueField": type2
                            },
                            {
                                "bullet": "triangleUp",
                                "id": "AmGraph-3",
                                "markerType": "triangleDown",
                                "title": type3,
                                "valueField": type3
                            }
                        ],
                        "guides": [],
                        "valueAxes": [
                            {
                                "id": "ValueAxis-1",
                                "title": ""
                            }
                        ],
                        "allLabels": [],
                        "balloon": {
                            "color": "#AAB3B3"
                        },
                        "legend": {
                            "enabled": true,
                            "align": "right",
                            "borderColor": "#AAB3B3",
                            "color": "#AAB3B3",
                            "fontSize": 10,
                            "markerLabelGap": 10,
                            "position": "right",
                            "useGraphSettings": true,
                            "valueWidth": 20,
                            "verticalGap": -2
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
                
                if(!($.isEmptyObject(timeArray))) {
                    var mat1, mat2, mat3;
                    var result = Object.keys(timeArray); 
                    mat1 = timeArray[result[0]];
                    mat2 = timeArray[result[1]];
                    mat3 = timeArray[result[2]];
                    var flag=false;
                    for (var j in mat1) {
                        for (var k in mat1[j]) {
                            if(mat1[j][k] !== 0) {
                                flag = true;
                                break;
                            } 
                        }
                    }
                    if(!flag) {
                       for (var j in mat2) {
                            for (var k in mat2[j]) {
                                if(mat2[j][k] !== 0) {
                                    flag = true;
                                    break;
                                } 
                            }
                        } 
                    }
                    if(!flag) {
                       for (var j in mat3) {
                            for (var k in mat3[j]) {
                                if(mat3[j][k] !== 0) {
                                    flag = true;
                                    break;
                                } 
                            }
                        } 
                    }
                    if(flag) {
                        var currentQArray = getDataAarrayIndividual(mat1, mat2, mat3, indTypeJSON[result[0]], indTypeJSON[result[1]], indTypeJSON[result[2]]);
                        generateTimeGraphIndividual('timeseriesChart', currentQArray, indTypeJSON[result[0]], indTypeJSON[result[1]], indTypeJSON[result[2]]);
                    } else {
                        $('#timeseriesChart').html('<div class="no-score"><span>Good things take time.</span><span>I will share scores as soon as there is sufficient data.</span></div>');
                    }
                } else {
                    $('#timeseriesChart').html('<div class="no-score"><span>Good things take time.</span><span>I will share scores as soon as there is sufficient data.</span></div>');
                }
            }
            
            
        });
        
        function updateComments(id, comments, obj) {
            comments = encodeURIComponent(comments);
            var postStr = 'iid=' + id + '&comments=' + comments;
            $.ajax({
                url: '<%=Constant.WEB_CONTEXT%>/individual/updatecomments.jsp',
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
        
        function enterComment(e, textarea){
            if(e.which === 13) { 
                e.preventDefault();
                $('#updateComments').click();
            }
        }
	</script>
</body>
</html>