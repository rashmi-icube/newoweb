<%-- 
    Document   : removeinitiative
    Created on : Jan 25, 2016, 3:58:04 PM
    Author     : fermion10
--%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.MessageConstant"%>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.json.JSONObject"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@include file="../common.jsp" %>
<%
        String id = request.getParameter("iid");
        String status = request.getParameter("status");
        JSONObject json = new JSONObject();
        try {
            int iid = Integer.parseInt(id);
            Initiative initiative = new Initiative();
            if(status.equals("Deleted")) {
                initiative.delete(comid,iid);
            } else if(status.equals("Completed")) { 
                initiative.complete(comid,iid);
            }
        }catch(Exception ex) {
            Util.printException(ex);
        }
        json.put("status", 0);
        json.put("msg", "Update successful.");
        response.setCharacterEncoding("utf-8");
        out.print(json.toString());  
%> 