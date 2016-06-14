<%-- 
    Document   : updatecomments
    Created on : Jan 25, 2016, 2:22:20 PM
    Author     : fermion10
--%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.MessageConstant"%>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.json.JSONObject"%>
<%@page trimDirectiveWhitespaces="true" %>
<%@include file="../common.jsp" %>
<%
    String id = request.getParameter("iid");
    String comments = request.getParameter("comments");
    JSONObject json = new JSONObject();
    JSONObject errorArray = new JSONObject();
    Employee emp =  (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee");
    Employee e = emp.get(comid,empid);
    try {
        int iid = Integer.parseInt(id);
        Initiative initiative = new Initiative();
        Initiative uinitiative = initiative.get(comid,iid);
        if(comments != null && !comments.equals("")) {
            comments = uinitiative.getInitiativeComment()+"<p>"+(e.getFirstName().substring(0, 1) + (e.getLastName() != null ? e.getLastName().substring(0, 1) : ""))+": "+comments+"</p>";
        } else {
            comments = uinitiative.getInitiativeComment();
        }
        uinitiative.setInitiativeComment(comments);
        initiative.updateInitiative(comid,uinitiative);
        json.put("status", 0);
        json.put("msg", MessageConstant.INITIATIVE_COMMENT_SUCCESS_MESSAGE);
        json.put("comments", comments);
    } catch(Exception ex) {
        Util.printException(ex);
    }
    response.setCharacterEncoding("utf-8");
    out.print(json.toString());        
%> 
