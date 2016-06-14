<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="org.icube.owen.initiative.InitiativeList"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.icube.owen.metrics.MetricsList"%>
<%@page import="org.icube.owen.metrics.Metrics"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@include file="../common.jsp" %>
<%
    String moduleName = "initiative";
%> 
<%
    String status = request.getParameter("status");
    String type = request.getParameter("type");
    String category = request.getParameter("cat");
    List<Initiative> iListArray = null;
    Initiative initiative  = (Initiative) ObjectFactory.getInstance("org.icube.owen.initiative.Initiative");
    Map <Integer,String> indivdualType =  initiative.getInitiativeTypeMap(comid,"individual");
    Map <Integer,String> teamType =  initiative.getInitiativeTypeMap(comid,"team");
    InitiativeList iListObj = (InitiativeList) ObjectFactory.getInstance("org.icube.owen.initiative.InitiativeList");
    if(category != null && !category.equals("")) {
        if(type != null && !type.equals("")) {
            iListArray =  iListObj.getInitiativeListByType(comid,category, Util.getIntValue(type));
        } else if(status != null && !status.equals("")){
            iListArray =  iListObj.getInitiativeListByStatus(comid,category, status);
        } else {
            iListArray = iListObj.getInitiativeList(comid,category);
            //iListArray =  iListObj.getInitiativeListByStatus(category, "Active");
        }
    }
    else {
            iListArray = iListObj.getInitiativeList(comid,category);
    }
    if(iListArray != null) {
    for (int iCnt = 0; iCnt < iListArray.size(); iCnt++) {
        Initiative iObj = iListArray.get(iCnt);
        List<Metrics> metList = iObj.getInitiativeMetrics();
        int score = 0;
        String direction = "";
        for(int i=0; i <metList.size(); i++) {
            if(metList.get(i).getId() == iObj.getInitiativeTypeId()) {
                score = metList.get(i).getScore();
                direction = metList.get(i).getDirection();
            }
        }
        
%>
<div class="initative-list clearfix" id="row_<%=iObj.getInitiativeId()%>">
    <div class="initative-pic">	
        <div class="initative-pic-cell">						
            <img src="<%=Constant.WEB_ASSETS%>images/<%=iObj.getInitiativeCategory().equals("Team") ? Util.getInitiativeTypeImage(teamType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory()) : Util.getInitiativeTypeImage(indivdualType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory()) %>" width="28" alt="Initiative 1">
        </div>
        <div class="initative-pic-popup">
            <img src="<%=Constant.WEB_ASSETS%>images/<%=iObj.getInitiativeCategory().equals("Team") ? Util.getInitiativeTypeImage(teamType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory()) : Util.getInitiativeTypeImage(indivdualType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory()) %>" width="28" height="28" alt="Initiative 2">
            <span><%=iObj.getInitiativeCategory().equals("Team") ? teamType.get(iObj.getInitiativeTypeId()) : indivdualType.get(iObj.getInitiativeTypeId()) %></span>
        </div>
    </div>
    <span class="list-name"><%=iObj.getInitiativeName()%></span>
    <div class="list-score-date">
        <span class="list-date <%=Util.checkDateBefore( new java.util.Date(),iObj.getInitiativeEndDate())?"red":""%>" title="<%=Util.getDisplayDateFormat(iObj.getInitiativeEndDate(), "dd MMM yyy")%>"><%=Util.getDisplayDateFormat(iObj.getInitiativeEndDate(), "dd MMM")%></span>								
        <span class="list-score"><% if(score > -1) { %><%=score%>
            <% if(direction.equalsIgnoreCase("positive")) { %>   
                <span class="up">&#x25B2;</span>
           <% } else if(direction.equalsIgnoreCase("negative")) { %>
               <span class="down">&#x25BC;</span>
           <% } else { %>
               <span class="neutral">..</span>
           <% } %>
           <% } %>
       </span>
         <% if(iObj.getInitiativeStatus().equalsIgnoreCase("active") || iObj.getInitiativeStatus().equalsIgnoreCase("pending")) { %>    
            <button type="button" class="list-remove" title="Delete" onClick="deleteInitative(<%=iObj.getInitiativeId()%>)">&#xD7;</button>
        <% } else { %>
            <span class="filler-remove"></span>
        <% }
         if(iObj.getInitiativeStatus().equalsIgnoreCase("active")) { %>
            <button type="button" class="list-complete" onClick="updateStatus(<%=iObj.getInitiativeId()%>, 'Completed')" title="Mark as complete">&#x2714;</button>
        <% } else { %>
            <span class="filler-complete"></span>  
         <% } 
        %>
    </div>
</div>    
<div style="display:none" id="popup_<%=iObj.getInitiativeId()%>">
    <div class="popup-header clearfix">
        <%
            Employee emp = (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee");
            if(iObj.getCreatedByEmpId() != 0 ) {
            emp = emp.get(comid, iObj.getCreatedByEmpId() );
        %>
        <span class="details-user"><%=emp.getFirstName().substring(0, 1) + (emp.getLastName() != null ? emp.getLastName().substring(0, 1) : "")%></span>
        <% } else { %>
        <span class="details-user">AA</span>
        <% } %>
        <div class="details-calendar-type">
            <img src="<%=Constant.WEB_ASSETS%>images/initiative_details_popup_date.png" alt="Date" width="30" height="30">
            <div>
                <span>Due Date</span>
                <span class="<%=Util.checkDateBefore(new java.util.Date(),iObj.getInitiativeEndDate())?"red":""%>"><%=Util.getDisplayDateFormat(iObj.getInitiativeEndDate(),"dd MMM, yyyy")%></span>
            </div>
        </div>
        <div class="details-calendar-type">
            <img src="<%=Constant.WEB_ASSETS%>images/<%=iObj.getInitiativeCategory().equals("Team") ? Util.getInitiativeTypeImage(teamType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory()) : Util.getInitiativeTypeImage(indivdualType.get(iObj.getInitiativeTypeId()), iObj.getInitiativeCategory()) %>" width="36">
            <div>
                <span>Type of Initiative</span>
                <span><%=iObj.getInitiativeCategory().equals("Team") ? teamType.get(iObj.getInitiativeTypeId()) : indivdualType.get(iObj.getInitiativeTypeId()) %></span>
            </div>
        </div>
        <div class="do-more-incomplete">
            <% if(iObj.getInitiativeStatus().equalsIgnoreCase("active") || iObj.getInitiativeStatus().equalsIgnoreCase("pending")) { %>       

            <div>
                <button title="Do more">&#x22EF;</button>
                <ul>
                    <li><a href="<%=Constant.WEB_CONTEXT%>/initiative/edit.jsp?iid=<%=iObj.getInitiativeId()%>" title="Edit">Edit</a></li>
                    <li><button type="button" id="deletePopup" title="Delete" onClick="javascript:deleteInitative(<%=iObj.getInitiativeId()%>)" data-id="<%=iObj.getInitiativeId()%>">Delete</button></li>
                </ul>
            </div>
                <% } %>
            <button title="Close the initative">x</button>
        </div>
    </div>

    <div class="popup-name">
        <% if(iObj.getInitiativeStatus().equalsIgnoreCase("active")) { %>
        <button title="Mark as complete" onClick="updateStatus(<%=iObj.getInitiativeId()%>, 'Completed')" data-id="<%=iObj.getInitiativeId()%>">&#x2714;</button>
        <% } %>
        <h3><%=iObj.getInitiativeName()%></h3>
    </div>
    <div class="popup-score-chat">
        <div class="wrapper">										
            <div class="popup-score">
               <ul>
                    <%
                  for(int i=0; i < metList.size(); i++) { %>
                    <li <%= metList.get(i).getId()==iObj.getInitiativeTypeId() ? "class=\"clicked\"" : "" %> >
                        
                            <% if (metList.get(i).getScore() > -1) { %>
                            <span class="score-no"  >
                            <%=metList.get(i).getScore() %> 
                            <% if(metList.get(i).getDirection().equalsIgnoreCase("positive")) { %>   
                                <span class="up">&#x25B4;</span>
                            <% } else if(metList.get(i).getDirection().equalsIgnoreCase("negative")) { %>
                                <span class="down">&#x25BE;</span>
                            <% } else { %>
                                <span class="neutral">..</span>
                            <% } %>
                            </span>
                             <% } else { %>
                                <span class="empty"  >
                                Team size too small.
                                </span>
                            <% } %>
                        
                        <span class="score-name"><%=metList.get(i).getName()%></span>
                    </li>
                   <% } %> 
                </ul>
            </div>
            <div class="popup-key">
                <span>Key Individuals</span>
                <div>
                    <% List<Employee> keyIndividual = iObj.getOwnerOfList();
                        for (int i = 0; i < keyIndividual.size(); i++) {
                    %>
                    <span><%=keyIndividual.get(i).getFirstName().substring(0, 1) + (keyIndividual.get(i).getLastName() != null ? keyIndividual.get(i).getLastName().substring(0, 1) : "")%></span>
                    <% }
                    %>
                </div>
            </div>
            <div class="popup-chat-window">
                <%=iObj.getInitiativeComment()%>
            </div>
            <% if(iObj.getInitiativeStatus().equalsIgnoreCase("active") || iObj.getInitiativeStatus().equalsIgnoreCase("pending")) { %>
            <div class="popup-chat-box">
                <span>Me</span>
                <textarea name="initative-chat" id="initative-chat-<%=iObj.getInitiativeId()%>" placeholder="Write a comment" onKeyPress="enterComment(event, this)"></textarea>
                <button type="button" title="Comment" id="updateComments" onClick="updateComments('<%=iObj.getInitiativeId()%>', $('#initative-chat-<%=iObj.getInitiativeId()%>').val(), this)">Comment</button>
            </div>
            <% } else { %>
                <div class="popup-chat-box">
                    <span>Me</span>
                    <textarea name="initative-chat" id="initative-chat-<%=iObj.getInitiativeId()%>" placeholder="Write a comment" disabled></textarea>
                    <button type="button" title="Comment" id="updateComments" disabled>Comment</button>
                </div>
            <% } %>
        </div>
    </div>
</div>        
<% }
    }
%>
<script>
    $(document).ready(function() {
        $('.list-complete').on('click', function () {
            event.stopPropagation();
            $(this).css({
                'border-color': '#4effb8',
                'background-color': '#4effb8',
                'color': '#fff',
                'font-weight': 'bold'
            });

            var $target = $(this);
            setTimeout(function () {
                $target.parents('.initative-list').hide('slide', {direction: 'right'}, function() {
                    $target.parents('.initative-list').after('<div class="undo-mark">Completed <span><span>| &#x21A9;</span> Undo</span></div>');
                });  
            }, 250);

            setTimeout(function () {
                $target.parents('.initative-list').next().remove();
            }, 5000);
        });

        $('.list-remove').on('click', function(event) {
            event.stopPropagation();
            $(this).parents('.initative-list').addClass('delete-initative-list');

            var $target = $(this);
            setTimeout(function () {            
                $target.parents('.initative-list').after('<div class="undo-mark">Deleted <span><span>| &#x21A9;</span> Undo</span></div>');
                $target.parents('.initative-list').hide().removeClass('delete-initative-list');
            }, 250);

            setTimeout(function () {
                $target.parents('.initative-list').next().remove();
            }, 5000);
        });
        
        $('.initative-list').on('click', function (event) {  
            var id = $(this).attr('id');
            var arr = id.split('_');
            $('.initative-details-popup').html($('#popup_'+arr[1]).html()).show().animate({'top': '80px'}, 400);

            $('.do-more-incomplete>button').on('click', function (event) {
                event.stopPropagation();
                $('.initative-details-popup').hide().css('top', '-478px');
            });

            $('.do-more-incomplete div>button').on('click', function (event) {
                $(this).toggleClass('active');
                $(this).next('ul').slideToggle('fast');
            });

            $('#deletePopup').on('click', function() {
                var target = $(this).parents('.initative-details-popup');
                setTimeout(function(){
                    target.hide('fast', function() {
                        target.css('top', '-478px');
                        target.parents('.initative-list').hide('slide', { direction: 'up' });
                    });
                }, 200);
            });

            $('.popup-name button').on('click', function (event) {
                var target = $(this).parents('.initative-details-popup');
                target.addClass('animate-popup');
                setTimeout(function () {
                    target.hide('fast', function () {
                        target.parents('.initative-list').hide('slide', {direction: 'right'});
                    });
                }, 300);
            });
        });    
    });  
            
    function enterComment(e, textarea){
        if(e.which === 13) { 
            e.preventDefault();
            $('#updateComments').click();
        }
    }
</script> 