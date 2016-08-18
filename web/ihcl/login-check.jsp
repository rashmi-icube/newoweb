<%@page import="java.awt.Image"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.icube.owen.individual.Login"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="com.owen.web.Util"%>
<%
    String username = request.getParameter("username") + "@i-cube.in";
    String password = request.getParameter("password");
    int roleid = request.getParameter("roleid") != null ? Util.getIntValue(request.getParameter("roleid")) : 0;
    if (username != null && !username.equals("") && password != null && !password.equals("")) {
        Login login = (Login) ObjectFactory.getInstance("org.icube.owen.individual.Login");
        try {
            Employee emp = login.login(username, password, request.getRemoteAddr(), roleid);
            session.setAttribute("empid", emp.getEmployeeId());
            session.setAttribute("comid", emp.getCompanyId());
            session.setAttribute("email", username);
            session.setAttribute("ename", emp.getFirstName() + " " + (emp.getLastName() != null ? emp.getLastName() : ""));
            session.setAttribute("esname", emp.getFirstName().substring(0, 1).toUpperCase() + (emp.getLastName() != null ? emp.getLastName().substring(0, 1).toUpperCase() : ""));
            session.setAttribute( "firstTimeLogin", emp.isFirstTimeLogin());
            response.sendRedirect("survey.jsp");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("index.jsp?msg=Invalid Credential, Please try again.");
        }
    } else {
        response.sendRedirect("index.jsp");
    }
%>
