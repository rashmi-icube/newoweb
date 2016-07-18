<%-- 
    Document   : survey
    Created on : Feb 12, 2016, 5:44:46 PM
    Author     : fermion10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.survey.QuestionList"%>
<%@page import="org.icube.owen.survey.Question"%>
<%@page import="org.icube.owen.survey.Batch"%>
<%@page import="org.icube.owen.survey.BatchList"%>
<%@page import="org.icube.owen.survey.Frequency"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%
    String moduleName = "survey";
    String subModuleName = "";
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>OWEN - Survey</title>
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
                    <%
                        BatchList bListObj = (BatchList) ObjectFactory.getInstance("org.icube.owen.survey.BatchList");
                        Batch currBatch = null;
                        try {
                            currBatch = bListObj.getCurrentBatch(comid);
                        } catch(Exception ex) {}
                        Question currQObj  = null;
                        if(currBatch != null) { %>
                        <div class="current-question">
                            <div class="current-question-box">
                                <h2>Current Question</h2>
                            </div>
                            <%
                                Question qObj =  (Question) ObjectFactory.getInstance("org.icube.owen.survey.Question");
                                currQObj = qObj.getCurrentQuestion(comid,currBatch.getBatchId());
                                if(currQObj != null) {
                                Map<Date, Integer> treeMap = new TreeMap<Date, Integer>(currQObj.getResponse(comid,currQObj));
                            %>
                            
                            <script>
                                var currentQArray = [
                                    <% for (Map.Entry<Date, Integer> entry : treeMap.entrySet()) { %> {
                                        "category": "<%=Util.getDisplayDateFormat(entry.getKey(),"yyyy-MM-dd")%>",
                                        "column-1": "<%=entry.getValue()%>"
                                    },
                                    <% } %>
                                ];
                            </script>
                        <div class="current-question-details">
                            <div class="collapse-view-question">
                                <div class="view-question">
                                    <% if(currQObj.getQuestionText() != null) { %>
                                        <span><%=currQObj.getQuestionText() %></span>
                                    <% } else { %>
                                        <span class="no-current-ques">You have no questions running at the moment.</span>
                                    <% } %>
                                </div>

                                <div class="collapse-question">
                                    <span><%=currQObj.getQuestionText() %></span>
                                    <div id="chartdiv" style="width: 100%; height: 170px; background-color: #fff;" ></div>
                                </div>
                            </div>

                            <div class="question-date-response">
                                <span>End Date: <%=Util.getDisplayDateFormat(currQObj.getEndDate(), "dd MMM") %></span>
                                <span>Response Rate: <%=currQObj.getResponsePercentage() %>%</span>
                                <a title="View responses" onClick="generateGraph('chartdiv', currentQArray, this)">View responses</a>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    
                    <div class="question-frequency">
                        <h3>Frequency</h3>
                        <div class="frequency-save">
                            <select name="questionFrequency" id="questionFrequency" title="Select a frequency for the upcoming questions" >
                                <%
                                   Frequency[] frq =  Frequency.values();
                                   Frequency currfrq = currBatch.getBatchFrequency();
                                   for(int j=0; j < frq.length; j++) { %>
                                        <option value="<%=frq[j].getValue()%>" <%=currfrq.getValue() == frq[j].getValue() ?"selected" :"" %>><%=frq[j].name()%></option>
                                   <% }
                                %>
                            </select>
                            <button type="button" onClick="updateFrequency()">Save</button>
                        </div>
                    </div>
                     <% } %>
                    <div class="completed-questions">
                        <div class="completed-questions-header">
                            <h3>&#x25BC; <span>Completed Questions</h3>
                            <div class="completed-questions-menu">
                                <h3>&#x25BC; <span>Completed Questions</span></h3>
                                <ul>
                                    <li class="selected" onClick="getList('Completed')"><span>&#x2714;</span> Completed questions</li>
                                    <li onClick="getList('Upcoming')"><span>&#x2714;</span> Upcoming questions</li>
                                </ul>
                            </div>

                            <div class="search-popup">
                                <button>&#x1F50D;</button>						
                                <input type="search" placeholder="Search" class="search-question">
                            </div>
                        </div>

                        <table class="completed-table" cellspacing="0" cellpadding="0" id="qtableCompleted">
                            <%
                            QuestionList qListObj = (QuestionList) ObjectFactory.getInstance("org.icube.owen.survey.QuestionList");
                            List<Question> qlist = qListObj.getQuestionListByStatus(comid,Constant.QUESTION_WEEKLY_ID, "Completed");
                            for(int i=0; i<qlist.size(); i++) { %>
                               <tr class="question-name-date">
                                <td><%=(i+1)%></td>
                                <td class="question-name"><%=qlist.get(i).getQuestionText()%></td>
                                <td><%=Util.getDisplayDateFormat(qlist.get(i).getEndDate(), "dd MMM") %></td>
                                <td><%=qlist.get(i).getResponsePercentage() %>%</td>
                                <td>
                                    <%
                                        Map<Date, Integer> treeMap1 = new TreeMap<Date, Integer>(qlist.get(i).getResponse(comid,qlist.get(i)));
                                    %>
                                    <script>
                                        var QRArray<%=i%> = [
                                            <%
                                                for (Map.Entry<Date, Integer> entry : treeMap1.entrySet()) {
                                                 %>{
                                                    "category": "<%=Util.getDisplayDateFormat(entry.getKey(),"yyyy-MM-dd")%>",
                                                    "column-1": "<%=entry.getValue()%>"
                                                 },
                                                <%}
                                            %>
                                        ];
                                    </script>
                                    <a title="View responses" onClick="generateGraph('chartTable<%=i%>', QRArray<%=i%>, this)">View responses</a>
                                </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        <div id="chartTable<%=i%>" style="width: 100%; height: 170px; background-color: #fff;" ></div>
                                    </td>
                                </tr>
                            <%} %>
                        </table>
                        <table class="upcoming-table" cellspacing="0" cellpadding="0" id="qtableUpcoming">
                        </table>
                    </div>
                </div>
            </div>            
        </div>    
        
        <script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/jquery-ui.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/amcharts/amcharts.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/amcharts/serial.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/amcharts/themes/light.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/survey.js"></script>
        
        <script>
            function updateFrequency() {
                var frequency = $('#questionFrequency').val();
                var postStr = 'frequency='+frequency;
                var status = 'Upcoming';
                $('.overlay_form').show();
                $.ajax({
                    url: '<%=Constant.WEB_CONTEXT%>/survey/getSurvey.jsp',
                    type: 'POST',
                    data: postStr,
                    dataType: 'html',
                    success: function (resp) {
                        $('.overlay_form').hide();
                        if(status == 'Upcoming') {
                            $('#qtableUpcoming').html(resp);
                            $('#qtableCompleted').hide();
                            $('#qtableUpcoming').show();
                            $('.completed-questions-header h3 span').text('Upcoming questions');
                            $('.completed-questions-menu li').removeClass('selected');
                            $('.completed-questions-menu li:nth-child(2)').addClass('selected');
                        }
                    }
                });
            }
            
            function emptySurvey() {
                if($('.completed-table tr').length === 0) {
                    var text = '<tr><td class="no-ques"><div>'+
                        '<span>Uh oh!! It\'s empty in here.</span>'+
                        '<span>Ask your team to take a quick survey first ?</span>'+
                        '</div></td></tr>';
                    $('.completed-table').html(text);
                }
            }
            
            emptySurvey();

            function getList(status) {
                var batchid = $('#questionFrequency').val();
                var postStr = "status=" + status;
                $('.overlay_form').show();
                $.ajax({
                    url: '<%=Constant.WEB_CONTEXT%>/survey/getSurvey.jsp',
                    type: 'POST',
                    data: postStr,
                    dataType: 'html',
                    success: function (resp) {
                        $('.overlay_form').hide();
                        if(status == "Completed") {
                            $('#qtableCompleted').html(resp);
                            $('#qtableUpcoming').hide();
                            $('#qtableCompleted').show();
                            emptySurvey();
                        } else {
                            $('#qtableUpcoming').html(resp);
                            $('#qtableUpcoming').show();
                            $('#qtableCompleted').hide();
                        }
                    }
                });
            }
       </script>  
    </body>       
</html>