<%-- 
    Document   : getindividual
    Created on : Jan 14, 2016, 3:58:04 PM
    Author     : fermion10
--%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.MessageConstant"%>
<%@page import="org.icube.owen.employee.EmployeeList"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.json.JSONObject"%>
<%@page trimDirectiveWhitespaces="true" %>
<%@include file="../common.jsp" %>
<%
        String type = request.getParameter("teamtype");
        int intType = 0;
        try {
            intType = Integer.parseInt(type);
        } catch (Exception ex) {
        }
        List<Filter> fList = null;
        String iid = request.getParameter("iid");
        
        String category = "Individual";
        if (intType == Constant.INITIATIVES_TEAM) {
            category = "Team";
            String[] teamGeography = request.getParameterValues("teamGeography");
            String[] teamFunction = request.getParameterValues("teamFunction");
            String[] teamLevel = request.getParameterValues("teamLevel");

            String[] teamGeographyText = request.getParameterValues("teamGeographyText");
            String[] teamFunctionText = request.getParameterValues("teamFunctionText");
            String[] teamLevelText = request.getParameterValues("teamLevelText");

            Filter geographyFilter = new Filter();
            geographyFilter.setFilterName(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
            Map<Integer, String> gMap = new HashMap<Integer, String>();
            for (int i = 0; i < teamGeography.length; i++) {
                gMap.put(Util.getIntValue(teamGeography[i]), teamGeographyText[i]);

            }
            Util.debugLog("gMap" + gMap);
            geographyFilter.setFilterValues(gMap);

            Filter functionFilter = new Filter();
            functionFilter.setFilterName(Constant.INITIATIVES_FUNCTION_FILTER_NAME);
            Map<Integer, String> fMap = new HashMap<Integer, String>();
            for (int i = 0; i < teamFunction.length; i++) {
                fMap.put(Util.getIntValue(teamFunction[i]), teamFunctionText[i]);

            }
            Util.debugLog("fMap" + fMap);
            functionFilter.setFilterValues(fMap);

            Filter levelFilter = new Filter();
            levelFilter.setFilterName(Constant.INITIATIVES_LEVEL_FILTER_NAME);
            Map<Integer, String> lMap = new HashMap<Integer, String>();
            for (int i = 0; i < teamLevel.length; i++) {
                lMap.put(Util.getIntValue(teamLevel[i]), teamLevelText[i]);

            }
            Util.debugLog("lMap" + lMap);
            levelFilter.setFilterValues(lMap);

            fList = new ArrayList();
            fList.add(geographyFilter);
            fList.add(functionFilter);
            fList.add(levelFilter);
        }
            //Initiative initiative = ObjectFactory.getInstance("org.icube.owen.initiative.Initiative.class");
        JSONObject json = new JSONObject();
        JSONObject errorArray = new JSONObject();
        boolean validate = true;
        String initiativeType = request.getParameter("initiativeType");
        String initiativeName = request.getParameter("initiativeName");
        String startDate = request.getParameter("startDate");
        String endDate   = request.getParameter("endDate");
        String initiativeComment = request.getParameter("initiativeComment");
        String[] keyIndividualList = request.getParameterValues("keyList");
        List<Employee> empList = new ArrayList();
        if(keyIndividualList != null ) {
            for(int empCnt=0; empCnt < keyIndividualList.length; empCnt++) {
                Employee emp = new Employee();
                emp.setEmployeeId(Util.getIntValue(keyIndividualList[empCnt]));
                System.out.println("emp   "+emp.getEmployeeId());
                empList.add(emp);
            }
        }
        if(validate) {
            Initiative initiative = new Initiative();
            Initiative uinitiative = initiative.get(comid,Util.getIntValue(iid));
            
            System.out.println("Name-------- "+uinitiative.getInitiativeName());
            System.out.println("Id-------- "+uinitiative.getInitiativeId());
            //uinitiative.setInitiativeCategory(category);
            //uinitiative.setFilterList(fList);
            if(initiativeComment != null && !initiativeComment.equals("")) {
                initiativeComment = uinitiative.getInitiativeComment()+"<p>Me: "+initiativeComment+"</p>";
            } else {
                 initiativeComment = uinitiative.getInitiativeComment();
            }
            uinitiative.setInitiativeComment(initiativeComment);
            if(endDate != null) {
                uinitiative.setInitiativeEndDate(Util.getStringToDate(endDate,"dd/MM/yyyy"));
            }
            //uinitiative.setInitiativeName(initiativeName);
            if(startDate != null) {
                uinitiative.setInitiativeStartDate(Util.getStringToDate(startDate,"dd/MM/yyyy"));
            }
            
            //uinitiative.setInitiativeType(initiativeType);
            uinitiative.setOwnerOfList(empList);
            boolean status =  initiative.updateInitiative(comid,uinitiative);
            if(status) {
                json.put("status", 0);
                json.put("msg", MessageConstant.INITIATIVE_UPDATE_SUCCESS_MESSAGE);
            }
        } else {
           json.put("status", 1);
           json.put("error",errorArray);
        }
        response.setCharacterEncoding("utf-8");
	out.print(json.toString());
%> 