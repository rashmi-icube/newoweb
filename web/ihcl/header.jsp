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
    if (session.getAttribute("empid") != null) {
        empid = (Integer) session.getAttribute("empid");
        comid = (Integer) session.getAttribute("comid");
        email = (String) session.getAttribute("email");
        firstTimeLogin = (Boolean) session.getAttribute("firstTimeLogin");
    }
    if (empid == 0) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<header>
    <head>
        <link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/style.css">
        <script src="<%=Constant.WEB_ASSETS%>js/modernizr.js"></script> <!-- Modernizr -->
    </head>
    <div class="wrapper clearfix">

        <a href="<%=Constant.WEB_CONTEXT%>/individual/dashboard.jsp" id="Header-Mobile-Logo">
            <img src="<%=Constant.WEB_ASSETS%>images/OWEN_Logo_Desktop.png" alt="OWEN Logo">
        </a>
        <div class="usernameapp">
            <p><%=session.getAttribute("ename")%></p>
        </div>
    </div>
</header>

<script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
<script src="<%=Constant.WEB_ASSETS%>js/individual.js"></script>

<script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.1.js"></script>
<script src="<%=Constant.WEB_ASSETS%>js/velocity.min.js"></script>
<script src="<%=Constant.WEB_ASSETS%>js/main.js"></script> <!-- Resource jQuery -->