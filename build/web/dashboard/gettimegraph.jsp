<%-- 
    Document   : gettimegraph
    Created on : Feb 20, 2016, 1:20:46 PM
    Author     : fermion10
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.dashboard.HrDashboardHelper"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.icube.owen.metrics.Metrics"%>
<%@include file="../common.jsp" %>
<% 
    String fid = request.getParameter("fid");
    String fidText = request.getParameter("fidText");
    String type = request.getParameter("type");
    String typeid = request.getParameter("typeid");
    int intType = 0;
    if(typeid  != null && !typeid.equals("")) {
        intType= Util.getIntValue(typeid);
    }
    String org = request.getParameter("org");
    int intFid = Util.getIntValue(fid);
    HrDashboardHelper dBoardObj =  (HrDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.HrDashboardHelper");
    Map<Integer, List<Map<java.util.Date,Integer>>> list1 = new HashMap<Integer, List<Map<java.util.Date,Integer>>>();
    List<Metrics> metList = new ArrayList<Metrics>();
    if(intFid > 0 && type != null && !type.equals("")) {
        Filter f = new Filter();
        f.setFilterName(type);
        f.setFilterId(intType);
        Map<Integer,String> filterValuesMap = new HashMap<Integer,String>();
        filterValuesMap.put(intFid, fidText);
        f.setFilterValues(filterValuesMap);
        list1 =  dBoardObj.getTimeSeriesGraph(comid,f);
        metList = dBoardObj.getFilterMetrics(comid,f);
    } else if(org != null && !org.equals("")){
        list1 =  dBoardObj.getOrganizationTimeSeriesGraph(comid);
        metList = dBoardObj.getOrganizationalMetrics(comid);
    }
    JSONArray jsonArray = new JSONArray();
    for(int i=0; i < metList.size(); i++) { 
        JSONObject matObj = new JSONObject();
        matObj.put("dataid", metList.get(i).getId());
        matObj.put("datascore", metList.get(i).getScore());
        matObj.put("dataavg", metList.get(i).getAverage());
        matObj.put("datadirection", metList.get(i).getDirection());
        jsonArray.put(matObj);
    } 
    response.setCharacterEncoding("utf-8");
    response.setHeader("Content-Type","text/json");
    JSONObject obj=new JSONObject(list1);
    JSONObject json = new JSONObject();
    json.put("data", obj);
    json.put("matdata", jsonArray);
    out.print(json.toString());
    
%>
         
        