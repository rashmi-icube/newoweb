<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.Util"%>
<%
    String moduleName = "dashboard";
    String subModuleName = "";
%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.TreeMap"%>

<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="org.icube.owen.initiative.InitiativeHelper"%>
<%@page import="org.icube.owen.initiative.InitiativeList"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="org.icube.owen.metrics.MetricsList"%>
<%@page import="org.icube.owen.metrics.Metrics"%>
<%@page import="org.icube.owen.dashboard.HrDashboardHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.filter.FilterList"%>
<%@page import="org.icube.owen.dashboard.Alert"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>OWEN - Dashboard</title>
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
                    <div class="compare-score">
                        <div class="compare-score-header clearfix">
                            <div class="compare-filter">
                                <% FilterList fl = new FilterList(); %>
                                <% Filter filter = fl.getFilterValues(comid,Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME); %>
                                <button type="button" class="compare-filter-type" value="<%=filter.getFilterId()%>">Geography</button>
                                <div class="compare-filter-box">
                                    <button class="prev-compare-list">&#x25C4;</button>
                                    
                                    <div>
                                        <% 
                                            Map <Integer,String>  item = filter.getFilterValues();
                                           int count = 0;
                                        for (Map.Entry<Integer, String> entry : item.entrySet()) { 
                                            if(count == 0) {
                                                %> <ul><%
                                            }
                                            if(count > 1 && count % 6 == 0) {
                                                %> </ul><ul> <%
                                            }%>
                                            <li id="<%=entry.getKey()%>"><%=entry.getValue()%></li>
                                        <% count ++; } %>
                                        </ul>
                                </div>							
                                    <button class="next-compare-list">&#x25BA;</button>
                                </div>
                                     <% filter = fl.getFilterValues(comid,Constant.INITIATIVES_FUNCTION_FILTER_NAME);  %>
                                <button type="button" class="compare-filter-type" value="<%=filter.getFilterId()%>">Function</button>
                                <div class="compare-filter-box">
                                    <button class="prev-compare-list">&#x25C4;</button>
                                    <div>
                                            <%  item = filter.getFilterValues();
                                              count = 0;
                                            for (Map.Entry<Integer, String> entry : item.entrySet()) { 
                                                if(count == 0) {
                                                    %> <ul><%
                                                }
                                                if(count > 1 && count % 6 == 0) {
                                                    %> </ul><ul> <%
                                                }%>
                                                <li id="<%=entry.getKey()%>"><%=entry.getValue()%></li>
                                            <% count ++; } %>
                                        </ul>
                                    </div>							
                                    <button class="next-compare-list">&#x25BA;</button>
                                </div>
                                        <% filter = fl.getFilterValues(comid,Constant.INITIATIVES_LEVEL_FILTER_NAME);  %>
                                <button type="button" class="compare-filter-type" value="<%=filter.getFilterId()%>">Level</button>
                                <div class="compare-filter-box">
                                    <button class="prev-compare-list">&#x25C3;</button>
                                    <div>
                                        <%  item = filter.getFilterValues();
                                        count = 0;
                                        for (Map.Entry<Integer, String> entry : item.entrySet()) { 
                                            if(count == 0) {
                                                %> <ul><%
                                            }
                                            if(count > 1 && count % 6 == 0) {
                                                %> </ul><ul> <%
                                            }%>
                                                <li id="<%=entry.getKey()%>"><%=entry.getValue()%></li>
                                            <% count ++; } %>
                                        </ul>
                                    </div>								
                                    <button class="next-compare-list">&#x25B9;</button>
                                </div>

                            </div>
                            <div class="chosen-filter-name"></div>
                            <button type="button">ALL</button>	
                        </div>
                        <div class="compare-score-body">
                            <div class="compare-score-boxes">
                                <div class="compare-score-box">
                                    <div class="compare-score-name">
                                        <button>&#x25BC; <span>Retention Score</span></button>
                                        <ul>
                                            <%
                                          //List<Filter> fList =   fl.getFilterValues();
                                            Initiative initiative = new Initiative();
                                            Map <Integer,String> teamType =  initiative.getInitiativeTypeMap(comid,"team");
                                            JSONObject teamTypeJSON = new JSONObject(teamType);
                                            HrDashboardHelper dBoardObj =  (HrDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.HrDashboardHelper");
                                            List<Metrics> metList = dBoardObj.getOrganizationalMetrics(comid);
                                            for(int i=0; i < metList.size(); i++) { %>
                                                <li data-id="<%=metList.get(i).getId()%>" data-score="<%=metList.get(i).getScore() %>" data-avg="<%= (int)metList.get(i).getAverage() %>" data-direction="<%=metList.get(i).getDirection() %>" <%=metList.get(i).getId() == Constant.DEFAULT_COMPARE_TYPE_1 ? "class='clicked'":"" %>><%=metList.get(i).getName() %> Score</li>
                                            <% } %>
                                        </ul>
                                    </div>	
                                    <div class="chart" id="chart-compare-one">
                                        <div>
                                            <div class="chart-score"><span></span> <span class="up"></span></div>				
                                            <div class="org-avg clearfix">
                                                <p><span class="filtertype">Org.</span><span>Average</span></p>
                                                <p></p>		
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="compare-score-box">
                                    <div class="compare-score-name">
                                        <button>&#x25BC; <span>Sentiment Score</span></button>
                                        <ul><%
                                            for(int i=0; i < metList.size(); i++) { %>
                                            <li data-id="<%=metList.get(i).getId()%>" data-score="<%=metList.get(i).getScore() %>" data-avg="<%= (int)metList.get(i).getAverage() %>" data-direction="<%=metList.get(i).getDirection() %>" <%=metList.get(i).getId() == Constant.DEFAULT_COMPARE_TYPE_2 ? "class='clicked'":"" %>><%=metList.get(i).getName() %> Score</li>
                                             <% } %>
                                        </ul>
                                    </div>

                                    <div class="chart" id="chart-compare-two"><div>
                                        <div class="chart-score"><span></span> <span class="down"></span></div>				
                                            <div class="org-avg clearfix">
                                                <p><span class="filtertype">Org.</span><span>Average</span></p>
                                                <p></p>		
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="compare-trend">
                                <button>Trend</button>
                                <div id="trend-graph"></div>							
                            </div>
                        </div>
                    </div>

                    <div class="focus-areas">
                        <div class="focus-areas-header">
                            <h3>Focus Areas</h3>
                            <button>Expand</button>
                        </div>
                        <div class="initative-details-popup">

                        </div>
                        <div class="initative-list-all">
                            <%
                                InitiativeList iListObj = new InitiativeList();
                                List<Initiative> iListArray = iListObj.	getInitiativeListByStatus(comid,"Team","Active");
                                for (int iCnt = 0; iCnt < iListArray.size(); iCnt++) {
                                    Initiative iObj = iListArray.get(iCnt);
                                    List<Metrics> metList1 = iObj.getInitiativeMetrics();
                                    int score = 0;
                                    String direction = "";
                                    for(int i=0; i <metList1.size(); i++) {
                                        if(metList1.get(i).getId() == iObj.getInitiativeTypeId()) {
                                            score = metList1.get(i).getScore();
                                            direction = metList1.get(i).getDirection();
                                        }
                                    }
                                %>
                            <div class="initative-list clearfix" id="row_<%=iObj.getInitiativeId()%>">
                                <div class="initative-pic">	
                                    <div class="initative-pic-cell">						
                                        <img src="<%=Constant.WEB_ASSETS%>images/<%=Util.getInitiativeTypeImage(teamType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory())%>" width="28" alt="Initiative 1">
                                    </div>
                                    <div class="initative-pic-popup">
                                        <img src="<%=Constant.WEB_ASSETS%>images/<%=Util.getInitiativeTypeImage(teamType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory())%>" width="28" height="28" alt="Initiative 2">
                                        <span><%=teamType.get(iObj.getInitiativeTypeId())%></span>
                                    </div>
                                </div>
                                <span class="list-name"><%=iObj.getInitiativeName()%></span>
                                <div class="list-score-date">
                                    <span class="list-date <%=Util.checkDateBefore(new java.util.Date(),iObj.getInitiativeEndDate())?"red":""%>" title="<%=Util.getDisplayDateFormat(iObj.getInitiativeEndDate(), "dd MMM yyy")%>"><%=Util.getDisplayDateFormat(iObj.getInitiativeEndDate(), "dd MMM")%></span>								
                                    <span class="list-score">
                                        <% if(score > -1) { %>
                                        <%=score%>
                                         <% if(direction.equalsIgnoreCase("positive")) { %>   
                                            <span class="up">&#x25B2;</span>
                                        <% } else if(direction.equalsIgnoreCase("negative")) { %>
                                            <span class="down">&#x25BC;</span>
                                        <% } else { %>
                                            <span class="neutral">..</span>
                                        <% } %>
                                        <% } %>
                                    </span>
                                    <% if(iObj.getInitiativeStatus().equalsIgnoreCase("active") || iObj.getInitiativeStatus().equalsIgnoreCase("pending")) { %>    
                                        <button type="button" class="list-remove" title="Delete" onClick="deleteInitative(<%=iObj.getInitiativeId()%>)">&#xD7;</button>
                                     <% } else { %>
                                        <span class="filler-remove"></span>
                                    <% }
                                     if(iObj.getInitiativeStatus().equalsIgnoreCase("active")) { %>
                                        <button type="button" class="list-complete" onClick="updateStatus(<%=iObj.getInitiativeId()%>, 'Completed')" title="Mark as complete">&#x2714;</button>
                                   <% } else { %>
                                        <span class="filler-complete"></span>  
                                     <% }  %>
                                </div>
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
                                            <span class="<%=Util.checkDateBefore(new java.util.Date(),iObj.getInitiativeEndDate())?"red":""%>"><%=Util.getDisplayDateFormat(iObj.getInitiativeEndDate(), "dd MMM, yyyy")%></span>
                                        </div>
                                    </div>
                                    <div class="details-calendar-type">
                                        <img src="<%=Constant.WEB_ASSETS%>images/<%=Util.getInitiativeTypeImage(teamType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory())%>" width="36">
                                        <div>
                                            <span>Type of Initiative</span>
                                            <span><%=teamType.get(iObj.getInitiativeTypeId())%></span>
                                        </div>
                                    </div>
                                    <div class="do-more-incomplete">										
                                        <div>
                                            <button title="Do more">&#x22EF;</button>
                                            <ul>
                                                <li><a href="<%=Constant.WEB_CONTEXT%>/initiative/edit.jsp?iid=<%=iObj.getInitiativeId()%>" title="Edit">Edit</a></li>
                                                <li><button type="button" id="deletePopup" title="Delete" onClick="javascript:deleteInitative(<%=iObj.getInitiativeId()%>)" data-id="<%=iObj.getInitiativeId()%>">Delete</button></li>
                                            </ul>
                                        </div>
                                        <button title="Close the initative">x</button>
                                    </div>
                                </div>

                                <div class="popup-name">
                                    <button type="button" title="Mark as complete" onClick="updateStatus(<%=iObj.getInitiativeId()%>, 'Completed')" data-id="<%=iObj.getInitiativeId()%>">&#x2714;</button>
                                    <h3><%=iObj.getInitiativeName()%></h3>
                                </div>
                                <div class="popup-score-chat">
                                    <div class="wrapper">										
                                        <div class="popup-score">
                                           <ul>
                                                <%
                                                 
                                              for(int i=0; i < metList1.size(); i++) { %>
                                                <li <%= metList1.get(i).getId()==iObj.getInitiativeTypeId() ? "class=\"clicked\"" : "" %> >
                                                        <% if (metList1.get(i).getScore() > -1) { %>
                                                        <span class="score-no"><%=metList1.get(i).getScore() %><% if(metList1.get(i).getDirection().equalsIgnoreCase("positive")) { %><span class="up">&#x25B4;</span><% } else if(metList1.get(i).getDirection().equalsIgnoreCase("negative")) { %><span class="down">&#x25BE;</span><% } else { %><span class="neutral">..</span><% } %></span>
                                                        <% } else { %>
                                                            <span class="empty"  >
                                                            Team size too small.
                                                            </span>
                                                        <% } %>
                                                    
                                                    <span class="score-name"><%=metList1.get(i).getName()%></span>
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

                    <div class="alerts-area">
                        <div class="alerts-area-header">
                            <h3>Alerts</h3>
                            <button>Expand</button>
                        </div>
                        <div class="alerts-area-body">
                        <%
                                List<Alert> listAlert =  dBoardObj.getAlertList(comid);
                                for(int i=0; i<listAlert.size(); i++) {
                                    Alert alert = listAlert.get(i);
                                    
                                %>
                                <div class="alert-item">
                                <div class="alert-pic">
                                    <div class="alert-pic-cell">
                                        <img src="<%=Constant.WEB_ASSETS%>images/<%=Util.getInitiativeTypeImage(teamType.get(alert.getInitiativeTypeId()), "Team")%>" width="28" height="28">
                                    </div>

                                    <div class="alert-pic-popup">
                                        <img src="<%=Constant.WEB_ASSETS%>images/<%=Util.getInitiativeTypeImage(teamType.get(alert.getInitiativeTypeId()), "Team")%>" width="28" height="28" alt="Alert 1">
                                        <span><%=teamType.get(alert.getInitiativeTypeId()) %></span>
                                    </div>
                                </div>
                                    
                                <div>
                                    <a class="alert-team" href="<%=Constant.WEB_CONTEXT%>/explore/explore.jsp?a=<%=alert.getAlertId()%>"><%= alert.getAlertTeam()%></a><%= alert.getAlertStatement()%>
                                </div>

                                <div><%if (alert.getEmployeeList().size() > 0){ %>
                                    <button class="alert-people-icon"><img src="<%=Constant.WEB_ASSETS%>images/alert-person-popup.png" width="25px"></button>
                                    <div class="alert-people-list">
                                        <span class="tip"></span>
                                        <div class="clearfix">
                                            <div class="alert-people-body">
                                                <% 
                                                    List<Employee> eList = alert.getEmployeeList();
                                                    for(int j=0; j<eList.size(); j++) { %>
                                                        <p>
                                                        <img src="<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=eList.get(j).getCompanyId() %>&eid=<%=eList.get(j).getEmployeeId() %>">
                                                        <span><a href="<%=Constant.WEB_CONTEXT%>/explore/explore.jsp?eid=<%=eList.get(j).getEmployeeId()%> "><%=eList.get(j).getFirstName()+" "+eList.get(j).getLastName() %> </a></span>
                                                        </p>
                                                    <%}
                                                %>
                                            </div>
                                            <button class="close-alert-people">x</button>										
                                        </div>
                                    </div>
                                <%}%></div>	
                                <div><%=alert.getAlertMetric().getScore()%>
                                    <% if(alert.getAlertMetric().getDirection().equalsIgnoreCase("positive") ) { %>   
                                        <span class="up">&#x25b4;</span>
                                    <% } else if(alert.getAlertMetric().getDirection().equalsIgnoreCase("negative")) { %>
                                        <span class="down">&#x25be;</span>
                                    <% } else { %>
                                        <span class="neutral">&#9666;&#9656;</span>
                                    <% } %>
                                </div>
                                <div><button type="button" class="alert-remove" title="Delete" onClick="deleteAlert(<%=alert.getAlertId()%>)">&#xD7;</button></div>
                                <div><button type="button" class="alert-create" title="Create an initiative" onClick="createInitiative(<%=alert.getAlertId()%>)">+</button></div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
                        
        <script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/jquery-ui.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/easypiechart.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/amcharts/amcharts.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/amcharts/serial.js"></script>	
        <script src="<%=Constant.WEB_ASSETS%>js/amcharts/themes/light.js"></script>	
        <script src="<%=Constant.WEB_ASSETS%>js/dashboard.js"></script>	
        <script>
            <%
                Map<Integer, List<Map<java.util.Date,Integer>>> list1 = dBoardObj.getOrganizationTimeSeriesGraph(comid);
                JSONObject obj=new JSONObject(list1);
                out.println("var timeArray = JSON.parse('"+obj+"');");
                String firstKey = teamType.get(Constant.DEFAULT_COMPARE_TYPE_1);
                String secondKey = teamType.get(Constant.DEFAULT_COMPARE_TYPE_2);
            %>
            var teamTypeJSON = <%=teamTypeJSON%>;
            $(document).ready(function() {
                if(!($.isEmptyObject(timeArray))) {
                    var mat1;
                    var mat2;
                    for (var i in timeArray) {
                        if(i==<%=Constant.DEFAULT_COMPARE_TYPE_1%>) {
                            mat1 = timeArray[i];
                        } else if(i==<%=Constant.DEFAULT_COMPARE_TYPE_2%>) {
                            mat2 = timeArray[i];
                        }
                    }
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
                    if(flag) {
                        var currentQArray = getDataAarray(mat1,mat2,'<%=firstKey%>','<%=secondKey%>');
                        generateTimeGraph('trend-graph',currentQArray,'<%=firstKey%>','<%=secondKey%>');
                    } else {
                        $('#trend-graph').html('<div class="no-score"><span>Good things take time.</span><span>I will share scores as soon as there is sufficient data.</span></div>');
                    }
                } else {
                    $('#trend-graph').html('<div class="no-score"><span>Good things take time.</span><span>I will share scores as soon as there is sufficient data.</span></div>');
                }
            });
        </script>

        <script>
            function getMatrics(fid, type, fidText,typeid,orglevel) {
                var postStr = "";
                 if(orglevel) {
                     postStr = "org=true";
                 } else {
                    postStr = "fid="+fid+"&type="+type+"&fidText="+fidText+"&typeid="+typeid;
                   }
                $.ajax({
                    url: '<%=Constant.WEB_CONTEXT%>/dashboard/gettimegraph.jsp',
                    type: 'POST',
                    data: postStr,
                    dataType: 'json',
                    success: function(resp) {
                        $('.overlay_form').hide();
                        timeArray = resp.data;
                        var matData = resp.matdata;

                         $.each(matData, function(key) {
                             if(type != '') {
                                $('.filtertype').text(type);
                             } else {
                                $('.filtertype').text('Org.');
                             }
                             $('.compare-score-name li').each(function(index, el) {
                                if($(el).attr('data-id') == matData[key].dataid) {
                                   if(matData[key].datascore < 0) {
                                        $(el).attr('data-score', 'Team size too small');
                                        $(el).attr('data-avg', '');
                                        $(el).attr('data-direction', '');
                                    } else {
                                        $(el).attr('data-score', matData[key].datascore);
                                        $(el).attr('data-avg', matData[key].dataavg);
                                        $(el).attr('data-direction', matData[key].datadirection);
                                    }

                                }
                            });
                         });

                        var selectedType = [];
                        $('.compare-score-name li.clicked').each(function(index, el) {
                            var score = $(this).attr('data-score');
                            var avrg = $(this).attr('data-avg');

                            var direction = $(this).attr('data-direction');
                            var target = $(this).parents('.compare-score-name').next('div');

                            if(score === 'Team size too small') {
                                $(target).data('easyPieChart').update(0);
                                $(target).find('.chart-score span:first').addClass('empty').text(score);
                                $(target).find('.chart-score span:nth-child(2)').removeClass('up down').text('');
                                $(target).find('.org-avg p:first-child').hide();
                                $(target).find('.org-avg p:nth-child(2)').text('');
                            } else {
                                $(target).data('easyPieChart').update(score);
                                $(target).find('.chart-score span:first').removeClass('empty').text(score);
                                if(direction === 'Positive') {
                                    $(target).find('.chart-score span:nth-child(2)').removeClass('up down').addClass('up').text('▴');
                                } else if(direction === 'Negative') {
                                    $(target).find('.chart-score span:nth-child(2)').removeClass('up down').addClass('down').text('▾');
                                }
                                $(target).find('.org-avg p:first-child').show();
                                $(target).find('.org-avg p:nth-child(2)').text(avrg);
                            }

                            selectedType.push($(el).attr('data-id'));
                        });

                        if(!(jQuery.isEmptyObject(timeArray))) {
                            var mat1, mat2;
                            for (var i in timeArray) {
                                if(i==selectedType[0]) {
                                   mat1 = timeArray[i];
                                } 
                                if(i==selectedType[1]) {
                                   mat2 = timeArray[i];
                                }
                            }
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
                            if(flag) {
                                    var currentQArray = getDataAarray(mat1, mat2, teamTypeJSON[selectedType[0]], teamTypeJSON[selectedType[1]]);
                                    generateTimeGraph('trend-graph', currentQArray, teamTypeJSON[selectedType[0]], teamTypeJSON[selectedType[1]]);
                            } else {
                                $('#trend-graph').html('<div class="no-score"><span>Good things take time.</span><span>I will share scores as soon as there is sufficient data.</span></div>');
                            }
                        } else {
                            $('#trend-graph').html('<div class="no-score"><span>Good things take time.</span><span>I will share scores as soon as there is sufficient data.</span></div>');
                        }                    
                    }
                }); 
            }

            $(function() {
                $('.compare-score-header>button').on('click', function() {
                    $('.chosen-filter-name').empty().hide();
                    $('.compare-filter>button').removeAttr('style');
                    getMatrics('','','',0,true)
                });

                $('.compare-score-name li.clicked').each(function(index, el) {
                    var score = $(el).attr('data-score');
                    var avrg = $(this).attr('data-avg');
                    var direction = $(el).attr('data-direction');
                    var target = $(el).parents('.compare-score-name').next('div');

                    $(target).attr('data-percent', score);
                    $(target).find('.chart-score span:first').text(score);
                    if(direction === 'Positive') {
                        $(target).find('.chart-score span:nth-child(2)').removeClass('up down').addClass('up').text('▴');
                    } else if(direction === 'Negative') {
                        $(target).find('.chart-score span:nth-child(2)').removeClass('up down').addClass('down').text('▾');
                    }
                    $(target).find('.org-avg p:nth-child(2)').text(avrg);
                });

                $('.compare-filter-box li').on('click', function() {
                    var name = $(this).text();
                    $('.chosen-filter-name').text(name).css('display', 'inline-block').show();
                    $(this).parents('.compare-filter-box').hide();
                    $(this).parents('.compare-filter-box').prev('button').css('border-bottom', '3px solid #ffb84e').siblings('button').removeAttr('style');
                    var fid = $(this).attr('id') ;
                    var fidText = $(this).text() ;
                    var type= $(this).parents('.compare-filter-box').prev().text();
                    var typeid = $(this).parents('.compare-filter-box').prev().val();
                    getMatrics(fid,type,fidText,typeid,false);

                });

                $('#chart-compare-one').easyPieChart({
                  barColor: '#ffb84e',
                  lineCap: 'butt',
                  lineWidth: 9,
                  scaleColor: false,
                  size: 152
                });

                $('#chart-compare-two').easyPieChart({
                  barColor: '#ffb84e',
                  lineCap: 'butt',
                  lineWidth: 9,
                  scaleColor: false,
                  size: 152
                });

                $('.compare-score-name li').on('click', function() {
                    var name = $(this).text();
                    $(this).parent('ul').hide().prev('button').children('span').text(name);
                    $(this).addClass('clicked').siblings().removeClass('clicked');

                    var score = $(this).attr('data-score');
                    var avrg = $(this).attr('data-avg');
                    var direction = $(this).attr('data-direction');
                    var target = $(this).parents('.compare-score-name').next('div');

                    if(score === 'Team size too small') {
                        $(target).data('easyPieChart').update(0);
                        $(target).find('.chart-score span:first').addClass('empty').text(score);
                        $(target).find('.chart-score span:nth-child(2)').removeClass('up down').text('');
                        $(target).find('.org-avg p:first-child').hide();
                        $(target).find('.org-avg p:nth-child(2)').text('');
                    } else {
                        $(target).data('easyPieChart').update(score);
                        $(target).find('.chart-score span:first').removeClass('empty').text(score);

                        if(direction === 'Positive') {
                            $(target).find('.chart-score span:nth-child(2)').removeClass('up down').addClass('up').text('▴');
                        } else if(direction === 'Negative') {
                            $(target).find('.chart-score span:nth-child(2)').removeClass('up down').addClass('down').text('▾');
                        }
                        $(target).find('.org-avg p:first-child').show();
                        $(target).find('.org-avg p:nth-child(2)').text(avrg);
                    }

                    var selectedType = [];    
                    $('.compare-score-name li.clicked').each(function(index, el) {
                        selectedType.push($(el).attr('data-id'));
                    });

                    if(!(jQuery.isEmptyObject(timeArray))) {
                        var mat1, mat2;
                        for (var i in timeArray) {
                            if(i == selectedType[0]) {
                                mat1 = timeArray[i];
                            } 
                            if(i == selectedType[1]) {
                                mat2 = timeArray[i];
                            }
                        }        var flag=false;
                        for (var j in mat1) {
                           for (var k in mat1[j]) {
                               if(mat1[j][k] !== 0) {
                                   flag = true;
                                   break;
                               } 
                           }
                        }
                        if( !flag ) {
                            for (var j in mat2) {
                                for (var k in mat2[j]) {
                                    if(mat2[j][k] !== 0) {
                                        flag = true;
                                        break;
                                    } 
                                }
                            } 
                        }
                        if(flag) {               
                            var currentQArray = getDataAarray(mat1, mat2, teamTypeJSON[selectedType[0]], teamTypeJSON[selectedType[1]]);
                            generateTimeGraph('trend-graph', currentQArray, teamTypeJSON[selectedType[0]], teamTypeJSON[selectedType[1]]);
                        } else {
                            $('#trend-graph').html('<div class="no-score"><span>Good things take time.</span><span>I will share scores as soon as there is sufficient data.</span></div>');
                        }
                    } else {
                        $('#trend-graph').html('<div class="no-score"><span>Good things take time.</span><span>I will share scores as soon as there is sufficient data.</span></div>');
                    }
                });
            });

            function enterComment(e, textarea){
                if(e.which === 13) { 
                    e.preventDefault();
                    $('#updateComments').click();
                }
            }
        </script>
    </body>
</html>