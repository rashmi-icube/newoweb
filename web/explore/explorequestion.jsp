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
                            <h3>Compare</h3>
                            <button type="button" style="float: none; font: 14px 'Open Sans Regular', 'Open Sans'; vertical-align: -2px; margin-left: 70px; color: white;"  onMouseOver="this.style.color='#169bd5'" onMouseOut="this.style.color='#FFFFFF'">Reset</button>
                            <button type="button" id="collapse-metrics" onMouseOver="this.style.color='#169bd5'" onMouseOut="this.style.color='#1e1e1e'">Expand</button>
                        </div>
                        <div class="create-metrics-list" style="padding: 0;">
                            <div class="initiative-which-people" style="height: 180px;">
                                <div class="initiative-which">
                                    <!--                                        <div class="initiative-category">
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
                                                <option value="7">Corporate HR</option>
                                                <option value="8">INTG1</option>
                                                <option value="9">INTG2</option>
                                                <option value="10">INTG3</option>
                                                <option value="11">INTG4</option>
                                                <option value="12">INTG5</option>
                                            </select>
                                            <div class="select-overlay" style="display: none;"></div>
                                        </div>
                                        <div class="initiative-choice-select">
                                            <span>2.</span>
                                            <label for="teamFunction">Select a function</label>
                                            <select name="teamFunction" id="teamFunction" size="5" required="" oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                                <option value="0">All</option>
                                                <option value="1">HR</option>
                                                <option value="2">Business</option>
                                            </select>
                                            <div class="select-overlay" style="display: none;"></div>
                                        </div>
                                        <div class="initiative-choice-select">
                                            <span>3.</span>
                                            <label for="teamLevel">Select a level</label>
                                            <select name="teamLevel" id="teamLevel" size="5" required="" oninvalid="setCustomValidity('Please select an item in the list.')" onchange="setCustomValidity('')">
                                                <option value="0">All</option>
                                                <option value="3">Corporate</option>
                                                <option value="4">Region</option>
                                                <option value="5">State</option>
                                                <option value="6">Zone</option>      
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
                        <div class="my-initatives-header clearfix">
                            <h2>Explore - Questions</h2>
                        </div>
                        <ul class="switched">
                            <li style="height: 193px">
                                <span>Learning</span>
                                <div class="panel-pic" style="width: 78px; height: 78px;">
                                    <img src="/assets/images/panel_performance_pic.png" width="79" alt="Performance">
                                </div>
<!--                            <div class="panel-help-text">
                                    HELP TEXT GOES HERE
                                </div>-->
                                <div class="current-completed clearfix">
                                    <p style="width: 80%; ">
                                        <span style="display: inline-block; text-align: justify;">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer</span>
                                    </p>
                                    <button class="panel-select-metric selected" title="Select" style="position: absolute; right: 5%; bottom: 5%;">&#x2714;</button>
                                </div>
                            </li>
                            <li style="height: 193px">
                                <span>Social Cohesion</span>
                                <div class="panel-pic" style="width: 78px; height: 78px;">
                                    <img src="/assets/images/panel_cohesion_pic.png" width="79" alt="Performance">
                                </div>
<!--                            <div class="panel-help-text">
                                    HELP TEXT GOES HERE
                                </div>-->
                                <div class="current-completed clearfix">
                                    <p style="width: 80%; ">
                                        <span style="display: inline-block; text-align: justify;">centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was</span>
                                    </p>
                                    <button class="panel-select-metric" title="Select" style="position: absolute; right: 5%; bottom: 5%;">&#x2714;</button>
                                </div>
                            </li>
                            <li style="height: 193px">
                                <span>Mentorship</span>
                                <div class="panel-pic" style="width: 78px; height: 78px;">
                                    <img src="/assets/images/panel_mentorship_pic.png" width="79" alt="Performance">
                                </div>
<!--                            <div class="panel-help-text">
                                    HELP TEXT GOES HERE
                                </div>-->
                                <div class="current-completed clearfix">
                                    <p style="width: 80%; ">
                                        <span style="display: inline-block; text-align: justify;">took a galley of type and scrambled it to make a type specimen book. It has survived not only five</span>
                                    </p>
                                    <button class="panel-select-metric" title="Select" style="position: absolute; right: 5%; bottom: 5%;">&#x2714;</button>
                                </div>
                            </li>
                            <li style="height: 193px">
                                <span>Innovation</span>
                                <div class="panel-pic" style="width: 78px; height: 78px;">
                                    <img src="/assets/images/panel_innovation_pic.png" width="79" alt="Performance">
                                </div>
<!--                            <div class="panel-help-text">
                                    HELP TEXT GOES HERE
                                </div>-->
                                <div class="current-completed clearfix">
                                    <p style="width: 80%; ">
                                        <span style="display: inline-block; text-align: justify;">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</span>
                                    </p>
                                    <button class="panel-select-metric" title="Select" style="position: absolute; right: 5%; bottom: 5%;">&#x2714;</button>
                                </div>
                            </li>
                            <li style="height: 193px">
                                <span>Others</span>
                                <div class="panel-pic" style="width: 78px; height: 78px;">
                                    <!--<img src="/assets/images/panel_performance_pic.png" width="79" alt="Performance">-->
                                </div>
<!--                            <div class="panel-help-text">
                                    HELP TEXT GOES HERE
                                </div>-->
                                <div class="current-completed clearfix">
                                    <p style="width: 80%; ">
                                        <span style="display: inline-block; text-align: justify;">popularized in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages</span>
                                    </p>
                                    <button class="panel-select-metric" title="Select" style="position: absolute; right: 5%; bottom: 5%;">&#x2714;</button>
                                </div>
                            </li>
<!--                            <li>
                                <span>Learning</span>
                                <div class="panel-help-text">
                                    HELP TEXT GOES HERE
                                </div>
                                <div class="current-completed clearfix">
                                    <button class="panel-select-metric" title="Select">&#x2714;</button>
                                </div>
                            </li>-->
                            
                        </ul>
                    </div>

                    <div class="explore-by-question">
                        <div class="explore-by-question-header">
                            <h3><span>Questions</span></h3>
                        </div>
                        <table class="explore-by-question-table">
                            <tbody>
                                <tr class="question-name-date">
                                    <td>1</td>
                                    <td class="question-name">I have a clear understanding of my job and what is expected of me</td>
                                    <td>9 June</td>
                                    <td>52%</td>
                                    <td>
                                        <div id="chartdiv1" style="width: 180px; height: 20px; background-color: #fff; display: block;">
                                            <input type="hidden" id="stronglyagree" value="36"/>
                                            <input type="hidden" id="agree" value="14"/>
                                            <input type="hidden" id="neutral" value="20"/>
                                            <input type="hidden" id="disagree" value="10"/>
                                            <input type="hidden" id="stronglydisagree" value="20"/>
                                        </div>
                                    </td>
                                    <td>
                                        <a title="View details">View details</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="width: 100%; background: #ffffff;">
                                        <div id="chartdiv2" style="margin: 0 auto; max-width: 90%; height: 170px; background-color: #fff; ">
                                            <input type="hidden" id="stronglyagree" value="36"/>
                                            <input type="hidden" id="agree" value="14"/>
                                            <input type="hidden" id="neutral" value="20"/>
                                            <input type="hidden" id="disagree" value="10"/>
                                            <input type="hidden" id="stronglydisagree" value="20"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="question-name-date">
                                    <td>2</td>
                                    <td class="question-name">I feel sufficiently recognized for the work I do</td>
                                    <td>16 June</td>
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
                                    <td>23 June</td>
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
                                    <td>30 June</td>
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
                                    <td>7 July</td>
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
                                    <td>14 July</td>
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
                                    <td>21 July</td>
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
                                    <td>28 July</td>
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
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--                    </div>-->
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
