<%-- 
    Document   : survey-json
    Created on : Nov 17, 2016, 10:30:15 AM
    Author     : rashmi
--%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.individual.Login"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.icube.owen.survey.Question"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>


<%
    String username = request.getParameter("username") + "@tajhotels.com";
    String password = request.getParameter("password");
    int roleid = request.getParameter("roleid") != null ? Util.getIntValue(request.getParameter("roleid")) : 1;

    Login login = (Login) ObjectFactory.getInstance("org.icube.owen.individual.Login");
    try {
        Employee emp = login.login(username, password, request.getRemoteAddr(), roleid);
        session.setAttribute("empid", emp.getEmployeeId());
        session.setAttribute("comid", emp.getCompanyId());
        session.setAttribute("email", username);
        session.setAttribute("role", roleid);
        Question question = (Question) ObjectFactory.getInstance("org.icube.owen.survey.Question");

        String jsonQuestionList = question.getJsonEmployeeQuestionList(emp.getCompanyId(), emp.getEmployeeId());
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.getWriter().write(jsonQuestionList);

    } catch (Exception ex) {
        ex.printStackTrace();
        JSONObject json = new JSONObject();
        json.put("error", "Invalid Credential, Please try again.");
        response.setContentType("application/json");
        response.getWriter().write(json.toString());

    }
%>
