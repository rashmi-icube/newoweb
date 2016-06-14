<%@page import="org.icube.owen.employee.LanguageDetails"%>
<%@page import="org.icube.owen.employee.EducationDetails"%>
<%@page import="org.icube.owen.employee.WorkExperience"%>
<%@page import="java.util.List"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.employee.EmployeeHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>
<% 
    String wid = request.getParameter("wid");
    String eid = request.getParameter("eid");
    String lid = request.getParameter("lid");
    EmployeeHelper eHelper =(EmployeeHelper) ObjectFactory.getInstance("org.icube.owen.employee.EmployeeHelper");
    if(wid != null) {
        eHelper.removeWorkExperience(comid, Util.getIntValue(wid));
        List<WorkExperience> expList = eHelper.getWorkExperienceDetails(comid, empid);
        for(int i =0; i< expList.size(); i++) {
        %>
        <div class="list-item clearfix">
            <div>
                <span class="item-title"><%=expList.get(i).getCompanyName() %></span>
                <span class="item-position"><%=expList.get(i).getDesignation() %></span>
                <span class="item-duration"> <%=Util.getDisplayDateFormat(expList.get(i).getStartDate(), "MMM y")  %> - <%=expList.get(i).getEndDate()== null ? "Present" :Util.getDisplayDateFormat(expList.get(i).getEndDate(), "MMM y") %>  <%=expList.get(i).getDuration() != null &&  !expList.get(i).getDuration().equals("") ? "("+expList.get(i).getDuration()+")" :"" %></span>
                <span class="item-location"><%=expList.get(i).getLocation() %></span>
            </div>   
            <button onClick="removeWorkExp(<%=expList.get(i).getWorkExperienceDetailsId() %>)">Remove position</button>
        </div>
        <% } 
    } else if(eid != null) {
        eHelper.removeEducation(comid, Util.getIntValue(eid));
        List<EducationDetails> eduList = eHelper.getEducationDetails(comid, empid);
        for(int i =0; i< eduList.size(); i++) {
        %>
        <div class="list-item clearfix">
            <div>
                <span class="item-title"><%=eduList.get(i).getInstitution() %></span>
                <span class="item-position"><%=eduList.get(i).getCertification() %></span>
                <span class="item-duration"><%=Util.getDisplayDateFormat(eduList.get(i).getStartDate(), "MMM y")  %> - <%=eduList.get(i).getEndDate()== null ? "Present" :Util.getDisplayDateFormat(eduList.get(i).getEndDate(), "MMM y") %></span>
                <span class="item-location"><%=eduList.get(i).getLocation() %></span>
            </div>  
            <button onClick="removeEducation(<%=eduList.get(i).getEducationDetailsId()%>)">Remove education</button>
        </div>
        <% }
    } else if(lid != null) {
        eHelper.removeLanguage(comid, Util.getIntValue(lid));
        List<LanguageDetails> langList = eHelper.getEmployeeLanguageDetails(comid, empid);
        for(int i =0; i< langList.size(); i++) {
        %>
        <div class="list-item clearfix">
            <div>
                <span class="item-title"><%=langList.get(i).getLanguageName()%></span>
            </div>
            <button onClick="removeLanguage(<%=langList.get(i).getLanguageDetailsId() %>)">Remove language</button>
        </div>
        <% } 
    }
%>