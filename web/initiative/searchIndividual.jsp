<%-- 
    Document   : searchIndividual
    Created on : Feb 19, 2016, 12:49:53 PM
    Author     : fermion10
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Util"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="org.icube.owen.employee.EmployeeList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@include file="../common.jsp" %>

<%
    String keywords = request.getParameter("keywords");
    int type = request.getParameter("type") != null ? Util.getIntValue(request.getParameter("type")) :0;
    String oEmpids = request.getParameter("oEmpids") != null ? request.getParameter("oEmpids"): "" ;
    String[] ownerEmpids = oEmpids.split(",");
    if(keywords == null ) keywords = "";
    keywords = keywords.toLowerCase();
    EmployeeList elistObj = new EmployeeList();
    List<Employee> eList = elistObj.getEmployeeMasterList(comid);
    List<Employee> searchResult = new ArrayList();
    for(int i=0; i<eList.size(); i++) {
        if(empid != eList.get(i).getEmployeeId()) {
            String firstName = eList.get(i).getFirstName() != null ? eList.get(i).getFirstName().toLowerCase(): "";
            String lastName = eList.get(i).getLastName() != null ? eList.get(i).getLastName().toLowerCase(): "";
            String name = firstName+" "+lastName;
            name = name.trim();
            if(name.indexOf(keywords) >= 0 || firstName.indexOf(keywords) >= 0 || lastName.indexOf(keywords) >=0 ){
                searchResult.add(eList.get(i));
            } else if(keywords == null || keywords.equals("")){
                searchResult.add(eList.get(i));
            }
        }
    }
    if(type == 0) {
        for(int i=0; i<searchResult.size(); i++) { %>
            <option value="<%=searchResult.get(i).getEmployeeId()%>"><%=searchResult.get(i).getFirstName()+" "+ searchResult.get(i).getLastName()%></option><%
        }
    } else {
        for(int i=0; i<searchResult.size(); i++) { 
            Employee emp =  searchResult.get(i); %>
            <div class="individual-cell">
                <div class="individual-profile">
                    <div class="profile-front">	
                        <div class="photo-individual">
                            <figure>		
                                <div class="person-pic" style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=emp.getCompanyId()%>&eid=<%=emp.getEmployeeId()%>');"></div>
                                <figcaption><%=emp.getFirstName()+(emp.getLastName()!=null && !emp.getLastName().equals("")?  " "+emp.getLastName():"")%></figcaption>
                            </figure>
                        </div>
                        <div class="score-add-button clearfix">
                            <span><%= (emp.getGrade() != null ?emp.getGrade()  :"") %></span>
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
        <% } %>
    <% } %>
                 
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