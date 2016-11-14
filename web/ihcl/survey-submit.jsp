<%@page import="java.util.Iterator"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.icube.owen.survey.ResponseHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.survey.QuestionType"%>
<%@page import="org.icube.owen.survey.Response"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@include file="../common.jsp" %>
<%System.out.println("IHCL :::Entering survey-submit.jsp for empId : " + empid);
    String empRating = request.getParameter("emp_rating");
    System.out.println("IHCL :::Starting survey-submit.jsp for empId : " + empid);
    if (!empRating.isEmpty()) {
        try {
            System.out.println("IHCL :::Entering the try block in survey-submit.jspfor empId : " + empid);
            JSONArray arr = new JSONArray(request.getParameter("emp_rating"));
            ResponseHelper responseHelper = (ResponseHelper) ObjectFactory.getInstance("org.icube.owen.survey.ResponseHelper");
            List<Response> responseList = new ArrayList();
            for (int i = 0; i < arr.length(); i++) {
                JSONObject jObj = arr.getJSONObject(i);
                System.out.println("IHCL :::survey-submit.jsp for empId : " + empid + " iterating through the jsonObj");
                Iterator<String> keys = jObj.keys();
                Response respObj = new Response();
                while (keys.hasNext()) {
                    String key = (String) keys.next();
                    if (key.equals("companyId")) {
                        respObj.setCompanyId(Util.getIntValue(jObj.getString(key)));
                    } else if (key.equals("employeeId")) {
                        respObj.setEmployeeId(Util.getIntValue(jObj.getString(key)));
                    } else if (key.equals("questionId")) {
                        respObj.setQuestionId(jObj.getInt(key));
                    } else if (key.equals("questionType")) {
                        respObj.setQuestionType(QuestionType.valueOf(jObj.getString(key)));
                    } else if (key.equals("responseValue")) {
                        respObj.setResponseValue(Util.getIntValue(jObj.getString(key)));
                    } else if (key.equals("targetEmployee") && (!(jObj.getString(key)).isEmpty())) {
                        respObj.setTargetEmployee(Util.getIntValue(jObj.getString(key)));
                    }
                }
                responseList.add(respObj);
                System.out.println("IHCL :::submit-we-submit.jsp ::" + comid + "::" + empid);
            }
            System.out.println("Response list size :::: " + responseList.size());
            System.out.println("IHCL :::survey-submit.jsp for empId : " + empid + " exiting the while loop");
            boolean subResp = responseHelper.saveAllResponses(responseList);
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
            System.out.println("IHCL :::Exiting survey-submit.jsp for empId : " + empid);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>