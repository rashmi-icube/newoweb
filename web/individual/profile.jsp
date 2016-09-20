<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.util.Map"%>
<%@page import="org.icube.owen.employee.LanguageDetails"%>
<%@page import="org.icube.owen.employee.EducationDetails"%>
<%@page import="org.icube.owen.employee.WorkExperience"%>
<%@page import="java.util.List"%>
<%@page import="com.owen.web.Util"%>
<%@page import="org.icube.owen.employee.BasicEmployeeDetails"%>
<%@page import="org.icube.owen.employee.EmployeeHelper"%>
<%@page import="org.icube.owen.ObjectFactory"%>
<%@page import="com.owen.web.Constant"%>
<%
    String moduleName = "profile";
    String subModuleName = "";
%>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Profile</title>
    <link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/individual_engage.css">
    <link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/jquery-ui.css">
    <link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/jquery.ui.theme.css">    
    <link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/kendo-ui/kendo.common.min.css">  
    <link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/kendo-ui/kendo.default.min.css">

    <!--<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/animate.css/3.2.0/animate.min.css">-->

    <link rel="apple-touch-icon" sizes="57x57" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/apple-icon-180x180.png">
    <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/favicon-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/android-icon-192x192.png" sizes="192x192">
    <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/favicon-96x96.png" sizes="96x96">
    <link rel="icon" type="image/png" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/favicon-16x16.png" sizes="16x16">
    <link rel="manifest" href="<%=Constant.WEB_ASSETS%>images/favicon_Individual/manifest.json">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="msapplication-TileImage" content="<%=Constant.WEB_ASSETS%>images/favicon_Individual/ms-icon-144x144.png">
    
    <!-- Chrome, Firefox OS and Opera -->
    <meta name="theme-color" content="#388E3C">
    <!-- Windows Phone -->
    <meta name="msapplication-navbutton-color" content="#388E3C">
    <!-- iOS Safari -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="apple-mobile-web-app-title" content="OWEN">
</head>

<body>
    <div class="container">
        <%@include file="header.jsp" %>
        <%
            EmployeeHelper eHelper = (EmployeeHelper) ObjectFactory.getInstance("org.icube.owen.employee.EmployeeHelper");
            BasicEmployeeDetails beDetails = eHelper.getBasicEmployeeDetails(comid, empid);

        %>
        <div class="main">
            <div class="wrapper profile-page">
                <div class="mobile-page-title">
                    <div class="settings-page">
                        <button id="goToSettings">
                            <img src="<%=Constant.WEB_ASSETS%>images/individual_settings_back_icon.png" alt="Back" width="25" height="25">
                        </button>
                        <img src="<%=Constant.WEB_ASSETS%>images/menu_icon_settings.png" alt="Settings" width="27" height="27">
                        <span>Settings</span>
                    </div>

                    <div class="password-page">
                        <button id="goToProfile">
                            <img src="<%=Constant.WEB_ASSETS%>images/individual_settings_back_icon.png" alt="Back" width="25" height="25">
                        </button>
                        <img src="<%=Constant.WEB_ASSETS%>images/menu_icon_settings.png" alt="Settings" width="27" height="27">
                        <span>Password</span>
                    </div>
                </div>

                <div class="personal-details-box clearfix">
                    <div class="personal-details-user-image">
                        <img class="profimg" src="<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=comid%>&eid=<%=empid%>" alt="User pic" width="130" height="130" />
                        <div class="profimg" style="background-image: url('<%=Constant.WEB_CONTEXT%>/getImage?cid=<%=comid%>&eid=<%=empid%>');"></div>
                        <button onclick="performClick('prof_img')">+</button>
                    </div>

                    <div class="personal-details-list">
                        <div class="personal-title-edit clearfix">
                            <h2><%=beDetails.getSalutation() + " " + beDetails.getFirstName() + " " + beDetails.getLastName()%></h2>                                
                            <div>
                                <button type="button" id="editPersonalDetails">&#x270E;</button>
                            </div>

                            <div class="image-size-warning">
                                <span>i</span>
                                <span class="warning-text"><span class="bold">Warning:</span> <span class="error-type">Image size larger than 500kb.</span></span>
                            </div>
                        </div>

                        <span class="personal-position"><%=beDetails.getDesignation()%></span>

                        <ul class="contact-info">
                            <li>
                                <img src="<%=Constant.WEB_ASSETS%>images/personal_details_location_icon.png" alt="Location" width="15" height="15"> <span class="personal-location"><%=beDetails.getLocation()%></span>
                            </li>
                            <li>
                                <span>@</span> <span class="personal-email"><%=beDetails.getEmailId()%></span>
                            </li>
                            <li>
                                <form action="#" method="post">
                                    <span>&#x2706;</span> <span class="personal-cell-no"><%=beDetails.getPhone()%></span>
                                    <input type="tel" maxlength="13" name="personal-cell-no">
                                    <div class="edit-actions">
                                        <button type="button" id="cancelEdit">Cancel</button>
                                        <button type="submit" id="saveEdit">Save</button>
                                    </div>
                                </form>
                            </li>
                            <li>
                                <img src="<%=Constant.WEB_ASSETS%>images/personal_details_birthday_icon.png" alt="Birthday" width="15" height="15"> <span><%=Util.getDisplayDateFormat(beDetails.getDob(), "MMMM d, y")%></span>
                            </li>
                        </ul>

                        <ul class="employment-info">
                            <li><%=beDetails.getFunction()%></li>
                            <li>Employee ID: <%=beDetails.getCompanyEmployeeId()%></li>
                            <li>
                                <button type="button" id="changePassword">Change Password</button>
                                <div class="block_page">
                                    <div class="modal_box">
                                        <span>Change Password</span>
                                        <form action="#" method="post">
                                            <table>
                                                <tr>
                                                    <td><label for="currentPassword">Current password</label></td>
                                                    <td><input type="password" name="current-password" id="currentPassword" required></td>
                                                </tr>
                                                <tr>
                                                    <td><label for="newPassword">New password</label></td>
                                                    <td><input type="password" name="new-password" id="newPassword" required oninput="setCustomValidity('')"></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td>
                                                        <span>Password Strength</span>
                                                        <div class="meter_wrapper">
                                                            <div class="meter"></div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><label for="confirmPassword">Confirm new password</label></td>
                                                    <td>
                                                        <input type="password" name="confirm-password" id="confirmPassword" required>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div>
                                                <button type="button" id="cancelPassword">Cancel</button>
                                                <button type="submit" id="savePassword">Save</button>
                                            </div>
                                            <div class="password-change-successful">
                                                <span>&#x2714;</span>
                                                <span class="success-text"><span class="bold">Success:</span> Password change successful</span>
                                            </div>
                                        </form>
                                        <span class="invalid-current">Current password doesn't match!</span>
                                    </div>
                                </div>
                            </li>
                        </ul>

                    </div>

                    <div class="mobile-personal-details-list">
                        <div class="personal-title-edit clearfix">
                            <h2><%=beDetails.getSalutation() + " " + beDetails.getFirstName() + " " + beDetails.getLastName()%></h2>
                        </div>
                        <span class="personal-position"><%=beDetails.getDesignation()%></span>

                        <ul class="employment-info">
                            <li><%=beDetails.getFunction()%></li>
                            <li>Employee ID: <%=beDetails.getCompanyEmployeeId()%></li>
                        </ul>

                        <div class="image-size-warning">
                            <span>i</span>
                            <span class="warning-text"><span class="bold">Warning:</span> <span class="error-type">Image size larger than 500kb.</span></span>
                        </div>
                    </div>
                </div>

                <div class="mobile-contact-info-box clearfix">
                    <form action="#" method="post">
                        <ul class="contact-info">
                            <li>
                                <img src="<%=Constant.WEB_ASSETS%>images/personal_details_location_icon.png" alt="Location" width="15" height="15"> <span class="personal-location"><%=beDetails.getLocation()%></span>
                            </li>
                            <li>
                                <span>@</span> <span class="personal-email"><%=beDetails.getEmailId()%></span>
                            </li>
                            <li>
                                <span>&#x2706;</span> <span class="personal-cell-no"><%=beDetails.getPhone()%></span>                                
                                <input type="tel" name="personal-cell-no" maxlength="13">

                                <div class="edit-actions">
                                    <button type="button" id="cancelEditMobile">x</button>
                                    <button type="button" id="saveEditMobile">&#x2714;</button>
                                </div>
                            </li>
                            <li>
                                <img src="<%=Constant.WEB_ASSETS%>images/personal_details_birthday_icon.png" alt="Birthday" width="15" height="15"> <span><%=Util.getDisplayDateFormat(beDetails.getDob(), "MMMM d, y")%></span>
                            </li>
                        </ul>
                    </form>
                    <button type="button" id="editPersonalDetails">&#x270E;</button>

                    <div class="clearfix">
                        <button type="button" id="changePasswordMobile">Change Password</button>
                        <form action="#" method="post">
                            <label for="currentPwd">Current password</label></td>
                            <input type="password" name="current-pwd" id="currentPwd" required>
                            <label for="newPwd">New password</label>
                            <input type="password" name="new-pwd" id="newPwd" required>
                            <div class="pwd-strength">
                                <span>Password Strength</span>
                                <div class="meter_wrapper">
                                    <div class="meter"></div>
                                </div>
                            </div>
                            <label for="confirmPwd">Confirm new password</label>
                            <input type="password" name="confirm-pwd" id="confirmPwd" required>

                            <span class="invalid-current">Current password doesn't match!</span>

                            <div class="clearfix">
                                <button type="button" id="cancelPwd">Cancel</button>
                                <button type="submit" id="savePwd">Save</button>
                            </div>
                            
                            <div class="password-change-successful-mobile">
                                <span>&#x2714;</span>
                                <span class="success-text"><span class="bold">Success:</span> Password change successful</span>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="experience-box">
                    <div class="header clearfix">
                        <h3>Work Experience</h3>
                        <button>+ Add position</button>
                    </div>

                    <div class="experience-list" >
                        <div id="experience-list">
                            <%
                                List<WorkExperience> expList = eHelper.getWorkExperienceDetails(comid, empid);
                                for (int i = 0; i < expList.size(); i++) {
                            %>
                            <div class="list-item clearfix">
                                <div>
                                    <span class="item-title"><%=expList.get(i).getCompanyName()%></span>
                                    <span class="item-position"><%=expList.get(i).getDesignation()%></span>
                                    <span class="item-duration"> <%=Util.getDisplayDateFormat(expList.get(i).getStartDate(), "MMM y")%> - <%=expList.get(i).getEndDate() == null ? "Present" : Util.getDisplayDateFormat(expList.get(i).getEndDate(), "MMM y")%>  <%=expList.get(i).getDuration() != null && !expList.get(i).getDuration().equals("") ? " (" + expList.get(i).getDuration() + ")" : ""%></span>
                                    <span class="item-location"><%=expList.get(i).getLocation()%></span>
                                </div>
                                <button onClick="removeWorkExp(<%=expList.get(i).getWorkExperienceDetailsId()%>)">Remove position</button>
                            </div>
                            <% } %>
                        </div>
                        <div class="to-add-item clearfix">
                            <form action="#" method="post">
                                <div>
                                    <div>
                                        <input type="text" placeholder="Organization Name" id="wOrgname" name="org-name" required>
                                    </div>
                                    <div>
                                        <input type="text" placeholder="Position" id="wPosition" name="org-position" required>
                                    </div>
                                    <div>
                                        <label for="wFromDt">From</label>
                                        <input type="text" name="org-start-date" id="wFromDt" class="org-start-date" required>
                                        <label for="wToDt">To</label>
                                        <input type="text" name="org-end-date" id="wToDt" class="org-end-date" required>
                                        <div class="current-job clearfix">
                                            <div>
                                                <input type="checkbox" name="currentJob" id="currentJob">
                                                <label for="currentJob">I currently work here</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <input type="text" placeholder="Location" id="wLocation" name="org-location" required>
                                    </div>
                                </div>

                                <div class="add-actions">
                                    <button type="button" class="cancelAdd">Cancel</button>
                                    <button type="submit" id="wSaveAdd" class="saveAdd">Save</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="education-box">
                    <div class="header clearfix">
                        <h3>Education</h3>
                        <button>+ Add education</button>
                    </div>

                    <div class="education-list" >
                        <div id="education-list">
                            <%
                                List<EducationDetails> eduList = eHelper.getEducationDetails(comid, empid);
                                for (int i = 0; i < eduList.size(); i++) {
                            %>
                            <div class="list-item clearfix">
                                <div>
                                    <span class="item-title"><%=eduList.get(i).getInstitution()%></span>
                                    <span class="item-position"><%=eduList.get(i).getCertification()%></span>
                                    <span class="item-duration"><%=Util.getDisplayDateFormat(eduList.get(i).getStartDate(), "MMM y")%> - <%=eduList.get(i).getEndDate() == null ? "Present" : Util.getDisplayDateFormat(eduList.get(i).getEndDate(), "MMM y")%></span>
                                    <span class="item-location"><%=eduList.get(i).getLocation()%></span>
                                </div>
                                <button onClick="removeEducation(<%=eduList.get(i).getEducationDetailsId()%>)">Remove education</button>
                            </div>
                            <% } %>
                        </div>

                        <div class="to-add-item clearfix">
                            <form action="#" method="post">
                                <div>
                                    <div>
                                        <input type="text" placeholder="Institution Name" id="eOrgname" name="org-name" required>
                                    </div>
                                    <div>
                                        <input type="text" placeholder="Educational Qualification" id="eQual" name="org-position" required>
                                    </div>
                                    <div>
                                        <label for="eFromDt">From</label>
                                        <input type="text" name="org-start-date" id="eFromDt" class="org-start-date" required>
                                        <label for="eToDt">To</label>
                                        <input type="text" name="org-end-date" id="eToDt" class="org-end-date" required>
                                    </div>
                                    <div>
                                        <input type="text" placeholder="Location" id="eLoc" name="org-location" required>
                                    </div>
                                </div>

                                <div class="add-actions">
                                    <button type="button" class="cancelAdd">Cancel</button>
                                    <button type="submit" id="eSaveAdd" class="saveAdd">Save</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="language-box">
                    <div class="header clearfix">
                        <h3>Language</h3>
                        <button>+ Add language</button>
                    </div>
                    <div class="language-list" >
                        <div id="language-list">
                            <%
                                List<LanguageDetails> langList = eHelper.getEmployeeLanguageDetails(comid, empid);
                                for (int i = 0; i < langList.size(); i++) {
                            %>				                        
                            <div class="list-item clearfix">
                                <div>
                                    <span class="item-title"><%=langList.get(i).getLanguageName()%></span>
                                </div>
                                <button onClick="removeLanguage(<%=langList.get(i).getLanguageDetailsId()%>)">Remove language</button>
                            </div>
                            <% } %>
                        </div>

                        <div class="to-add-item clearfix">
                            <form action="#" method="post">
                                <div>
                                    <select id="addOneLanguage" required>
                                        <option value="">Choose one...</option>                                        
                                        <%
                                            Map<Integer, String> mlangList = eHelper.getLanguageMasterMap(comid);
                                            for (Map.Entry<Integer, String> entry : mlangList.entrySet()) {
                                                boolean found = false;
                                                for (int i = 0; i < langList.size(); i++) {
                                                    if (langList.get(i).getLanguageId() == entry.getKey()) {
                                                        found = true;
                                                        break;
                                                    }
                                                }
                                                if (!found) {
                                        %>
                                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                        <% }
                                            }%>  
                                    </select>
                                </div>
                                <div class="add-actions">
                                    <button type="button" class="cancelAdd">Cancel</button>
                                    <button type="submit" class="saveAdd">Save</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <form id="profileImgForm">
            <input type="file" id="prof_img" name="prof_img" style="display:none;">
        </form>
        <div id="iframe" style="display:none;"></div>
    </div>
                                    <script>
                                        
                                        function openPopup()
                                        {
                            document.getElementById("popup_main").style.display = "block";
                                        }
                                        window.onload = openPopup;
                                    </script>
</body>

<script src="<%=Constant.WEB_ASSETS%>js/jquery-ui.js"></script>    
<script>
                                    $('#wFromDt').datepicker({
                                        dateFormat: 'dd/mm/yy',
                                        minDate: new Date('01/01/1900'),
                                        maxDate: 0,
                                        onClose: function (selectedDate) {
                                            $(this).datepicker('setDate', $(this).datepicker('getDate'));
                                            if (selectedDate) {
                                                $(this).next('span').remove();
                                                $('#wToDt').datepicker('option', 'minDate', $(this).datepicker('getDate'));
                                            }
                                        }
                                    });
                                    $('#wToDt').datepicker({
                                        dateFormat: 'dd/mm/yy',
                                        minDate: new Date('01/01/1900'),
                                        maxDate: 0,
                                        onClose: function (selectedDate) {
                                            $(this).datepicker('setDate', $(this).datepicker('getDate'));
                                            if (selectedDate) {
                                                $(this).next('span').remove();
                                                $('#wFromDt').datepicker('option', 'maxDate', $(this).datepicker('getDate'));
                                            }
                                        }
                                    });
                                    $('#eFromDt').datepicker({
                                        dateFormat: 'dd/mm/yy',
                                        minDate: new Date('01/01/1900'),
                                        maxDate: 0,
                                        onClose: function (selectedDate) {
                                            $(this).datepicker('setDate', $(this).datepicker('getDate'));
                                            if (selectedDate) {
                                                $(this).next('span').remove();
                                                $('#eToDt').datepicker('option', 'minDate', $(this).datepicker('getDate'));
                                            }
                                        }
                                    });
                                    $('#eToDt').datepicker({
                                        dateFormat: 'dd/mm/yy',
                                        minDate: new Date('01/01/1900'),
                                        maxDate: 0,
                                        onClose: function (selectedDate) {
                                            $(this).datepicker('setDate', $(this).datepicker('getDate'));
                                            if (selectedDate) {
                                                $(this).next('span').remove();
                                                $('#eFromDt').datepicker('option', 'maxDate', $(this).datepicker('getDate'));
                                            }
                                        }
                                    });
</script>

<script src="<%=Constant.WEB_ASSETS%>js/kendo.all.min.js"></script>    
<script>
                                    $('.modal_box form').kendoValidator({
                                        rules: {
                                            length: function (input) {
                                                if (input.is("[name=new-password]")) {
                                                    if (input.val().length < 8) {
                                                        return false;
                                                    }
                                                }
                                                return true;
                                            },
                                            nonumber: function (input) {
                                                if (input.is("[name=new-password]")) {
                                                    if (input.val().search(/\d/) === -1) {
                                                        return false;
                                                    }
                                                }
                                                return true;
                                            },
                                            samepw: function (input) {
                                                if (input.is("[name=new-password]")) {
                                                    if (input.val() === $('#currentPassword').val()) {
                                                        return false;
                                                    }
                                                }
                                                return true;
                                            },
                                            match: function (input) {
                                                if (input.is("[name=confirm-password]")) {
                                                    if (input.val() !== $('#newPassword').val()) {
                                                        return false;
                                                    }
                                                }
                                                return true;
                                            }
                                        },
                                        messages: {
                                            required: "Please fill in this field.",
                                            length: "Minimum 8 characters required!",
                                            nonumber: "Password must contain atleast one number.",
                                            samepw: "New password can't be same as current password!",
                                            match: "Passwords don't match!"
                                        }
                                    });

                                    $('.mobile-contact-info-box div form').kendoValidator({
                                        rules: {
                                            length: function (input) {
                                                if (input.is("[name=new-pwd]")) {
                                                    if (input.val().length < 8) {
                                                        return false;
                                                    }
                                                }
                                                return true;
                                            },
                                            nonumber: function (input) {
                                                if (input.is("[name=new-pwd]")) {
                                                    if (input.val().search(/\d/) === -1) {
                                                        return false;
                                                    }
                                                }
                                                return true;
                                            },
                                            samepw: function (input) {
                                                if (input.is("[name=new-pwd]")) {
                                                    if (input.val() === $('#currentPwd').val()) {
                                                        return false;
                                                    }
                                                }
                                                return true;
                                            },
                                            match: function (input) {
                                                if (input.is("[name=confirm-pwd]")) {
                                                    if (input.val() !== $('#newPwd').val()) {
                                                        return false;
                                                    }
                                                }
                                                return true;
                                            }
                                        },
                                        messages: {
                                            required: "Please fill this field.",
                                            length: "Minimum 8 characters required!",
                                            nonumber: "Password must contain atleast one number.",
                                            samepw: "New password can't be same as current password!",
                                            match: "Passwords don't match!"
                                        }
                                    });

                                    $('.to-add-item form').kendoValidator({
                                        messages: {
                                            required: "Please fill in this field."
                                        }
                                    });
</script>

<script src="<%=Constant.WEB_ASSETS%>js/profile.js"></script>