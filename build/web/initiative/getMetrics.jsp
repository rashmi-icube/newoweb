<%-- 
    Document   : getMetrics
    Created on : Feb 12, 2016, 4:41:58 PM
    Author     : vikas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.metrics.MetricsList"%>
<%@page import="org.icube.owen.metrics.Metrics"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@include file="../common.jsp" %>
<%
    String type = request.getParameter("teamtype");
    int intType = 0;
    try {
         intType = Integer.parseInt(type);
    }catch(Exception ex) {
    }
    List<Filter> fList = new ArrayList();
    if(intType == Constant.INITIATIVES_TEAM) {
        String[] teamGeography = request.getParameterValues("teamGeography");
        String[] teamFunction = request.getParameterValues("teamFunction");
        String[] teamLevel = request.getParameterValues("teamLevel");

        String[] teamGeographyText = request.getParameterValues("teamGeographyText");
        String[] teamFunctionText = request.getParameterValues("teamFunctionText");
        String[] teamLevelText = request.getParameterValues("teamLevelText");
        int filterFunId = Util.getIntValue(request.getParameter("filterFunId"));
        int filterLevelId = Util.getIntValue(request.getParameter("filterLevelId"));
        int filterGeoId = Util.getIntValue(request.getParameter("filterGeoId"));
        Filter geographyFilter = new Filter();
        geographyFilter.setFilterName(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
        geographyFilter.setFilterId(filterGeoId);
        Map<Integer,String> gMap = new HashMap<Integer,String>();
        for(int i=0; i<teamGeography.length; i++) {
            gMap.put(Util.getIntValue(teamGeography[i]), teamGeographyText[i]);

        }
        Util.debugLog("gMap" + gMap);
        geographyFilter.setFilterValues(gMap);

        Filter functionFilter = new Filter();
        functionFilter.setFilterName(Constant.INITIATIVES_FUNCTION_FILTER_NAME);
        functionFilter.setFilterId(filterFunId);
        Map<Integer,String> fMap = new HashMap<Integer,String>();
        for(int i=0; i<teamFunction.length; i++) {
            fMap.put(Util.getIntValue(teamFunction[i]), teamFunctionText[i]);

        }
        functionFilter.setFilterValues(fMap);

        Filter levelFilter = new Filter();
        levelFilter.setFilterName(Constant.INITIATIVES_LEVEL_FILTER_NAME);
        levelFilter.setFilterId(filterLevelId);
        Map<Integer,String> lMap = new HashMap<Integer,String>();
        for(int i=0; i<teamLevel.length; i++) {
            lMap.put(Util.getIntValue(teamLevel[i]), teamLevelText[i]);

        }
        Util.debugLog("lMap" + lMap);
        levelFilter.setFilterValues(lMap);
        fList.add(geographyFilter);
        fList.add(functionFilter);
        fList.add(levelFilter);
    }
    String initiativeType = request.getParameter("initiativeType");
    List<Metrics> metList = new ArrayList();
    MetricsList mListObj =  (MetricsList) ObjectFactory.getInstance("org.icube.owen.metrics.MetricsList");
    if(intType == Constant.INITIATIVES_TEAM) {
        metList = mListObj.getInitiativeMetricsForTeam(comid,Util.getIntValue(initiativeType),fList);
    } else {
        Employee emp = (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee"); 
        List<Employee> list = new ArrayList();
        int employeeId = Util.getIntValue(request.getParameter("empid"));
        list.add(emp.get(comid,employeeId));
        metList = mListObj.getInitiativeMetricsForIndividual(comid,Util.getIntValue(initiativeType),list);
    }
    for(int i=0; i < metList.size(); i++) { %>
    <li <%=metList.get(i).isPrimary() ? "class=\"highlighted\"" : "" %> >
        <div class="chart" id="createStat<%=(i+1)%>" data-percent=<%=metList.get(i).getScore() > -1 ? metList.get(i).getScore() : 0%> >
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
                    <span class="empty"  >
                            Team size too small.
                    </span>
                <% } %>
            </div>
        </div>
        <span class="chart-name"><%=metList.get(i).getName()%></span>    
    </li>
    <% } %>
     
    <script>
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
    </script>