<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.Util"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.icube.owen.dashboard.ActivityFeed"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.NavigableMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="org.icube.owen.dashboard.IndividualDashboardHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@include file="../common.jsp" %>
<%

int pageNo = Util.getIntValue(request.getParameter("p"));
if(pageNo == 0) {
    pageNo = 1;
}
IndividualDashboardHelper iDashboard =  (IndividualDashboardHelper) ObjectFactory.getInstance("org.icube.owen.dashboard.IndividualDashboardHelper");
NavigableMap<Date,List<ActivityFeed>> mapActivity = null;
try {
    mapActivity = (new TreeMap<Date,List<ActivityFeed>>(iDashboard.getActivityFeedList(comid, empid, pageNo))).descendingMap();
}catch(Exception e) {
    e.printStackTrace();
    mapActivity = new TreeMap<Date, List<ActivityFeed>>();
}
Date todayDate = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
String currentDate = sdf.format(todayDate);
for (Map.Entry<Date,List<ActivityFeed>> entry : mapActivity.entrySet()) {
    String actDate = sdf.format(entry.getKey());
    String dispDate = Util.getDisplayDateFormat(entry.getKey(), "MMM dd");
%>
<div class="activity-group">
    <div class="activity-date"><%=currentDate.equals(actDate)? "TODAY" : dispDate%> </div>
    <% 
        List<ActivityFeed> listActivty = entry.getValue();
        for(int aCnt=0; aCnt<listActivty.size(); aCnt++) {
            ActivityFeed aFeed = listActivty.get(aCnt);
          %>
          <div class="activity-item">
            <div class="activity-img">
                <% if (aFeed.getActivityType().equals("Appreciation")) { %>
                <img src="<%=Constant.WEB_ASSETS%>images/panel_appreciate_hover.png" alt="<%=aFeed.getActivityType()%>" width="35" height="35">
                <% } else { %>
                    <span>I</span>
                <% } %>
            </div>
            <div>
                <span class="activity-title"><%=aFeed.getHeaderText() %></span>
                <p class="activity-details">
                    <%=aFeed.getBodyText() %>
                </p>
            </div>
        </div>
          <% } %>
</div>
<% 
}
%>