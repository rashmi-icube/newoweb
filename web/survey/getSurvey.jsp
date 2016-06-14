<%-- 
    Document   : getSurvey
    Created on : Feb 12, 2016, 7:19:15 PM
    Author     : fermion10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.survey.QuestionList"%>
<%@page import="org.icube.owen.survey.Question"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@page import="org.icube.owen.survey.Batch"%>
<%@page import="org.icube.owen.survey.BatchList"%>
<%@page import="org.icube.owen.survey.Frequency"%>
<%@include file="../common.jsp" %>
<%
    String status = request.getParameter("status");
    String frequency = request.getParameter("frequency");
    BatchList bListObj = (BatchList) ObjectFactory.getInstance("org.icube.owen.survey.BatchList");
    Batch currBatch = bListObj.getCurrentBatch(comid);
    if(frequency != null && !frequency.equals("")) {
        status = "Upcoming";
        bListObj.changeFrequency(comid,currBatch, Frequency.get(Util.getIntValue(frequency)));
    }
    QuestionList qListObj =  (QuestionList) ObjectFactory.getInstance("org.icube.owen.survey.QuestionList");
    List<Question> qlist = qListObj.getQuestionListByStatus(comid,currBatch.getBatchId(), status);
    for(int i=0; i<qlist.size(); i++) { %>
    <% if(status.equals("Completed"))  { %>
        <tr class="question-name-date">
            <td><%=(i+1)%></td>
            <td class="question-name"><%=qlist.get(i).getQuestionText()%>?</td>
            <td><%=Util.getDisplayDateFormat(qlist.get(i).getEndDate(), "dd MMM") %></td>
            <td><%=qlist.get(i).getResponsePercentage() %>%</td>
            <td>
            <%
                Map<Date, Integer> treeMap1 = new TreeMap<Date, Integer>(qlist.get(i).getResponse(comid,qlist.get(i)));
            %>
            <script>
                var QRArray<%=i%> = [
                    <%
                        for (Map.Entry<Date, Integer> entry : treeMap1.entrySet()) {
                         %>{
                            "category": "<%=Util.getDisplayDateFormat(entry.getKey(),"yyyy-MM-dd")%>",
                            "column-1": "<%=entry.getValue()%>"
                         },
                        <%}
                    %>
                ];
            </script>
                <a title="View responses" onClick="generateGraph('chartTable<%=i%>', QRArray<%=i%>,this)">View responses</a>
            </td>
        </tr>
        <tr>
            <td colspan="5">
                <div id="chartTable<%=i%>" style="width: 100%; height: 170px; background-color: #fff;" ></div>
            </td>
        </tr>
    <%} else { %>
        <tr class="question-name-date">
           <td><%=(i+1)%></td>
           <td class="question-name"><%=qlist.get(i).getQuestionText()%>?</td>
           <td><%=Util.getDisplayDateFormat(qlist.get(i).getStartDate(), "dd MMM") %></td>
           <td><%=Util.getDisplayDateFormat(qlist.get(i).getEndDate(), "dd MMM") %></td>
           <td><a>Edit</a></td>
       </tr>
    <%
    } 
} %>