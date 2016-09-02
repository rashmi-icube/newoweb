/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.owen.web;

/**
 *
 * @author fermion10
 */
public interface Constant {

    public static final int INITIATIVES_TEAM = 1;
    public static final String WEB_CONTEXT = "";
    public static final String WEB_ASSETS = WEB_CONTEXT + "/assets/";
    public static final String INITIATIVES_GEOGRAPHY_FILTER_NAME = "Zone";
    public static final String INITIATIVES_FUNCTION_FILTER_NAME = "Function";
    public static final String INITIATIVES_LEVEL_FILTER_NAME = "Position";

    public static final String INITIATIVES_CATEGORY_TEAM = "Team";
    public static final String INITIATIVES_CATEGORY_INDIVIDUAL = "Individual";

    public static final int QUESTION_WEEKLY_ID = 1;
    public static final int QUESTION_BY_WEEKLY_ID = 2;
    public static final int QUESTION_MONTHLY_ID = 3;

    public static final int INFO = 2;
    public static final int DEBUG = 1;
    public static final int FATAL = 0;
    public static final int LOG_LEVEL = 1;

    public static final String IND_EXPERTISE = "Expertise";
    public static final String IND_MENTORSHIP = "Mentorship";
    public static final String IND_RETENTION = "Retention";
    public static final String IND_INFLUENCE = "Influence";
    public static final String IND_SENTIMENT = "Sentiment";

    public static final String TEAM_PERFORMANCE = "Performance";
    public static final String TEAM_SOCIAL_COHESION = "Social Cohesion";
    public static final String TEAM_RETENTION = "Retention";
    public static final String TEAM_INNOVATION = "Innovation";
    public static final String TEAM_SENTIMENT = "Sentiment";

    public static final int DEFAULT_COMPARE_TYPE_1 = 8;
    public static final int DEFAULT_COMPARE_TYPE_2 = 10;
    public static final String[] LINE_COLOR = {"#f60", "#fcd202", "#b0de09", "#0d8ecf", "#2a0cd0"};
    public static final String[] TEAM_IMAGE = {"network-cluster-t1.png", "network-cluster-t2.png", "network-cluster-t3.png",
        "network-cluster-t4.png", "network-cluster-t5.png"};
    public static final String[] BULLET_SHAPE = {"round", "square", "triangleUp", "triangleDown", "bubble"};
    public static final String[][][] INIT_TYPE_IMAGE_MAPPING = {{{"Expertise", "Mentorship", "Retention", "Influence", "Sentiment"},
    {"panel_expertise_pic.png", "panel_mentorship_pic.png", "panel_retention2_pic.png", "panel_influence_pic.png", "panel_sentiment2_pic.png"}},
    {{"Performance", "Social Cohesion", "Retention", "Innovation", "Sentiment"},
    {"panel_performance_pic.png", "panel_cohesion_pic.png", "panel_retention_pic.png", "panel_innovation_pic.png", "panel_sentiment_pic.png"}}};
    public static final String[][] QUESTION_TYPE_LABEL_MAPPING = {{"learning", "social", "mentor", "innovation", "others"},
    {"Learning", "Social Cohesion", "Mentorship", "Innovation", "Others"}};
    public static final String[][] QUESTION_TYPE_IMAGE_MAPPING = {{"learning", "social", "mentor", "innovation", "others"},
    {"panel_performance_pic.png", "panel_cohesion_pic.png", "panel_mentorship_pic.png", "panel_innovation_pic.png", "panel_others_pic.png"}};
    public static final String[][] QUESTION_TYPE_TEXT_MAPPING = {{"learning", "social", "mentor", "innovation", "others"},
    {"Questions on day-to-day work and related learning", "Questions related to the informal , interest based activities in the organization",
        "Questions related to coaching and mentoring, company policies and operating practices", "Questions related to new ways of doing things",
        "Other questions"}};

}
