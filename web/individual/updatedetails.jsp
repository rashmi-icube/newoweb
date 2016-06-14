<%-- 
    Document   : updatedetails
    Created on : Mar 10, 2016, 2:17:28 PM
    Author     : fermion10
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="org.icube.owen.dashboard.IndividualDashboardHelper"%>
<%@page import="com.owen.web.MessageConstant"%>
<%@page import="org.icube.owen.employee.BasicEmployeeDetails"%>
<%@page import="org.icube.owen.employee.EmployeeHelper"%>
<%@page import="org.icube.owen.individual.Login"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>
<%
    String type = request.getParameter("type"); //cpass, odetails
    boolean validate = true;
    JSONObject errorArray = new JSONObject();
    JSONObject resp = new JSONObject();
    if(type != null && type.equals("cpass")) {
        String oldpass = request.getParameter("oldpass");
        String newpass = request.getParameter("newpass");
        String newConfirmpass = request.getParameter("newConfirmpass");
        if(oldpass != null && newpass != null && newConfirmpass != null) {
            Login login =  (Login) ObjectFactory.getInstance("org.icube.owen.individual.Login");
            try {
                //Employee emp = login.login(email, oldpass,request.getRemoteAddr());
                IndividualDashboardHelper iDashboard =  (IndividualDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.IndividualDashboardHelper");
                boolean result = iDashboard.changePassword(comid, empid, oldpass, newpass);
                if(result) {
                    resp.put("status", "1");
                    resp.put("msg", "Password changed successful.");
                } else {
                   resp.put("status", "0");
                   resp.put("msg", "Current password not correct.");
                   //resp.put("msg", MessageConstant.SYSTEM_ERROR);
                }
            }catch(Exception ex) {
                resp.put("status", "0");
                resp.put("msg", "Current password not correct.");
            }
        } else {
            resp.put("status", "0");
            resp.put("msg", "Please provide all details");
        }
    }else if(type != null && type.equals("odetails")) {
         String phone = request.getParameter("phone");
        if(phone != null) {
            EmployeeHelper eHelper =(EmployeeHelper) ObjectFactory.getInstance("org.icube.owen.employee.EmployeeHelper");
            BasicEmployeeDetails beDetails =  eHelper.getBasicEmployeeDetails(comid,empid);
            beDetails.setPhone(phone);
            boolean result = eHelper.updateBasicDetails(comid, beDetails);
             if(result) {
                resp.put("status", "1");
                resp.put("msg", "Record updated successful.");
             } else {
                resp.put("status", "0");
                resp.put("msg", MessageConstant.SYSTEM_ERROR);;
             }
        } else {
            resp.put("status", "0");
            resp.put("msg", "Please provide all details");
        }
    }
    out.print(resp.toString());
%>