<%-- 
    Document   : list
    Created on : Jan 14, 2016, 6:45:29 PM
    Author     : vikas
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.Util"%>
<%
    String moduleName = "initiative";
    String subModuleName = "list";
%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.json.JSONObject"%>

<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="org.icube.owen.initiative.InitiativeHelper"%>
<%@page import="org.icube.owen.initiative.InitiativeList"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="org.icube.owen.metrics.MetricsList"%>
<%@page import="org.icube.owen.metrics.Metrics"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>OWEN - View all initiatives</title>
        <link rel="apple-touch-icon" sizes="57x57" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="72x72" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="114x114" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="120x120" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="144x144" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="152x152" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-152x152.png">
        <link rel="apple-touch-icon" sizes="180x180" href="<%=Constant.WEB_ASSETS%>images/favicon/apple-icon-180x180.png">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon/android-icon-192x192.png" sizes="192x192">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon/favicon-16x16.png" sizes="16x16">
        <link rel="manifest" href="<%=Constant.WEB_ASSETS%>images/favicon/manifest.json">
        <meta name="msapplication-TileColor" content="#da532c">
        <meta name="msapplication-TileImage" content="<%=Constant.WEB_ASSETS%>images/favicon/ms-icon-144x144.png">
    </head>
        
    <body>	
        <div class="overlay_form"><img src="<%=Constant.WEB_ASSETS%>images/ajax-loader.gif"></div>
        
        <div class="container">
            <%@include file="../header.jsp" %>
            <%
               Initiative initiative =  (Initiative) ObjectFactory.getInstance("org.icube.owen.initiative.Initiative");
               Map <Integer,String> indivdualType =  initiative.getInitiativeTypeMap(comid,"individual");
               Map <Integer,String> teamType =  initiative.getInitiativeTypeMap(comid,"team");
               JSONObject indTypeJSON = new JSONObject(indivdualType);
               JSONObject teamTypeJSON = new JSONObject(teamType);
            %>
            <div class="main">
                <div class="wrapper">
                
                    <div class="my-initatives">
                        <div class="my-initatives-header clearfix">
                            <h2>My Initiatives</h2>
                            <div class="filter-metric">
                                <span>Individual</span>
                                <div class="filter-tool">
                                    <img src="<%=Constant.WEB_ASSETS%>images/filter_disc.png">
                                </div>
                                <span class="clicked">Team</span>
                            </div>						
                        </div>
                    <%
                        InitiativeHelper iHelper = new    InitiativeHelper();
                        java.util.List<java.util.Map<java.lang.String,java.lang.Object>> iList =  iHelper.getInitiativeCount(comid);
                        HashMap<Integer,HashMap<String, Integer>> hasmap = Util.getTypeList(iList, "Team");
                    %>
                        <ul class="switched">
                            <% for (Map.Entry<Integer,HashMap<String, Integer>> entry : hasmap.entrySet()) { 
                                    HashMap<String, Integer> hmap = entry.getValue();
                                %>
                                <li>
                                    <span><%=teamType.get(entry.getKey())%></span>
                                    <div class="panel-pic">																
                                       <img src="<%=Constant.WEB_ASSETS%>images/<%=Util.getInitiativeTypeImage(teamType.get(entry.getKey()), "Team") %>" width="79" alt="<%=teamType.get(entry.getKey())%>">
                                    </div>
                                    <div class="current-completed clearfix">
                                       <p>
                                           <span>Current Initiatives: <span class="bold"><%=hmap.get("Active")%></span></span>
                                           <span>Completed Initiatives: <%=hmap.get("Completed")%></span>
                                       </p>
                                       <a href="create.jsp?c=1&t=<%=entry.getKey()%>" title="Set an initiative for <%=teamType.get(entry.getKey())%>">+</a>
                                    </div>
                               </li>
                                <% } %>    
                        </ul>
                        
                           <%  
                            hasmap = Util.getTypeList(iList, "Individual"); %>
                        <ul>
                            <% for (Map.Entry<Integer,HashMap<String, Integer>> entry : hasmap.entrySet()) { 
                                    HashMap<String, Integer> hmap = entry.getValue();
                                   
                                %>
                                <li>
                                   <span><%=indivdualType.get(entry.getKey())%></span>
                                   <div class="panel-pic">																
                                       <img src="<%=Constant.WEB_ASSETS%>images/<%=Util.getInitiativeTypeImage(indivdualType.get(entry.getKey()), "Individual") %>" width="79" alt="<%=indivdualType.get(entry.getKey())%>">
                                   </div>
                                   <div class="current-completed clearfix">
                                       <p>
                                           <span>Current Initiatives: <span class="bold"><%=hmap.get("Active")%></span></span>
                                           <span>Completed Initiatives: <%=hmap.get("Completed")%></span>
                                       </p>
                                       <a href="create.jsp?c=0&t=<%=entry.getKey()%>" title="Set an initiative for <%=indivdualType.get(entry.getKey())%>">+</a>
                                   </div>
                               </li>
                                <% } %>    
                        </ul>
                    </div>
                    <% String catid = request.getParameter("c") != null ?  request.getParameter("c") : "1";
                       String type = request.getParameter("t") != null ?  request.getParameter("t") : ""; %>
                    <script>
                        var indTypeJSON = <%=indTypeJSON%>;
                        var teamTypeJSON = <%=teamTypeJSON%>;
                    </script>
                    <div class="sort-by">
                        <h2 class="clearfix">
                            <button id="sort-by">&#x25BC; View By</button>
                            <div class="view-by-list">
                                <button>&#x25BC; View By</button>
                                <ul>
                                    <li class="selected-view">
                                        <span>&#x2714;</span> <span>Status</span> <span>&#x25B6;</span>
                                        <ul>
                                            <li class="selected-view" onClick="getList('Active', '', this)"><span>&#x2714;</span> <a href="javascript:void(0)">Active initiatives</a></li>
                                            <li onClick="getList('Completed', '', this)"><span>&#x2714;</span><a href="javascript:void(0)">Completed initiatives</a></li>
                                            <li onClick="getList('Pending', '', this)"><span>&#x2714;</span> <a href="javascript:void(0)">Pending initiatives</a></li>
                                            <li onClick="getList('Deleted', '', this)"><span>&#x2714;</span><a href="javascript:void(0)">Deleted initiatives</a></li>
                                        </ul>
                                    </li>
                                    <li>
                                        <span>&#x2714;</span> <span>Type</span> <span>&#x25B6;</span>
                                        <ul id="typelist">
                                            <%
                                             for (Map.Entry<Integer, String> entry : teamType.entrySet()) { %>
                                                <li onClick="getList('', <%=entry.getKey()%>, this)"><span>&#x2714;</span> <a href="javascript:void(0)"><%=entry.getValue()%></a></li>
                                            <% } %>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                                        
                            <div class="search-popup">
                                <button type="button">&#x1F50D;</button>						
                                <input type="search" placeholder="Search" class="search-initiative">
                            </div>            
                            
                            <div class="view-by-filter">
                                <span>Active initiatives</span>
                                <button type="button" onClick="getList('', '','', this)">x</button>
                            </div>
                            
                            <div class="view-date-all">
                                <button id="viewByDate" type="button">&#x21C5;</button>
                                <button id="view-all" type="button" onClick="getList('', '','', this)">ALL</button>
                            </div>
                        </h2>

                        <div class="initative-details-popup">

                        </div>

                        <div class="initative-list-all">
                            <%
                                InitiativeList iListObj = new InitiativeList();
                                List<Initiative> iListArray = iListObj.	getInitiativeListByStatus(comid,"Team","Active");
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
                                    <span class="list-date <%=Util.checkDateBefore(new java.util.Date(),iObj.getInitiativeEndDate())?"red":""%>" title="<%=Util.getDisplayDateFormat(iObj.getInitiativeEndDate(), "dd MMM yyy")%>"><%=Util.getDisplayDateFormat(iObj.getInitiativeEndDate(), "dd MMM")%></span>								
                                    <span class="list-score">
                                        <% if(score > -1) { %>
                                        <%=score%>
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
                                     <% }  %>
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
                                            <span class="<%=Util.checkDateBefore(new java.util.Date(),iObj.getInitiativeEndDate())?"red":""%>"><%=Util.getDisplayDateFormat(iObj.getInitiativeEndDate(), "dd MMM, yyyy")%></span>
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
                                                    <span class="score-no"><%=metList.get(i).getScore() %><% if(metList.get(i).getDirection().equalsIgnoreCase("positive")) { %><span class="up">&#x25B4;</span><% } else if(metList.get(i).getDirection().equalsIgnoreCase("negative")) { %><span class="down">&#x25BE;</span><% } else { %><span class="neutral">..</span><% } %></span>
                                                    <% } else { %>
                                                    <span class="empty">Team size too small.</span>
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
                                                <textarea name="initative-chat" id="initative-chat-<%=iObj.getInitiativeId()%>" placeholder="Write a comment"  onKeyPress="enterComment(event, this)"></textarea>
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
                            <% }%>    
                        </div>
                    </div>
                </div>
            </div>
        </div><script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/jquery-ui.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/initiative.js"></script>
        
        <script src="<%=Constant.WEB_ASSETS%>js/jquery.slimscroll.min.js"></script>
        <script>            
            // Get refreshed Metrics panel on completion/delete of initiative
            function getTopList(catid) {
                $('.overlay_form').show();
                var postStr = "catid=" + catid;
                $.ajax({
                    url: '<%=Constant.WEB_CONTEXT%>/initiative/getTopList.jsp',
                    type: 'POST',
                    data: postStr,
                    dataType: 'html',
                    success: function (resp) {
                        $('.overlay_form').hide();
                        $('ul.switched').html(resp);
                    }
                });
            }
            
            function showScroll() {
                if($('.initative-list-all')[0].scrollHeight > 308) {                
                    $('.initative-list-all').slimScroll({
                        height: '308px',
                        alwaysVisible: true,
                        color: '#ff9800',
                        railColor: '#d7d7d7',
                        railOpacity: 0.5,
                        railVisible: true
                    });
                } else {
                    $('.initative-list-all').slimScroll({destroy: true});
                    $('.slimScrollBar, .slimScrollRail').remove();
                    $('.initative-list-all').removeAttr('style');
                }
            }
            
            showScroll();
            
            function emptyList() {
                if($('.initative-list').length === 0) {
                    var text = '<div class="empty-focus-alert">'+
                        '<span>The universe is infinite. Yet, this list is empty. You should do things like</span>'+
                        '<span><span>&nbsp; i. Explore</span><span>&nbsp;ii. Setup a new initiative</span><span>iii. Ask your organisation to take a quick survey</span></span>'+
                        '</div>';
                    $('.initative-list-all').append(text);
                }
            }
            
            emptyList();
            
            function getList(status, type, obj) {            
                var cat = $('.filter-metric').children('.clicked').text();
                var postStr = "status=" + status+"&type="+type+"&cat="+cat;
                $('.overlay_form').show();
                $.ajax({
                    url: '<%=Constant.WEB_CONTEXT%>/initiative/getlist.jsp',
                    type: 'POST',
                    data: postStr,
                    dataType: 'html',
                    success: function (resp) {
                        $('.overlay_form').hide();
                        $('.view-by-list').hide();
                        $('.initative-list-all').html(resp);
                        $('#viewByDate').removeClass('selected').click();
                        showScroll();
                        emptyList();
                    }
                });
            }
            
            function getListByCategory(cat) {
                var postStr = "cat=" + cat+"&status=Active";
                $('.overlay_form').show();
                $.ajax({
                    url: '<%=Constant.WEB_CONTEXT%>/initiative/getlist.jsp',
                    type: 'POST',
                    data: postStr,
                    dataType: 'html',
                    success: function (resp) {
                        $('.overlay_form').hide();
                        $('.initative-list-all').html(resp);
                        $('.view-by-list').hide();
                        showScroll();
                        emptyList();
                    }
                });
            }
            
            function enterComment(e, textarea){
                if(e.which === 13) { 
                    e.preventDefault();
                    $('#updateComments').click();
                }
            }
            
            $(document).ready(function() {
                function compareAsc(a,b) {
                    if (a.time < b.time)
                        return -1;
                    else if (a.time > b.time)
                        return 1;
                    else 
                        return 0;
                }
                function compareDesc(a,b) {
                    if (a.time < b.time)
                        return 1;
                    else if (a.time > b.time)
                        return -1;
                    else 
                        return 0;
                }

                $.sortByDate = function(elements, order) {
                    var arr = [];
                    elements.each(function() {
                        var obj = {},
                        $el = $(this),
                        time = $el.find('.list-date').attr('title'),

                        date = new Date( $.trim( time ) ),
                        timestamp = date.getTime();

                        obj.html = $el[0].outerHTML;
                        obj.time = timestamp;
                        arr.push( obj );
                    });
                    var sorted;
                    if(order === 'ASC') {
                        sorted =  arr.sort(compareAsc);
                    }
                    else {
                        sorted =  arr.sort(compareDesc); 
                    }
                    return sorted;
                };
                                
                $('#viewByDate').on('click', function() {
                    var $content = $('.initative-list-all'),
                    $elements = $('.initative-list');

                    if($(this).hasClass('selected')) {
                        var elements = $.sortByDate($elements, 'DESC');
                        var html = '';
                        for(var i = 0; i< elements.length; ++i ) {
                            html += elements[i].html;
                        }
                        $content.children('.initative-list').remove();
                        $content.append(html);
                        $(this).removeClass('selected');
                    }
                    else {
                        var elements = $.sortByDate($elements, 'ASC');
                        var html = '';
                        for(var i = 0; i < elements.length; ++i) {
                            html += elements[i].html;
                        }
                        $content.children('.initative-list').remove();
                        $content.append(html);

                        $(this).addClass('selected');
                    }
                });    
                
                $('#viewByDate').trigger('click');
            });
        </script>
    </body>
</html>