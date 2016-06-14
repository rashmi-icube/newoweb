<%-- 
    Document   : signout
    Created on : Mar 10, 2016, 2:42:58 PM
    Author     : fermion10
--%>
<%
    request.getSession().invalidate();
    response.sendRedirect("login.jsp");
%>