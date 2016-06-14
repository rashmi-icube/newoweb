<%-- 
    Document   : addlanguage
    Created on : Mar 10, 2016, 1:36:19 PM
    Author     : fermion10
--%>

<%@page import="com.owen.web.MessageConstant"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.icube.owen.employee.LanguageDetails"%>
<%@page import="java.util.List"%>
<%@page import="org.icube.owen.employee.EmployeeHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>
<% 
    EmployeeHelper eHelper =(EmployeeHelper) ObjectFactory.getInstance("org.icube.owen.employee.EmployeeHelper");
    String lid = request.getParameter("lid");
    JSONObject errorArray = new JSONObject();
    JSONObject resp = new JSONObject();
    if(lid != null) {
        LanguageDetails ld = new LanguageDetails();
        ld.setLanguageId(Util.getIntValue(lid));
        ld.setEmployeeId(empid);
        boolean result = eHelper.addLanguage(comid, ld);
        if(result) {
            resp.put("status", "1");
            List<LanguageDetails> langList = eHelper.getEmployeeLanguageDetails(comid, empid);
            StringBuilder sbuilder = new StringBuilder();
            for(int i =0; i< langList.size(); i++) {
                sbuilder.append("<div class=\"list-item clearfix\">");
                sbuilder.append("<div>");
                sbuilder.append("<span class=\"item-title\">"+langList.get(i).getLanguageName()+"</span>");
                sbuilder.append("</div>");
                sbuilder.append("<button onClick=\"removeLanguage("+langList.get(i).getLanguageDetailsId() +")\">Remove language</button>");
                sbuilder.append("</div>");
            }
            resp.put("data", sbuilder.toString());
        }else {
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