<%-- 
    Document   : dashboard
    Created on : 26 Oct, 2016, 2:21:00 PM
    Author     : adoshi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>
<%
    String moduleName = "dashboard";
    String subModuleName = "ihcl";
%>
<!DOCTYPE html>
<html lang = "en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>IHCL Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/idash.css">
        <!--Import Google Icon Font-->
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/materialize.css"  media="screen,projection"/>

    </head>
    <body>
<input type="hidden" id="moduleName" value="<%= moduleName%>" />
        <input type="hidden" id="subModuleName" value="<%= subModuleName%>" />
        <nav class="orange" role="navigation">
            <div class="nav-wrapper">
                <a id="logo-container" href="#" class="brand-logo">OWEN
                    <!--<img src="<%=Constant.WEB_ASSETS%>images/OWEN_Logo_Desktop.png" alt="OWEN Logo">-->
                </a>
                <ul class="right hide-on-med-and-down">
                    <li class="waves-effect active"><a href="#">Dashboard</a></li>
                    <li class="waves-effect"><a href="report.jsp">Report</a></li>
                    <li class="waves-effect"><a href="#">Analysis</a></li>
                    <li class="waves-effect"><a href="#">Focus Areas</a></li>
                    <li class="waves-effect"><a href="#">Explore</a></li>
                    <li class="waves-effect"><a href="#">Responses</a></li>                    
                </ul>
                <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
                <ul class="side-nav" id="mobile-demo">
                    <li><a href="#">Dashboard</a></li>
                    <li><a href="report.jsp">Report</a></li>
                    <li><a href="#">Analysis</a></li>
                    <li><a href="#">Focus Areas</a></li>
                    <li><a href="#">Explore</a></li>
                    <li><a href="#">Responses</a></li>
                </ul>
            </div>
        </nav>
        <div class ="container">
            <!-- Dropdown Trigger -->
            <select class='dropdown-button select-dropdown' data-activates='dropdown1'>
                <ul class='dropdown-content select-dropdown'>
                    <li><option value="Arithmetic">Arithmetic mean</option></li>
                    <li><option value="Weighted">Weighted mean</option></li>
                </ul>
            </select>
            <!-- Dropdown Structure -->

<!--            <ul id='dropdown1' class='dropdown-content select-dropdown'>
                <li><option value="Arithmetic Mean">Arithmetic mean</option></li>
                <li><option value="Weighted Mean">Weighted mean</option></li>
                <li class="divider"></li>
            </ul>-->
            <div id="container1" style="width: 33%; height: 400px; display: inline-block;"></div>
            <div id="container2" style="width: 33%; height: 400px; display: inline-block;"></div>
            <div id="container3" style="width: 33%; height: 400px; display: inline-block;"></div>
        </div>
    </body>
    <script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/highcharts-more.js"></script>
    <script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
    <script src="<%=Constant.WEB_ASSETS%>js/idash.js"></script>

    <script type="text/javascript" src="<%=Constant.WEB_ASSETS%>js/materialize.js"></script>
</html>
