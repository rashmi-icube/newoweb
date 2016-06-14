<%-- 
    Document   : dashboardsmartlist
    Created on : Mar 15, 2016, 7:11:15 PM
    Author     : fermion10
--%>
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
    <img src="<%=Constant.WEB_ASSETS%>images/ajax-loader.gif">
</div>
<div class="individuals-grid">
<%  int filterIdGeo = request.getParameter("Geography") != null ? Util.getIntValue(request.getParameter("Geography")) : 0;
    int filterIdFun = request.getParameter("Function") != null ? Util.getIntValue(request.getParameter("Function")) : 0;
    int filterIdLevel = request.getParameter("Level") != null ? Util.getIntValue(request.getParameter("Level")) : 0;
    String filterValGeo = request.getParameter("Geography_name");
    String filterValFun = request.getParameter("Function_name");
    String filterValLevel = request.getParameter("Level_name");
    
    int geoId = request.getParameter("Geography_id") != null ? Util.getIntValue(request.getParameter("Geography_id")) :0;
    int funId = request.getParameter("Function_id") != null ? Util.getIntValue(request.getParameter("Function_id")) :0;
    int levelId = request.getParameter("Level_id") != null ? Util.getIntValue(request.getParameter("Level_id")) :0;
    
    List<Employee> mapSmartList = null;
    if((filterIdGeo >= 0 && filterValGeo != null) || (filterIdFun >= 0 && filterValFun != null) || (filterIdLevel >= 0 && filterValLevel != null)) {
        EmployeeList employeeListObj = (EmployeeList) ObjectFactory.getInstance("org.icube.owen.employee.EmployeeList");
        List<Filter> listFilter = new ArrayList<Filter>();
        if(filterIdGeo != 0 && filterValGeo != null) {
            Filter filter = (Filter) ObjectFactory.getInstance("org.icube.owen.filter.Filter");
            filter.setFilterId(geoId);
            filter.setFilterName(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);        
            // out.println(filter.getFilterId());  
            Map<Integer,String> filterValuesMap = new HashMap<Integer,String>();
            filterValuesMap.put(filterIdGeo, filterValGeo);
            filter.setFilterValues(filterValuesMap);
            listFilter.add(filter);
        }
        if(filterIdFun != 0 && filterValFun != null) {
            Filter filter = (Filter) ObjectFactory.getInstance("org.icube.owen.filter.Filter");
            filter.setFilterId(funId);
            filter.setFilterName(Constant.INITIATIVES_FUNCTION_FILTER_NAME);
            Map<Integer,String> filterValuesMap = new HashMap<Integer,String>();
            filterValuesMap.put(filterIdFun, filterValFun);
            filter.setFilterValues(filterValuesMap);
            listFilter.add(filter);
        }
        if(filterIdLevel != 0 && filterValLevel != null) {
            Filter filter = (Filter) ObjectFactory.getInstance("org.icube.owen.filter.Filter");
            filter.setFilterId(levelId);
            filter.setFilterName(Constant.INITIATIVES_LEVEL_FILTER_NAME);
            Map<Integer,String> filterValuesMap = new HashMap<Integer,String>();
            filterValuesMap.put(filterIdLevel, filterValLevel);
            filter.setFilterValues(filterValuesMap);
            listFilter.add(filter);
        }
        mapSmartList =  employeeListObj.getEmployeeListByFilters(comid, listFilter);
    }else {
        int metricId = Util.getIntValue(request.getParameter("mid"));
        if(metricId > 0) {
            IndividualDashboardHelper iDashboard =  (IndividualDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.IndividualDashboardHelper");
            mapSmartList = iDashboard.getSmartList(comid,empid, metricId);

        }
    }
       if(mapSmartList != null) {
        for (int incr=0; incr<mapSmartList.size(); incr++) { 
          Employee employee = mapSmartList.get(incr);
          if(empid == employee.getEmployeeId()) {
                continue;
            }
        //employee.g
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
                <span class="star-rating-total" id="rat_<%= employee.getEmployeeId() %>" emp_id="<%= employee.getEmployeeId() %>"></span>
            </div>
        </div>
    <%
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