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
    <%
        int questionId = Util.getIntValue(request.getParameter("questionId"), 0);
        int filterIdGeo = Util.getIntValue(request.getParameter("Geography"), 0);
        int filterIdFun = Util.getIntValue(request.getParameter("Function"), 0);
        int filterIdLevel = Util.getIntValue(request.getParameter("Level"), 0);
        String filterValGeo = request.getParameter("Geography_name");
        String filterValFun = request.getParameter("Function_name");
        String filterValLevel = request.getParameter("Level_name");

        int geoId = Util.getIntValue(request.getParameter("Geography_id"), 0);
        int funId = Util.getIntValue(request.getParameter("Function_id"), 0);
        int levelId = Util.getIntValue(request.getParameter("Level_id"), 0);

        int metricId = Util.getIntValue(request.getParameter("mid"));
        List<Employee> mapSmartList = null;
        if ((filterIdGeo >= 0 && filterValGeo != null) || (filterIdFun >= 0 && filterValFun != null) || (filterIdLevel >= 0 && filterValLevel != null)) {
            EmployeeList employeeListObj = (EmployeeList) ObjectFactory.getInstance("org.icube.owen.employee.EmployeeList");
            List<Filter> listFilter = new ArrayList<Filter>();
            if (filterIdGeo != 0 && filterValGeo != null) {
                Filter filter = (Filter) ObjectFactory.getInstance("org.icube.owen.filter.Filter");
                filter.setFilterId(geoId);
                filter.setFilterName(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                // out.println(filter.getFilterId());  
                Map<Integer, String> filterValuesMap = new HashMap<Integer, String>();
                filterValuesMap.put(filterIdGeo, filterValGeo);
                filter.setFilterValues(filterValuesMap);
                listFilter.add(filter);
            }
            if (filterIdFun != 0 && filterValFun != null) {
                Filter filter = (Filter) ObjectFactory.getInstance("org.icube.owen.filter.Filter");
                filter.setFilterId(funId);
                filter.setFilterName(Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                Map<Integer, String> filterValuesMap = new HashMap<Integer, String>();
                filterValuesMap.put(filterIdFun, filterValFun);
                filter.setFilterValues(filterValuesMap);
                listFilter.add(filter);
            }
            if (filterIdLevel != 0 && filterValLevel != null) {
                Filter filter = (Filter) ObjectFactory.getInstance("org.icube.owen.filter.Filter");
                filter.setFilterId(levelId);
                filter.setFilterName(Constant.INITIATIVES_LEVEL_FILTER_NAME);
                Map<Integer, String> filterValuesMap = new HashMap<Integer, String>();
                filterValuesMap.put(filterIdLevel, filterValLevel);
                filter.setFilterValues(filterValuesMap);
                listFilter.add(filter);
            }
            mapSmartList = employeeListObj.getEmployeeListByFilters(comid, listFilter);
        } else {
            metricId = Util.getIntValue(request.getParameter("mid"));
            if (metricId > 0) {
                IndividualDashboardHelper iDashboard = (IndividualDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.IndividualDashboardHelper");
                mapSmartList = iDashboard.getSmartList(comid, empid, metricId);
                // out.println("mapSmartList ::::::::::::: " + mapSmartList.size());

            }
        }
        if (mapSmartList != null) {
            for (int incr = 0; incr < mapSmartList.size(); incr++) {
                Employee employee = mapSmartList.get(incr);
                if (empid == employee.getEmployeeId()) {
                    continue;
                }
    %>
    <div class="individual-cell clearfix">
        <button class="get-person-info">
            <span>i</span>
        </button>
        <div class="individual-card">
            <div class="front-card">
                <!--<div style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=employee.getCompanyId()%>&eid=<%=employee.getEmployeeId()%>');" class="person-pic"></div>-->
                <div style="background-image: url('<%=Constant.WEB_ASSETS%>images/user_image.png');" class="person-pic"></div>
            </div>
            <div class="back-card">
                <ul>
                    <li><%=employee.getZone()%></li>
                    <li><%=employee.getFunction()%></li>
                    <li><%=employee.getPosition()%></li>
                </ul>
            </div>
        </div>
        <span class="individual-cell-name"><%= employee.getFirstName() + " " + employee.getLastName()%></span>
        <div class="star-rating-row clearfix">
            <div class="rating-stars">

                <input type="hidden" id="quesId" value="<%= questionId%>" />
                <span class="rating-star"></span>
                <span class="rating-star"></span>
                <span class="rating-star"></span>
                <span class="rating-star"></span>
                <span class="rating-star"></span>
            </div>
            <span class="star-rating-total" id="rat_<%= questionId + "_" + employee.getEmployeeId()%>" emp_id="<%= employee.getEmployeeId()%>" ques_id="<%= questionId%>"></span>
        </div>
    </div>
    <%
            }
        }%>
</div>

<script>
    $('.get-person-info').on('click', function () {
        $(this).toggleClass('flip');
        $(this).next('div').toggleClass('flip');
    });

    $('.rating-star').on('click', function () {
        var row = $(this).parent();
        var i = $(this).index();
        var lastStar = $(row).find('.filled:last').index();
        var parent = row.parent().parent();
        var quesId = $(obj).parent().find('#quesId').val();
        var name = $(parent).find('span.individual-cell-name').text().trim();
        var count = $('#list-mobile-' + quesId + ' p').length;

        // clear the ratings for the chosen employee
        if (lastStar === i) {
            // remove the filled class + style
            $(row).children().removeClass('filled');
            $(row).next().text('0').removeAttr('style');

            // remove names from the list
            $('#list-desktop-' + quesId + ' p').each(function (j) {
                if ($(this).text() === name) {
                    $(this).remove();
                }
            });

            $('#list-mobile-' + quesId + ' p').each(function (j) {
                if ($(this).text() === name) {
                    $(this).remove();
                }
            });
            // update the count of the names
            --count;
            $('#count-desktop-' + quesId + ' span').text('');
            $('#count-desktop-' + quesId + ' span').text(count);

            $('#count-mobile-' + quesId + ' span').text('');
            $('#count-mobile-' + quesId + ' span').text(count);

        } else {
            // add or update the stars for the given employee
            $(obj).nextAll().removeClass('filled');
            for (var n = 0; n < i; n++) {
                $(row).children('span:eq(' + n + ')').addClass('filled');
            }
            $(row).next().text(i).css('visibility', 'visible');

            // flag to check whether the list already contains the name of the employee to update the count
            var flag = false;

            // for the first employee that is selected append the employee
            if (($('#list-desktop-' + quesId + ' p').length === 0) && ($('#list-mobile-' + quesId + ' p').length === 0)) {
                ++count;
                $('#list-desktop-' + quesId).append('<p>' + name + '</p>');
                $('#count-desktop-' + quesId + ' span').text(count);

                $('#list-mobile-' + quesId).append('<p>' + name + '</p>');
                $('#count-mobile-' + quesId + ' span').text(count);
            } else {
                // check with the help of the flag and update the list & count accordingly
                $('#list-desktop-' + quesId + ' p').each(function (j) {
                    if ($(this).text().trim() === name) {
                        flag = true;
                    }
                });

                $('#list-mobile-' + quesId + ' p').each(function (j) {
                    if ($(this).text().trim() === name) {
                        flag = true;
                    }
                });
                if (!flag) {
                    ++count;
                    $('#list-desktop-' + quesId).append('<p>' + name + '</p>');
                    $('#count-desktop-' + quesId + ' span').text('');
                    $('#count-desktop-' + quesId + ' span').text(count);

                    $('#list-mobile-' + quesId).append('<p>' + name + '</p>');
                    $('#count-mobile-' + quesId + ' span').text('');
                    $('#count-mobile-' + quesId + ' span').text(count);
                }
            }
        }
        //    ADD SCROLL IF MORE PEOPLE THAN VISIBLE WITHIN DIV SIZE
        if ($('.list-of-people-selected').height() >= 348) {
            $('.no-key-selected').slimScrollPopupDashboard({
                height: '400px',
                width: '287px',
                color: '#388E3C',
                railVisible: true,
                railColor: '#D7D7D7',
                alwaysVisible: true,
                touchScrollStep: 50
            });
            $('.no-key-selected').css('position', 'absolute');
        } else {
            $('.no-key-selected').slimScrollPopupDashboard({
                destroy: true
            });
            //Update CSS properties of div whenever scroll is destroyed
            $('.no-key-selected').css('position', '');
            $('.no-key-selected').css('width', '');
        }
        saveRating();
    });
    debugger;
</script>