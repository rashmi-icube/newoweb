<%-- 
    Document   : survey-we-submit
    Created on : Mar 9, 2016, 11:08:37 AM
    Author     : fermion10
--%>
<%@page import="java.util.Iterator"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.icube.owen.survey.ResponseHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.survey.QuestionType"%>
<%@page import="org.icube.owen.survey.Response"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@include file="../common.jsp" %>
<%System.out.println("IHCL :::Entering survey-we-submit.jsp for empId : " + empid);

    String empRating = request.getParameter("emp_rating");
    System.out.println("IHCL :::Starting survey-we-submit.jsp for empId : " + empid);
    if (!empRating.isEmpty()) {
        try {
            System.out.println("IHCL :::Entering the try block in survey-we-submit.jsp for empID : " + empid);
            JSONObject jObj = new JSONObject(request.getParameter("emp_rating"));
            ResponseHelper responseHelper = (ResponseHelper) ObjectFactory.getInstance("org.icube.owen.survey.ResponseHelper");
            Iterator<String> keys = jObj.keys();
            List<Response> responseList = new ArrayList();
            while (keys.hasNext()) {
                System.out.println("IHCL :::survey-we-submit.jsp for empId : " + empid /*+ " questionID : " + questionId*/ + " iterating through the jsonObj");
                String key = (String) keys.next();
                String rating = jObj.getString(key);
                String[] ques_emp = key.split("_");
                String quesId = ques_emp[0];
                int questionId = Util.getIntValue(quesId);
                int ratEmpId = Util.getIntValue(ques_emp[1]);
                int ratVal = Util.getIntValue(rating);
                Response respObj = new Response();
                respObj.setQuestionId(questionId);
                respObj.setQuestionType(QuestionType.WE);
                respObj.setResponseValue(ratVal);
                respObj.setTargetEmployee(ratEmpId);
                responseList.add(respObj);
                System.out.println("IHCL :::submit-we-submit.jsp ::" + comid + "::" + empid + "::" + questionId + "::" + ratEmpId + "::" + ratVal);
            }
            System.out.println("Response list size :::: " + responseList.size());
            System.out.println("IHCL :::survey-we-submit.jsp for empId : " + empid + " exiting the while loop");
            boolean subResp = responseHelper.saveAllResponses(comid, empid, responseList);
            JSONObject respJOBJ = new JSONObject();
            respJOBJ.put("status", subResp);
            if (subResp) {
                respJOBJ.put("message", "Successfully Saved");
                System.out.println("IHCL :::Successfully saved we response for empId : " + empid);
            } else {
                respJOBJ.put("message", "Saving failed");
                System.out.println("IHCL :::Could not save we response for empId : " + empid);
            }
            out.print(respJOBJ.toString());
            System.out.println("IHCL :::Exiting survey-we-submit.jsp for empId : " + empid);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>