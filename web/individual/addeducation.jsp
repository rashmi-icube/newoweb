<%-- 
    Document   : addeducation
    Created on : Mar 10, 2016, 1:36:10 PM
    Author     : fermion10
--%>

<%@page import="com.owen.web.MessageConstant"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.employee.EducationDetails"%>
<%@page import="java.util.List"%>
<%@page import="org.icube.owen.employee.EmployeeHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>
<% 
    EmployeeHelper eHelper =(EmployeeHelper) ObjectFactory.getInstance("org.icube.owen.employee.EmployeeHelper");
    String iname = request.getParameter("iname");
    String qualification = request.getParameter("qualification");
    String fromdate = request.getParameter("fromdate");
    String todate = request.getParameter("todate");
    String location = request.getParameter("location");
    
    boolean validate = true;
    JSONObject errorArray = new JSONObject();
    JSONObject resp = new JSONObject();
    if(Util.isEmpty(iname)) {
        validate = false;
        errorArray.put("iname", "Institution name is Mandatory.");
    } else if(!Util.isTextWithMinLength(iname, 2)) {
        validate = false;
        errorArray.put("iname", "Institution name is not valid.");
    } else if(!Util.isEmpty(iname) && !Util.validateLength(iname, 2, 100)) {
        validate = false;
        errorArray.put("cname", "Institution name length should be between 2 and 100.");
    }
    if(Util.isEmpty(qualification)) {
        validate = false;
        errorArray.put("qualification", "Qualification is Mandatory.");
    } else if(!Util.isTextWithMinLength(qualification, 2)) {
        validate = false;
        errorArray.put("qualification", "Qualification is not valid.");
    } else if(!Util.isEmpty(qualification) && !Util.validateLength(qualification, 2, 100)) {
        validate = false;
        errorArray.put("qualification", "Qualification length should be between 2 and 100.");
    }
    if(validate) {
        EducationDetails eDetails = new EducationDetails();
        eDetails.setInstitution(iname);
        eDetails.setCertification(qualification);
        eDetails.setStartDate(Util.getStringToDate(fromdate, "dd/MM/yyyy"));
        eDetails.setEndDate(Util.getStringToDate(todate, "dd/MM/yyyy"));
        eDetails.setLocation(location);
        eDetails.setEmployeeId(empid);
        boolean result = eHelper.addEducation(comid, eDetails);
        
        if(result) {
            resp.put("status", "1");
            List<EducationDetails> eduList = eHelper.getEducationDetails(comid, empid);
            StringBuilder sbuilder = new StringBuilder();
            for(int i =0; i< eduList.size(); i++) {
                sbuilder.append("<div class=\"list-item clearfix\">");
                sbuilder.append("<div>");
                sbuilder.append("<span class=\"item-title\">"+eduList.get(i).getInstitution()+"</span>");
                sbuilder.append("<span class=\"item-position\">"+eduList.get(i).getCertification()  +"</span>");
                sbuilder.append("<span class=\"item-duration\">"+Util.getDisplayDateFormat(eduList.get(i).getStartDate(), "MMM y")  +" - "+ Util.getDisplayDateFormat(eduList.get(i).getEndDate(), "MMM y") +"</span>");
                sbuilder.append("<span class=\"item-location\">"+eduList.get(i).getLocation() +"</span>");
                sbuilder.append("</div>");
                sbuilder.append("<button onClick=\"removeEducation("+eduList.get(i).getEducationDetailsId() +")\">Remove education</button>");
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