<%-- 
    Document   : survey-me-submit
    Created on : Mar 8, 2016, 11:08:37 AM
    Author     : fermion10
--%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.icube.owen.survey.ResponseHelper"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.icube.owen.survey.Question"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.survey.QuestionType"%>
<%@page import="java.util.List"%>
<%@include file="../common.jsp" %>
<%System.out.println("IHCL :::Entering survey-me-submit.jsp for empId : " + empid);
    String strCompId = request.getParameter("comp_id");
    String strEmpId = request.getParameter("emp_id");
    String strQuesId = request.getParameter("question_id");
    String feedback = request.getParameter("feedback");
    String strResp = request.getParameter("resp_val");
    System.out.println("IHCL :::Starting survey-me-submit.jsp for empId : " + strEmpId + " questionID : " + strQuesId);
    try {
        System.out.println("IHCL :::Entering the try block in survey-me-submit.jspfor empId : " + strEmpId + " questionID : " + strQuesId);
        int companyId = Util.getIntValue(strCompId);
        int employeeId = Util.getIntValue(strEmpId);
        int questionId = Util.getIntValue(strQuesId);
        int respVal = Util.getIntValue(strResp);
        ResponseHelper respObj = (ResponseHelper) ObjectFactory.getInstance("org.icube.owen.survey.ResponseHelper");
        System.out.println("IHCL :::submit-me-submit.jsp ::" + companyId + "::" + employeeId + "::" + questionId + "::" + respVal + "::" + feedback);

        boolean responseSaved = respObj.saveMeResponse(companyId, employeeId, questionId, respVal, feedback);
        JSONObject jObj = new JSONObject();
        jObj.put("status", responseSaved);

        if (responseSaved) {
            jObj.put("message", "Successfully Saved");
            System.out.println("IHCL :::Successfully saved me response for empId : " + empid + " question : " + questionId);
        } else {
            jObj.put("message", "Saving failed");
            System.out.println("IHCL :::Could not save me response for empId : " + empid + " question : " + questionId);
        }
        out.print(jObj.toString());
        System.out.println("IHCL :::Exiting survey-me-submit.jsp for empId : " + empid + " questionID : " + questionId);
    } catch (Exception e) {
        e.printStackTrace(System.out);
    }
%>