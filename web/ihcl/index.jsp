<%-- 
    Document   : indexcordova
    Created on : 2 Aug, 2016, 11:29:47 AM
    Author     : adoshi
--%>

<!DOCTYPE html>
<%@page import="com.owen.web.Constant"%>
<%@page import="com.owen.web.Util"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="<%=Constant.WEB_ASSETS%>css/login.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            <header>
                <div class="wrapper">
                    <a id="Login-Logo">
                        <img src="<%=Constant.WEB_ASSETS%>images/OWEN_Logo_Desktop.png" alt="OWEN Logo">
                    </a>
                </div>
            </header>
            <div class="main">
                <div class="login-box">

                    <div class="login-form">
                        <h2>LOGIN</h2>
                        <% if (request.getParameter("msg") != null) {%>
                        <div class="invalid-warning show">
                            <span>i</span>
                            <span class="warning-text"><span class="bold">Warning:</span> <%= request.getParameter("msg") != null ? request.getParameter("msg") : ""%></span>                        
                        </div>
                        <% }%>
                        <form method="post" action="login-check.jsp">
                            <label for="username">Username</label>
                            <input type="text" name="username" id="username" required>
                            <input type="hidden" name="password" id="password" value="abc123">
                            <input type="hidden" name="roleid" id="roleid" value="1">    
                            <div class="login-remember-me">
                                <input type="checkbox" id="check-me">
                                <label for="check-me">
                                    <span class="check"></span>
                                    <span class="box"></span>
                                    Remember me
                                </label>
                            </div>

                            <button type="submit">GO</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="<%=Constant.WEB_ASSETS%>js/jquery-2.1.4.min.js"></script>
        <script src="<%=Constant.WEB_ASSETS%>js/login.js"></script>

        <!-- Webshim script to enable HTML5 form validation in Safari --> 
        <script>
            (function () {
                var loadScript = function (src, loadCallback) {
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