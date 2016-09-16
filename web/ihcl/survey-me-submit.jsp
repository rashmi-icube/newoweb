<%-- 
    Document   : survey-me-submit
    Created on : Mar 8, 2016, 11:08:37 AM
    Author     : fermion10
--%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.icube.owen.survey.Response"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.icube.owen.survey.Question"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.survey.QuestionType"%>
<%@page import="java.util.List"%>
<%@include file="../common.jsp" %>
<%
    String strCompId = request.getParameter("comp_id");
    String strEmpId = request.getParameter("emp_id");
    String strQuesId = request.getParameter("question_id");
    String feedback = request.getParameter("feedback");
    String strResp = request.getParameter("resp_val");
    String strRela = request.getParameter("rela_val");
    try {
        int companyId = Util.getIntValue(strCompId);
        int employeeId = Util.getIntValue(strEmpId);
        int questionId = Util.getIntValue(strQuesId);
        int respVal = Util.getIntValue(strResp);
        int relaVal = Util.getIntValue(strRela);
        Question question =  (Question) ObjectFactory.getInstance("org.icube.owen.survey.Question");
        Question quesObj = question.getQuestion(comid, questionId);
        quesObj.setRelationshipTypeId(relaVal);
        Response respObj = (Response) ObjectFactory.getInstance("org.icube.owen.survey.Response");
        // System.out.println("HERE:"+companyId+"::"+employeeId+"::"+quesObj+"::"+respVal+"::"+feedback+"::"+quesObj.getRelationshipTypeId());
        
        boolean  responseSaved = respObj.saveMeResponse(companyId, employeeId, quesObj, respVal, feedback);
        JSONObject jObj = new JSONObject();
        //boolean responseSaved = true;
        jObj.put("status", responseSaved);
        
        if(responseSaved) {
            jObj.put("message", "Successfully Saved");
        }else {
            jObj.put("message", "Saving failed");
        }
        out.print(jObj.toString());
    }catch(Exception e) {
        e.printStackTrace(System.out);
    }
%>