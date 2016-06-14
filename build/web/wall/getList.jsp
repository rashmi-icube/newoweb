<%-- 
    Document   : getList
    Created on : Apr 5, 2016, 4:49:07 PM
    Author     : fermion10
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.owen.web.Util"%>
<%@page import="java.util.List"%>
<%@page import="org.icube.owen.dashboard.TheWallHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="java.util.Map"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@include file="../common.jsp" %>
<%
    String dir = request.getParameter("dir") != null ? request.getParameter("dir") : "top";
    int matid = request.getParameter("matid") != null ? Util.getIntValue(request.getParameter("matid")) : 0;
    String type = request.getParameter("type") != null ? request.getParameter("type"): "Team"; // 1 team, 0 Individual
    int perPage = request.getParameter("perpage") != null ? Util.getIntValue(request.getParameter("perpage")) : 12;
    int percentage = request.getParameter("percentage") != null ? Util.getIntValue(request.getParameter("percentage")) : 10;
    int pageno = request.getParameter("pageno") != null ? Util.getIntValue(request.getParameter("pageno")) : 1;
    
    int filterIdGeo = request.getParameter("Geography") != null ? Util.getIntValue(request.getParameter("Geography")) : 0;
    int filterIdFun = request.getParameter("Function") != null ? Util.getIntValue(request.getParameter("Function")) : 0;
    int filterIdLevel = request.getParameter("Level") != null ? Util.getIntValue(request.getParameter("Level")) : 0;
    
    String filterValGeo = request.getParameter("Geography_name");
    String filterValFun = request.getParameter("Function_name");
    String filterValLevel = request.getParameter("Level_name");
    
    int geoId = request.getParameter("Geography_id") != null ? Util.getIntValue(request.getParameter("Geography_id")) :0;
    int funId = request.getParameter("Function_id") != null ? Util.getIntValue(request.getParameter("Function_id")) :0;
    int levelId = request.getParameter("Level_id") != null ? Util.getIntValue(request.getParameter("Level_id")) :0;
    
    List<Filter> listFilter = null;
    
    if((filterIdGeo >= 0 && filterValGeo != null) || (filterIdFun >= 0 && filterValFun != null) || (filterIdLevel >= 0 && filterValLevel != null)) {
        listFilter = new ArrayList<Filter>();
        if(filterIdGeo != 0 && filterValGeo != null) {
            Filter filter = (Filter) ObjectFactory.getInstance("org.icube.owen.filter.Filter");
            filter.setFilterId(geoId);
            filter.setFilterName("Geography");
            //out.println(filter.getFilterName());
            Map<Integer,String> filterValuesMap = new HashMap<Integer,String>();
            filterValuesMap.put(filterIdGeo, filterValGeo);
            filter.setFilterValues(filterValuesMap);
            listFilter.add(filter);
        }
        if(filterIdFun != 0 && filterValFun != null) {
            Filter filter = (Filter) ObjectFactory.getInstance("org.icube.owen.filter.Filter");
            filter.setFilterId(funId);
            filter.setFilterName("Function");
            Map<Integer,String> filterValuesMap = new HashMap<Integer,String>();
            filterValuesMap.put(filterIdFun, filterValFun);
            filter.setFilterValues(filterValuesMap);
            listFilter.add(filter);
        }
        if(filterIdLevel != 0 && filterValLevel != null) {
            Filter filter = (Filter) ObjectFactory.getInstance("org.icube.owen.filter.Filter");
            filter.setFilterId(levelId);
            filter.setFilterName("Level");
            //out.println(filter.getFilterName());
            Map<Integer,String> filterValuesMap = new HashMap<Integer,String>();
            filterValuesMap.put(filterIdLevel, filterValLevel);
            filter.setFilterValues(filterValuesMap);
            listFilter.add(filter);
        }
    }
    TheWallHelper wallHelper = (TheWallHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.TheWallHelper");
    if(type.equals("Team")) { // Team
        List<Map<String,Object>> teamList =  wallHelper.getTeamWallFeed(comid,matid, dir, percentage, pageno, perPage, listFilter);
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
                   
            <a href="javascript:void(0)" onClick="goToCreate(1,<%=matid%>,'<%=strFilter%>','')" title="Create an initiative">
                <span>+</span>
                
            </a>
        </div>
        <% }
    } else {  // Individuals
       List<Map<String,Object>> individualList =  wallHelper.getIndividualWallFeed(comid,matid, dir, percentage, pageno, perPage, listFilter);
        for(int i=0; i<individualList.size(); i++  ) {
            Map<String, Object> detailsindividual = individualList.get(i);
        %>
        <div class="wall-view-cell">
            <button class="get-person-info">
                <span>i</span>
            </button>
            <div class="wall-person-card">
                <div class="front-card">
                    <figure class="clearfix">
                        <div class="person-pic" style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=detailsindividual.get("companyId")%>&eid=<%=detailsindividual.get("employeeId")%>');"></div>
                        <!--<img src="<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=detailsindividual.get("companyId")%>&eid=<%=detailsindividual.get("employeeId")%>" alt="Company Logo" width="75" height="75">-->
                        <figcaption><%=detailsindividual.get("firstName")+" "+(detailsindividual.get("lastName")!= null ? detailsindividual.get("lastName") :" "+detailsindividual.get("lastName")) %></figcaption>
                    </figure>
                    <span class="person-score"><%=detailsindividual.get("metricScore")%></span>
                </div>
                <div class="back-card">
                    <span><%=detailsindividual.get("firstName")+" "+(detailsindividual.get("lastName")!= null ? detailsindividual.get("lastName") :" "+detailsindividual.get("lastName")) %></span>	
                    <div class="person-info">
                        <div>
                            <span class="wall-list-geo"><%=detailsindividual.get("zone")%></span>	
                            <span class="wall-list-function"><%=detailsindividual.get("function")%></span>	
                            <span class="wall-list-level"><%=detailsindividual.get("position")%></span>	
                        </div>
                    </div>
                    <span class="person-score"><%=detailsindividual.get("metricScore")%></span>	
                </div>
            </div>
                    <% if(((Integer)detailsindividual.get("employeeId")).intValue() != empid ) {%>    
            <a href="javascript:void(0)" onClick="goToCreate(0,<%=matid%>,'',<%=detailsindividual.get("employeeId")%>)"  title="Create an initiative">
                <span>+</span>
            </a>
                <% } %>
        </div>	
    <% } 
} %>
