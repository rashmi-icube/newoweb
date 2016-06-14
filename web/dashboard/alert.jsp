<%-- 
    Document   : alert
    Created on : Feb 20, 2016, 2:52:49 PM
    Author     : fermion10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.icube.owen.dashboard.Alert"%>
<%@page import="com.owen.web.Util"%>
<%@include file="../common.jsp" %>
<%
        String id = request.getParameter("iid");
        String status = request.getParameter("status");
        try {
            int iid = Integer.parseInt(id);
            Alert alert = new Alert();
            if(status.equals("Deleted")) {
                alert.delete(comid,iid);
            } 
        }catch(Exception ex) {
            Util.printException(ex);
        }
%> 