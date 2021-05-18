<%@ page language="java" import="it.meucci.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String messaggio =(String)session.getAttribute("MESSAGGIO");
	if(messaggio==null) messaggio="";;
%>
<!doctype html>
<html lang="en" class="no-focus">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">

         <title>SeTech</title>

        <meta name="description" content="SeTech">
        <meta name="author" content="pixelcave">
        <meta name="robots" content="noindex, nofollow">

        <!-- Open Graph Meta -->
        <meta property="og:title" content="SeTech">
        <meta property="og:site_name" content="SeTech">
        <meta property="og:description" content="SeTech">
        <meta property="og:type" content="website">
        <meta property="og:url" content="">
        <meta property="og:image" content="">

        <!-- Icons -->
        <!-- The following icons can be replaced with your own, they are used by desktop and mobile browsers -->
        <link rel="shortcut icon" href="assets/media/favicons/logo.png.png">
        <link rel="icon" type="image/png" sizes="192x192" href="assets/media/favicons/logo.png">
        <link rel="apple-touch-icon" sizes="180x180" href="assets/media/favicons/logo.png">
        <!-- END Icons -->
        
        <!-- Stylesheets -->

        <!-- Fonts and Codebase framework -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito+Sans:300,400,400i,600,700&display=swap">
        <link rel="stylesheet" id="css-main" href="assets/css/codebase.min.css">

        <!-- You can include a specific file from css/themes/ folder to alter the default color theme of the template. eg: -->
        <!-- <link rel="stylesheet" id="css-theme" href="assets/css/themes/flat.min.css"> -->
        <!-- END Stylesheets -->
    </head>
    <body>
        <div id="page-container" class="main-content-boxed">

            <!-- Main Container -->
            <main id="main-container">

                <!-- Page Content -->
                <div class="bg-image" style="background-image: url('assets/media/photos/photo34@2x.jpg');">
                    <div class="row mx-0 bg-default-op">
                        <div class="hero-static col-md-6 col-xl-8 d-none d-md-flex align-items-md-end">
                            <div class="p-30 invisible" data-toggle="appear">
                                <p class="font-size-h3 font-w600 text-white">
                                    You are awesome! Build something amazing!
                                </p>
                                <p class="font-italic text-white-op">
                                    Copyright &copy; <span class="js-year-copy"></span>
                                </p>
                            </div>
                        </div>
                        <div class="hero-static col-md-6 col-xl-4 d-flex align-items-center bg-white">
                            <div class="content content-full">
                                <!-- Header -->
                                <div class="px-30 py-10">
                                    <a class="link-effect font-w700" href="login.jsp">
                                        <img style="height: 25px;"
							 src="assets/img/_logo.png"> <span
								class="font-size-xl text-dual-primary-dark">Se</span><span
								class="font-size-xl text-primary">Tech</span>
                                    </a>
                                    <h1 class="h3 font-w700 mt-30 mb-10">Non preoccuparti ti riportiamo dentro a breve</h1>
                                    <h2 class="h5 font-w400 text-muted mb-0">Perfavore inserisci la tua email</h2>
                                </div>
                                <!-- END Header -->

                                <!-- Reminder Form -->
                                <!-- jQuery Validation functionality is initialized with .js-validation-reminder class in js/pages/op_auth_reminder.min.js which was auto compiled from _es6/pages/op_auth_reminder.js -->
                                <!-- For more examples you can check out https://github.com/jzaefferer/jquery-validation -->
                                <form class="js-validation-reminder px-30" action="gestforgot?cmd=verifyemail" method="post">
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <div class="form-material floating">
                                                <input type="text" class="form-control" id="email" name="email">
                                                <label for="reminder-credential">Email</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-sm btn-hero btn-alt-primary">
                                            <i class="fa fa-asterisk mr-10"></i> Password Reminder
                                        </button>
                                        <%=messaggio%>
										<%request.getSession().setAttribute("MESSAGGIO", ""); %>
                                        <div class="mt-30">
                                            <a class="link-effect text-muted mr-10 mb-5 d-inline-block" href="login.jsp">
                                                <i class="fa fa-user text-muted mr-5"></i> Sign In
                                            </a>
                                        </div>
                                    </div>
                                </form>
                                <!-- END Reminder Form -->
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END Page Content -->

            </main>
            <!-- END Main Container -->
        </div>
        <!-- END Page Container -->

        <script src="assets/js/codebase.core.min.js"></script>

        <!--
            Codebase JS

            Custom functionality including Blocks/Layout API as well as other vital and optional helpers
            webpack is putting everything together at assets/_es6/main/app.js
        -->
        <script src="assets/js/codebase.app.min.js"></script>

        <!-- Page JS Plugins -->
        <script src="assets/js/plugins/jquery-validation/jquery.validate.min.js"></script>

        <!-- Page JS Code -->
        <script src="assets/js/pages/op_auth_reminder.min.js"></script>
    </body>
</html>