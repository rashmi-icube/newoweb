<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItemStream"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItemIterator"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.awt.Image"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.icube.owen.employee.EmployeeHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.employee.BasicEmployeeDetails"%>
<%@include file="../common.jsp" %>
<%
    JSONObject jsonObj = new JSONObject();
    ServletFileUpload upload = new ServletFileUpload();
    FileItemIterator iter = upload.getItemIterator(request);
    if (iter.hasNext()) {
        FileItemStream item = iter.next();
        InputStream stream = item.openStream();
        if (!item.isFormField()) {
            Employee emp = (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee");
            File tmpdir = (File)application.getAttribute("javax.servlet.context.tempdir");
            File file =  Util.saveFile(tmpdir.getAbsolutePath(), comid+"_"+empid+".jpg", stream, 8192, true);
            Image image = ImageIO.read(file);
            boolean saved = emp.saveImage(comid, empid, image);
            if(saved) {
                jsonObj.put("status", 1);
            }else {
                jsonObj.put("status", 0);
            }
        }else {
            jsonObj.put("status", 0);
        }
    }else {
        jsonObj.put("status", 0);
    }
    out.println(jsonObj.toString());
%>