<%-- 
    Document   : common
    Created on : Mar 10, 2016, 2:21:42 PM
    Author     : fermion10
--%>
<%
    int empid  = 0;
    int comid = 0;
    String email = "";
    if(session.getAttribute("empid") != null && session.getAttribute("comid") != null) {
        empid = (Integer) session.getAttribute("empid");
        comid = (Integer) session.getAttribute("comid");
        email = (String) session.getAttribute("email");
    }
    if(empid == 0 || comid == 0) {
        response.sendRedirect("login.jsp");
        return;
    }
%>