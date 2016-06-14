<%-- 
    Document   : common
    Created on : Mar 10, 2016, 2:21:42 PM
    Author     : fermion10
--%>
<%@page import="com.owen.web.Constant"%>
<%
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
    String url = request.getRequestURL().toString();
    System.out.println(url+" "+roleid);
            
    if(roleid != 2) {
        if(!url.contains("login.jsp") && !url.contains("singout.jsp") && !url.contains("individual")) {
            response.sendRedirect(Constant.WEB_CONTEXT+"/login.jsp");
        }
    }
    if(empid == 0 || comid == 0 ) {
        response.sendRedirect(Constant.WEB_CONTEXT+"/login.jsp");
        return;
    }
%>