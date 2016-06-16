<%-- 
    Document   : login-check
    Created on : Mar 7, 2016, 10:58:38 AM
    Author     : fermion10
--%>

<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.Util"%>
<%@page import="java.awt.Image"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.icube.owen.individual.Login"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    int roleid = request.getParameter("roleid") != null ? Util.getIntValue(request.getParameter("roleid")) :0 ;
    if(username != null && !username.equals("") && password != null && !password.equals("")) {
        Login login =  (Login) ObjectFactory.getInstance("org.icube.owen.individual.Login");
        try {
            Employee emp = login.login(username, password,request.getRemoteAddr(),roleid);
            session.setAttribute( "empid", emp.getEmployeeId() );
            session.setAttribute( "comid", emp.getCompanyId() );
            session.setAttribute( "email", username);
            session.setAttribute( "ename", emp.getFirstName()+" "+(emp.getLastName() != null ?emp.getLastName(): "") );
            session.setAttribute( "esname", emp.getFirstName().substring(0, 1).toUpperCase()+(emp.getLastName() != null ? emp.getLastName().substring(0, 1).toUpperCase(): "") );
            session.setAttribute( "role", roleid );
            session.setAttribute( "firstTimeLogin", emp.isFirstTimeLogin());
            if(roleid == 1) {
                response.sendRedirect(Constant.WEB_CONTEXT+"/individual/profile.jsp");
            } else if(roleid == 2) {
                response.sendRedirect(Constant.WEB_CONTEXT+"/dashboard/dashboard.jsp");
            } else {
                response.sendRedirect("login.jsp");
            }
        } catch(Exception ex) {
            ex.printStackTrace();
            %>
            <form action="login.jsp" method="post" name="loginForm">
                <input type="hidden" name="msg" value="Invalid Credentials. Please try again.">
                <input type="hidden" name="roleid" value="<%=roleid%>">
            </form>
            <script>
               document.forms["loginForm"].submit();
            </script>
            <%
        }
    } else {
        response.sendRedirect("login.jsp");
    }
%>
