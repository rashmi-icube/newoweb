<%-- 
    Document   : report
    Created on : 27 Oct, 2016, 2:14:12 PM
    Author     : adoshi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="java.util.Map"%>
<%@page import="org.icube.owen.dashboard.HrDashboardHelper"%>
<%@page import="org.icube.owen.dashboard.ReportObject"%>
<%@page import="org.json.JSONObject"%>

<%
    String moduleName = "report";
    String subModuleName = "ihcl";
%>
<!DOCTYPE html>
<html lang = "en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>IHCL Report</title>
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
                    <li class="waves-effect"><a href="dashboard.jsp">Dashboard</a></li>
                    <li class="waves-effect active"><a href="#">Report</a></li>
                    <li class="waves-effect"><a href="#">Analysis</a></li>
                    <li class="waves-effect"><a href="#">Focus Areas</a></li>
                    <li class="waves-effect"><a href="#">Explore</a></li>
                    <li class="waves-effect"><a href="#">Responses</a></li>                   
                </ul>
                <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
                <ul class="side-nav" id="mobile-demo">
                    <li><a href="dashboard.jsp">Dashboard</a></li>
                    <li><a href="#">Report</a></li>
                    <li><a href="#">Analysis</a></li>
                    <li><a href="#">Focus Areas</a></li>
                    <li><a href="#">Explore</a></li>
                    <li><a href="#">Responses</a></li>
                </ul>
            </div>
        </nav>
        <div class ="container">
            <div class="row">
                <div class="col s12">
                    <ul class="tabs">
                        <li class="tab col s3"><a  href="#test1">Heat Map Drill Down</a></li>
                        <li class="tab col s3"><a class = "active" href="#test2">Stacked Bar</a></li>
                        <li class="tab col s3"><a href="#test3">Scatter Plot with Quadrants</a></li>
                        <li class="tab col s3"><a href="#test4">Data Table</a></li>
                    </ul>
                </div>
                <div id="test1" class="col s12">
                    <div class="input-field col s12 m3">
                        <select>
                            <!--<optgroup label="Choose your option">-->
                            <option value="1">Option 1</option>
                            <option value="2">Option 2</option>
                            <option value="3">Option 3</option>
                            <!--</optgroup>-->
                        </select>
                        <label>Choose an option</label>
                    </div>
                    <div id="heatmapContainer" class = "chartContainer"></div>
                </div>
                <div id="test2" class="col s12">
                    <form action="resources" method="post" >

                        <div class="input-field col s12 m3">
                            <select id="dropdown">
                                <option value="a">Option A</option>
                                <option value="b">Option B</option>
                            </select>
                            <label>Select any one</label>
                        </div>
                    </form>
                    <%
                        String clickedPhoneId = request.getParameter("dropdown");

                        HrDashboardHelper obj = (HrDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.HrDashboardHelper");
                        Map<String, ReportObject> result1;
                        if (clickedPhoneId == "a") {
                            result1 = obj.getReportData1("group", "subGroup");
                        } else {
                            result1 = obj.getReportData2("group", "subGroup");
                        }
                        JSONObject json = new JSONObject(result1);

                    %>
                    <input type="hidden" id="result" value='<%= json%>'/>
                    <div id="stackedBarContainer" class = "chartContainer"></div>
                </div>
                <div id="test3" class="col s12">
                    <div class="input-field col s12 m3">
                        <select>
                            <option value="i">Option I</option>
                            <option value="ii">Option II</option>
                        </select>
                        <label>Select one</label>
                    </div>
                    <div id="scatterContainer" class = "chartContainer"></div>
                </div>
                <div id="test4" class="col s12">
                    <table class="highlight bordered responsive-table">
                        <thead>
                            <tr>
                                <th data-field="id">Name</th>
                                <th data-field="name">Item Name</th>
                                <th data-field="price">Item Price</th>
                            </tr>
                        </thead>

                        <tbody>
                            <tr>
                                <td>Alvin</td>
                                <td>Eclair</td>
                                <td>$0.87</td>
                            </tr>
                            <tr>
                                <td>Alan</td>
                                <td>Jellybean</td>
                                <td>$3.76</td>
                            </tr>
                            <tr>
                                <td>Jonathan</td>
                                <td>Lollipop</td>
                                <td>$7.00</td>
                            </tr>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
    </body>
    <script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="http://code.highcharts.com/modules/heatmap.js"></script>
    <script src="http://github.highcharts.com/master/modules/treemap.js"></script>
    <script src="<%=Constant.WEB_ASSETS%>js/idash.js"></script>

    <script type="text/javascript" src="<%=Constant.WEB_ASSETS%>js/materialize.js"></script>
</html>
