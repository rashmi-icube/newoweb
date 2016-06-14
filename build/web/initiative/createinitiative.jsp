<%-- 
    Document   : createinitiative
    Created on : Jan 14, 2016, 3:58:04 PM
    Author     : fermion10
--%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true" %>
<%@page import="org.icube.owen.ObjectFactory"%>
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
<%@include file="../common.jsp" %>
<%
        String type = request.getParameter("teamtype");
        int intType = 0;
        try {
            intType = Integer.parseInt(type);
        } catch (Exception ex) {
        }
        List<Filter> fList = null;
        String category = "Individual";
        JSONObject json = new JSONObject();
        JSONObject errorArray = new JSONObject();
        boolean validate = true;
        String initiativeType = request.getParameter("initiativeType");
        String initiativeName = request.getParameter("initiativeName");
        String startDate = request.getParameter("startDate");
        String endDate   = request.getParameter("endDate");
        String initiativeComment = request.getParameter("initiativeComment");
        //String[] keyIndividualList = request.getParameterValues("keyIndividual");
        String[] keyIndividualList = request.getParameterValues("keyList");
        if(validate) {
            Initiative initiative = new Initiative();
            if (intType == Constant.INITIATIVES_TEAM) {
                category = "Team";
                String[] teamGeography = request.getParameterValues("teamGeography");
                String[] teamFunction = request.getParameterValues("teamFunction");
                String[] teamLevel = request.getParameterValues("teamLevel");

                String[] teamGeographyText = request.getParameterValues("teamGeographyText");
                String[] teamFunctionText = request.getParameterValues("teamFunctionText");
                String[] teamLevelText = request.getParameterValues("teamLevelText");
                int geoId = request.getParameter("geoId") != null ? Util.getIntValue(request.getParameter("geoId")) : 0;
                int funId = request.getParameter("funId") != null ? Util.getIntValue(request.getParameter("funId")) : 0;
                int levelId = request.getParameter("levelId") != null ? Util.getIntValue(request.getParameter("levelId")) : 0;
                
                Filter geographyFilter = new Filter();
                geographyFilter.setFilterId(geoId);
                geographyFilter.setFilterName(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                Map<Integer, String> gMap = new HashMap<Integer, String>();
                for (int i = 0; i < teamGeography.length; i++) {
                    gMap.put(Util.getIntValue(teamGeography[i]), teamGeographyText[i]);

                }
                Util.debugLog("gMap" + gMap);
                geographyFilter.setFilterValues(gMap);

                Filter functionFilter = new Filter();
                functionFilter.setFilterId(funId);
                functionFilter.setFilterName(Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                Map<Integer, String> fMap = new HashMap<Integer, String>();
                for (int i = 0; i < teamFunction.length; i++) {
                    fMap.put(Util.getIntValue(teamFunction[i]), teamFunctionText[i]);

                }
                Util.debugLog("fMap" + fMap);
                functionFilter.setFilterValues(fMap);

                Filter levelFilter = new Filter();
                levelFilter.setFilterId(levelId);
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
            } else {
                Employee emp = (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee");
                List<Employee> list = new ArrayList();
                int employeeId = Util.getIntValue(request.getParameter("empid"));
                list.add(emp.get(comid,employeeId));
                initiative.setPartOfEmployeeList(list);
            }
            List<Employee> empList = new ArrayList();
            if(keyIndividualList != null) {
                for(int empCnt=0; empCnt < keyIndividualList.length; empCnt++) {
                    Employee emp = new Employee();
                    emp.setEmployeeId(Util.getIntValue(keyIndividualList[empCnt]));
                    empList.add(emp);
                }
            }
            
            initiative.setInitiativeCategory(category);
            initiative.setFilterList(fList);
             Employee e  =  (Employee) ObjectFactory.getInstance("org.icube.owen.employee.Employee");
                e = e.get(comid, empid);
            if(initiativeComment != null && !initiativeComment.equals("")) {
                initiativeComment = "<p>"+(e.getFirstName().substring(0, 1) + (e.getLastName() != null ? e.getLastName().substring(0, 1) : ""))+": "+initiativeComment+"</p>";
            } else {
                 initiativeComment = "";
            }
            initiative.setInitiativeComment(initiativeComment);
            
            java.util.Date ustartDate = Util.getStringToDate(startDate,"dd/MM/yyyy");
            java.util.Date uendDate = Util.getStringToDate(endDate,"dd/MM/yyyy");
            Util.printLog(ustartDate);
            Util.printLog(uendDate);
            
            initiative.setInitiativeEndDate(uendDate);
            initiative.setInitiativeName(initiativeName);
            initiative.setInitiativeStartDate(ustartDate);
            initiative.setInitiativeCreationDate(new java.util.Date());
            initiative.setInitiativeTypeId(Util.getIntValue(initiativeType));
            initiative.setOwnerOfList(empList);
            initiative.setCreatedByEmpId(empid);
            
            int initiativeID =  initiative.create(comid);
            if(initiativeID > 0 ) {
                json.put("status", 0);
                json.put("msg", MessageConstant.INITIATIVE_CREATE_SUCCESS_MESSAGE);
            }
        } else {
           json.put("status", 1);
           json.put("error",errorArray);
        }
        response.setCharacterEncoding("utf-8");
	out.print(json.toString());
%> 