<%-- 
    Document   : addworkexperience
    Created on : Mar 10, 2016, 1:35:59 PM
    Author     : fermion10
--%>
<%@page import="com.owen.web.MessageConstant"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.employee.WorkExperience"%>
<%@page import="java.util.List"%>
<%@page import="org.icube.owen.employee.EmployeeHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>
<% 
    EmployeeHelper eHelper =(EmployeeHelper) ObjectFactory.getInstance("org.icube.owen.employee.EmployeeHelper");
    String cName = request.getParameter("cname");
    String position = request.getParameter("position");
    String fromdate = request.getParameter("fromdate");
    String todate = request.getParameter("todate");
    String location = request.getParameter("location");
    boolean validate = true;
    JSONObject errorArray = new JSONObject();
    JSONObject resp = new JSONObject();
    if(Util.isEmpty(cName)) {
        validate = false;
        errorArray.put("cname", "Organization name is Mandatory.");
    } else if(!Util.isTextWithMinLength(cName, 2)) {
        validate = false;
        errorArray.put("cname", "Organization name is not valid.");
    } else if(!Util.isEmpty(cName) && !Util.validateLength(cName, 2, 100)) {
        validate = false;
        errorArray.put("cname", "Organization name length should be between 2 and 100.");
    }
    if(Util.isEmpty(position)) {
        validate = false;
        errorArray.put("position", "Position is Mandatory.");
    } else if(!Util.isTextWithMinLength(position, 2)) {
        validate = false;
        errorArray.put("position", "Position is not valid.");
    } else if(!Util.isEmpty(position) && !Util.validateLength(position, 2, 100)) {
        validate = false;
        errorArray.put("position", "Position length should be between 2 and 100.");
    }
    if(validate) {
        WorkExperience wExp = new WorkExperience();
        wExp.setCompanyName(cName);
        wExp.setDesignation(position);
        wExp.setStartDate(Util.getStringToDate(fromdate, "dd/MM/yyyy"));
        if(todate.isEmpty()) {
            wExp.setEndDate(null);
        }else {
            wExp.setEndDate(Util.getStringToDate(todate, "dd/MM/yyyy"));
        }
        wExp.setLocation(location);
        wExp.setEmployeeId(empid);
        boolean result = eHelper.addWorkExperience(comid, wExp);
        if(result) {
            resp.put("status", "1");
            List<WorkExperience> expList = eHelper.getWorkExperienceDetails(comid, empid);
            StringBuilder sbuilder = new StringBuilder();
            for(int i =0; i< expList.size(); i++) {
                sbuilder.append("<div class=\"list-item clearfix\">");
                sbuilder.append("<div>");
                sbuilder.append("<span class=\"item-title\">"+expList.get(i).getCompanyName()+"</span>");
                sbuilder.append("<span class=\"item-position\">"+expList.get(i).getDesignation() +"</span>");
                sbuilder.append("<span class=\"item-duration\">"+Util.getDisplayDateFormat(expList.get(i).getStartDate(), "MMM y")  +" - "+(expList.get(i).getEndDate()== null ? "Present" : Util.getDisplayDateFormat(expList.get(i).getEndDate(), "MMM y") )+ " " +(expList.get(i).getDuration() != null && !expList.get(i).getDuration().equals("") ? "("+expList.get(i).getDuration()+")" :"") +"</span>");
                sbuilder.append("<span class=\"item-location\">"+expList.get(i).getLocation() +"</span>");
                sbuilder.append("</div>");
                sbuilder.append("<button onClick=\"removeWorkExp("+expList.get(i).getWorkExperienceDetailsId() +")\">Remove position</button>");
                sbuilder.append("</div>");
            }
            resp.put("data", sbuilder.toString());
        } else {
            resp.put("status", "0");
            errorArray.put("msg", MessageConstant.SYSTEM_ERROR);
            resp.put("error", errorArray);
        }
    } else {
        resp.put("status", "0");
        resp.put("error", errorArray);
    }
    out.print(resp.toString());
%>   