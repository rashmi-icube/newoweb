<%-- 
    Document   : signout
    Created on : Mar 10, 2016, 2:42:58 PM
    Author     : fermion10
--%>
<%@include file="common.jsp" %>
<%
    request.getSession().invalidate();
%>
<form action="login.jsp" method="post" name="loginForm">
     <input type="hidden" name="roleid" value="<%=roleid%>">
</form>
<script>
   document.forms["loginForm"].submit();
</script>