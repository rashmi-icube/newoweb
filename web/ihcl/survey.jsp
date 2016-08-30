<%@page import="java.util.ArrayList"%>
<%@page import="java.util.TreeMap"%>
<%@page import="org.icube.owen.filter.FilterList"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.icube.owen.survey.Question"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.survey.QuestionType"%>
<%@page import="java.util.List"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.owen.web.Util"%>

<%
    String moduleName = "survey";
    String subModuleName = "ihcl";
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>OWEN - Survey</title>
        <link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/individual.css">

        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/animate.css/3.2.0/animate.min.css">

        <link rel="apple-touch-icon" sizes="57x57" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="72x72" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="114x114" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="120x120" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="144x144" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="152x152" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-152x152.png">
        <link rel="apple-touch-icon" sizes="180x180" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-180x180.png">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/android-icon-192x192.png" sizes="192x192">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/favicon-16x16.png" sizes="16x16">
        <link rel="manifest" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/manifest.json">
        <meta name="msapplication-TileColor" content="#da532c">
        <meta name="msapplication-TileImage" content="<%=Constant.WEB_ASSETS%>images/favicon_Individual/ms-icon-144x144.png">

        <!-- Chrome, Firefox OS and Opera -->
        <meta name="theme-color" content="#388E3C">
        <!-- Windows Phone -->
        <meta name="msapplication-navbutton-color" content="#388E3C">
        <!-- iOS Safari -->
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
        <meta name="apple-mobile-web-app-title" content="OWEN">       
        <script language="JAVASCRIPT">
<!--//
var expdate = new Date ();
expdate.setTime (expdate.getTime() + (24 * 60 * 60 * 1000*365)); // 1 yr from now 

/* ####################### start set cookie  ####################### */

function setCookie(name, value, expires, path, domain, secure) {  var thisCookie = name + "=" + escape(value) +
((expires) ? "; expires=" + expires.toGMTString() : "") +
((path) ? "; path=" + path : "") +
((domain) ? "; domain=" + domain : "") +
((secure) ? "; secure" : "");
document.cookie = thisCookie;
}
/* ####################### start show cookie ####################### */

function showCookie(){

alert(unescape(document.cookie));
}
/* ####################### start get cookie value ####################### */

function getCookieVal (offset) {
var endstr = document.cookie.indexOf (";", offset);
if (endstr == -1)
endstr = document.cookie.length;
return unescape(document.cookie.substring(offset, endstr));
/* ####################### end get cookie value ####################### */

}
/* ####################### start get cookie (name) ####################### */

function GetCookie (name) {
var arg = name + "=";
var alen = arg.length;
var clen = document.cookie.length;
var i = 0;
while (i < clen) {
var j = i + alen;
if (document.cookie.substring(i, j) == arg)
return getCookieVal (j);
i = document.cookie.indexOf(" ", i) + 1;
if (i == 0) break; 
}
return null;
}
/* ####################### end get cookie (name) ####################### */

/* ####################### start delete cookie ####################### */
function DeleteCookie (name,path,domain) {
if (GetCookie(name)) {
document.cookie = name + "=" +
((path) ? "; path=" + path : "") +
((domain) ? "; domain=" + domain : "") +
"; expires=Thu, 01-Jan-70 00:00:01 GMT";
}
}
/* ####################### end of delete cookie ####################### */

//-->
        </script>
        
        <script language="javascript">
            function CookieCheck(){
                var username = GetCookie("employeeID");
                if ((!username)||(username==='null')){
                    window.location.replace("login.jsp");
                }
            }
        </script>
    </head>

    <body>
        <input type="hidden" id="moduleName" value="<%= moduleName%>" />
        <input type="hidden" id="subModuleName" value="<%= subModuleName%>" />

        <div class="swiper-container">
            <script language="javascript">
                CookieCheck();
            </script>
            <%@include file="header.jsp" %>
            <%                Question question = (Question) ObjectFactory.getInstance("org.icube.owen.survey.Question");
                try {
                    List<Question> qList = question.getEmployeeQuestionList(comid, empid);
                    //List<Question> qList = new ArrayList<Question>();
                    System.out.println("LIST: " + qList);
                    JSONArray questionList = new JSONArray(qList);
                    System.out.println("JSONObject " + questionList);
                    String jArray = questionList.toString();
                    int len = qList.size();
                    //len = 0;
                    if (len == 0) {
                        response.sendRedirect("thankyou.jsp");%>
            <div class="no-survey">Nothing to do here, now. I will be back with more questions for you soon.</div>
            <!--            <div class="site-nav survey">
                            <a class="site-nav-dash1" href="/ihcl/thankyou.jsp" title="Go to Thank You" >&#x276F;</a>
                        </div>-->
            <% } else if (len == 1) { %>
            <!--            <div class="site-nav survey">
                            <a class="site-nav-dash1" href="/ihcl/thankyou.jsp" title="Go to Thank You" >&#x276F;</a>
                        </div>-->
            <% } else if (len > 1) { %>        
            <!--            <div class="site-nav survey">
                            <a class="site-nav-prev" href="#" title="Prev" onclick="this.disabled = true;">&#x276F;</a>
                            <a class="site-nav-next" href="#" title="Next" onclick="this.disabled = true;">&#x276F;</a>
                            <a class="site-nav-dash" href="/ihcl/thankyou.jsp" title="Go to Thank You" style="display:none;">&#x276F;</a>
                        </div>-->
            <% }%>
            <div class="black_overlay"></div>
            <div class="swiper-pagination"></div>
            <div class="swiper-button-next">&#x276F;</div>
            <div class="swiper-button-prev">&#x276F;</div>
            <div class="progress-fraction">
                <p id="progress-value">
                    <span>
                    </span>
                </p>
            </div>
            <div class="wrapper swiper-wrapper">
                <input type="hidden" id="ques_list" value='<%= jArray%>'/>
                <input type="hidden" id="total_ques" value="<%= len%>" />
                <input type="hidden" id="remaining_ques" value="<%= len%>" />
                <%
                    int i = 0;
                    for (i = 0; i < len; i++) {
                        Question ques = qList.get(i);
                        QuestionType quesType = ques.getQuestionType();
                        if (quesType == QuestionType.ME) {
                %>
                <input type="hidden" id="comp_id_<%=ques.getQuestionId()%>" value="<% out.print(comid);%>" />
                <input type="hidden" id="emp_id_<%= ques.getQuestionId()%>" value="<% out.print(empid);%>" />
                <input type="hidden" id="question_id_<%= ques.getQuestionId()%>" value="<% out.print(ques.getQuestionId());%>" />
                <input type="hidden" id="resp_val_<%= ques.getQuestionId()%>" value="" />
                <input type="hidden" id="rela_val_<%= ques.getQuestionId()%>" value="<%= ques.getRelationshipTypeId()%>" />

                <%
                    if (len == 1 || i == 0) {
                %>
                <div class="swiper-slide">
                    <div class="wrapper survey-me question_div app" style="display:block;">
                        <%
                        } else {
                        %>
                        <div class="swiper-slide">
                            <div class="wrapper survey-me question_div app">
                                <%
                                    }
                                %>
                                <input type="hidden" class="question_no" value="<%= i%>" />
                                <div class="me-survey-box clearfix">
                                    <!--<h2></h2>-->
                                    <span class="question-title"><% out.print(ques.getQuestionText()); %></span>

                                    <div class="answer-box">
                                        <div class="agree-limit clearfix">
                                            <span>Strongly disagree</span>
                                            <span>Strongly agree</span>
                                        </div>

                                        <div class="answer-range" ques_id="<% out.print(ques.getQuestionId()); %>">
                                            <div><button value="1">1</button></div>
                                            <div><button value="2">2</button></div>
                                            <div><button value="3">3</button></div>
                                            <div><button value="4">4</button></div>
                                            <div><button value="5">5</button></div>
                                        </div>

                                        <div class="feedback-comment" style="display: none;">
                                            <input type="text" id="feedback_<% out.print(ques.getQuestionId()); %>" name="feedback-comment" placeholder="Enter your feedback here">
                                        </div>
                                    </div>
                                    <div style="clear: both;"></div>
                                    <!--<div class="submit-circle clearfix">
                                            <button onclick="this.disabled = true;this.form.submit();" value="<% out.print(ques.getQuestionId()); %>">&#x2714;</button>
                                            <div class="submit-tooltip">
                                                <span class="submit-title"><span>SUBMIT</span> this response</span>
                                                <span class="submit-response">Please select a response</span>
                                            </div>
                                        </div>-->

                                    <!--                                    <div class="submit-popup">
                                                                            <h2>Submit your responses ?</h2>
                                                                            <div class="submit-popup-warning-text">
                                                                                <p>You have unanswered questions
                                                                                    <span>Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8</span>
                                                                                </p>
                                                                                <p>You will not be able to take the survey again or change your responses, if you submit your responses now.</p>
                                                                            </div>
                                                                            <div class="submit-popup-buttons">
                                                                                <button>YES</button>
                                                                                <button>NO</button>
                                                                            </div>
                                                                        </div>-->
                                </div>
                            </div>
                        </div>
                        <%
                        } else if (quesType == QuestionType.WE) {
//} else if (false) {
                            if (len == 1 || i == 0) {
                        %>
                        <div class="swiper-slide">
                            <div class="wrapper survey-we question_div app" style="display:block;">
                                <%
                                } else {
                                %>
                                <div class="swiper-slide">
                                    <div class="wrapper survey-we question_div app">
                                        <%
                                            }
                                        %>
                                        <input type="hidden" class="question_no" value="<%= i%>" />
                                        <input type="hidden" id="rela_val_<%= ques.getQuestionId()%>" value="<%= ques.getRelationshipTypeId()%>" />
                                        <!--<h2></h2>-->
                                        <h3><%= ques.getQuestionText()%></h3>
                                        <div class="people-list-box clearfix">
                                            <p style = "font: 14px Open Sans Regular, Open Sans; color: #333; padding-bottom: 10px;"><b>Tip: </b> Indicate frequency of collaboration/level of appreciation  by the number of stars</p>

                                            <input class="search-colleague" type="search" placeholder=" &#x1F50D; Search for a colleague you would like to appreciate" ques_id="<%= ques.getQuestionId()%>">
                                            <button>&#x1F50D;</button>
                                            <div class="mobile-filter-row">
                                                <div>
                                                    <div class="header">
                                                        <button id="closeFilter"><img src="<%=Constant.WEB_ASSETS%>images/button_filter_back.png" alt="Back button"></button>
                                                        <span>Filter</span>
                                                        <div>
                                                            <button id="getMobileSmartList" onclick="fetchSmartData(<%= ques.getQuestionId()%>);">Smart</button>
                                                            <button id="chooseMobileFilter"><img src="<%=Constant.WEB_ASSETS%>images/button_filter__icon_tick.png" alt="Smart List"></button> 
                                                        </div>
                                                    </div>
                                                    <div class="filter-menu" ques_id="<%= ques.getQuestionId()%>">
                                                        <ul>
                                                            <li>
                                                                <span>Geography</span>
                                                                <ul>
                                                                    <%
                                                                        FilterList fl = new FilterList();
                                                                        Filter geoFilter = fl.getFilterValues(comid, Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                                                                        Map<Integer, String> geoitem = geoFilter.getFilterValues();
                                                                        for (Map.Entry<Integer, String> entry : geoitem.entrySet()) {%>
                                                                    <li>
                                                                        <input type="radio" id="filterGeography_<%=entry.getKey()%>" name="filter-geography" filter_type="Geography" data_id="<%=entry.getKey()%>"  filter_type_id="<%=geoFilter.getFilterId()%>">
                                                                        <label for="filterGeography_<%=entry.getKey()%>"><%=entry.getValue()%></label>
                                                                    </li>    
                                                                    <% } %>
                                                                </ul>
                                                            </li>
                                                            <li>
                                                                <span>Function</span>
                                                                <ul>
                                                                    <%
                                                                        Filter funFilter = fl.getFilterValues(comid, Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                                                                        Map<Integer, String> funitem = funFilter.getFilterValues();
                                                                        for (Map.Entry<Integer, String> entry : funitem.entrySet()) {%>
                                                                    <li>
                                                                        <input type="radio" id="filterFunction_<%=entry.getKey()%>" name="filter-function" filter_type="Function" data_id="<%=entry.getKey()%>"  filter_type_id="<%=funFilter.getFilterId()%>">
                                                                        <label for="filterFunction_<%=entry.getKey()%>"><%=entry.getValue()%></label>
                                                                    </li>
                                                                    <% } %>
                                                                </ul>
                                                            </li>
                                                            <li>
                                                                <span>Level</span>
                                                                <ul>
                                                                    <%
                                                                        Filter levelFilter = fl.getFilterValues(comid, Constant.INITIATIVES_LEVEL_FILTER_NAME);
                                                                        Map<Integer, String> levelitem = levelFilter.getFilterValues();
                                                                        for (Map.Entry<Integer, String> entry : levelitem.entrySet()) {%>
                                                                    <li>
                                                                        <input type="radio" id="filterLevel_<%=entry.getKey()%>" name="filter-level" filter_type="Level" data_id="<%=entry.getKey()%>"  filter_type_id="<%=levelFilter.getFilterId()%>">
                                                                        <label for="filterLevel_<%=entry.getKey()%>"><%=entry.getValue()%></label>
                                                                    </li>
                                                                    <% }%>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="no-key-selected-mobile" id="count-mobile-<%= ques.getQuestionId()%>">
                                                <p>View appreciated: </p>
                                                <span></span>
                                                <p style="margin-left: 20px;">&#x276F;</p>
                                                <div style="display: none;">
                                                    <div class="header">
                                                        <button id="closeFilter"><img src="<%=Constant.WEB_ASSETS%>images/button_filter_back.png" alt="Back button"></button>
                                                        <span>You have appreciated</span>
                                                    </div>
                                                    <div class="list-of-selected-people-popup-mobile clearfix" id="list-mobile-<%= ques.getQuestionId()%>">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="filter-row">
                                                <div class="get-filter-list">
                                                    <button id="getFilteredList">Filter &#x25BE;</button>
                                                    <div class="filter-menu" ques_id="<%= ques.getQuestionId()%>">
                                                        <ul>
                                                            <li>
                                                                <span>Geography <span>&#x203A;</span></span>
                                                                <ul><%
                                                                    for (Map.Entry<Integer, String> entry : geoitem.entrySet()) {%>
                                                                    <li><span>&#x2714;</span> <span class="filter-choice-name" filter_type="Geography" data_id="<%=entry.getKey()%>"  filter_type_id="<%=geoFilter.getFilterId()%>"><%=entry.getValue()%></span></li>
                                                                        <% } %>
                                                                </ul>
                                                            </li>
                                                            <li>
                                                                <span>Function <span>&#x203A;</span></span>
                                                                <ul>
                                                                    <%
                                                                        for (Map.Entry<Integer, String> entry : funitem.entrySet()) {%>
                                                                    <li><span>&#x2714;</span> <span class="filter-choice-name" filter_type="Function" data_id="<%=entry.getKey()%>"  filter_type_id="<%=funFilter.getFilterId()%>"><%=entry.getValue()%></span></li>   
                                                                        <% } %>
                                                                </ul>
                                                            </li>
                                                            <li>
                                                                <span>Level <span>&#x203A;</span></span>
                                                                <ul>
                                                                    <%
                                                                        for (Map.Entry<Integer, String> entry : levelitem.entrySet()) {%>
                                                                    <li><span>&#x2714;</span> <span class="filter-choice-name" filter_type="Level" data_id="<%=entry.getKey()%>"  filter_type_id="<%=levelFilter.getFilterId()%>"><%=entry.getValue()%></span></li>   
                                                                        <% }%>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <button id="getSmartList" onclick="fetchSmartData(<%= ques.getQuestionId()%>);">Smart</button>
                                                <input type="hidden" id="relation_<%= ques.getQuestionId()%>" value="<%= ques.getRelationshipTypeId()%>" />
                                                <div class="three-filters-group" id="three-filters-group-<%= ques.getQuestionId()%>">
                                                    <span></span>
                                                    <span></span>
                                                    <span></span>
                                                </div>
                                            </div>
                                            <div id="we_grid_<%= ques.getQuestionId()%>" class="individuals-box">     
                                                <div class="overlay_form"><img src="/assets/images/ajax-loader.gif"></div>

                                                <div class="individuals-grid" id="scroll-for-individuals-grid">
                                                    <%
                                                        List<Employee> mapSmartList = ques.getSmartListForQuestion(comid, empid, ques);
                                                        System.out.println("MAP LIST:" + mapSmartList);
                                                        for (int incr = 0; incr < mapSmartList.size(); incr++) {
                                                            Employee employee = mapSmartList.get(incr);
                                                            if (empid == employee.getEmployeeId()) {
                                                                continue;
                                                            }
                                                            //employee.g
                                                    %>
                                                    <div class="individual-cell clearfix">
                                                        <button class="get-person-info">
                                                            <span>i</span>
                                                        </button>
                                                        <div class="individual-card">
                                                            <div class="front-card">
                                                                <div style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=employee.getCompanyId()%>&eid=<%=employee.getEmployeeId()%>');" class="person-pic"></div>
                                                            </div>
                                                            <div class="back-card">
                                                                <ul>
                                                                    <li><%=employee.getZone()%></li>
                                                                    <li><%=employee.getFunction()%></li>
                                                                    <li><%=employee.getPosition()%></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <span class="individual-cell-name"><%= employee.getFirstName() + " " + employee.getLastName()%></span>
                                                        <div class="star-rating-row clearfix">
                                                            <div class="rating-stars">
                                                                <input type="hidden" id="quesId" value="<%= ques.getQuestionId()%>" />
                                                                <span class="rating-star"></span>
                                                                <span class="rating-star"></span>
                                                                <span class="rating-star"></span>
                                                                <span class="rating-star"></span>
                                                                <span class="rating-star"></span>
                                                            </div>
                                                            <span class="star-rating-total" emp_id="<%= employee.getEmployeeId()%>" ques_id="<%= ques.getQuestionId()%>" id="rat_<%= ques.getQuestionId() + "_" + employee.getEmployeeId()%>"></span>
                                                        </div>
                                                    </div>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                            </div>
                                            <div class="no-key-selected" id="count-desktop-<%= ques.getQuestionId()%>">
                                                <p>Selected: </p>
                                                <span></span>
                                                <div class="list-of-people-selected" id="list-desktop-<%= ques.getQuestionId()%>">
                                                </div>
                                            </div>
                                            <!--<div class="submit-circle clearfix">
                                                    <button value="<%= ques.getQuestionId()%>">&#x2714;</button>
                                                    <div class="submit-tooltip">
                                                        <span class="submit-title"><span>SUBMIT</span> this response</span>
                                                        <span class="submit-response">Please select a response</span>
                                                    </div>
                                                </div>-->

                                            <!--                                            <div class="submit-popup">
                                                                                            <h2>Submit your responses ?</h2>
                                                                                            <div class="submit-popup-warning-text">
                                                                                                <p>You have unanswered questions
                                                                                                    <span>Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8</span>
                                                                                                </p>
                                                                                                <p>You will not be able to take the survey again or change your responses, if you submit your responses now.</p>
                                                                                            </div>
                                                                                            <div class="submit-popup-buttons">
                                                                                                <button>YES</button>
                                                                                                <button>NO</button>
                                                                                            </div>
                                                                                        </div>-->
                                        </div>
                                    </div>
                                </div>
                                <%
                                } else { %>
                                <input type="hidden" id="comp_id_<%=ques.getQuestionId()%>" value="<% out.print(comid);%>" />
                                <input type="hidden" id="emp_id_<%= ques.getQuestionId()%>" value="<% out.print(empid);%>" />
                                <input type="hidden" id="question_id_<%= ques.getQuestionId()%>" value="<% out.print(ques.getQuestionId());%>" />
                                <input type="hidden" id="resp_val_<%= ques.getQuestionId()%>" value="" />
                                <input type="hidden" id="rela_val_<%= ques.getQuestionId()%>" value="<%= ques.getRelationshipTypeId()%>" />

                                <% if (len == 1 || i == 0) {
                                %>

                                <div class="swiper-slide">
                                    <div class="wrapper survey-me question_div app" style="display:block;">
                                        <%} else {%>
                                        <div class="swiper-slide">
                                            <div class="wrapper survey-me question_div app">
                                                <%}%>
                                                <input type="hidden" class="question_no" value="<%= i%>" />
                                                <div class="me-survey-box clearfix">
                                                    <!--<h2></h2>-->
                                                    <span class="question-title"><% out.print(ques.getQuestionText()); %></span>
                                                    <div class="answer-box">
                                                        <!--<div class="agree-limit clearfix">
                                                                <span>Strongly disagree</span>
                                                                <span>Strongly agree</span>
                                                            </div>-->

                                                        <div class="mood-range" ques_id="<% out.print(ques.getQuestionId()); %>">
                                                            <div><button value="1">&#128546</button></div>
                                                            <div><button value="2">&#128543</button></div>
                                                            <div><button value="3">&#128528</button></div>
                                                            <div><button value="4">&#128522</button></div>
                                                            <div><button value="5">&#128515</button></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <%
                                                    }
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        %>
                                    </div>
                                </div>                          
                            </div>
                        </div>
                    </div>
                </div>
                <div class="submit-circle app">
                    <button>&#x2714;</button>
                    <div class="submit-tooltip">
                        <span class="submit-title"><span>SUBMIT</span> this response</span>
                        <span class="submit-response">Please select a response</span>
                    </div>
                </div>
                <div class="submit-popup">
                    <h2>Submit your responses ?</h2>
                    <div class="submit-popup-warning-text"></div>
                    <div class="submit-popup-buttons">
                        <button id="yesButton">YES</button>
                        <button>NO</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="<%=Constant.WEB_ASSETS%>js/animatedModal.min.js"></script>            

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

        <script src="<%=Constant.WEB_ASSETS%>js/jquery-ui.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/isotope.pkgd.min.js"></script>
        <!--<script src="<%=Constant.WEB_ASSETS%>js/jquery.slimscroll.min.js"></script>-->
        <script src="<%=Constant.WEB_ASSETS%>js/jquery.slimscrollPopup.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/jquery.slimscroll.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/survey-individual.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/js/swiper.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/js/swiper.jquery.min.js"></script>
    </body>
</html>