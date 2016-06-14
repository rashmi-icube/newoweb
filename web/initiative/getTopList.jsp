<%-- 
    Document   : getTopList
    Created on : Apr 7, 2016, 3:51:57 PM
    Author     : fermion10
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="java.util.Map"%>
<%@page import="com.owen.web.Util"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.icube.owen.initiative.InitiativeHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>
<%
    String catid = request.getParameter("catid") != null ? request.getParameter("catid") : "Team";
    Initiative initiative =  (Initiative) ObjectFactory.getInstance("org.icube.owen.initiative.Initiative");
    Map <Integer,String> indivdualType =  initiative.getInitiativeTypeMap(comid,"individual");
    Map <Integer,String> teamType =  initiative.getInitiativeTypeMap(comid,"team");
    InitiativeHelper iHelper = new    InitiativeHelper();
    java.util.List<java.util.Map<java.lang.String,java.lang.Object>> iList =  iHelper.getInitiativeCount(comid);
    HashMap<Integer,HashMap<String, Integer>> hasmap = Util.getTypeList(iList, "Team");
    if(catid.equalsIgnoreCase("Team")) {
    for (Map.Entry<Integer,HashMap<String, Integer>> entry : hasmap.entrySet()) { 
        HashMap<String, Integer> hmap = entry.getValue();
%>
<li>
    <span><%=teamType.get(entry.getKey())%></span>
    <div class="panel-pic">																
        <img src="<%=Constant.WEB_ASSETS%>images/<%=Util.getInitiativeTypeImage(teamType.get(entry.getKey()), "Team") %>" width="79" alt="<%=teamType.get(entry.getKey())%>">
    </div>
    <div class="current-completed clearfix">
        <p>
            <span>Current Initiatives: <span class="bold"><%=hmap.get("Active")%></span></span>
            <span>Completed Initiatives: <%=hmap.get("Completed")%></span>
        </p>
        <a href="create.jsp?c=1&t=<%=entry.getKey()%>" title="Set an initiative for <%=indivdualType.get(entry.getKey())%>">+</a>
    </div>
</li>
<% } 
 } else {  
    hasmap = Util.getTypeList(iList, "Individual"); 
    for (Map.Entry<Integer,HashMap<String, Integer>> entry : hasmap.entrySet()) { 
    HashMap<String, Integer> hmap = entry.getValue();
%>
<li class="animate-list">
    <span><%=indivdualType.get(entry.getKey())%></span>
    <div class="panel-pic">																
        <img src="<%=Constant.WEB_ASSETS%>images/<%=Util.getInitiativeTypeImage(indivdualType.get(entry.getKey()), "Individual") %>" width="79" alt="<%=indivdualType.get(entry.getKey())%>">
    </div>
    <div class="current-completed clearfix">
        <p>
            <span>Current Initiatives: <span class="bold"><%=hmap.get("Active")%></span></span>
            <span>Completed Initiatives: <%=hmap.get("Completed")%></span>
        </p>
        <a href="create.jsp?c=0&t=<%=entry.getKey()%>" title="Set an initiative for <%=indivdualType.get(entry.getKey())%>">+</a>
    </div>
</li>
<% } 
}%>
