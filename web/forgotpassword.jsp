<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.icube.owen.dashboard.IndividualDashboardHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.json.JSONObject"%>
<%@page trimDirectiveWhitespaces="true" %>
<%
String email = request.getParameter("email");
JSONObject jsonObj = new JSONObject();
if(email != null && !email.equals("")) {
    IndividualDashboardHelper iDashboard = (IndividualDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.IndividualDashboardHelper");
    try {
        boolean status = iDashboard.generateNewPassword(email);
        if(status) {
            jsonObj.put("status", 0);
            jsonObj.put("msg", "New password sent.");
        } else {
            jsonObj.put("status", 1);
            jsonObj.put("msg", "Please try again.");
        }
    } catch(Exception ex) {
        jsonObj.put("status", 1);
        jsonObj.put("msg", "Please try again.");
    }
} else {
    jsonObj.put("status", 1);
    jsonObj.put("msg", "Please provide valid email.");
}
out.println(jsonObj.toString());
%>