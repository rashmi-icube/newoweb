<%-- 
    Document   : header
    Created on : Mar 7, 2016, 10:54:34 AM
    Author     : fermion10
--%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.dashboard.IndividualDashboardHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    int empid = 0;
    int comid = 0;
    String email = "";
    boolean firstTimeLogin = false;
    if (session.getAttribute("empid") != null && session.getAttribute("comid") != null) {
        empid = (Integer) session.getAttribute("empid");
        comid = (Integer) session.getAttribute("comid");
        email = (String) session.getAttribute("email");
        firstTimeLogin = (Boolean) session.getAttribute("firstTimeLogin");
    }
    if (empid == 0 || comid == 0) {
        response.sendRedirect("../login.jsp");
        return;
    }
    IndividualDashboardHelper iDashboardHeader = (IndividualDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.IndividualDashboardHelper");
    if (moduleName.equals("dashboard")) {
        iDashboardHeader.updateNotificationTimestamp(comid, empid);
    }
    int notCount = iDashboardHeader.getNotificationsCount(comid, empid);
%>

<header>
    <head>
        <link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/style.css">
        <script src="<%=Constant.WEB_ASSETS%>js/modernizr.js"></script> <!-- Modernizr -->
    </head>
    <div class="wrapper clearfix">
        <a href="<%=Constant.WEB_CONTEXT%>/individual/dashboard.jsp"> <h1><span>OWEN</span> <span>Individual</span></h1></a>
        <nav>

            <li <%=moduleName.equals("survey") ? "class=\"current\"" : ""%>><a href="<%=Constant.WEB_CONTEXT%>/individual/survey.jsp">Survey</a></li>
            <li <%=moduleName.equals("dashboard") ? "class=\"current\"" : ""%>><a href="<%=Constant.WEB_CONTEXT%>/individual/dashboard.jsp">Dashboard</a></li>
            <li><a href="<%=Constant.WEB_CONTEXT%>/individual/dashboard.jsp#initiatives"></a></li>
            <li>
                <a href="<%=Constant.WEB_CONTEXT%>/individual/dashboard.jsp#notification"></a>
                <% if (notCount > 0) { %>
                <img src="/assets/images/notification_red_dot.png" alt="Notification alert">
                <% }%>
            </li>
            <li id="mobileSettings">
                <a href="#"></a>
                <div class="settings-sign-page clearfix">
                    <div>
                        <!--<img src="<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=comid%>&eid=<%=empid%>" alt="User pic" width="88" height="88">-->
                        <div class="profimg" style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=comid%>&eid=<%=empid%>')"></div>
                    </div>

                    <div>
                        <span class="set-full-name"><%=session.getAttribute("ename")%></span>
                        <span class="set-username"><%=session.getAttribute("esname")%></span>
                        <span class="set-company"><%=session.getAttribute("companyName")%></span>
                    </div>
                    <div>
                            <a href="profile.jsp" id="setUserDetails"><img src="<%=Constant.WEB_ASSETS%>images/menu_icon_settings.png" alt="Settings" width="27" height="27" onClick=""> Settings</a>
                            <a href="../signout.jsp" id="signOutMobile"><img src="<%=Constant.WEB_ASSETS%>images/menu_icon_logout.png" alt="Sign out" width="27" height="27"> Sign out</a>
                    </div>
                </div>
            </li>
            <li>
                <section class="cd-section">    
                    <div class="cd-modal-action">
                        <a href="#0" class="btn" data-type="modal-trigger"><img src="/assets/images/mobile-help-icon.png" alt="Help Popup" style="margin-left: -10px;"></a>
                        <span class="cd-modal-bg"></span>
                    </div> <!-- cd-modal-action -->
                    <div class="cd-modal">
                        <div class="cd-modal-content">
                            <section class="modal-content">
                                <div class="main" style="background: #ffffff; padding:2% 1.5rem;">
                                    <h2>Welcome!</h2>
                                    <p>OWEN helps you provide feedback about your experience at work as well as recognize your colleagues for their support. Please be assured that all your responses are <strong style="font: 500 14px 'Open Sans Bold', 'Open Sans';">strictly confidential</strong>, and that management will never see the names of the respondents.</p>
                                    <p>Let's get started...</p>
                                    <div class="main-survey" style="padding-top: 1em;">
                                        <h2>Survey</h2>
                                        <p>
                                            1. For questions with a numerical scale, select any one value that indicates your answer most correctly
                                        </p>
                                        <img src="/assets/images/survey_numeric_scale.gif" alt="Survey Numeric Scale" width = 70% height = auto>
                                        <p>
                                            2. For questions that show a scale of stars, show your appreciation to fellow colleagues by showering them with the appropriate number of stars
                                        </p>
                                        <img src="/assets/images/survey_stars.gif" alt="Survey Star Scale" width = 90%>
                                        <br>
                                        <p><em>Quick Tip: Appreciating people makes them feel better and wanted in the team, so don't shy away from appreciating more people.</em></p>
                                        <p>
                                            3. Once you have answered the questions, click on the submit button! That's it…
                                        </p>
                                        <img src="/assets/images/survey_submit_button.gif" alt="Survey Submit Button" width = 30%>
                                        <br>
                                    </div>
                                    <div class="main-dashboard" style="padding-top: 1em;">
                                        <h2>Dashboard</h2>
                                        <p>
                                            1. The metrics and trendline show your scores for Expertise, Mentorship and Influence
                                        </p>
                                        <img src="/assets/images/dashboard_metrics.png" alt="Dashboard Metrics" width = 90%>
                                        <br>
                                        <p>
                                            <em>Quick Tip: Appreciating people makes them feel better and wanted in the team, so don't shy away from appreciating more people.</em>
                                        </p>
                                        <p>
                                            2. Use the thumbs up to appreciate your colleagues for their Expertise, Mentorship and Influence
                                        </p>
                                        <img src="/assets/images/dashboard_metric_appreciate.png" alt="Dashboard Appreciate Expertise" width = 30%>
                                        <p>
                                            3. Search, monitor, track or comment initiatives that you are a part of
                                        </p>
                                        <p>
                                            4. Use the activity feed to stay on top of all your work
                                        </p>                                            
                                    </div>
                                    <p>Hopefully this will give you enough so you can breeze through your surveys and make the most of your dashboard.</p>
                                    <p>If you still have questions, comments or conundrums, write to us at support@owenanalytics.com</p>
                                </div>
                            </section>
                        </div>  <!-- cd-modal-content  -->
                    </div>  <!-- cd-modal -->
                    <a href="#0" class="cd-modal-close" style="padding-bottom: 0; top: 10%;">Close</a>
                </section>
            </li>
        </nav>

        <div class="notif-settings">
            <div class="intro-modal-popup"
                 <!--Call your modal-->

                 <section class="cd-section">    
                    <div class="cd-modal-action">
                        <a href="#0" class="btn" data-type="modal-trigger">
                            <img src="/assets/images/help-circle.png" alt="Help Popup" width="23" height="23">
                        </a>
                        <span class="cd-modal-bg"></span>
                    </div> <!-- cd-modal-action -->

                    <div class="cd-modal">
                        <div class="cd-modal-content">
                            <section class="modal-header">
                                <header>
                                    <div class="wrapper clearfix">
                                        <a href="/individual/dashboard.jsp" style="display: inline">
                                            <h1>
                                                <span>OWEN  </span>
                                                <span>Individual</span>
                                            </h1>
                                        </a>
                                    </div>
                                </header>
                            </section>
                            <section class="modal-content">
                                <div class="main" style="background: #ffffff; padding:2% 11.5rem;">
                                    <h2>Welcome!</h2>
                                    <p>OWEN helps you provide feedback about your experience at work as well as recognize your colleagues for their support. Please be assured that all your responses are <strong style="font: 500 14px 'Open Sans Bold', 'Open Sans';">strictly confidential</strong>, and that management will never see the names of the respondents.</p>
                                    <p>Let's get started...</p>
                                    <div class="main-survey" style="padding-top: 1em;">
                                        <h2>Survey</h2>
                                        <ol style="padding-left: 1em; font: 14px 'Open Sans Light', 'Open Sans';">
                                            <li style="padding-top: 1em;">For questions with a numerical scale, select any one value that indicates your answer most correctly</li>
                                            <img src="/assets/images/survey_numeric_scale.gif" alt="Survey Numeric Scale" width = 40% height = auto>
                                            <li>For questions that show a scale of stars, show your appreciation to fellow colleagues by showering them with the appropriate number of stars</li>
                                            <img src="/assets/images/survey_stars.gif" alt="Survey Star Scale" width = 30%>
                                            <br>
                                            <em>Quick Tip: Appreciating people makes them feel better and wanted in the team, so don't shy away from appreciating more people.</em>
                                            <li>Once you've answered the questions, click on the submit button! That's it…</li>
                                            <img src="/assets/images/survey_submit_button.gif" alt="Survey Submit Button" width = 10%>
                                            <br>
                                        </ol>
                                    </div>
                                    <div class="main-dashboard" style="padding-top: 1em;">
                                        <h2>Dashboard</h2>
                                        <ol style="padding-left: 1em; font: 14px 'Open Sans Light', 'Open Sans';">
                                            <li style="padding-top: 1em;">The metrics and trendline show your scores for Expertise, Mentorship and Influence</li>
                                            <img src="/assets/images/dashboard_metrics.png" alt="Dashboard Metrics" width = 30%>
                                            <br>
                                            <em>Quick Tip: Appreciating people makes them feel better and wanted in the team, so don't shy away from appreciating more people.</em>
                                            <li>Use the thumbs up to appreciate your colleagues for their Expertise, Mentorship and Influence</li>
                                            <img src="/assets/images/dashboard_metric_appreciate.png" alt="Dashboard Expertise" width = 10%>
                                            <li>Search, monitor, track or comment initiatives that you are a part of</li>
                                            <li>Use the activity feed to stay on top of all your work</li>
                                        </ol>
                                    </div>
                                    <p>Hopefully this will give you enough so you can breeze through your surveys and make the most of your dashboard.
                                        If you still have questions, comments or conundrums, write to us at <a style ='display: inline ;' href=mailto:support@owenanalytics.com>support@owenanalytics.com</p>
                                </div>
                            </section>
                        </div> <!-- cd-modal-content -->
                    </div> <!-- cd-modal -->

                    <a href="#0" class="cd-modal-close">Close</a>
                </section>                    


            </div>
            <div class="notif-area">
                <div class="notif-box">
                    <a href="<%=Constant.WEB_CONTEXT%>/individual/dashboard.jsp">
                        <img src="<%=Constant.WEB_ASSETS%>images/header_icon_notification.png" alt="Notification icon" width="25" height="25">
                    </a>
                    <% if (notCount > 0) {%>
                    <img src="<%=Constant.WEB_ASSETS%>images/notification_red_dot.png" alt="Notification alert">
                    <% } %>
                </div>            
                <div class="num-view-notif">
                    <% if (notCount > 0) {%>
                    <span>You have <span class="num-notif"><%=notCount%></span> new notification(s) today.</span>
                    <% } else { %>
                    <span>You have <span class="num-notif">no</span> new notifications today.</span>
                    <% }%>
                </div>            
            </div>

            <div class="user-small-pic">
                <div class="profimg" style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=comid%>&eid=<%=empid%>');"></div>
                <div class="settings-sign-popup clearfix">
                    <div>
                        <div class="profimg" style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=comid%>&eid=<%=empid%>');"></div>
                    </div>
                    <div>
                        <span class="set-full-name"><%=session.getAttribute("ename")%></span>
                        <span class="set-username"><%=session.getAttribute("esname")%></span>
                    </div>
                    <div>
                        <a href="profile.jsp" id="setUserDetails">&#x1F527; Settings</a>
                        <a href="../signout.jsp" id="signOut">Sign out</a>
                    </div>
                </div>
            </div>

            <div class="user-name-company">
                <span><%=session.getAttribute("esname")%></span>
                <span><%=session.getAttribute("companyName")%></span>
            </div>
        </div>
    </div>
</header>

<script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
<script src="<%=Constant.WEB_ASSETS%>js/individual.js"></script>

<script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.1.js"></script>
<script src="<%=Constant.WEB_ASSETS%>js/velocity.min.js"></script>
<script src="<%=Constant.WEB_ASSETS%>js/main.js"></script> <!-- Resource jQuery -->