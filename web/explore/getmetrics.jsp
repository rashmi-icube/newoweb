<%-- 
    Document   : getmetrics
    Created on : Feb 26, 2016, 1:04:23 PM
    Author     : fermion10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true" %>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.owen.web.Util"%>
<%@page import="com.owen.web.Constant"%>
<%@page import="org.icube.owen.explore.ExploreHelper"%>
<%@page import="org.icube.owen.filter.Filter"%>
<%@page import="org.icube.owen.metrics.Metrics"%>
<%@page import="org.icube.owen.initiative.Initiative"%>
<%@page import="org.icube.owen.employee.Employee"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.icube.owen.explore.Edge"%>
<%@page import="org.icube.owen.explore.Node"%>
<%@include file="../common.jsp" %>
<%
    String type = request.getParameter("type");
    String[] teams = request.getParameterValues("team");
    String gtype = request.getParameter("gtype");
    if(type != null && gtype != null) {
        ExploreHelper eHelperObj = (ExploreHelper)  ObjectFactory.getInstance("org.icube.owen.explore.ExploreHelper");
        Map<String, List<Filter>> inputData = new HashMap<String, List<Filter>>();
        Map<String, String> color = new HashMap<String, String>();
        Map<String, String> teamImage = new HashMap<String, String>();
        if(type.equals("1")) {
            if(teams != null) {
                for(int i=0; i<teams.length; i++) {
                    String team = teams[i];
                    String[] filter = team.split("\\|");
                    String[] filterName = filter[0].split("\\#");

                    List<Filter> fList = new ArrayList<Filter>();

                    Filter f = new Filter();
                    f.setFilterId(Util.getIntValue(filterName[0]));
                    f.setFilterName(Constant.INITIATIVES_GEOGRAPHY_FILTER_NAME);
                    Map<Integer,String> filterValuesMap = new HashMap<Integer,String>();
                    filterValuesMap.put(Util.getIntValue(filterName[0]), filterName[1]);
                    f.setFilterValues(filterValuesMap);
                    fList.add(f);

                    filterName = filter[1].split("#");
                    f = new Filter();
                    f.setFilterId(Util.getIntValue(filterName[0]));
                    f.setFilterName(Constant.INITIATIVES_FUNCTION_FILTER_NAME);
                    filterValuesMap = new HashMap<Integer,String>();
                    filterValuesMap.put(Util.getIntValue(filterName[0]), filterName[1]);
                    f.setFilterValues(filterValuesMap);
                    fList.add(f);

                    filterName = filter[2].split("#");
                    f = new Filter();
                    f.setFilterId(Util.getIntValue(filterName[0]));
                    f.setFilterName(Constant.INITIATIVES_LEVEL_FILTER_NAME);
                    filterValuesMap = new HashMap<Integer,String>();
                    filterValuesMap.put(Util.getIntValue(filterName[0]), filterName[1]);
                    f.setFilterValues(filterValuesMap);
                    fList.add(f);
                    inputData.put("Team "+(i+1), fList);
                    color.put("Team "+(i+1), Constant.LINE_COLOR[i]);
                    teamImage.put("Team "+(i+1), Constant.WEB_ASSETS+"images/"+Constant.TEAM_IMAGE[i]);
                }
            }
            if(gtype.equals("metrics")){
                Map<String, List<Metrics>>  output = eHelperObj.getTeamMetricsData(comid,inputData);
                JSONObject jsonOutput = new JSONObject();
                JSONArray garphArray = new JSONArray();
                //JSONArray dataArray = new JSONArray();
                int count = 1;
                for (Map.Entry<String, List<Metrics>> entry : output.entrySet()) {
                    String team = entry.getKey();
                    JSONObject graphObject = new JSONObject();
                    graphObject.put("title", team);
                    graphObject.put("name", team.replaceAll("Team ", ""));
                    graphObject.put("valueField", team);
                    garphArray.put(graphObject);
                    List<Metrics> mList =  entry.getValue();
                    JSONObject dataObject = new JSONObject();
                    int score = 0;
                    for(int j=0; j < mList.size(); j++) {
                        Metrics m = mList.get(j);
                        score = m.getScore();
                        dataObject.put(m.getName(),score);
                    }
                    if(score != -1) { 
                        graphObject.put("data",dataObject);
                    } else {
                        graphObject.put("data","NO_DATA");
                    }
                        
                    count++;
                }
                jsonOutput.put("graph", garphArray);
                out.println(jsonOutput.toString());
            }
            else if(gtype.equals("time")) {
                Map<String,Map<Integer,List<Map<java.util.Date,Integer>>>>  output = eHelperObj.getTeamTimeSeriesGraph(comid,inputData);
                JSONArray garphArray = new JSONArray();
                JSONObject jsonOutput = new JSONObject();
                Initiative initiative = new Initiative();
                Map <Integer,String> teamType =  initiative.getInitiativeTypeMap(comid,"Team");
                int count = 0;
                for (Map.Entry<String,Map<Integer,List<Map<java.util.Date,Integer>>>> entry : output.entrySet()) {
                    String team = entry.getKey();
                    int score = 0;
                    for (Map.Entry<Integer,List<Map<java.util.Date,Integer>>> entry1 : entry.getValue().entrySet()) {
                        JSONObject graphObject = new JSONObject();
                        graphObject.put("title", team);
                        graphObject.put("lineColor", Constant.LINE_COLOR[count]);
                        graphObject.put("bullet", Constant.BULLET_SHAPE[count]);
                        graphObject.put("valueField", team+" "+teamType.get(entry1.getKey()));
                        graphObject.put("type", teamType.get(entry1.getKey()));
                        JSONObject dataObject = new JSONObject();
                        for(int k=0; k< entry1.getValue().size(); k++) {
                            Map<java.util.Date,Integer> data = entry1.getValue().get(k);
                            for (Map.Entry<java.util.Date,Integer> entry2 : data.entrySet()) {
                                score = entry2.getValue();
                                dataObject.put(entry2.getKey().toString(),entry2.getValue());
                            }
                        }
                        graphObject.put("data",dataObject);
                        graphObject.put("name", team.replaceAll("Team ", ""));
                        if(score == -1) {
                            graphObject.put("data-avail", "NO_DATA");
                        } else {
                            graphObject.put("data-avail", "DATA");
                        }
                        garphArray.put(graphObject);
                    }
                    count++;
                }
                
                jsonOutput.put("graph", garphArray);
                out.println(jsonOutput.toString());
            }  else if(gtype.equals("network")) {
                Map<Integer,String> selectrelMap = new HashMap<Integer, String>();
                Map<Integer,String> relMap = new HashMap<Integer, String>();
                relMap.put(1, "innovation");
                relMap.put(2, "mentor");
                relMap.put(3, "social");
                relMap.put(4, "learning");
                String[] strRelMap = request.getParameterValues("relMap");
                for(int i=0; i<strRelMap.length; i++) {
                    selectrelMap.put(Util.getIntValue(strRelMap[i]), relMap.get(Util.getIntValue(strRelMap[i])));
                }
                Map<String,String> relColor = new HashMap<String,String>();
                relColor.put("innovation", "#ff9e01");
                relColor.put("mentor", "#f8ff01");
                relColor.put("social", "#04d215");
                relColor.put("learning", "#8a0ccf");
                // relColor.put("learning", Constant.LINE_COLOR[3]);
                Map<String, List<?>> teamNetwork = eHelperObj.getTeamNetworkDiagram(comid,inputData, selectrelMap);
                List<Node> nodeList = (List<Node>) teamNetwork.get("nodeList");
                List<Edge> edgeList =  (List<Edge>) teamNetwork.get("edgeList");
                JSONArray nodeArray = new JSONArray();
                JSONArray edgeArray = new JSONArray();
                JSONObject jsonOutput = new JSONObject();
                for(int i=0; i<nodeList.size(); i++) {
                    String initial = "", title = "";
                    if((nodeList.get(i).getFirstName() != null && !nodeList.get(i).getFirstName().isEmpty()) &&
                           (nodeList.get(i).getLastName() != null && !nodeList.get(i).getLastName().isEmpty())){
                      initial = nodeList.get(i).getFirstName().substring(0, 1) + (nodeList.get(i).getLastName() != null ? nodeList.get(i).getLastName().substring(0, 1) : "");  
                      title = nodeList.get(i).getFirstName()+(nodeList.get(i).getLastName() != null ? " "+nodeList.get(i).getLastName() : "");
                    } else {
                      title = " Geography : " + nodeList.get(i).getZone() + " | Function :  " + nodeList.get(i).getFunction() + " | Level :  " + nodeList.get(i).getPosition();
                    }
                
                    JSONObject jsonNode = new JSONObject();
                    jsonNode.put("id", nodeList.get(i).getEmployeeId());
                    jsonNode.put("label", initial);
                    jsonNode.put("title",  title);
                    jsonNode.put("color", color.get(nodeList.get(i).getTeamName()));
                    jsonNode.put("oldColor", color.get(nodeList.get(i).getTeamName()));
                    jsonNode.put("value", 1);
                    jsonNode.put("team", nodeList.get(i).getTeamName());
                    jsonNode.put("geography", nodeList.get(i).getZone());
                    jsonNode.put("function", nodeList.get(i).getFunction());
                    jsonNode.put("level", nodeList.get(i).getPosition());
                    nodeArray.put(jsonNode);
                }
                for(int i=0; i<edgeList.size(); i++) {
                    JSONObject jsonEdge = new JSONObject();
                    jsonEdge.put("from", edgeList.get(i).getFromEmployeId()+"");
                    jsonEdge.put("to", edgeList.get(i).getToEmployeeId()+"");
                    jsonEdge.put("title", edgeList.get(i).getRelationshipType());
                    jsonEdge.put("arrows", "to");
                    jsonEdge.put("color", relColor.get(edgeList.get(i).getRelationshipType()));
                    jsonEdge.put("oldColor", relColor.get(edgeList.get(i).getRelationshipType()));
                    edgeArray.put(jsonEdge);
                }
                jsonOutput.put("node", nodeArray);
                jsonOutput.put("edge", edgeArray);
                jsonOutput.put("teamcolor", color);
                jsonOutput.put("teamImage", teamImage);
                out.println(jsonOutput.toString());
            }
        } else {
           String[] emps = request.getParameterValues("emp");
           Employee emp = (Employee)ObjectFactory.getInstance("org.icube.owen.employee.Employee");
           List<Employee> empList = new ArrayList<Employee>();
           for(int i=0; i<emps.length; i++) {
               Employee emp1 = emp.get(comid,Util.getIntValue(emps[i]));
               empList.add(emp1);
           }
           if(gtype.equals("metrics")){
                Map<Employee,List<Metrics>> output = eHelperObj.getIndividualMetricsData(comid,empList);
                JSONObject jsonOutput = new JSONObject();
                JSONArray garphArray = new JSONArray();
                //JSONArray dataArray = new JSONArray();
                int count = 1;
                for (Map.Entry<Employee, List<Metrics>> entry : output.entrySet()) {
                    Employee emp1 = entry.getKey();
                    JSONObject graphObject = new JSONObject();
                    graphObject.put("title", emp1.getFirstName()+" "+emp1.getLastName());
                    graphObject.put("valueField", emp1.getFirstName()+" "+emp1.getLastName());
                    garphArray.put(graphObject);
                    List<Metrics> mList =  entry.getValue();
                    JSONObject dataObject = new JSONObject();
                    for(int j=0; j < mList.size(); j++) {
                        Metrics m = mList.get(j);
                        dataObject.put(m.getName(),m.getScore());
                    }
                    graphObject.put("data",dataObject);
                    count++;
                }
                jsonOutput.put("graph", garphArray);
                out.println(jsonOutput.toString());
           }else if(gtype.equals("time")) {
               Map<Employee,Map<Integer,List<Map<java.util.Date,Integer>>>> output =  eHelperObj.getIndividualTimeSeriesGraph(comid,empList);
               JSONArray garphArray = new JSONArray();
                JSONObject jsonOutput = new JSONObject();
                Initiative initiative = new Initiative();
                 Map <Integer,String> indivdualType =  initiative.getInitiativeTypeMap(comid,"Individual");
                int count = 0;
                
                for (Map.Entry<Employee,Map<Integer,List<Map<java.util.Date,Integer>>>> entry : output.entrySet()) {
                    int score = 0;
                    Employee emp1 = entry.getKey();
                    for (Map.Entry<Integer,List<Map<java.util.Date,Integer>>> entry1 : entry.getValue().entrySet()) {
                        JSONObject graphObject = new JSONObject();
                        graphObject.put("title", emp1.getFirstName()+" "+emp1.getLastName());
                        graphObject.put("lineColor", Constant.LINE_COLOR[count]);
                        graphObject.put("bullet", Constant.BULLET_SHAPE[count]);
                        graphObject.put("valueField", emp1.getFirstName()+" "+emp1.getLastName()+" "+indivdualType.get(entry1.getKey()));
                        graphObject.put("type", indivdualType.get(entry1.getKey()));
                        JSONObject dataObject = new JSONObject();
                        for(int k=0; k< entry1.getValue().size(); k++) {
                            Map<java.util.Date,Integer> data = entry1.getValue().get(k);
                            for (Map.Entry<java.util.Date,Integer> entry2 : data.entrySet()) {
                                score = entry2.getValue();
                                dataObject.put(entry2.getKey().toString(),entry2.getValue());
                            }
                        }
                        graphObject.put("data",dataObject);
                        if(score == -1) {
                            graphObject.put("data-avail", "NO_DATA");
                        } else {
                            graphObject.put("data-avail", "DATA");
                        }
                        garphArray.put(graphObject);
                    }
                    
                    count++;
                }
                jsonOutput.put("graph", garphArray);
                out.println(jsonOutput.toString());
           }else if(gtype.equals("network")) {
               //out.println(empList);
                Map<Integer,String> selectrelMap = new HashMap<Integer, String>();
                Map<Integer,String> relMap = new HashMap<Integer, String>();
                relMap.put(1, "innovation");
                relMap.put(2, "mentor");
                relMap.put(3, "social");
                relMap.put(4, "learning");
                String[] strRelMap = request.getParameterValues("relMap");
                for(int i=0; i<strRelMap.length; i++) {
                    selectrelMap.put(Util.getIntValue(strRelMap[i]), relMap.get(Util.getIntValue(strRelMap[i])));
                }
                Map<String,String> relColor = new HashMap<String,String>();
                relColor.put("innovation", "#ff9e01");
                relColor.put("mentor", "#f8ff01");
                relColor.put("social", "#04d215");
                relColor.put("learning", "#8a0ccf");                
               
                Map<String, List<?>> teamNetwork = eHelperObj.getIndividualNetworkDiagram(comid,empList, selectrelMap);
              
                List<Edge> edgeList =  (List<Edge>) teamNetwork.get("edgeList");
                List<Node> nodeList = (List<Node>) teamNetwork.get("nodeList");
                JSONArray edgeArray = new JSONArray();
                JSONArray nodeArray = new JSONArray();
                JSONObject jsonOutput = new JSONObject();
                for(int i=0; i<edgeList.size(); i++) {
                    JSONObject jsonEdge = new JSONObject();
                    jsonEdge.put("from",edgeList.get(i).getFromEmployeId()+"");
                    jsonEdge.put("to",edgeList.get(i).getToEmployeeId()+"");
                    jsonEdge.put("relation",edgeList.get(i).getRelationshipType());
                    jsonEdge.put("arrows", "to");
                    jsonEdge.put("title", edgeList.get(i).getRelationshipType());
                    jsonEdge.put("color", relColor.get(edgeList.get(i).getRelationshipType()));
                    jsonEdge.put("oldColor", relColor.get(edgeList.get(i).getRelationshipType()));
                    edgeArray.put(jsonEdge);
                }
                for(int i=0; i<nodeList.size(); i++) {
                    String initial = "", title = "";
                    if((nodeList.get(i).getFirstName() != null && !nodeList.get(i).getFirstName().isEmpty()) &&
                           (nodeList.get(i).getLastName() != null && !nodeList.get(i).getLastName().isEmpty())){
                      initial = nodeList.get(i).getFirstName().substring(0, 1) + (nodeList.get(i).getLastName() != null ? nodeList.get(i).getLastName().substring(0, 1) : "");  
                      title = nodeList.get(i).getFirstName()+(nodeList.get(i).getLastName() != null ? " "+nodeList.get(i).getLastName() : "");
                    } else {
                      title = " Geography : " + nodeList.get(i).getZone() + "| Function :  " + nodeList.get(i).getFunction() + "| Level :  " + nodeList.get(i).getPosition();
                      
                    } 
                    
                    JSONObject jsonNode = new JSONObject();
                    jsonNode.put("id", nodeList.get(i).getEmployeeId());
                    jsonNode.put("label", initial);
                    jsonNode.put("title", title);
                    jsonNode.put("team", nodeList.get(i).getConnectedness());
                    jsonNode.put("geography", nodeList.get(i).getZone());
                    jsonNode.put("function", nodeList.get(i).getFunction());
                    jsonNode.put("level", nodeList.get(i).getPosition());
                    jsonNode.put("oldColor", "#97c2fc");
                    nodeArray.put(jsonNode);
                }
                jsonOutput.put("edge",edgeArray);
                jsonOutput.put("node",nodeArray);

                out.println(jsonOutput.toString());
            }
        }
    }
%>