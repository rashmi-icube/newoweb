<%-- 
    Document   : explorequestion
    Created on : 3 Aug, 2016, 11:23:24 AM
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
<%@page import="org.icube.owen.survey.MeResponse"%>
<%@page import="org.icube.owen.survey.Question"%>

<%
    String moduleName = "explore";
    String subModuleName = "explorequestion";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OWEN - Explore Question</title>
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
                    <!--<div class="explore-box">-->
                    <div class="metrics-section" style="margin: 20px auto 20px;">
                        <div class="metrics-header">
                            <h3>Team Selection</h3>
                            <button type="button" style="float: none; font: 14px 'Open Sans Regular', 'Open Sans'; vertical-align: -2px; margin-left: 70px; color: white;"  onMouseOver="this.style.color = '#169bd5'" onMouseOut="this.style.color = '#FFFFFF'">Reset</button>
                            <button type="button" id="collapse-metrics" onMouseOver="this.style.color = '#169bd5'" onMouseOut="this.style.color = '#1e1e1e'">Expand</button>
                        </div>
                        <div class="create-metrics-list" style="padding: 0;">
                            <div class="initiative-which-people" style="height: 180px;">
                                <div class="initiative-which">
                                    <%  FilterList fl = new FilterList(); %>
                                    <div class="initiative-choice-team">
                                        <div class="initiative-choice-select">
                                            <span>1.</span>
                                            <label for="teamGeography">Select a geography</label>
                                            <select name="teamGeography" id="teamGeography" size="5" required="" oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                                <% Filter filter = fl.getFilterValues(comid, Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                                                    Map<Integer, String> geoitem = filter.getFilterValues();
                                                    for (Map.Entry<Integer, String> entry : geoitem.entrySet()) {%>
                                                <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                <% } %>
                                                ]        </select>
                                            <div class="select-overlay" style="display: none;"></div>
                                        </div>
                                        <div class="initiative-choice-select">
                                            <span>2.</span>
                                            <label for="teamFunction">Select a function</label>
                                            <select name="teamFunction" id="teamFunction" size="5" required="" oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                                <%  filter = fl.getFilterValues(comid, Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                                                    Map<Integer, String> funitem = filter.getFilterValues();
                                                    for (Map.Entry<Integer, String> entry : funitem.entrySet()) {%>
                                                <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                <% } %>
                                            </select>
                                            <div class="select-overlay" style="display: none;"></div>
                                        </div>
                                        <div class="initiative-choice-select">
                                            <span>3.</span>
                                            <label for="teamLevel">Select a level</label>
                                            <select name="teamLevel" id="teamLevel" size="5" required="" oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                                <%  filter = fl.getFilterValues(comid, Constant.INITIATIVES_LEVEL_FILTER_NAME);
                                                    Map<Integer, String> levelitem = filter.getFilterValues();
                                                    for (Map.Entry<Integer, String> entry : levelitem.entrySet()) {%>
                                                <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                <% } %>
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
                    <div class="my-initatives">
                        <div class="my-initatives-header clearfix">
                            <h2>Explore - Questions</h2>
                        </div>
                        <%
                            ExploreHelper eHelperObj = (ExploreHelper) ObjectFactory.getInstance("org.icube.owen.explore.ExploreHelper");
                            Map<Integer, String> relMap = eHelperObj.getMeQuestionRelationshipTypeMap(comid);
                            int defaultMetricsId = 5;
                        %>

                        <ul class="switched"> 
                            <% for (Map.Entry<Integer, String> entry : relMap.entrySet()) {

                            %>
                            <li style="height: 193px">
                                <span><%=Util.getQuestionTypeLabel(entry.getValue())%></span>
                                <div class="panel-pic" style="width: 78px; height: 78px;">																
                                    <img src="<%=Constant.WEB_ASSETS%>images/<%=Util.getQuestionTypeImage(entry.getValue())%>" width="79" alt="<%=Util.getQuestionTypeLabel(entry.getValue())%>">
                                </div>
                                <div class="current-completed clearfix">
                                    <p style="width: 80%; ">
                                        <span style="display: inline-block; padding-top: 4px;"><%=Util.getQuestionTypeText(entry.getValue())%></span>
                                    </p>
                                    <button data-id="<%=entry.getKey()%>" class="panel-select-metric <%= defaultMetricsId == 5 ? "selected" : ""%>" title="Select <%=Util.getQuestionTypeLabel(entry.getValue())%>" style="position: absolute; right: 5%; bottom: 5%;">&#x2714;</button>
                                </div>
                            </li>
                            <% if (defaultMetricsId == 5) {
                                        defaultMetricsId = entry.getKey();
                                    }
                                }%> 
                        </ul>
                    </div>
                    <!-- TODO export -->
                    <!--                    <div class="explore-by-question">
                                            <div class="explore-by-question-header">
                                                <h3><span>Questions</span></h3>
                                                <div class="search-popup">
                                                    <button>🔍</button>						
                                                    <input type="search" placeholder="Search" class="search-question">
                                                </div>
                                                <div class="visual-actions" style='top: 0; right: 0;'>
                                                    <div>
                                                        <button type="button" id="export-explore-by-questions" style='margin: 0;'><img src="/assets/images/export_icon.png" width="21" title="Export As"></button>
                                                        <div class="action-export-menu" style="display: none; height:52px;">
                                                            <span>Export as</span>
                                                            <ul>
                                                                <li><a href="#" download='Questions1_8.csv'>CSV</a></li>
                                                            </ul>
                                                        </div>	
                                                    </div>
                                                </div>
                                            </div>-->
                    <table class="explore-by-question-table">
                        <%
                            Map<Integer, Map<Question, MeResponse>> qList = eHelperObj.getCompletedMeQuestionList(comid, defaultMetricsId);
                        %>
                        <tbody>

                            <% for (int quesId : qList.keySet()) {
                                    Map<Question, MeResponse> result = qList.get(quesId);
                                    for (Question q : result.keySet()) {
                                        MeResponse mr = result.get(q);
                            %>

                            <tr class="question-name-date">
                                <td><%=quesId%></td>
                                <td class="question-name"><%=q.getQuestionText()%></td>
                                <td><%=Util.getDisplayDateFormat(q.getEndDate(), "dd MMM")%></td>
                                <td><%=q.getResponsePercentage()%></td>
                                <td>
                                    <div id="inline-chart-<%=quesId%>" style="width: 180px; height: 20px; background-color: #fff; display: block;">
                                        <input type="hidden" id="stronglyagree" value=<%=mr.getStronglyAgree()%>/>
                                        <input type="hidden" id="agree" value=<%=mr.getAgree()%>/>
                                        <input type="hidden" id="neutral" value=<%=mr.getNeutral()%>/>
                                        <input type="hidden" id="disagree" value=<%=mr.getDisagree()%>/>
                                        <input type="hidden" id="stronglydisagree" value=<%=mr.getStronglyDisagree()%>/>
                                    </div>
                                </td>
                                <td>
                                    <a title="View details">View details</a>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="6" style="width: 100%; background: #ffffff;">
                                    <div id="collapsible-chart-<%=quesId%>" style="margin: 0 auto; max-width: 90%; height: 170px; background-color: #fff; ">
                                        <input type="hidden" id="stronglyagree" value=<%=mr.getStronglyAgree()%>/>
                                        <input type="hidden" id="agree" value=<%=mr.getAgree()%>/>
                                        <input type="hidden" id="neutral" value=<%=mr.getNeutral()%>/>
                                        <input type="hidden" id="disagree" value=<%=mr.getDisagree()%>/>
                                        <input type="hidden" id="stronglydisagree" value=<%=mr.getStronglyDisagree()%>/>
                                    </div>
                                </td>
                            </tr>
                            <%}
                                    }%>
                            <!--                                <tr class="question-name-date">
                                                                <td>2</td>
                                                                <td class="question-name">I feel sufficiently recognized for the work I do</td>
                                                                <td>21 July</td>
                                                                <td>72%</td>
                                                                <td>
                                                                    <div id="chartdiv3" style="width: 180px; height: 20px; background-color: #fff; display: block;">
                                                                        <input type="hidden" id="stronglyagree" value="14"/>
                                                                        <input type="hidden" id="agree" value="20"/>
                                                                        <input type="hidden" id="neutral" value="36"/>
                                                                        <input type="hidden" id="disagree" value="20"/>
                                                                        <input type="hidden" id="stronglydisagree" value="10"/>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <a title="View details">View details</a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="6" style="width: 100%; background: #ffffff;">
                                                                    <div id="chartdiv4" style="margin: 0 auto; max-width: 90%; height: 170px; background-color: #fff; ">
                                                                        <input type="hidden" id="stronglyagree" value="14"/>
                                                                        <input type="hidden" id="agree" value="20"/>
                                                                        <input type="hidden" id="neutral" value="36"/>
                                                                        <input type="hidden" id="disagree" value="20"/>
                                                                        <input type="hidden" id="stronglydisagree" value="10"/>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr class="question-name-date">
                                                                <td>3</td>
                                                                <td class="question-name">I have sufficient opportunities for training and development to upgrade my skills</td>
                                                                <td>14 July</td>
                                                                <td>82%</td>
                                                                <td>
                                                                    <div id="chartdiv5" style="width: 180px; height: 20px; background-color: #fff; display: block;">
                                                                        <input type="hidden" id="stronglyagree" value="20"/>
                                                                        <input type="hidden" id="agree" value="20"/>
                                                                        <input type="hidden" id="neutral" value="20"/>
                                                                        <input type="hidden" id="disagree" value="20"/>
                                                                        <input type="hidden" id="stronglydisagree" value="20"/>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <a title="View details">View details</a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="6" style="width: 100%; background: #ffffff;">
                                                                    <div id="chartdiv6" style="margin: 0 auto; max-width: 90%; height: 170px; background-color: #fff; ">
                                                                        <input type="hidden" id="stronglyagree" value="20"/>
                                                                        <input type="hidden" id="agree" value="20"/>
                                                                        <input type="hidden" id="neutral" value="20"/>
                                                                        <input type="hidden" id="disagree" value="20"/>
                                                                        <input type="hidden" id="stronglydisagree" value="20"/>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr class="question-name-date">
                                                                <td>4</td>
                                                                <td class="question-name">I have adequate opportunities for my own professional growth within the organization</td>
                                                                <td>7 July</td>
                                                                <td>92%</td>
                                                                <td>
                                                                    <div id="chartdiv7" style="width: 180px; height: 20px; background-color: #fff; display: block;">
                                                                        <input type="hidden" id="stronglyagree" value="10"/>
                                                                        <input type="hidden" id="agree" value="10"/>
                                                                        <input type="hidden" id="neutral" value="10"/>
                                                                        <input type="hidden" id="disagree" value="10"/>
                                                                        <input type="hidden" id="stronglydisagree" value="60"/>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <a title="View details">View details</a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="6" style="width: 100%; background: #ffffff;">
                                                                    <div id="chartdiv8" style="margin: 0 auto; max-width: 90%; height: 170px; background-color: #fff; ">
                                                                        <input type="hidden" id="stronglyagree" value="10"/>
                                                                        <input type="hidden" id="agree" value="10"/>
                                                                        <input type="hidden" id="neutral" value="10"/>
                                                                        <input type="hidden" id="disagree" value="10"/>
                                                                        <input type="hidden" id="stronglydisagree" value="60"/>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr class="question-name-date">
                                                                <td>5</td>
                                                                <td class="question-name">I see strong evidence of effective leadership and am confident about the company's future</td>
                                                                <td>30 June</td>
                                                                <td>67%</td>
                                                                <td>
                                                                    <div id="chartdiv9" style="width: 180px; height: 20px; background-color: #fff; display: block;">
                                                                        <input type="hidden" id="stronglyagree" value="20"/>
                                                                        <input type="hidden" id="agree" value="20"/>
                                                                        <input type="hidden" id="neutral" value="20"/>
                                                                        <input type="hidden" id="disagree" value="20"/>
                                                                        <input type="hidden" id="stronglydisagree" value="20"/>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <a title="View details">View details</a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="6" style="width: 100%; background: #ffffff;">
                                                                    <div id="chartdiv10" style="margin: 0 auto; max-width: 90%; height: 170px; background-color: #fff; ">
                                                                        <input type="hidden" id="stronglyagree" value="20"/>
                                                                        <input type="hidden" id="agree" value="20"/>
                                                                        <input type="hidden" id="neutral" value="20"/>
                                                                        <input type="hidden" id="disagree" value="20"/>
                                                                        <input type="hidden" id="stronglydisagree" value="20"/>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr class="question-name-date">
                                                                <td>6</td>
                                                                <td class="question-name">I receive regular and transparent communication on the company's plan, guidelines and policies</td>
                                                                <td>23 June</td>
                                                                <td>59%</td>
                                                                <td>
                                                                    <div id="chartdiv11" style="width: 180px; height: 20px; background-color: #fff; display: block;">
                                                                        <input type="hidden" id="stronglyagree" value="5"/>
                                                                        <input type="hidden" id="agree" value="7"/>
                                                                        <input type="hidden" id="neutral" value="10"/>
                                                                        <input type="hidden" id="disagree" value="53"/>
                                                                        <input type="hidden" id="stronglydisagree" value="25"/>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <a title="View details">View details</a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="6" style="width: 100%; background: #ffffff;">
                                                                    <div id="chartdiv12" style="margin: 0 auto; max-width: 90%; height: 170px; background-color: #fff; ">
                                                                        <input type="hidden" id="stronglyagree" value="5"/>
                                                                        <input type="hidden" id="agree" value="7"/>
                                                                        <input type="hidden" id="neutral" value="10"/>
                                                                        <input type="hidden" id="disagree" value="53"/>
                                                                        <input type="hidden" id="stronglydisagree" value="25"/>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr class="question-name-date">
                                                                <td>7</td>
                                                                <td class="question-name">Work culture at my plant is generally energizing and motivating</td>
                                                                <td>16 June</td>
                                                                <td>87%</td>
                                                                <td>
                                                                    <div id="chartdiv13" style="width: 180px; height: 20px; background-color: #fff; display: block;">
                                                                        <input type="hidden" id="stronglyagree" value="37"/>
                                                                        <input type="hidden" id="agree" value="27"/>
                                                                        <input type="hidden" id="neutral" value="26"/>
                                                                        <input type="hidden" id="disagree" value="8"/>
                                                                        <input type="hidden" id="stronglydisagree" value="2"/>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <a title="View details">View details</a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="6" style="width: 100%; background: #ffffff;">
                                                                    <div id="chartdiv14" style="margin: 0 auto; max-width: 90%; height: 170px; background-color: #fff; ">
                                                                        <input type="hidden" id="stronglyagree" value="37"/>
                                                                        <input type="hidden" id="agree" value="27"/>
                                                                        <input type="hidden" id="neutral" value="26"/>
                                                                        <input type="hidden" id="disagree" value="8"/>
                                                                        <input type="hidden" id="stronglydisagree" value="2"/>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr class="question-name-date">
                                                                <td>8</td>
                                                                <td class="question-name">I receive fair and unbiased treatment from my supervisor</td>
                                                                <td>9 June</td>
                                                                <td>47%</td>
                                                                <td>
                                                                    <div id="chartdiv15" style="width: 180px; height: 20px; background-color: #fff; display: block;">
                                                                        <input type="hidden" id="stronglyagree" value="17"/>
                                                                        <input type="hidden" id="agree" value="25"/>
                                                                        <input type="hidden" id="neutral" value="28"/>
                                                                        <input type="hidden" id="disagree" value="20"/>
                                                                        <input type="hidden" id="stronglydisagree" value="10"/>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <a title="View details">View details</a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="6" style="width: 100%; background: #ffffff;">
                                                                    <div id="chartdiv16" style="margin: 0 auto; max-width: 90%; height: 170px; background-color: #fff; ">
                                                                        <input type="hidden" id="stronglyagree" value="17"/>
                                                                        <input type="hidden" id="agree" value="25"/>
                                                                        <input type="hidden" id="neutral" value="28"/>
                                                                        <input type="hidden" id="disagree" value="20"/>
                                                                        <input type="hidden" id="stronglydisagree" value="10"/>
                                                                    </div>
                                                                </td>
                                                            </tr>-->
                        </tbody>
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
    <script src="<%=Constant.WEB_ASSETS%>js/explore.js"></script>	
    <script type="text/javascript">

    </script>

</body>
</html>
