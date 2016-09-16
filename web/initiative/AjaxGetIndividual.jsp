<%-- 
    Document   : getindividual
    Created on : Jan 14, 2016, 3:58:04 PM
    Author     : fermion10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.icube.owen.employee.EmployeeList"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@include file="../common.jsp" %>

<%
    String searchTerm = request.getParameter("searchTerm");
    List<Employee> smartEmpList = new ArrayList();
    EmployeeList elist = new EmployeeList();
    String initiativeType1 = request.getParameter("initiativeType");
    String oEmpids = request.getParameter("oEmpids") != null ? request.getParameter("oEmpids"): "" ;
    String[] ownerEmpids = oEmpids.split(",");
    if(searchTerm!= null && !searchTerm.equals("")) {
        //TODO for getting employee master list and search to be finish
        elist.getEmployeeMasterList(comid);
    } else {
        String type = request.getParameter("teamtype");
        int intType = 0;
        try {
            intType = Integer.parseInt(type);
        } catch(Exception ex) {
        }
        
        if(intType == Constant.INITIATIVES_TEAM) {
            String[] teamGeography = request.getParameterValues("teamGeography");
            String[] teamFunction = request.getParameterValues("teamFunction");
            String[] teamLevel = request.getParameterValues("teamLevel");

            String[] teamGeographyText = request.getParameterValues("teamGeographyText");
            String[] teamFunctionText = request.getParameterValues("teamFunctionText");
            String[] teamLevelText = request.getParameterValues("teamLevelText");

            Filter geographyFilter = new Filter();
            geographyFilter.setFilterName(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
            Map<Integer,String> gMap = new HashMap<Integer,String>();
            for(int i=0; i<teamGeography.length; i++) {
                gMap.put(Util.getIntValue(teamGeography[i]), teamGeographyText[i]);

            }
            Util.debugLog("gMap" + gMap);
            geographyFilter.setFilterValues(gMap);

            Filter functionFilter = new Filter();
            functionFilter.setFilterName(Constant.INITIATIVES_FUNCTION_FILTER_NAME);
            Map<Integer,String> fMap = new HashMap<Integer,String>();
            for(int i=0; i<teamFunction.length; i++) {
                fMap.put(Util.getIntValue(teamFunction[i]), teamFunctionText[i]);

            }
            Util.debugLog("fMap" + fMap);
            functionFilter.setFilterValues(fMap);

            Filter levelFilter = new Filter();
            levelFilter.setFilterName(Constant.INITIATIVES_LEVEL_FILTER_NAME);
            Map<Integer,String> lMap = new HashMap<Integer,String>();
            for(int i=0; i<teamLevel.length; i++) {
                lMap.put(Util.getIntValue(teamLevel[i]), teamLevelText[i]);

            }
            levelFilter.setFilterValues(lMap);
            List<Filter> fList = new ArrayList();
            fList.add(geographyFilter);
            fList.add(functionFilter);
            fList.add(levelFilter);
            smartEmpList =  elist.getEmployeeSmartListForTeam(comid,fList,Util.getIntValue(initiativeType1));
            // System.out.println(smartEmpList);
        } else {
            Employee emp = (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee");
            List<Employee> list = new ArrayList();
            int employeeId = Util.getIntValue(request.getParameter("empid"));
            list.add(emp.get(comid,employeeId));
            smartEmpList =  elist.getEmployeeSmartListForIndividual(comid,list,Util.getIntValue(initiativeType1));
        }
        
        for(int i=0; i<smartEmpList.size(); i++) {
            Employee emp = smartEmpList.get(i); %>
            <div class="individual-cell">
                <div class="individual-profile">
                    <div class="profile-front">	
                        <div class="photo-individual">
                            <figure>		
                                <!--<img src="<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=emp.getCompanyId() %>&eid=<%=emp.getEmployeeId() %>">-->
                                <div class="person-pic" style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=emp.getCompanyId()%>&eid=<%=emp.getEmployeeId()%>');"></div>
                                <figcaption><%=emp.getFirstName()+(emp.getLastName()!=null && !emp.getLastName().equals("")?  " "+emp.getLastName():"")%></figcaption>
                            </figure>
                        </div>
                        <div class="score-add-button clearfix">
                            <span><%= (emp.getGrade() != null ? emp.getGrade() : "") %></span>
                        </div>
                    </div>
                    <div class="profile-back">
                        <span><%=emp.getFirstName()+(emp.getLastName()!=null && !emp.getLastName().equals("")?  " "+emp.getLastName():"")%></span>                        
                        <div class="profile-position">
                            <span><%=emp.getZone() %></span>
                            <span><%=emp.getFunction() %></span>
                            <span><%=emp.getPosition() %></span>
                        </div>
                    </div>        
                </div>
                <div class="info-individual">
                    <span>i</span>
                </div>
                <%  boolean found = false;
                    for(int cnt=0; cnt<ownerEmpids.length; cnt++) { 
                        if(emp.getEmployeeId() == Util.getIntValue(ownerEmpids[cnt])) { 
                           found = true;
                           break;
                        } 
                    } 
                    if(found) { %>
                        <input type="checkbox" value="<%=emp.getEmployeeId()%>" name="keyIndividual" id="checkInitative<%=emp.getEmployeeId()%>" value="addMe" checked>
                        <button type="button" class="addToInitative" title="Click to add to this initiative" style="background-color:#4effb8; color:#fff;">✔</button>
                    <% } else { %>
                        <input type="checkbox" value="<%=emp.getEmployeeId()%>" name="keyIndividual" id="checkInitative<%=emp.getEmployeeId()%>" value="addMe">        
                        <button type="button" class="addToInitative" title="Click to add to this initiative">+</button> 
                    <% } %>        
            </div>        
        <% } 
    }
%>
        
<script>
    var arr = [];
    $('.addToInitative').on('click', function() {
        var text=$(this).text();
        var selected = $('.individual-grid').find('input:checked').length;

        function getInitials(obj) {
            var name = obj.parent().find('figcaption').text().split(' ');
            var nameSize = name.length;
            var initials = name[0].charAt(0) + '' + name[nameSize-1].charAt(0);
            return initials;
        }

        var personInitials = getInitials($(this));

        if(text === '+') {
            $(this).css({'background-color':'#4effb8', 'color':'#fff'}).text('✔');
            $(this).siblings('input').prop('checked', true);

            if(selected < 5) {
                $('.no-key-selected').append('<p>' + personInitials + '</p>');
            }
            else {
                var remaining = selected - 4;
                $('.no-key-selected').children('span').remove();
                $('.no-key-selected').append('<span>and ' + remaining + ' more</span');
            }
            arr.push($(this).siblings('input').attr('id'));
            var addId = $(this).siblings('input').val();
            arrEmpId.push(addId);
        } else {
            $(this).removeAttr('style').text('+');
            $(this).siblings('input').prop('checked', false);

            var tag;

            $('.no-key-selected p').each(function(i) {
                if($(this).text() === personInitials) {
                    tag = true;
                    $(this).remove();

                    if(selected>=6) {	
                        var newInitials = getInitials($('#' + arr[5]));			
                        $('.no-key-selected p:last-of-type').after('<p>' + newInitials + '</p>');
                    }
                    return false;
                }
            });

            if(selected === 6) {
                $('.no-key-selected').children('span').remove();
            }
            else if((selected < 6) && !tag) {
                $('.no-key-selected').children('p:last-of-type').remove();
            }
            else if(selected > 6)  {
                var remaining = selected - 6;
                $('.no-key-selected').children('span').remove();
                $('.no-key-selected').append('<span>and ' + remaining + ' more</span>');
            }

            var removeItem = $(this).siblings('input').attr('id');
            arr = jQuery.grep(arr, function(value) {
              return value !== removeItem;
            });
            var removeId = $(this).siblings('input').val();
            arrEmpId = jQuery.grep(arrEmpId, function(value) {
              return value !== removeId;
            });
        }
    });

    $('.info-individual').on('click', function() {
        $(this).prev('.individual-profile').toggleClass('animate-profile');
        $(this).toggleClass('clicked');
    });
</script>