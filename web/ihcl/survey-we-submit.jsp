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
<%@page import="org.icube.owen.survey.Response"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.icube.owen.survey.Question"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.survey.QuestionType"%>
<%@page import="java.util.List"%>

<%@include file="../common.jsp" %>
<%//    out.println("QUESTION:"+request.getParameter("ques_id"));
//    out.println("RATING:"+request.getParameter("emp_rating"));
    int questionId = Util.getIntValue(request.getParameter("ques_id"));
    String empRating = request.getParameter("emp_rating");
    int relationId = Util.getIntValue(request.getParameter("rela_val"));
    if (questionId > 0 && !empRating.isEmpty()) {
        try {
            JSONObject jObj = new JSONObject(request.getParameter("emp_rating"));
//            Question question = (Question) ObjectFactory.getInstance("org.icube.owen.survey.Question");
//            Question quesObj = question.getQuestion(comid, questionId);
//            quesObj.setRelationshipTypeId(relationId);
            Response respObj = (Response) ObjectFactory.getInstance("org.icube.owen.survey.Response");
            //System.out.println("HERE:"+companyId+"::"+employeeId+"::"+quesObj+"::"+respVal+"::"+feedback+"::"+quesObj.getRelationshipTypeId());
            Map<Employee, Integer> employeeRating = new HashMap<Employee, Integer>();

            Iterator<String> keys = jObj.keys();
            while (keys.hasNext()) {
                String key = (String) keys.next();
                String rating = jObj.getString(key);
                int ratEmpId = Util.getIntValue(key);
                int ratVal = Util.getIntValue(rating);
                Employee employee = (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee");
                employee.setEmployeeId(ratEmpId);
                employee.setCompanyId(comid);
                employeeRating.put(employee, new Integer(ratVal));
            }
            // System.out.println("empid :::::::: " + empid);
            // System.out.println("quesObj :::::::: " + quesObj.getQuestionId());
            // System.out.println("employeeRating :::::::: " + employeeRating.toString());

            boolean subResp = respObj.saveWeResponse(comid, empid, questionId, employeeRating);
            //boolean subResp = true;
            JSONObject respJOBJ = new JSONObject();
            respJOBJ.put("status", subResp);
            if (subResp) {
                respJOBJ.put("message", "Successfully Saved");
            } else {
                respJOBJ.put("message", "Saving failed");
            }
            out.print(respJOBJ.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>