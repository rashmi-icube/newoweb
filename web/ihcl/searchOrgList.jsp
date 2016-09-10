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
    <%    EmployeeList eList = (EmployeeList) ObjectFactory.getInstance("org.icube.owen.employee.EmployeeList");
        String keywords = request.getParameter("q");
        int metricId = request.getParameter("mid") != null ? Util.getIntValue(request.getParameter("mid")) : 0;
        int ques = request.getParameter("ques") != null ? Util.getIntValue(request.getParameter("ques")) : 0;

        List<Employee> mapSmartList = null;
        if (keywords != null && !keywords.equals("")) {
            mapSmartList = eList.getEmployeeMasterList(comid);
            keywords = keywords.toLowerCase();
        } else if (metricId != 0) {
            IndividualDashboardHelper iDashboard = (IndividualDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.IndividualDashboardHelper");
            mapSmartList = iDashboard.getSmartList(comid, empid, metricId);
        } else {
            Question question = (Question) ObjectFactory.getInstance("org.icube.owen.survey.Question");
            mapSmartList = question.getSmartListForQuestion(comid, empid, question.getQuestion(comid, ques));
        }
        if (mapSmartList != null) {
            for (int incr = 0; incr < mapSmartList.size(); incr++) {
                Employee employee = mapSmartList.get(incr);
                if (empid == employee.getEmployeeId()) {
                    continue;
                }
                String firstName = employee.getFirstName() != null ? employee.getFirstName().toLowerCase() : "";
                String lastName = employee.getLastName() != null ? employee.getLastName().toLowerCase() : "";
                String name = firstName + " " + lastName;
                name = name.trim();
                if (name.indexOf(keywords) >= 0 || firstName.indexOf(keywords) >= 0 || lastName.indexOf(keywords) >= 0) {
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
                <input type="hidden" id="quesId" value="<%=ques%>" />
                <span class="rating-star"></span>
                <span class="rating-star"></span>
                <span class="rating-star"></span>
                <span class="rating-star"></span>
                <span class="rating-star"></span>
            </div>
            <% if (ques == 0) {%>
            <span class="star-rating-total" ques_id="<%= ques%>" id="rat_<%= ques%>_<%= employee.getEmployeeId()%>" emp_id="<%= employee.getEmployeeId()%>"></span>
            <% } else {%>
            <span class="star-rating-total" ques_id="<%= ques%>" id="rat_<%= ques%>_<%= employee.getEmployeeId()%>" emp_id="<%= employee.getEmployeeId()%>"></span>
            <% } %>
        </div>
    </div>
    <% }
            }
        }%>
</div>

<script>
    $('.get-person-info').on('click', function () {
        $(this).toggleClass('flip');
        $(this).next('div').toggleClass('flip');
    });

    $('.rating-star').on('click', function () {
        console.log("calling searchOrgList");
        var row = $(this).parent();
        var i = $(this).index();
        var lastStar = $(row).find('.filled:last').index();
        var parent = row.parent().parent();
        var quesId = $(this).parent().find('#quesId').val();
        console.log("quesId : " + quesId);
        var name = $(parent).find('span.individual-cell-name').text().trim();
        if (quesId === '0') {
            var dashboardCount = $('.list-of-people-selected p').length;
        } else {
            var count = $('#list-mobile-' + quesId + ' p').length;
        }
        // clear the ratings for the chosen employee
        if (lastStar === i) {
            // remove the filled class + style
            $(row).children().removeClass('filled');
            $(row).next().text('0').removeAttr('style');
            if (quesId === '0') {
                console.log("this is for the individual dashboard");
                // remove names from the list
                $('.list-of-people-selected p').each(function (j) {
                    if ($(this).text() === name) {
                        $(this).remove();
                    }
                });

                $('.list-of-selected-people-popup-mobile p').each(function (j) {
                    if ($(this).text() === name) {
                        $(this).remove();
                    }
                });
                // update the count of the names
                --dashboardCount;
                $('#count-desktop span').text('');
                $('#count-desktop span').text(dashboardCount);

                $('#count-mobile span').text('');
                $('#count-mobile span').text(dashboardCount);
            } else {
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
            }
        } else {
            // add or update the stars for the given employee
            $(this).nextAll().removeClass('filled');
            for (var n = 0; n < i; n++) {
                $(row).children('span:eq(' + n + ')').addClass('filled');
            }
            $(row).next().text(i).css('visibility', 'visible');

            // flag to check whether the list already contains the name of the employee to update the count
            var flag = false;
            if (quesId === '0') {
                // for the first employee that is selected append the employee
                if (($('.list-of-people-selected p').length === 0) && ($('.list-of-selected-people-popup-mobile p').length === 0)) {
                    ++dashboardCount;
                    $('.list-of-people-selected').append('<p>' + name + '</p>');
                    $('#count-desktop span').text(dashboardCount);

                    $('.list-of-selected-people-popup-mobile').append('<p>' + name + '</p>');
                    $('#count-mobile span').text(dashboardCount);
                } else {
                    // check with the help of the flag and update the list & count accordingly
                    $('.list-of-people-selected p').each(function (j) {
                        if ($(this).text().trim() === name) {
                            flag = true;
                        }
                    });

                    $('.list-of-people-selected p').each(function (j) {
                        if ($(this).text().trim() === name) {
                            flag = true;
                        }
                    });
                    if (!flag) {
                        ++dashboardCount;
                        $('.list-of-people-selected').append('<p>' + name + '</p>');
                        $('#count-desktop span').text('');
                        $('#count-desktop span').text(dashboardCount);

                        $('.list-of-selected-people-popup-mobile').append('<p>' + name + '</p>');
                        $('#count-mobile span').text('');
                        $('#count-mobile span').text(dashboardCount);
                    }
                }
            } else {
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
        }
        //For quesId = 0, append scroll to dashboard list; else append to survey page list        
        if (quesId === '0') {
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
                //Reset div css properties
                $('.no-key-selected').css('position', '');
                $('.no-key-selected').css('width', '');
            }
            //Apply Scroll to Survey Page List of People Selected
        } else {
            //    ADD SCROLL IF MORE PEOPLE THAN VISIBLE WITHIN DIV SIZE, FOR EVERY WE QUESTION
                if (window.screen.width === 1024) {
                    if (window.orientation === 90 || window.orientation === -90) {
                        $('.list-of-people-selected').each(function (i) {
                            if ($('.list-of-people-selected')[i].clientHeight >= 348) {
                                $(this).parent().slimScrollTab({
                                    height: '400px',
                                    width: '263px',
                                    color: '#388E3C',
                                    railVisible: true,
                                    railColor: '#D7D7D7',
                                    alwaysVisible: true,
                                    touchScrollStep: 50
                                });
                            } else {
                                $(this).parent().slimScrollTab({
                                    destroy: true
                                });
                                $(this).parent().css('width','33%');
                            }
                        });
                    }
                }
                else{
            
            
            
            
            $('.list-of-people-selected').each(function (i) {
                if ($('.list-of-people-selected')[i].clientHeight >= 348) {
                    $(this).parent().slimScrollPopup({
                        height: '400px',
                        width: '250px',
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
        }
        }
        saveRating();
    });
</script>