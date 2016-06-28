<%-- 
    Document   : header
    Created on : Jan 8, 2016, 5:56:43 PM
    Author     : fermion10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>

<% 
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
    int empid  = 0;
    int comid = 0;
     int roleid = 0;
    String email = "";
    if(session.getAttribute("empid") != null && session.getAttribute("comid") != null) {
        empid = (Integer) session.getAttribute("empid");
        comid = (Integer) session.getAttribute("comid");
        roleid = (Integer) session.getAttribute("role");
        email = (String) session.getAttribute("email");
    }
    if(empid == 0 || comid == 0 || roleid == 1 ) {
        response.sendRedirect("../login.jsp");
        return;
    }

%>

<link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/jquery-ui.css">
<link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/jquery.ui.theme.css">
<link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/font-awesome.min.css">
<link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/jquery.circliful.css">  
<link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/main.css">

<meta http-equiv="Cache-Control" content="no-cache">

<script src="<%=Constant.WEB_ASSETS%>js/common.js"></script>	
<script>
    var webcontext = "<%=Constant.WEB_CONTEXT%>";
</script>

<header class="clearfix">
    <div class="wrapper">				
        <a href="<%=Constant.WEB_CONTEXT%>/dashboard/dashboard.jsp"><h1>OWEN</h1></a>
        <nav>
            <ul>
                <li <%=moduleName.equals("dashboard") ? "class=\"current\"" : ""%>><a href="<%=Constant.WEB_CONTEXT%>/dashboard/dashboard.jsp">Dashboard</a></li>
                <li <%=moduleName.equals("wall") ? "class=\"current\"" : ""%>><a href="<%=Constant.WEB_CONTEXT%>/wall/wall.jsp">The Wall</a></li>
                <li <%=moduleName.equals("initiative") ? "class=\"current\"" : ""%>>
                    <a href="#">My Initiatives</a>
                    <div class="create-view-list">
                        <span>My Initiatives</span>
                        <ul>
                            <li <%=subModuleName!= null && subModuleName.equals("list") ? "class=\"current-tab\"" : ""%>><a href="<%=Constant.WEB_CONTEXT%>/initiative/list.jsp">View all initiatives</a></li>
                            <li <%=subModuleName!= null && subModuleName.equals("create") ? "class=\"current-tab\"" : ""%>><a href="<%=Constant.WEB_CONTEXT%>/initiative/create.jsp">Create new initiative</a></li>
                        </ul>								
                    </div>
                </li>
                <li <%=moduleName.equals("explore") ? "class=\"current\"" : ""%>><a href="<%=Constant.WEB_CONTEXT%>/explore/explore.jsp">Explore</a></li>
                <li <%=moduleName.equals("survey") ? "class=\"current\"" : ""%>><a href="<%=Constant.WEB_CONTEXT%>/survey/survey.jsp">Survey</a></li>
            </ul>
        </nav>
 
<!--    <div class="user-profile">
        <div class="profimg" style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=comid%>&eid=<%=empid%>');"></div>
        <div class="user-name-company">
            <div class="user-profile-name">						
                <p><a href="#" title="<%=session.getAttribute("ename")%>"><%=session.getAttribute("ename")%> &#9660;</a></p>
                <ul>
                    <li>
                        <a id="setUserDetails" href="<%=Constant.WEB_CONTEXT%>/individual/profile.jsp">Settings</a>
                    </li>
                    <li>
                        <a id="signOut" href="../signout.jsp">Sign out</a>
                    </li>
                </ul>
            </div>
            <p><%=session.getAttribute("esname")%></p>
        </div>
    </div>        -->
        <div class="notif-settings">
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
                        <!--<a href="<%=Constant.WEB_CONTEXT%>/individual/profile.jsp" id="setUserDetails">&#x1F527; Settings</a>-->
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