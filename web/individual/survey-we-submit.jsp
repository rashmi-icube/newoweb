<%-- 
    Document   : survey-we-submit
    Created on : Mar 9, 2016, 11:08:37 AM
    Author     : fermion10
--%>
<%@page import="java.util.Iterator"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.icube.owen.survey.ResponseHelper"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.icube.owen.survey.Question"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.survey.QuestionType"%>
<%@page import="java.util.List"%>

<%@include file="../common.jsp" %>
<%System.out.println("Entering survey-we-submit.jsp for empId : " + empid);
    int questionId = Util.getIntValue(request.getParameter("ques_id"));
    String empRating = request.getParameter("emp_rating");
    System.out.println("Starting survey-we-submit.jsp for empId : " + empid + " questionID : " + questionId);
    if (questionId > 0 && !empRating.isEmpty()) {
        try {
            System.out.println("Entering the try block in survey-we-submit.jsp for empID : " + empid + " question : " + questionId);
            JSONObject jObj = new JSONObject(request.getParameter("emp_rating"));
            ResponseHelper respObj = (ResponseHelper) ObjectFactory.getInstance("org.icube.owen.survey.ResponseHelper");
            Map<Employee, Integer> employeeRating = new HashMap<Employee, Integer>();
            Iterator<String> keys = jObj.keys();
            while (keys.hasNext()) {
                System.out.println("survey-we-submit.jsp for empId : " + empid + " questionID : " + questionId + " iterating through the jsonObj");
                String key = (String) keys.next();
                String rating = jObj.getString(key);
                int ratEmpId = Util.getIntValue(key);
                int ratVal = Util.getIntValue(rating);
                Employee employee = (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee");
                employee.setEmployeeId(ratEmpId);
                employee.setCompanyId(comid);
                employeeRating.put(employee, new Integer(ratVal));
                System.out.println("submit-we-submit.jsp ::" + comid + "::" + empid + "::" + questionId + "::" + ratEmpId + "::" + ratVal);
            }
            System.out.println("survey-we-submit.jsp for empId : " + empid + " questionID : " + questionId + " exiting the while loop");
            boolean subResp = respObj.saveWeResponse(comid, empid, questionId, employeeRating);
            //boolean subResp = true;
            JSONObject respJOBJ = new JSONObject();
            respJOBJ.put("status", subResp);
            if (subResp) {
                respJOBJ.put("message", "Successfully Saved");
                System.out.println("Successfully saved we response for empId : " + empid + " question : " + questionId);
            } else {
                respJOBJ.put("message", "Saving failed");
                System.out.println("Could not save we response for empId : " + empid + " question : " + questionId);
            }
            out.print(respJOBJ.toString());
            System.out.println("Exiting survey-we-submit.jsp for empId : " + empid + " questionID : " + questionId);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>