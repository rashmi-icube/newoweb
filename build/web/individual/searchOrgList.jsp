<%-- 
    Document   : dashboardsmartlist
    Created on : Mar 15, 2016, 7:11:15 PM
    Author     : fermion10
--%>
<%@page import="org.icube.owen.survey.Question"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.icube.owen.employee.EmployeeList"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="java.util.List"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.dashboard.IndividualDashboardHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>

 <div class="overlay"></div>
<div class="overlay_form">
    <img src="/assets/images/ajax-loader.gif">
</div>
<div class="individuals-grid">
<%  
    EmployeeList eList = (EmployeeList) ObjectFactory.getInstance("org.icube.owen.employee.EmployeeList"); 
    String keywords = request.getParameter("q");
    int metricId = request.getParameter("mid") != null ? Util.getIntValue(request.getParameter("mid")) : 0;
    int ques = request.getParameter("ques") != null ? Util.getIntValue(request.getParameter("ques")) : 0;
    
    List<Employee> mapSmartList = null;
    if(keywords != null && !keywords.equals("")) {
        mapSmartList = eList.getEmployeeMasterList(comid);
        keywords = keywords.toLowerCase();
    } else if( metricId != 0 ){
        IndividualDashboardHelper iDashboard =  (IndividualDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.IndividualDashboardHelper");
        mapSmartList = iDashboard.getSmartList(comid,empid, metricId);
    }else {
        Question question =  (Question) ObjectFactory.getInstance("org.icube.owen.survey.Question");
        mapSmartList =  question.getSmartListForQuestion(comid, empid, question.getQuestion(comid,ques));
    }
    if(mapSmartList != null) {
        for (int incr=0; incr<mapSmartList.size(); incr++) { 
          Employee employee = mapSmartList.get(incr);
            if(empid == employee.getEmployeeId()) {
                continue;
            }
            String firstName = employee.getFirstName() != null ? employee.getFirstName().toLowerCase(): "";
            String lastName = employee.getLastName() != null ? employee.getLastName().toLowerCase(): "";
            String name = firstName+" "+lastName;
            name = name.trim();
            if(name.indexOf(keywords) >= 0 || firstName.indexOf(keywords) >=0 || lastName.indexOf(keywords) >=0  ){
        %>
        <div class="individual-cell clearfix">
            <button class="get-person-info">
                <span>i</span>
            </button>
            <div class="individual-card">
                <div class="front-card">
                    <div style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=employee.getCompanyId()%>&eid=<%=employee.getEmployeeId()%>');" class="person-pic"></div>
                </div>
                <div class="back-card">
                    <ul>
                        <li><%=employee.getZone() %></li>
                        <li><%=employee.getFunction() %></li>
                        <li><%=employee.getPosition() %></li>
                    </ul>
                </div>
            </div>
            <span class="individual-cell-name"><%= employee.getFirstName() + " " + employee.getLastName() %></span>
            <div class="star-rating-row clearfix">
                <div class="rating-stars">
                    <span class="rating-star"></span>
                    <span class="rating-star"></span>
                    <span class="rating-star"></span>
                    <span class="rating-star"></span>
                    <span class="rating-star"></span>
                </div>
                <% if(ques == 0) { %>
                    <span class="star-rating-total" ques_id="<%= ques %>" id="rat_<%= employee.getEmployeeId() %>" emp_id="<%= employee.getEmployeeId() %>"></span>
                <% }else { %>
                    <span class="star-rating-total" ques_id="<%= ques %>" id="rat_<%= ques %>_<%= employee.getEmployeeId() %>" emp_id="<%= employee.getEmployeeId() %>"></span>
                <% } %>
            </div>
        </div>
    <% }
    }
    }%>
</div>
    
<script>
    $('.get-person-info').on('click', function() {
		$(this).toggleClass('flip');
		$(this).next('div').toggleClass('flip');
	});

	$('.rating-star').on('click', function() {
		var row = $(this).parent();
		var i = $(this).index();
		var lastStar = $(row).find('.filled:last').index();
		var total = i+1;

		if(lastStar === i) {
			$(row).children().removeClass('filled');
			$(row).next().text('0').removeAttr('style');
		} else {
			$(this).nextAll().removeClass('filled');
			for(var n=0; n<=i; n++) {
				$(row).children('span:eq('+n+')').addClass('filled');
			}
			$(row).next().text(total).css('visibility', 'visible');
		}
        saveRating();
	});
</script>