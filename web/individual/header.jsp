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
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
    int empid  = 0;
    int comid = 0;
    String email = "";
    boolean firstTimeLogin = false;
    if(session.getAttribute("empid") != null && session.getAttribute("comid") != null) {
        empid = (Integer) session.getAttribute("empid");
        comid = (Integer) session.getAttribute("comid");
        email = (String) session.getAttribute("email");
        firstTimeLogin = (Boolean) session.getAttribute("firstTimeLogin");
    }
    if(empid == 0 || comid == 0) {
        response.sendRedirect("../login.jsp");
        return;
    }
    IndividualDashboardHelper iDashboardHeader =  (IndividualDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.IndividualDashboardHelper");
    if(moduleName.equals("dashboard")) {
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
                    <% if (notCount > 0 ) { %>
                        <img src="/assets/images/notification_red_dot.png" alt="Notification alert">
                     <% } %>
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
                            <span class="set-company">i-Cube Analytics &amp; Data Services</span>
                        </div>
                        <div>
                            <!--<a id="demo01" href="#animatedModal"><img src="/assets/images/help-circle.png" alt="Help Popup" width="27" height="27" onClick=""> Welcome</a>-->
                            <a href="profile.jsp" id="setUserDetails"><img src="<%=Constant.WEB_ASSETS%>images/menu_icon_settings.png" alt="Settings" width="27" height="27" onClick=""> Settings</a>
                            <a href="../signout.jsp" id="signOutMobile"><img src="<%=Constant.WEB_ASSETS%>images/menu_icon_logout.png" alt="Sign out" width="27" height="27"> Sign out</a>
                        </div>
                    </div>
                </li>
            
        </nav>

        <div class="notif-settings">
            <div class="intro-modal-popup"
                 <!--Call your modal-->
<!--                        <a id="demo01" href="#animatedModal">
                            <img src="/assets/images/help-circle.png" alt="Help Popup" width="23" height="23">
                        </a>-->
              
                <section class="cd-section">    
                    <div class="cd-modal-action">
                        <a href="#0" class="btn" data-type="modal-trigger">
                            <img src="/assets/images/help-circle.png" alt="Help Popup" width="23" height="23">
                        </a>
			<span class="cd-modal-bg"></span>
                    </div> <!-- cd-modal-action -->
                    
                    <div class="cd-modal">
			<div class="cd-modal-content">
                            <section class="modal-header" style="padding: 8px;">
                                <div class="wrapper clearfix">
                                    <a>
                                        <h1>
                                            <span>OWEN</span>
                                            <span>Individual</span>
                                        </h1>
                                    </a>
                                </div>
                            </section>
                            <section class="modal-content">
                                <div class="main" style="background: #ffffff; padding:2% 11.5rem; height:100vh;">
                                    <h2>Welcome to OWEN</h2>
                                    <p>Just wanted to show you a short(ish) note to help you know me better. If you ever have a question, comment or conundrum, please reach out.<br>The best way to get in touch is <a href="mailto:support@owenanalytics.com" style="display: inline !important;">support@owenanalytics.com </a><p>
                                    <div class="main-settings">
                                        <h2>SETTINGS</h2>
                                        <h4>Quick tips to get started</h4>
                                        <ol style="padding-left: 1em; font: 14px 'Open Sans Light', 'Open Sans';">
                                            <li>
                                                <a href='/individual/survey.jsp' style='display:inline;'>Answer a quick survey</a>
                                            </li>
                                            <li>
                                                <a href='/individual/profile.jsp' style='display:inline;'>Setup a profile</a>
                                            </li>
                                        </ol>     
                                    </div>
                                    <div class="main-survey" style='padding-top: 1em;'>
                                        <h2>SURVEY</h2>
                                        <h4>Take a survey to help me know you better</h4>
                                        <ol style="padding-left: 1em; font: 14px 'Open Sans Light', 'Open Sans';">
                                            <li>For questions that show a numeric scale of 1-5, select any one value that indicates your answer most correctly</li>
                                            <li>For questions that show a scale of stars, show your appreciation for fellow colleagues by showering them with stars</li>
                                            <li>Use the Search Bar and filters to find more colleagues you want to appreciate</li>
                                            <li>Reset your filter or search to the original smart list, by clicking on "Smart" </li>
                                            <li>Once you are done answering, you can click on the yellow submit button to proceed to the next question</li>
                                            <li>To get the most out of me, I'd recommend you to answer all of my questions </li>
                                        </ol>
                                    </div>
                                    <div class="main-dashboard" style='padding-top: 1em;'>
                                        <h2>DASHBOARD</h2>
                                        <h4>Here's how you can know me better</h4>
                                        <ol style="padding-left: 1em; font: 14px 'Open Sans Light', 'Open Sans';">
                                            <li>The metrics and trendline show your Expertise, Mentorship and Influence scores across the organization</li>
                                            <em>OWEN Tip - Answer your surveys regularly to earn a higher score in your organization</em>
                                            <li>Use the thumbs up to appreciate your colleagues for their Expertise, Mentorship and Influence</li>
                                            <li>Search, monitor, track or comment initiatives that you are a part of</li>
                                            <li>Use the activity feed to stay on top of all your work</li>
                                        </ol>
                                    </div>
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
                    <% if (notCount > 0 ) { %>
                    <img src="<%=Constant.WEB_ASSETS%>images/notification_red_dot.png" alt="Notification alert">
                    <% } %>
                </div>            
                <div class="num-view-notif">
                    <% if(notCount > 0 ) { %>
                    <span>You have <span class="num-notif"><%=notCount%></span> new notifications today.</span>
                    <% } else { %>
                        <span>You have <span class="num-notif">no</span> new notifications today.</span>
                    <% } %>
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
                <span>i-Cube</span>
            </div>
        </div>
    </div>
</header>
                        
<script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
<script src="<%=Constant.WEB_ASSETS%>js/individual.js"></script>

<script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.1.js"></script>
<script src="<%=Constant.WEB_ASSETS%>js/velocity.min.js"></script>
<script src="<%=Constant.WEB_ASSETS%>js/main.js"></script> <!-- Resource jQuery -->