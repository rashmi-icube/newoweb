<%-- 
    Document   : create
    Created on : Jan 7, 2016, 11:08:06 AM
    Author     : Deepali
--%>

<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.metrics.MetricsList"%>
<%@page import="org.icube.owen.metrics.Metrics"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.owen.web.Util"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.json.JSONObject"%>
<%
    String moduleName = "initiative";
    String subModuleName = "create";
%>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="org.icube.owen.filter.FilterList"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="org.icube.owen.dashboard.Alert"%>

<!DOCTYPE html> 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OWEN- Create new initiative</title>
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
        <meta name="theme-color" content="#ffffff">
    </head>
    
    <body>
        <div class="overlay_form"><img src="<%=Constant.WEB_ASSETS%>images/ajax-loader.gif"></div>
        
        <div class="container">
            <%@include file="../header.jsp" %>
            <%  boolean goButton = false;
                boolean goButtonDis = false;
                FilterList fl = new FilterList(); 
                Initiative initiative = new Initiative();
                Map <Integer,String> indivdualType =  initiative.getInitiativeTypeMap(comid,"Individual");
                Map <Integer,String> teamType =  initiative.getInitiativeTypeMap(comid,"Team");
                JSONObject indTypeJSON = new JSONObject(indivdualType);
                JSONObject teamTypeJSON = new JSONObject(teamType);
                String catid = request.getParameter("c") != null ?  request.getParameter("c") : ""; // 0 Individual 1 Team
                
                String type = request.getParameter("t") != null ?  request.getParameter("t") : ""; // Initiative Type
                String alertid = request.getParameter("a") != null ?  request.getParameter("a") : "";
                int intType = 0;
                if(type != null && !type.equals("")) {
                    intType = Util.getIntValue(type);
                }
                
                if(catid != null && !catid.equals("")) {
                    goButton= true;
                }
                
                Map<Integer,String> alertFFilter = new HashMap<Integer,String>();
                Map<Integer,String> alertLFilter = new HashMap<Integer,String>();
                Map<Integer,String> alertGFilter = new HashMap<Integer,String>();
                List<Filter> preFList  = null;
                if(alertid != null && !alertid.equals("")) {
                    Alert alert = new Alert();
                    alert = alert.get(comid,Util.getIntValue(alertid));
                    catid = "1";
                    goButton= true; 
                    intType = alert.getInitiativeTypeId();
                    List<Filter> alertFilter = alert.getFilterList();
                    for(int i=0; i<alertFilter.size(); i++) {
                       if(alertFilter.get(i).getFilterName().equals(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME)) {
                           alertGFilter = alertFilter.get(i).getFilterValues();
                       } else if(alertFilter.get(i).getFilterName().equals(Constant.INITIATIVES_FUNCTION_FILTER_NAME)) {
                           alertFFilter = alertFilter.get(i).getFilterValues();
                       } else if(alertFilter.get(i).getFilterName().equals(Constant.INITIATIVES_LEVEL_FILTER_NAME)) {
                           alertLFilter = alertFilter.get(i).getFilterValues();
                       }
                    }
                    preFList = new ArrayList<Filter>();
                    Filter fGeography = new Filter();
                    fGeography.setFilterName(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                    fGeography.setFilterValues(alertGFilter);
                    Filter fFunction = new Filter();
                    fFunction.setFilterName(Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                    fFunction.setFilterValues(alertFFilter);
                    Filter fLevel = new Filter();
                    fLevel.setFilterName(Constant.INITIATIVES_LEVEL_FILTER_NAME);
                    fLevel.setFilterValues(alertLFilter);
                    preFList.add(fGeography);
                    preFList.add(fFunction);
                    preFList.add(fLevel);
                }
                
                String[] teams = request.getParameterValues("team");
                if(teams != null) {
                    for(int i=0; i<teams.length; i++) {
                        String team = teams[i];
                        String[] filter = team.split("\\|");
                        String[] filterName = filter[0].split("#");
                        alertGFilter.put(Util.getIntValue(filterName[0]), filterName[1]);
                        filterName = filter[1].split("#");
                        alertFFilter.put(Util.getIntValue(filterName[0]), filterName[1]);
                        filterName = filter[2].split("#");
                        alertLFilter.put(Util.getIntValue(filterName[0]), filterName[1]);
                    }
                    goButton= true;
                    preFList = new ArrayList<Filter>();
                    Filter fGeography = new Filter();
                    fGeography.setFilterName(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                    fGeography.setFilterValues(alertGFilter);
                    Filter fFunction = new Filter();
                    fFunction.setFilterName(Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                    fFunction.setFilterValues(alertFFilter);
                    Filter fLevel = new Filter();
                    fLevel.setFilterName(Constant.INITIATIVES_LEVEL_FILTER_NAME);
                    fLevel.setFilterValues(alertLFilter);
                    preFList.add(fGeography);
                    preFList.add(fFunction);
                    preFList.add(fLevel);
                    
                }
                String rEmpid = request.getParameter("emp_id");
                List<Employee> empList = null;
                Employee empObj = null;
                if(rEmpid != null && !rEmpid.equals("")) {
                    goButton= true;
                    empList = new ArrayList();
                    Employee emp = (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee");
                    int employeeId = Util.getIntValue(rEmpid);
                    empObj = emp.get(comid,employeeId);
                    empList.add(empObj);
                }
                if(preFList != null) {
                    
                }
            %>
            
            <div class="main">
                <form id="searchIndividual">
                    <div class="initiative-selection clearfix">
                        <div class="initiative-category-name clearfix">
                            <div class="initiative-category">
                                <input type="radio" value="0" name="teamtype" id="chooseIndividual" <%=catid.equalsIgnoreCase("0")?"checked":""%>/>
                                <label for="chooseIndividual"><span>&#x2714;</span>Individual</label> 
                                <input type="radio" value="1" name="teamtype" id="chooseTeam" <%=catid.equalsIgnoreCase("1")?"checked":""%> />
                                <label for="chooseTeam"><span>&#x2714;</span>Team</label>
                            </div>
                                <div class="initiative-name">						
                                    <label for="initiativeName">Name of initiative</label>
                                    <div>
                                        <input id="initiativeName" name="initiativeName" type="text" placeholder="Enter a name for your initiative" required oninvalid="setCustomValidity('Please fill in this field.')" oninput="setCustomValidity('')">
                                    </div>
                                </div>
                        </div>
                        <div class="initiative-type-date clearfix">
                            <div class="initiative-type">						
                                <label for="initiativeType">Type of initiative</label>
                                <select id="initiativeType" name="initiativeType" style="display:none;">
                                <%
                                    if(catid.equals("1")) {
                                        for (Map.Entry<Integer, String> entry : teamType.entrySet()) { %>
                                            <option value="<%=entry.getKey()%>" <%=entry.getKey() == intType ? "selected" : "" %>><%=entry.getValue()%></option>
                                        <% } 
                                    } else if(catid.equals("0")){
                                        for (Map.Entry<Integer, String> entry : indivdualType.entrySet()) { %>
                                            <option value="<%=entry.getKey()%>" <%=entry.getKey() == intType? "selected":"" %>><%=entry.getValue()%></option>
                                        <% }
                                    }
                                %>
                                </select>
                            </div>
                            <div class="initiative-date">
                                <div>							
                                    <label for="startDate">Start Date</label>
                                    <input type="text" id="startDate" name="startDate" required oninvalid="setCustomValidity('Please fill in this field.')" oninput="setCustomValidity('')">
                                    <span class="form-error">Please select start date.</span>
                                </div>
                                <div>							
                                    <label for="endDate">End Date</label>
                                    <input type="text" id="endDate" name="endDate" required oninvalid="setCustomValidity('Please fill in this field.')" oninput="setCustomValidity('')">
                                    <span class="form-error">Please select end date.</span>
                                </div>
                            </div>
                        </div>

                        <div class="initiative-choices">
                            <div class="initiative-choice-individual">	
                                <span>Find an individual(s)</span>
                                <input type="search" placeholder="Search..." id="findAnIndividual" <%= !catid.equalsIgnoreCase("0") || empObj != null?"disabled":""%> required oninvalid="setCustomValidity('Please fill in this field.')" oninput="setCustomValidity('')">
                                <select id="suggestion-box" size="5"></select>
                                
                                <div class="found-list">
                                    <% 
                                        if(empObj != null) { %>
                                         <p><input type="hidden" id="empid" name="empid" value="<%=empObj.getEmployeeId() %>"><%=empObj.getFirstName()+" "+(empObj.getLastName() != null ? empObj.getLastName() :"" )%><button type="button">x</button></p>
                                        <%}
                                    %>
                                </div>
                            </div>

                            <div class="initiative-choice-team">	
                                <div class="initiative-choice-select">
                                    <span>1.</span>
                                    <label for="teamGeography">Select a geography</label>
                                    <% Filter filter = fl.getFilterValues(comid,Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                                        
                                    %>
                                    <input type="hidden" name="geoId" value="<%=filter.getFilterId() %>">
                                    <select name="teamGeography" id="teamGeography" size="4" <%= !catid.equalsIgnoreCase("1")?"disabled":""%> multiple required oninvalid="setCustomValidity('Please select an item in the list.')" oninput="setCustomValidity('')" onchange="setCustomValidity('')">
                                        <%
                                            Map <Integer,String>  item = filter.getFilterValues();
                                            // Function, Zone, Position
                                            for (Map.Entry<Integer, String> entry : item.entrySet()) { 
                                                if(alertGFilter != null) {
                                                       if(alertGFilter.containsKey(entry.getKey())) { %>
                                                        <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                                                   <%  } else { %>
                                                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                    <%      } 
                                                    }else { %>  
                                                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                 <% }
                                                } %>
                                    </select>
                                    <input type="hidden" name="filterGeoId" id="filterGeoId" value="<%=filter.getFilterId()%>"/>
                                    <div class="select-overlay"></div>
                                </div>
                                <div class="initiative-choice-select">
                                    <span>2.</span>
                                    <label for="teamFunction">Select a function</label>
                                    <%  filter = fl.getFilterValues(comid,Constant.INITIATIVES_FUNCTION_FILTER_NAME); %>
                                    <input type="hidden" name="funId" value="<%=filter.getFilterId() %>">
                                    <select name="teamFunction" id="teamFunction" size="4" <%= !catid.equalsIgnoreCase("1")?"disabled":""%> multiple required oninvalid="setCustomValidity('Please select an item in the list.')" oninput="setCustomValidity('')" onchange="setCustomValidity('')">
                                        <%
                                            item = filter.getFilterValues();
                                             // Function, Zone, Position
                                            for (Map.Entry<Integer, String> entry : item.entrySet()) { 
                                                   if(alertFFilter != null) {
                                                       if(alertFFilter.containsKey(entry.getKey())) { %>
                                                        <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                                                   <%  } else { %>
                                                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                               <%      } 
                                                    }else { %>  
                                                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                               <% }
                                               } %>
                                    </select>
                                    <input type="hidden" name="filterFunId" id="filterFunId" value="<%=filter.getFilterId()%>"/>
                                    <div class="select-overlay"></div>
                                </div>
                                <div class="initiative-choice-select">
                                    <span>3.</span>
                                    <label for="teamLevel">Select a level</label>
                                    <%  filter = fl.getFilterValues(comid,Constant.INITIATIVES_LEVEL_FILTER_NAME); %>
                                    <input type="hidden" name="levelId" value="<%=filter.getFilterId() %>">
                                    <select name="teamLevel" id="teamLevel" size="4" <%= !catid.equalsIgnoreCase("1")?"disabled":""%> multiple required oninvalid="setCustomValidity('Please select an item in the list.')" oninput="setCustomValidity('')" onchange="setCustomValidity('')">
                                        <%
                                            item = filter.getFilterValues();
                                            // Function, Zone, Position
                                            for (Map.Entry<Integer, String> entry : item.entrySet()) { 
                                                if(alertLFilter != null) {
                                                    if(alertLFilter.containsKey(entry.getKey())) { %>
                                                        <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                                                    <% } else { %>
                                                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                    <% } 
                                                } else { %>  
                                                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                                <% }
                                            } 
                                        %>
                                    </select>
                                    <input type="hidden" name="filterLevelId" id="filterLevelId" value="<%=filter.getFilterId()%>"/>
                                    <div class="select-overlay"></div>
                                </div>
                            </div>			
                        </div>
                        <button type="submit" title="Find the correct individuals for this initiative" id="findIndividuals" <%= goButton ?"class='enabled'":  "disabled"%>>Go</button>
                    </div>
                    <div class="metrics-section">
                        <div class="metrics-header">
                            <h3>Metrics</h3>
                            <button type="button" id="collapse-metrics" disabled>Expand</button>
                        </div>
                        <div class="create-metrics-list">
                            <ul id="metrics-list">
                            </ul>
                        </div>
                    </div>               
                    <div class="key-individuals">
                        <div class="individual-header">
                            <h3>Key Individuals</h3>
                            <div class="search-popup">
                                <button type="button">&#x1F50D;</button>						
                                <input type="search" placeholder="Search" class="search-individual">
                            </div>
                        </div>
                        <div class="individual-grid-comment">
                            <div class="grid_overlay"></div>
                            <div class="grid_overlay_form"><img src="<%=Constant.WEB_ASSETS%>images/ajax-loader.gif"></div>
                            
                            <div class="individual-grid">
                                <div class="individual-cell">
                                    <div class="individual-profile blank-profile">
                                        <div class="photo-individual">
                                            <figure>									
                                                <img src="<%=Constant.WEB_ASSETS%>/images/silhouette_individual.png">
                                            </figure>
                                        </div>
                                    </div>
                                </div>
                                <div class="individual-cell">
                                    <div class="individual-profile blank-profile">
                                        <div class="photo-individual">
                                            <figure>									
                                                <img src="<%=Constant.WEB_ASSETS%>/images/silhouette_individual.png">
                                            </figure>
                                        </div>
                                    </div>
                                </div>
                                <div class="individual-cell">
                                    <div class="individual-profile blank-profile">
                                        <div class="photo-individual">
                                            <figure>									
                                                <img src="<%=Constant.WEB_ASSETS%>/images/silhouette_individual.png">
                                            </figure>
                                        </div>
                                    </div>
                                </div> 
                                <div class="individual-cell">
                                    <div class="individual-profile blank-profile">
                                        <div class="photo-individual">
                                                <figure>									
                                                        <img src="<%=Constant.WEB_ASSETS%>/images/silhouette_individual.png">
                                                </figure>
                                        </div>
                                    </div>
                                </div> 
                                <div class="individual-cell">
                                    <div class="individual-profile blank-profile">
                                        <div class="photo-individual">
                                                <figure>									
                                                        <img src="<%=Constant.WEB_ASSETS%>/images/silhouette_individual.png">
                                                </figure>
                                        </div>
                                    </div>
                                </div>  
                                <div class="individual-cell">
                                    <div class="individual-profile blank-profile">
                                        <div class="photo-individual">
                                            <figure>									
                                                <img src="<%=Constant.WEB_ASSETS%>/images/silhouette_individual.png">
                                            </figure>
                                        </div>
                                    </div>
                                </div>
                                <div class="individual-cell">
                                    <div class="individual-profile blank-profile">
                                        <div class="photo-individual">
                                            <figure>									
                                                <img src="<%=Constant.WEB_ASSETS%>/images/silhouette_individual.png">
                                            </figure>
                                        </div>
                                    </div>
                                </div>
                                <div class="individual-cell">
                                    <div class="individual-profile blank-profile">
                                        <div class="photo-individual">
                                            <figure>									
                                                <img src="<%=Constant.WEB_ASSETS%>/images/silhouette_individual.png">
                                            </figure>
                                        </div>
                                    </div>
                                </div> 
                                <div class="individual-cell">
                                    <div class="individual-profile blank-profile">
                                        <div class="photo-individual">
                                                <figure>									
                                                        <img src="<%=Constant.WEB_ASSETS%>/images/silhouette_individual.png">
                                                </figure>
                                        </div>
                                    </div>
                                </div> 
                                <div class="individual-cell">
                                    <div class="individual-profile blank-profile">
                                        <div class="photo-individual">
                                                <figure>									
                                                        <img src="<%=Constant.WEB_ASSETS%>/images/silhouette_individual.png">
                                                </figure>
                                        </div>
                                    </div>
                                </div>                
                            </div>
                            <div class="comment-create">
                                <div class="scrollbar" style="visibility: hidden;">
                                    <a href="#" class="prev"></a> 
                                    <a href="#" class="next"></a>
                                </div>						
                                <div class="write-comment">
                                    <div class="no-key-selected">
                                    </div>
                                    <span>Me</span>
                                    <textarea placeholder="Write a comment" name="initiativeComment"></textarea>
                                </div>
                                <div class="create-initiative clearfix" style="visibility: hidden;">
                                    <button type="button" id="cancelInitiative" disabled>Cancel</button>
                                    <button type="button" id="create-initiative" disabled>Create</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
             </div>
        </div>
                                                
        <script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/jquery-ui.js"></script>

        <script>
            <% if(!catid.equals("")) { %>
                $(document).ready(function () {
                    <% if(catid.equals("1")) { %>
                        $('.initiative-choice-select div').removeClass('disable-animate').addClass('enable-animate');                  
                    <% } %>
                    $('#initiativeType').show(); 
                });
            <% } %>
            var indTypeJSON = <%=indTypeJSON%>;
            var teamTypeJSON = <%=teamTypeJSON%>;
        </script>
            
        <script>
            var arrEmpId = [];
            $(document).ready(function() {
                $('#startDate').datepicker({
                    showOn: "both",
                    buttonImage: '<%=Constant.WEB_ASSETS%>images/calendar_icon_button.png',
                    buttonImageOnly: true,
                    buttonText: 'Select date',
                    dateFormat: "dd/mm/yy",
                    minDate: 0,
                    onSelect: function() {
                        $('#startDate')[0].setCustomValidity('');
                    },
                    onClose: function(selectedDate) {
                        if(!selectedDate) {
                            $('#endDate').datepicker('option', 'minDate', 0);
                        }
                        else {
                            $('#endDate').datepicker('option', 'minDate', selectedDate);
                        }
                    }
                });
                $('#endDate').datepicker({
                    showOn: "both",
                    buttonImage: '<%=Constant.WEB_ASSETS%>images/calendar_icon_button.png',
                    buttonImageOnly: true,
                    buttonText: 'Select date',
                    dateFormat: "dd/mm/yy",
                    minDate: 0,
                    onSelect: function() {
                        $('#endDate')[0].setCustomValidity('');
                    },
                    onClose: function(selectedDate) {
                        $('#startDate').datepicker('option', 'maxDate', selectedDate);
                    }
                });

                $('#findAnIndividual').on('input', function(){
                    var flag = $('.found-list').children().length;
                    if(!flag) {
                        $.ajax({
                            type: 'POST',
                            url: '<%=Constant.WEB_CONTEXT%>/initiative/searchIndividual.jsp',
                            data: 'keywords='+$(this).val(),
                            beforeSend: function(xhr, options){
                                $('#findAnIndividual').css('background', '#fff url(<%=Constant.WEB_ASSETS%>images/loaderIcon.gif) no-repeat 2px');
                                if($('#findAnIndividual').val() === '') {
                                    $('#findAnIndividual').removeAttr('style');
                                    $('#suggestion-box').html('').hide();
                                    xhr.abort();
                                }
                            },
                            success: function(data){
                                $('#suggestion-box').show().html(data);
                                if(data==='') {
                                    $('#suggestion-box').hide();
                                }
                                $('#findAnIndividual').removeAttr('style');

                                $('#findAnIndividual').on('keyup' ,function(e){
                                    if(e.which === 40) {
                                        $('#suggestion-box').focus();
                                    }
                                });
                            }
                        });
                    }
                });

                $('#suggestion-box').on('keypress', function(e){
                    if(e.which === 13) {
                        e.preventDefault();
                        if($(this).val()) {
                            selectEmployee($(this).find('option:selected'));
                        }
                    }
                }); 

                $('#suggestion-box').on('click', function(e){
                    if($(this).val()) {
                        selectEmployee($(this).find('option:selected'));
                    }
                }); 
            });

            function selectEmployee(obj) {
                var personName = $(obj).text();
                $('#findAnIndividual').val('').prop('disabled', true);
                $('#suggestion-box').hide();

                $('.found-list').append('<p><input type="hidden" id="empid" name="empid" value="'+$(obj).val()+'">' + personName + '<button type="button">x</button></p>');
                $('#findIndividuals').addClass('enabled');

                $('.found-list button').on('click', function() {
                    $(this).parent('p').remove();
                    $('#findAnIndividual').removeAttr('disabled');
                    $('#findIndividuals').removeClass('enabled');
                });
            } 

            $('#findIndividuals').on('click', function(event) {
                var allowKey = 0;    
                $('.initiative-category input').each(function(i) {
                    if(($(this).prop('checked')) === true) {
                        allowKey = 1;
                    }
                });                    
                $('.initiative-name input, #startDate, #endDate').each(function() {
                    if($(this).val() === '') {
                      allowKey = 0;
                    }
                });
                if($('.initiative-choice-select select').is(':disabled')) {
                    if(!$('.found-list p').length) {
                        allowKey = 0;
                    }
                } else {
                    $('.initiative-choice-select select').each(function() {
                        if($(this).val() === null) {
                            allowKey = 0;
                        }
                    });
                }

                if(allowKey) {
                    event.preventDefault();
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
                    postStr +="&empid="+ $('#empid').val();
                    postStr +="&oEmpids="+arrEmpId.join(",");
                    
                    $('.scrollbar, .create-initiative button').css('visibility', 'visible');
                    $('.overlay_form').show();

                    var metResponse = false;
                    var indiResponse = false;
                    $.ajax({
                        url: '<%=Constant.WEB_CONTEXT%>/initiative/getMetrics.jsp',
                        type: 'POST',
                        data: postStr,
                        dataType: 'html',
                        success: function(resp) {
                            metResponse = true;
                            $('#metrics-list').html(resp);
                            $('.create-metrics-list').slideDown('400', function() {
                                $('#collapse-metrics').text('Collapse').prop('disabled', false);
                                var i = $('#initiativeType option:selected').index();
                                $('.create-metrics-list').find('li').eq(i).addClass('highlighted').siblings().removeClass('highlighted'); 
                            });
                            if(metResponse && indiResponse) {
                                $('.overlay_form').hide();
                            }
                        }
                    }); 
                    
                    $.ajax({
                        url: '<%=Constant.WEB_CONTEXT%>/initiative/AjaxGetIndividual.jsp',
                        type: 'POST',
                        data: postStr,
                        dataType: 'html',
                        success: function(resp) {
                            indiResponse = true;
                            $('.individual-grid').html(resp);
                            $('.key-individuals').css('display','block');
                            $('#cancelInitiative').prop("disabled", false);
                            $('#create-initiative').prop("disabled", false);
                            if(metResponse && indiResponse) {
                                $('.overlay_form').hide();
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
                if($('#metrics-list').children().length) {
                    if($(this).val() !== '') {
                        fetchOrgnizationSearch($(this).val());
                    } else {
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
                        postStr +="&empid="+ $('#empid').val();
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
                }
            });

            $('#create-initiative').on('click', function() {
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
                postStr +="&empid="+ $('#empid').val();
                for(var i=0; i<arrEmpId.length; i++) {
                    postStr +="&keyList="+arrEmpId[i];
                }
                
                $('.overlay_form').show();
                $.ajax({
                    url: '<%=Constant.WEB_CONTEXT%>/initiative/createinitiative.jsp',
                    type: 'POST',
                    data: postStr,
                    error: function() {
                        $('#info').html('<p>An error has occurred</p>');
                    },
                    dataType: 'json',
                    success: function(resp) {
                        $('.overlay_form').hide();
                        if(resp.status==0) {
                            window.location.href = '<%=Constant.WEB_CONTEXT%>/initiative/list.jsp';
                        } else {
                            showError(resp.error);
                        }
                    }
                });  
            });

            $('#cancelInitiative').on('click', function() {
               window.location.href = '<%=Constant.WEB_CONTEXT%>/initiative/list.jsp';
            });
        </script>
            
        <!-- Webshim script to enable HTML5 form validation in Safari --> 
        <script>
            (function() {
              var loadScript = function(src, loadCallback) {
                var s = document.createElement('script');
                s.type = 'text/javascript';
                s.src = src;
                s.onload = loadCallback;
                document.body.appendChild(s);
              };
              var isSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;

              if (isSafari) {
                loadScript('<%=Constant.WEB_ASSETS%>js/js-webshim/minified/polyfiller.js', function () {
                    webshims.setOptions('forms', {
                      overrideMessages: true,
                      replaceValidationUI: false
                    });
                    webshims.setOptions({
                      waitReady: true
                    });
                    webshims.polyfill();
                });
              }
            })();
        </script>
            
        <script src="<%=Constant.WEB_ASSETS%>js/easypiechart.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/isotope.pkgd.min.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/initiative.js"></script>
    </body>
</html>