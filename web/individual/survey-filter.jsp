<%-- 
    Document   : survey-filter
    Created on : Mar 8, 2016, 4:35:18 PM
    Author     : fermion10
--%>

<%@page import="java.util.TreeMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.icube.owen.employee.EmployeeList"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.icube.owen.survey.Response"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.icube.owen.survey.Question"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.survey.QuestionType"%>
<%@page import="java.util.List"%>
<%@include file="../common.jsp" %>

<div class="overlay"></div>
<div class="overlay_form">
    <img src="/assets/images/ajax-loader.gif">
</div>
<div class="individuals-grid">    
    <%    int filterIdGeo = Util.getIntValue(request.getParameter("Geography"), -1);
        int filterIdFun = Util.getIntValue(request.getParameter("Function"), -1);
        int filterIdLevel = Util.getIntValue(request.getParameter("Level"), -1);
        //out.println(filterIdGeo+"::"+filterIdFun+":"+filterIdLevel);
        String filterValGeo = request.getParameter("Geography_name");
        String filterValFun = request.getParameter("Function_name");
        String filterValLevel = request.getParameter("Level_name");
        int geoId = request.getParameter("Geography_id") != null ? Util.getIntValue(request.getParameter("Geography_id"), 0) : 0;
        int funId = request.getParameter("Function_id") != null ? Util.getIntValue(request.getParameter("Function_id"), 0) : 0;
        int levelId = request.getParameter("Level_id") != null ? Util.getIntValue(request.getParameter("Level_id"), 0) : 0;

        List<Employee> mapSmartList = null;

        int questionId = Util.getIntValue(request.getParameter("question_id"));
        int relationshipTypeId = Util.getIntValue(request.getParameter("rel_type"));
        Question ques = (Question) ObjectFactory.getInstance("org.icube.owen.survey.Question");
        ques.setQuestionId(questionId);
        ques.setRelationshipTypeId(relationshipTypeId);
        if ((filterIdGeo > -1 && filterValGeo != null) || (filterIdFun > -1 && filterValFun != null) || (filterIdLevel > -1 && filterValLevel != null)) {
            EmployeeList employeeListObj = (EmployeeList) ObjectFactory.getInstance("org.icube.owen.employee.EmployeeList");
            List<Filter> listFilter = new ArrayList<Filter>();
            if (filterIdGeo > -1 && filterValGeo != null) {
                Filter filter = (Filter) ObjectFactory.getInstance("org.icube.owen.filter.Filter");
                filter.setFilterId(geoId);
                filter.setFilterName(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                //out.println(filter.getFilterName());
                Map<Integer, String> filterValuesMap = new HashMap<Integer, String>();
                filterValuesMap.put(filterIdGeo, filterValGeo);
                //out.println(filterValuesMap);
                filter.setFilterValues(filterValuesMap);
                listFilter.add(filter);
            }
            if (filterIdFun > -1 && filterValFun != null) {
                Filter filter = (Filter) ObjectFactory.getInstance("org.icube.owen.filter.Filter");
                filter.setFilterId(funId);
                filter.setFilterName(Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                //out.println(filter.getFilterName());
                Map<Integer, String> filterValuesMap = new HashMap<Integer, String>();
                filterValuesMap.put(filterIdFun, filterValFun);
                filter.setFilterValues(filterValuesMap);
                listFilter.add(filter);
            }
            if (filterIdLevel > -1 && filterValLevel != null) {
                Filter filter = (Filter) ObjectFactory.getInstance("org.icube.owen.filter.Filter");
                filter.setFilterId(levelId);
                filter.setFilterName(Constant.INITIATIVES_LEVEL_FILTER_NAME);
                //out.println(filter.getFilterName());
                Map<Integer, String> filterValuesMap = new HashMap<Integer, String>();
                filterValuesMap.put(filterIdLevel, filterValLevel);
                filter.setFilterValues(filterValuesMap);
                listFilter.add(filter);
            }
            //        out.println(listFilter);
            mapSmartList = employeeListObj.getEmployeeListByFilters(comid, listFilter);
        } else {
            mapSmartList = ques.getSmartListForQuestion(comid, empid, ques);
        }
        //out.println("HERE---------------"+mapSmartList);    
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
                <div style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=employee.getCompanyId()%>&eid=<%=employee.getEmployeeId()%>');" class="person-pic"></div>
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
        <div class="star-rating-row" >
            <div class="rating-stars">
                <input type="hidden" id="quesId" value="<%= ques.getQuestionId()%>" />
                <span class="rating-star"></span>
                <span class="rating-star"></span>
                <span class="rating-star"></span>
                <span class="rating-star"></span>
                <span class="rating-star"></span>
            </div>
            <span class="star-rating-total" emp_id="<%= employee.getEmployeeId()%>" ques_id="<%= ques.getQuestionId()%>" id="rat_<%= ques.getQuestionId() + "_" + employee.getEmployeeId()%>"></span>
        </div>
    </div>
    <% }%>

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
        var quesId = $(this).parent().find('#quesId').val();
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
            $(this).nextAll().removeClass('filled');
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
        $('.list-of-people-selected').each(function (i) {
                if ($('.list-of-people-selected')[i].clientHeight >= 348) {
                    $(this).parent().slimScrollPopup({
                        height: '400px',
                        width: '272px',
                        color: '#388E3C',
                        railVisible: true,
                        railColor: '#D7D7D7',
                        alwaysVisible: true,
                        touchScrollStep: 50
                    });
                } else {
                    $(this).parent().slimScrollPopup({
                        destroy: true
                    });
                }
            });
    });


</script>
