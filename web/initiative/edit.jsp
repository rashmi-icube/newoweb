<%-- 
    Document   : create
    Created on : Jan 7, 2016, 11:08:06 AM
    Author     : Deepali
--%>

<%@page import="org.icube.owen.metrics.Metrics"%>
<%@page import="org.icube.owen.metrics.MetricsList"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.json.JSONObject"%>
<%
    String moduleName = "initiative";
    String subModuleName = "";
%>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="org.icube.owen.filter.FilterList"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="org.icube.owen.employee.EmployeeList"%>
<%@page import="org.icube.owen.employee.Employee"%>

<% FilterList fl = new FilterList();
String id = request.getParameter("iid");
Initiative initiative = null;
int iid = 0;
try {
       iid = Integer.parseInt(id);
       initiative = new Initiative();
       initiative = initiative.get((Integer) session.getAttribute("comid"),iid);
    } catch(Exception ex) {
        Util.printException(ex);
    }
if(initiative != null) {
%>
<!DOCTYPE html> 

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OWEN</title>
        <link rel="apple-touch-icon" sizes="57x57" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="72x72" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="114x114" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="120x120" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="144x144" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="152x152" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-152x152.png">
        <link rel="apple-touch-icon" sizes="180x180" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/apple-icon-180x180.png">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/android-icon-192x192.png" sizes="192x192">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/favicon-16x16.png" sizes="16x16">
        <link rel="manifest" href="<%=Constant.WEB_ASSETS%>images/favicon_HR/manifest.json">
        <meta name="msapplication-TileColor" content="#da532c">
        <meta name="msapplication-TileImage" content="<%=Constant.WEB_ASSETS%>images/favicon_HR/ms-icon-144x144.png">
    </head>
    
    <body>   
        <div class="overlay_form"><img src="<%=Constant.WEB_ASSETS%>images/ajax-loader.gif"></div>
        
        <div class="container">
            <%@include file="../header.jsp" %>
            <%  
                Map <Integer,String> indivdualType =  initiative.getInitiativeTypeMap(comid,"Individual");
                Map <Integer,String> teamType =  initiative.getInitiativeTypeMap(comid,"Team");
                JSONObject indTypeJSON = new JSONObject(indivdualType);
                JSONObject teamTypeJSON = new JSONObject(teamType);
                String status = initiative.getInitiativeStatus();
                boolean disabled = true;
                if(status.equalsIgnoreCase("Active") || status.equalsIgnoreCase("Pending")) {
                    disabled = false;
                }
            %>
            <script>
                var indTypeJSON = <%=indTypeJSON%>;
                var teamTypeJSON = <%=teamTypeJSON%>;
            </script>
            
            <div class="main">
                <form id="searchIndividual">
                 <input type="hidden" name="iid" value="<%=iid%>"/>   
                    <div class="initiative-selection clearfix">
                    <div class="initiative-category-name clearfix">
                        <div class="initiative-category">
                            <input type="radio" value="0" name="teamtype" id="chooseIndividual" <%=initiative.getInitiativeCategory().equalsIgnoreCase("Individual")?"checked":""%> disabled />
                            <label for="chooseIndividual"><span>&#x2714;</span>Individual</label> 

                            <input type="radio" value="1" name="teamtype" id="chooseTeam" <%=initiative.getInitiativeCategory().equalsIgnoreCase("Team")?"checked":""%> disabled />
                            <label for="chooseTeam"><span>&#x2714;</span>Team</label>
                        </div>
                            <div class="initiative-name">						
                                <label for="initiativeName">Name of initiative</label>
                                <div>
                                    <input id="initiativeName" name="initiativeName" type="text" placeholder="Enter a name for your initiative" value="<%=initiative.getInitiativeName()%>" disabled>
                                    <span class="form-error">Please enter a name.</span>
                                </div>
                            </div>
                    </div>

                    <div class="initiative-type-date clearfix">
                        <div class="initiative-type">						
                            <label for="initiativeType">Type of initiative</label>
                            <select id="initiativeType" name="initiativeType" disabled>
                                 <%
                                    
                                    if(initiative.getInitiativeCategory().equalsIgnoreCase("Team")) {
                                        for (Map.Entry<Integer, String> entry : teamType.entrySet()) { %>
                                        <option value="<%=entry.getKey()%>" <%= entry.getKey().intValue() == initiative.getInitiativeTypeId() ? "selected" : "" %>><%=entry.getValue()%></option>
                                        <% } 
                                    } else {
                                        for (Map.Entry<Integer, String> entry : indivdualType.entrySet()) { %>
                                        <option value="<%=entry.getKey()%>" <%= entry.getKey().intValue() == initiative.getInitiativeTypeId()? "selected":"" %>><%=entry.getValue()%></option>
                                        <% }
                                    }
                               %>
                            </select>
                        </div>

                        <div class="initiative-date">
                            <div>							
                                <label for="startDate">Start Date</label>
                                <input type="text" id="startDate" name="startDate" value="<%=Util.getDisplayDateFormat(initiative.getInitiativeStartDate(),"dd/MM/yyyy")%>" <%=(!disabled && status.equals("Active") || disabled )  ? "disabled" :""%>>
                                <span class="form-error">Please select start date.</span>
                            </div>

                            <div>							
                                <label for="endDate">End Date</label>
                                <input type="text" id="endDate" name="endDate" value="<%=Util.getDisplayDateFormat(initiative.getInitiativeEndDate(),"dd/MM/yyyy")%>" <%=disabled ? "disabled" :""%>>
                                <span class="form-error">Please select end date.</span>
                            </div>
                        </div>
                    </div>

                    <div class="initiative-choices">
                        <div class="initiative-choice-individual">	
                            <span>Find an individual(s)</span>
                            <input type="search" placeholder="Search..." id="findAnIndividual" disabled>
                            <select id="suggestion-box" size="5"></select>
                            <div class="found-list">
                                <% 
                                    if(initiative.getInitiativeCategory().equalsIgnoreCase("individual")) { 
                                        List<Employee> list = initiative.getPartOfEmployeeList();
                                        Employee empObj = list.get(0);
                                %>
                                     <p><input type="hidden" id="empid" name="empid" value="<%=empObj.getEmployeeId() %>"><%=empObj.getFirstName()+" "+(empObj.getLastName() != null ? empObj.getLastName() :"" )%><button type="button">x</button></p>
                                    <%}
                                %>
                            </div>
                        </div>

                        <div class="initiative-choice-team">	
                            <div class="initiative-choice-select">
                                <span>1.</span>

                                <%  List<Filter> preFList = null;
                                        Filter fGeography  = null;
                                        Filter fFunction = null;
                                        Filter fLevel =  null;
                                        if(initiative.getInitiativeCategory().equalsIgnoreCase("team")) {
                                            preFList =  initiative.getFilterList();
                                            if(preFList != null) {
                                                for(int i=0; i<preFList.size(); i++ ) {
                                                    if(preFList.get(i).getFilterName().equals(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME)) {
                                                        fGeography = preFList.get(i);
                                                    } else if(preFList.get(i).getFilterName().equals(Constant.INITIATIVES_FUNCTION_FILTER_NAME)) {
                                                        fFunction = preFList.get(i);
                                                    }else if(preFList.get(i).getFilterName().equals(Constant.INITIATIVES_LEVEL_FILTER_NAME)) {
                                                        fLevel  = preFList.get(i);
                                                    }
                                                }
                                            }
                                            if(fGeography == null) {
                                                fGeography = new Filter();
                                                fGeography.setFilterName(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                                                Map<Integer, String> map = new HashMap<Integer, String>();
                                                map.put(0, "All");
                                                fGeography.setFilterValues(map);
                                                preFList.add(fGeography);
                                            }
                                            if(fFunction == null) {
                                               fFunction = new Filter();
                                                fFunction.setFilterName(Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                                                Map<Integer, String> map = new HashMap<Integer, String>();
                                                map.put(0, "All");
                                                fFunction.setFilterValues(map);
                                                preFList.add(fFunction); 
                                            }
                                            if(fLevel == null) {
                                                fLevel = new Filter();
                                                fLevel.setFilterName(Constant.INITIATIVES_LEVEL_FILTER_NAME);
                                                Map<Integer, String> map = new HashMap<Integer, String>();
                                                map.put(0, "All");
                                                fLevel.setFilterValues(map);
                                                preFList.add(fLevel);
                                            }
                                       }
                                        Map <Integer,String>  fGeographyMap = null;
                                        if(fGeography != null) {
                                            fGeographyMap = fGeography.getFilterValues();
                                        }
                                    %>
                                <label for="teamGeography">Select a geography</label>
                                <select name="teamGeography" id="teamGeography" size="4" multiple disabled>
                                    <%
                                    Filter filter = fl.getFilterValues(comid,Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                                    Map <Integer,String>  item = filter.getFilterValues();
                                        // Function, Zone, Position
                                        for (Map.Entry<Integer, String> entry : item.entrySet()) { 
                                            if(fGeographyMap != null) {
                                                if(fGeographyMap.containsKey(entry.getKey())) { %>
                                                    <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                                                <% } else { %>
                                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                            <% } 
                                            } else { %>  
                                                <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                         <% }
                                        } %>
                                </select>
                                <input type="hidden" name="geoId" value="<%=filter.getFilterId() %>">
                                <input type="hidden" name="filterGeoId" id="filterGeoId" value="<%=filter.getFilterId()%>"/>
                                <div class="overlay"></div>
                            </div>
                            <div class="initiative-choice-select">
                                <span>2.</span>
                                <%
                                       Map <Integer,String>  fFunctionMap = null;
                                        if(fFunction != null) {
                                            fFunctionMap = fFunction.getFilterValues();
                                        }     
                                     %>
                                <label for="teamFunction">Select a function</label>
                                <select name="teamFunction" id="teamFunction" size="4" multiple disabled>
                                        <%
                                            filter = fl.getFilterValues(comid,Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                                            item = filter.getFilterValues();
                                         // Function, Zone, Position
                                         for (Map.Entry<Integer, String> entry : item.entrySet()) { 
                                               if(fFunctionMap != null) {
                                                   if(fFunctionMap.containsKey(entry.getKey())) { %>
                                                    <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                                               <%  } else { %>
                                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                           <%      } 
                                                }else { %>  
                                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                           <% }
                                           } %>
                                    </select>
                                    <input type="hidden" name="funId" value="<%=filter.getFilterId() %>">
                                    <input type="hidden" name="filterFunId" id="filterFunId" value="<%=filter.getFilterId()%>"/>
                                <div class="overlay"></div>
                            </div>
                            <div class="initiative-choice-select">
                                <span>3.</span>
                                 <%
                                       Map <Integer,String>  fLevelMap = null;
                                        if(fLevel != null) {
                                            fLevelMap = fLevel.getFilterValues();
                                        }     
                                     %>
                                <label for="teamLevel">Select a level</label>
                                <select name="teamLevel" id="teamLevel" size="4" multiple disabled>
                                    <%
                                        filter = fl.getFilterValues(comid,Constant.INITIATIVES_LEVEL_FILTER_NAME);
                                        item = filter.getFilterValues();
                                        // Function, Zone, Position
                                        for (Map.Entry<Integer, String> entry : item.entrySet()) { 
                                              if(fLevelMap != null) {
                                                  if(fLevelMap.containsKey(entry.getKey())) { %>
                                                   <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                                              <%  } else { %>
                                                   <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                          <%      } 
                                               }else { %>  
                                                   <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                          <% }
                                       } %>
                                </select>
                                <input type="hidden" name="levelId" value="<%=filter.getFilterId() %>">
                                <input type="hidden" name="filterLevelId" id="filterLevelId" value="<%=filter.getFilterId()%>"/>
                                <div class="overlay"></div>
                            </div>
                        </div>			
                    </div>

<!--                        <button type="button" title="Find the correct individuals for this initiative" id="findIndividuals" disabled>Go</button>-->
                </div>

                <div class="metrics-section">
                    <div class="metrics-header">
                        <h3>Metrics</h3>
                        <button type="button" id="collapse-metrics">Collapse</button>
                    </div>
                    <div class="create-metrics-list">
                        <ul>
                            <%  
                               int intInitiativeType = initiative.getInitiativeTypeId();
                                List<Metrics> metList = new ArrayList();
                                MetricsList mListObj =  (MetricsList) ObjectFactory.getInstance("org.icube.owen.metrics.MetricsList");
                                if(initiative.getInitiativeCategory().equalsIgnoreCase("team")) {
                                    metList = mListObj.getInitiativeMetricsForTeam(comid,intInitiativeType,preFList);
                               } else {
                                    List<Employee> list = initiative.getPartOfEmployeeList();
                                    metList = mListObj.getInitiativeMetricsForIndividual(comid,intInitiativeType,list);
                                }
                                for(int i=0; i < metList.size(); i++) { 
                                %>
                                <li <%=metList.get(i).isPrimary() ? "class=\"highlighted\"" : "" %> >
                                    <div class="chart" id="createStat<%=(i+1)%>" data-percent=<%=metList.get(i).getScore()%> >
                                        <div class="chart-score">
                                            <% if(metList.get(i).getScore() > -1) { %>
                                            <span><%=metList.get(i).getScore() %></span> 
                                            <% if(metList.get(i).getDirection().equalsIgnoreCase("positive")) { %>   
                                                        <span class="up">&#x25B4;</span>
                                                    <% } else if(metList.get(i).getDirection().equalsIgnoreCase("negative")) { %>
                                                        <span class="down">&#x25BE;</span>
                                                    <% } else { %>
                                                        <span class="neutral">..</span>
                                            <% } %>
                                            <% } else { %>
                                                <span class="empty">Team size too small.</span>
                                            <% } %>
                                        </div>
                                    </div>
                                    <span class="chart-name"><%=metList.get(i).getName()%></span>    
                                </li>
                                <% } %>
                        </ul>
                    </div>
                </div>               

                <div class="key-individuals">
                    <div class="individual-header">
                        <h3>Key Individuals </h3>
                        <div class="search-popup">
                            <button type="button">&#x1F50D;</button>						
                            <input type="search" placeholder="Search" class="search-individual">
                        </div>
                    </div>
                    <div class="individual-grid-comment">
                        <div class="individual-grid">
                        <%
                        EmployeeList elist = new EmployeeList();
                        List<Employee> iOwnerList = initiative.getOwnerOfList();
                        List<Employee> smartEmpList = null;
                        if(initiative.getInitiativeCategory().equalsIgnoreCase("team")) {
                            smartEmpList =  elist.getEmployeeSmartListForTeam(comid,preFList,intInitiativeType);
                        } else {
                            List<Employee> list = initiative.getPartOfEmployeeList();
                            smartEmpList =  elist.getEmployeeSmartListForIndividual(comid,list,intInitiativeType);
                        }
                        for(int i=0; i<smartEmpList.size(); i++) {
                            Employee emp =  smartEmpList.get(i); %>
        <!--                <li>-->

                            <div class="individual-cell">
                                <div class="individual-profile">
                                    <div class="profile-front">
                                        <div class="photo-individual">
                                            <figure>									
                                                <div style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=emp.getCompanyId()%>&eid=<%=emp.getEmployeeId()%>');" class="person-pic"></div>
                                                <figcaption><%=emp.getFirstName()+(emp.getLastName()!=null && !emp.getLastName().equals("")?  " "+emp.getLastName():"")%></figcaption>
                                            </figure>
                                        </div>
                                        <div class="score-add-button clearfix">
                                            <span><%=emp.getGrade()%><span></span></span>
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
                                    if(iOwnerList!= null) { 
                                        for(int cnt=0; cnt<iOwnerList.size(); cnt++) {
                                            if(iOwnerList.get(cnt).getEmployeeId() == emp.getEmployeeId()) {
                                                 found = true;
                                                 break;
                                            }
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
        <!--                </li>-->
                        <% } %>
                        </div>

                        <div class="comment-create">
                            <div class="scrollbar">
                                <a href="#" class="prev"></a>
                                <a href="#" class="next"></a>
                            </div> 
                            <div class="write-comment">	
                                <div class="no-key-selected">
                                    <%
                                    String ownerEmpIds = "";
                                    if(iOwnerList!= null) {
                                        int count = iOwnerList.size() > 5 ? 5 : iOwnerList.size();
                                        String remaining = iOwnerList.size() > 5 ? "and "+(iOwnerList.size()-5)+" more" : "";
                                        for (int i = 0; i < iOwnerList.size(); i++) { 
                                            ownerEmpIds += "\""+iOwnerList.get(i).getEmployeeId()+"\",";
                                            if(i < count) {
                                            %>
                                            <p><%= iOwnerList.get(i).getFirstName().substring(0, 1) + (iOwnerList.get(i).getLastName() != null ? iOwnerList.get(i).getLastName().substring(0, 1) : "")%></p>
                                        <% }
                                        }
                                    } %>
                                </div> 
                                <div class="popup-chat-window">
                                    <%= initiative.getInitiativeComment()%>
                                </div>
                            </div>
                            <div class="create-initiative clearfix">
                                <button type="button" id="cancel-initiative">Cancel</button>
                                <button type="button" id="update-initiative">Save changes</button>
                            </div>
                            <div id="resp_msg"></div>
                        </div>
                    </div>
                </div>
            </form>
         </div>
        </div>
                                
        <script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/jquery-ui.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/isotope.pkgd.min.js"></script>
        <script> 
        </script>

        <script src="<%=Constant.WEB_ASSETS%>js/easypiechart.js"></script>
        <script>
            var arrEmpId = [<%=ownerEmpIds%>];
            $(document).ready(function() {
                $('#createStat1').easyPieChart({
                    barColor: '#ffb84e',
                    lineCap: 'butt',
                    lineWidth: 6,
                    scaleColor: false,
                    trackColor: '#c0c0c0',	
                    size: 96
                });
                $('#createStat2').easyPieChart({
                    barColor: '#ffb84e',
                    lineCap: 'butt',
                    lineWidth: 6,
                    scaleColor: false,
                    trackColor: '#c0c0c0',
                    size: 96
                });
                $('#createStat3').easyPieChart({
                    barColor: '#ffb84e',
                    lineCap: 'butt',
                    lineWidth: 6,
                    scaleColor: false,
                    trackColor: '#c0c0c0',
                    size: 96
                });
                $('#createStat4').easyPieChart({
                    barColor: '#ffb84e',
                    lineCap: 'butt',
                    lineWidth: 6,
                    scaleColor: false,
                    trackColor: '#c0c0c0',
                    size: 96
                });
                $('#createStat5').easyPieChart({
                    barColor: '#ffb84e',
                    lineCap: 'butt',
                    lineWidth: 6,
                    scaleColor: false,
                    trackColor: '#c0c0c0',
                    size: 96
                });
            });
        </script>

        <script src="<%=Constant.WEB_ASSETS%>js/initiative.js"></script>
        <script>
            $(document).ready(function() {
                $('.create-metrics-list').slideDown('400');
                   
                $('#startDate').datepicker({
                    showOn: "both",
                    buttonImage: '<%=Constant.WEB_ASSETS%>images/calendar_icon_button.png',
                    buttonImageOnly: true,
                    buttonText: 'Select date',
                    dateFormat: 'dd/mm/yy',
                    minDate: 0,
                    maxDate: $('#endDate').val(),
                    onSelect: function() {
                        $('#startDate')[0].setCustomValidity('');
                    }, 
                    onClose: function(selectedDate) {
                        $(this).datepicker('setDate', $(this).datepicker('getDate'));
                        if(selectedDate) {
                            $('#endDate').datepicker('option', 'minDate', $(this).datepicker('getDate'));
                        }
                    }
                });
               
                $('#endDate').datepicker({
                    showOn: "both",
                    buttonImage: '<%=Constant.WEB_ASSETS%>images/calendar_icon_button.png',
                    buttonImageOnly: true,
                    buttonText: 'Select date',
                    dateFormat: 'dd/mm/yy',
                    minDate: $('#startDate').val(),
                    onSelect: function() {
                        $('#endDate')[0].setCustomValidity('');
                    },
                    onClose: function(selectedDate) {
                        $(this).datepicker('setDate', $(this).datepicker('getDate'));
                        if(selectedDate) {
                            $('#startDate:enabled').datepicker('option', 'maxDate', $(this).datepicker('getDate'));
                        }
                    }
                });

                $('.hasDatepicker:disabled').datepicker('disable');
                
                $('.found-list button').prop('disabled', true);
                
                if($('.individual-grid').height() <= 316) {
                    $('.scrollbar a').hide();
                } else {
                    $('.scrollbar a').show();
                }
                
                var $grid = $('.individual-grid').isotope({
                    itemSelector: '.individual-cell',
                    layoutMode: 'fitRows'
                });
                var $quicksearch = $('.search-individual').keyup(debounce(function() {
                    $grid.isotope();
                }, 200));
                
                $('#findIndividuals').on('click', function() {
                    // Validation to be written
                    if(true) {
                        var postStr = $('#searchIndividual').serialize();
                        $('#teamGeography :selected').each(function(i, selectedElement) {
                            postStr +="&teamGeographyText="+ $(selectedElement).text();
                        });
                        $('#teamLevel :selected').each(function(i, selectedElement) {
                            postStr +="&teamLevelText="+ $(selectedElement).text();
                        });
                        $('#teamFunction :selected').each(function(i, selectedElement) {
                            postStr +="&teamFunctionText="+ $(selectedElement).text();
                        });
                        $('.overlay_form').show();
                        $.ajax({
                            url: '<%=Constant.WEB_CONTEXT%>/initiative/AjaxGetIndividual.jsp',
                            type: 'POST',
                            data: postStr,
                            dataType: 'html',
                            success: function(resp) {
                                $('.overlay_form').hide();
                                $('.individual-grid').html(resp);
                                $('.create-initiative').css('visibility','visible');
                                $('.key-individuals').css('display','block');
                            }    
                        });   
                    } else {
                        return false;
                    }
                });

                function fetchOrgnizationSearch(q) {
                    var query = "keywords="+q+"&type=1&oEmpids="+arrEmpId.join(",");
                    $('.grid_overlay_form').show();
                    var currentRequest = null;
                    currentRequest = jQuery.ajax({
                        type: "POST",
                        url: "/initiative/searchIndividual.jsp",
                        data: query,
                        dataType: 'HTML',
                        beforeSend : function()    {           
                            if(currentRequest !== null) {
                                currentRequest.abort();
                            }
                        },
                        success: function(resp){
                            $('.grid_overlay_form').hide();
                            $('.individual-grid').html(resp);
                            $('.key-individuals').css('display','block');
                            $('#cancelInitiative, #create-initiative').prop('disabled', false); 
                            var flag = $('.found-list').children().length;
                            if(flag) {                            
                                $('.individual-cell').each(function() {    
                                    var empId = $(this).find($('input[name="keyIndividual"]')).val();
                                    if($('#empid').val() === empId) {
                                        $(this).remove();
                                    }
                                });
                            }
                        },
                        complete: function(resp) {
                            if($('.individual-grid').is('[style]')) {
                                $('.individual-grid').isotope('destroy');
                            }
                            var $grid = $('.individual-grid').isotope({
                                itemSelector: '.individual-cell',
                                layoutMode: 'fitRows'
                            });  
                            if($('.individual-grid').height() <= 316) {
                                $('.scrollbar a').hide();
                            } else {
                                $('.scrollbar a').show();
                            }
                        }
                    });
                }

                $('.search-individual').on('input', function(){
                    if($(this).val() !== '') {
                        fetchOrgnizationSearch($(this).val());
                    } else {
                        var postStr = $('#searchIndividual').serialize();
                        postStr += "&teamtype=" + $('input[name="teamtype"]:checked').val();
                        postStr += "&initiativeType=" + $('#initiativeType').val();
                        if($('#startDate').is(':disabled')) {
                            postStr += "&startDate="+ $('#startDate').val();
                        }
                        $('#teamGeography :selected').each(function(i, selectedElement) {
                            postStr += "&teamGeography="+ $('#teamGeography').val();
                            postStr += "&teamGeographyText="+ $(selectedElement).text();
                        });
                        $('#teamLevel :selected').each(function(i, selectedElement) {
                            postStr += "&teamLevel="+ $('#teamLevel').val();
                            postStr += "&teamLevelText="+ $(selectedElement).text();
                        });
                        $('#teamFunction :selected').each(function(i, selectedElement) {
                            postStr += "&teamFunction="+ $('#teamFunction').val();
                            postStr += "&teamFunctionText="+ $(selectedElement).text();
                        });
                        postStr += "&empid="+ $('#empid').val();
                        postStr +="&oEmpids="+arrEmpId.join(",");
                        $.ajax({
                            url: '<%=Constant.WEB_CONTEXT%>/initiative/AjaxGetIndividual.jsp',
                            type: 'POST',
                            data: postStr,
                            dataType: 'html',
                            success: function(resp) {
                                $('.overlay_form').hide();
                                $('.individual-grid').html(resp);
                            },
                            complete: function(resp) {
                                if($('.individual-grid').is('[style]')) {
                                    $('.individual-grid').isotope('destroy');
                                }
                                var $grid = $('.individual-grid').isotope({
                                    itemSelector: '.individual-cell',
                                    layoutMode: 'fitRows'
                                });  
                                if($('.individual-grid').height() <= 316) {
                                    $('.scrollbar a').hide();
                                } else {
                                    $('.scrollbar a').show();
                                }
                            }
                        });
                    }
                });

                $('#cancel-initiative').on('click', function() {
                   window.location.href = "list.jsp";
                });

                $('#update-initiative').on('click', function() {
                    if(true) {
                        var postStr = $('#searchIndividual').serialize();
                        $('#teamGeography :selected').each(function(i, selectedElement) {
                            postStr +="&teamGeographyText="+ $(selectedElement).text();
                        });
                        $('#teamLevel :selected').each(function(i, selectedElement) {
                             postStr +="&teamLevelText="+ $(selectedElement).text();
                        });
                        $('#teamFunction :selected').each(function(i, selectedElement) {
                           postStr +="&teamFunctionText="+ $(selectedElement).text();
                        });
                        $('#initiativeType :selected').each(function(i, selectedElement) {
                           postStr +="&initiativeTypeText="+ $(selectedElement).text();
                        });
                        for(var i=0; i<arrEmpId.length; i++) {
                            postStr +="&keyList="+arrEmpId[i];
                        }
                        
                        $('.overlay_form').show();
                        $.ajax({
                            url: '<%=Constant.WEB_CONTEXT%>/initiative/updateinitiative.jsp',
                            type: 'POST',
                            data: postStr,
                            dataType: 'json',
                            success: function(resp) {
                                $('.overlay_form').hide();
                                window.location.href = '<%=Constant.WEB_CONTEXT%>/initiative/list.jsp';
                            }
                        });   
                    } else {
                        return false;
                    }
                });
            });
        </script> 
    </body>
</html>
<% } %>