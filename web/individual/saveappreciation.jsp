<%-- 
    Document   : saveappreciation
    Created on : Mar 15, 2016, 8:40:14 PM
    Author     : fermion10
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="org.icube.owen.dashboard.IndividualDashboardHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.owen.web.Util"%>
<%@include file="../common.jsp" %>
<%
    int metricId = Util.getIntValue(request.getParameter("mid"));
    String empRating = request.getParameter("emp_rating");
    if(metricId > 0 && !empRating.isEmpty()) {
        try {
            JSONObject jObj = new JSONObject(request.getParameter("emp_rating"));
            Map<Employee, Integer> employeeRating = new HashMap<Employee, Integer>();
            
            Iterator<String> keys = jObj.keys();
            while( keys.hasNext() ) {
                String key = (String)keys.next();
                String rating = jObj.getString(key);
                int ratEmpId = Util.getIntValue(key);
                int ratVal = Util.getIntValue(rating);
                Employee employee = (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee");
                employee.setEmployeeId(ratEmpId);
                employee.setCompanyId(comid);
                employeeRating.put(employee, new Integer(ratVal));
            }
            IndividualDashboardHelper iDashboard =  (IndividualDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.IndividualDashboardHelper");
            boolean subResp = iDashboard.saveAppreciation(comid, empid, metricId, employeeRating);
            JSONObject respJOBJ = new JSONObject();
            if(subResp) {
                 respJOBJ.put("status", 1);
                respJOBJ.put("message", "Successfully Saved");
            }else {
                respJOBJ.put("status", 0);
                respJOBJ.put("message", "Saving failed");
            }
            out.print(respJOBJ.toString());
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
%>