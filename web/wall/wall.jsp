<%-- 
    Document   : The Wall
    Created on : March 22, 2016, 6:38:29 PM
    Author     : fermion10
--%>

<%@page import="org.icube.owen.dashboard.TheWallHelper"%>
<%@page import="org.icube.owen.filter.FilterList"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.icube.owen.initiative.InitiativeHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.Util"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%
    String moduleName = "wall";
    String subModuleName = "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>OWEN - The Wall</title>
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
    <div id="overlay_div">
        <div class="overlay_form"><img src="<%=Constant.WEB_ASSETS%>images/ajax-loader.gif"></div>
    </div>
    
	<div class="container">
		<%@include file="../header.jsp" %>
		<div class="main">
			<div class="wrapper wall">
                <input type="hidden" id="page_no" value="1"/>
				<div class="my-initatives">
					<div class="my-initatives-header clearfix">
						<h2>My Initiatives</h2>
						<div class="filter-metric">
							<span>Individual</span>
							<div class="filter-tool">
								<img src="<%=Constant.WEB_ASSETS%>images/filter_disc.png" alt="Toggle tool">
							</div>
							<span class="clicked">Team</span>
						</div>						
					</div>
                    <%
                        Initiative initiative =  (Initiative) ObjectFactory.getInstance("org.icube.owen.initiative.Initiative");
                        Map <Integer,String> indivdualType =  initiative.getInitiativeTypeMap(comid,"individual");
                        Map <Integer,String> teamType =  initiative.getInitiativeTypeMap(comid,"team");
                        JSONObject indTypeJSON = new JSONObject(indivdualType);
                        JSONObject teamTypeJSON = new JSONObject(teamType);
                        InitiativeHelper iHelper = new    InitiativeHelper();
                        java.util.List<java.util.Map<java.lang.String,java.lang.Object>> iList =  iHelper.getInitiativeCount(comid);
                        HashMap<Integer,HashMap<String, Integer>> hasmap = Util.getTypeList(iList, "Team");
                        int defaultMetricsId = 0;
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
                               <button data-id="<%=entry.getKey() %>" class="panel-select-metric <%= defaultMetricsId ==0 ?"selected":"" %>" title="Select <%=teamType.get(entry.getKey())%>">&#x2714;</button>
                           </div>
                       </li>
                        <% if(defaultMetricsId == 0 ) {
                                defaultMetricsId = entry.getKey();
                            }
                        } %>    
					</ul>
                    <%  hasmap = Util.getTypeList(iList, "Individual"); %>
					<ul>
						<% int indMetricsId = 0;
                            for (Map.Entry<Integer,HashMap<String, Integer>> entry : hasmap.entrySet()) { 
                                HashMap<String, Integer> hmap = entry.getValue(); %>
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
                                       <button data-id="<%=entry.getKey() %>" class="panel-select-metric <%= indMetricsId ==0 ?"selected":"" %>" title="Select <%=indivdualType.get(entry.getKey())%>">&#x2714;</button>		
                                   </div>
                               </li>
                         <% if(indMetricsId == 0 ) { indMetricsId = entry.getKey(); } } %>  					
					</ul>
				</div>

				<div class="wall-view-box">
					<div class="wall-view-header clearfix">
						<div class="get-filter-list">
							<button id="getFilteredList" type="button">Filter &#x25BE;</button>	
							<div class="filter-menu" >
								<ul>
									<li>
										<span>Geography <span>&#x203A;</span></span>
										<ul><%
                                            FilterList fl = new FilterList();
                                            Filter geoFilter = fl.getFilterValues(comid,Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                                            Map <Integer,String>  geoitem = geoFilter.getFilterValues();
                                            for (Map.Entry<Integer, String> entry : geoitem.entrySet()) { %>
                                                <li><span>&#x2714;</span> <span class="filter-choice-name" filter_type="Geography" data_id="<%=entry.getKey()%>" filter_type_id="<%=geoFilter.getFilterId() %>"><%=entry.getValue()%></span></li>
                                            <% } %>
										</ul>
									</li>
									<li>
										<span>Function <span>&#x203A;</span></span>
										<ul>
                                            <%
                                            Filter funFilter = fl.getFilterValues(comid,Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                                            Map <Integer,String>  funitem = funFilter.getFilterValues();
                                            for (Map.Entry<Integer, String> entry : funitem.entrySet()) { %>
                                                <li><span>&#x2714;</span> <span class="filter-choice-name" filter_type="Function" data_id="<%=entry.getKey()%>"   filter_type_id="<%=funFilter.getFilterId() %>"><%=entry.getValue()%></span></li>   
                                            <% } %>
										</ul>
									</li>
									<li>
										<span>Level <span>&#x203A;</span></span>
										<ul>
                                            <%
                                            Filter levelFilter = fl.getFilterValues(comid,Constant.INITIATIVES_LEVEL_FILTER_NAME);
                                            Map <Integer,String>  levelitem =  levelFilter.getFilterValues();
                                            for (Map.Entry<Integer, String> entry : levelitem.entrySet()) { %>
                                                <li><span>&#x2714;</span> <span class="filter-choice-name" filter_type="Level" data_id="<%=entry.getKey()%>"   filter_type_id="<%=levelFilter.getFilterId() %>"><%=entry.getValue()%></span></li>   
                                            <% } %>
										</ul>
									</li>
								</ul>
                            </div>
						</div>

						<button id="clearFilteredList" type="button">Reset</button>

						<div class="three-filters-group">
							<span id="filterGeo"></span>
							<span id="filterFun"></span>
							<span id="filterLevel"></span>
						</div>

						<div class="wall-view-header-right">
							<div class="view-data-position">
								<span>View</span>	
								<button id="viewFromTop" type="button" class="selected">Top</button>	
								<button id="viewFromBottom" type="button">Bottom</button>	
							</div>	

							<div class="wall-filter-percent">
								<span>10%</span>	
								<form>
									<input type="text" maxlength="3" name="filterPercent" pattern="^[1-9][0-9]?$|^100$" oninvalid="setCustomValidity('Number should be between 1 and 100')" oninput="setCustomValidity('')" />
								</form>							
							</div>

							<div class="view-grid-list">
								<button id="viewByGrid" class="selected">Grid</button>	
								<button id="viewByList">List</button>	
							</div>
						</div>						
					</div>

					<div class="wall-view-body">
                        <div class="wall-overlay"></div>
                        <div id="wall-overlay_div">
                            <div class="wall-overlay_form"><img src="<%=Constant.WEB_ASSETS%>images/ajax-loader.gif"></div>
                        </div>
                        <div class="wall-view-grid">
							<div class="wall-view-people" >
                                <% TheWallHelper wallHelper = (TheWallHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.TheWallHelper");
                                    List<Map<String,Object>> teamList =  wallHelper.getTeamWallFeed(comid,defaultMetricsId, "top", 10, 1, 12, null);
                                    for(int i=0; i<teamList.size(); i++  ) {
                                        Map<String, Object> detailsTeam = teamList.get(i);
                                %>
                                <div class="wall-view-cell">
									<button class="get-person-info">
										<span>i</span>
									</button>
									<div class="wall-team-card">
										<div class="front-card">
											<div class="person-info">
												<div>
                                                    <% 
                                                        List<Filter> fList =  (List)detailsTeam.get("filterList");
                                                        
                                                        String strGeoFilter = "";
                                                        String strFunFilter = "";
                                                        String strLevelFilter = "";
                                                        String strGeoFilter1 = "";
                                                        String strFunFilter1 = "";
                                                        String strLevelFilter1 = "";
                                                        for(int j=0; j<fList.size(); j++) {
                                                            Filter f = fList.get(j);
                                                            Map<Integer,String> filVal =  f.getFilterValues();
                                                            for (Map.Entry<Integer, String> entry : filVal.entrySet()) { 
                                                                if(f.getFilterName().equals(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME)) {
                                                                    strGeoFilter += entry.getKey()+"#"+entry.getValue() ;
                                                                    strGeoFilter1 = entry.getValue();
                                                                } else if(f.getFilterName().equals(Constant.INITIATIVES_FUNCTION_FILTER_NAME )) {
                                                                    strFunFilter += entry.getKey()+"#"+entry.getValue() ;
                                                                    strFunFilter1 = entry.getValue();
                                                                } else if(f.getFilterName().equals(Constant.INITIATIVES_LEVEL_FILTER_NAME )) {
                                                                    strLevelFilter += entry.getKey()+"#"+entry.getValue() ;
                                                                    strLevelFilter1 = entry.getValue();
                                                                }
                                                            } 
                                                        }  
                                                        String strFilter = strGeoFilter+"|"+strFunFilter+"|"+strLevelFilter; 
                                                         %>
                                                        <span class="wall-list-geo"><%=strGeoFilter1 %></span>
                                                        <span class="wall-list-function"><%=strFunFilter1 %></span>
                                                        <span class="wall-list-level"><%=strLevelFilter1 %></span>
												</div>	
											</div>	
                                            <span class="person-score"><%=detailsTeam.get("metricScore")%></span>
                                            
										</div>
										<div class="back-card">
                                            <img src="<%=Constant.WEB_ASSETS%>images/silhouette_individual.png" alt="Company logo">
                                            <span class="person-score"><%=detailsTeam.get("metricScore")%></span>	
										</div>
									</div>									
									<a href="javascript:void(0)" onClick="goToCreate(1,<%=defaultMetricsId%>,'<%=strFilter%>','')" title="Create an initiative">
										<span>+</span>
									</a>
								</div>
                                <% } %>
							</div>
							<div class="scroll-up-down">
								<button id="scrollUp"></button>
								<button id="scrollDown"></button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
    <script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
    <script src="<%=Constant.WEB_ASSETS%>js/jquery-ui.js"></script>
    
    <script src="<%=Constant.WEB_ASSETS%>js/jquery.slimscroll.min.js"></script>
    
    <script src="<%=Constant.WEB_ASSETS%>js/wall.js"></script>
    <script>
        function goToCreate(catid,matid,team,empid) {
            var form = document.createElement("form");
            form.setAttribute("method", "post");
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", 'c');
            hiddenField.setAttribute("value", catid);
            form.appendChild(hiddenField);
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", 't');
            hiddenField.setAttribute("value", matid);
            form.appendChild(hiddenField);
            if(team !== '') {
                var hiddenField = document.createElement("input");
                hiddenField.setAttribute("type", "hidden");
                hiddenField.setAttribute("name", 'team');
                hiddenField.setAttribute("value", team);
                form.appendChild(hiddenField);
            }
            if(empid !== '') {
                var hiddenField = document.createElement("input");
                hiddenField.setAttribute("type", "hidden");
                hiddenField.setAttribute("name", 'emp_id');
                hiddenField.setAttribute("value", empid);
                form.appendChild(hiddenField);
            }
            
            form.setAttribute("action", '<%=Constant.WEB_CONTEXT%>/initiative/create.jsp');
            document.body.appendChild(form);
            form.submit();
        }
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
</body>
</html>