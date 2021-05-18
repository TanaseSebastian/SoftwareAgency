<%@ page language="java" import="java.util.*,it.meucci.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String mess=(String)session.getAttribute("utente_loggato");
System.out.println("utente loggato:"+mess);
if(session.getAttribute("utente_loggato").equals("false")){
		response.sendRedirect("login.jsp");
	}
Dipendente user;
user = (Dipendente) session.getAttribute("SESSION_USER");
String messaggio = (String) session.getAttribute("MESSAGGIO");
if (messaggio == null)
	messaggio = "";
// Leggo le proprietà da file propertiess
Properties prop;
ReadPropertyFileFromClassPath obj = new ReadPropertyFileFromClassPath();
prop = obj.loadProperties("DB.properties");
String pathImages= prop.getProperty("pathImages");
String srcImmagineProfilo;
if(user.getImmagineProfilo()!=null){
  srcImmagineProfilo="immaginiProfilo/"+user.getImmagineProfilo();}
else{
	srcImmagineProfilo="assets/media/avatars/avatar0.jpg";
}
%>
<%
	// Leggo le proprietà da file properties
	prop = obj.loadProperties("DB.properties");
	prop = obj.loadProperties("DB.properties");
	String userDB = prop.getProperty("Username");
	String pwDB = prop.getProperty("Pasword");
%>
<sql:setDataSource var="myDS" driver="com.mysql.cj.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/softwarehouse?serverTimezone=UTC"
	user='<%=userDB%>' password='<%=pwDB%>' />
<!doctype html>
<html lang="en" class="no-focus">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">

        <title>Codebase - Bootstrap 4 Admin Template &amp; UI Framework</title>

        <meta name="description" content="Codebase - Bootstrap 4 Admin Template &amp; UI Framework created by pixelcave and published on Themeforest">
        <meta name="author" content="pixelcave">
        <meta name="robots" content="noindex, nofollow">

        <!-- Open Graph Meta -->
        <meta property="og:title" content="Codebase - Bootstrap 4 Admin Template &amp; UI Framework">
        <meta property="og:site_name" content="Codebase">
        <meta property="og:description" content="Codebase - Bootstrap 4 Admin Template &amp; UI Framework created by pixelcave and published on Themeforest">
        <meta property="og:type" content="website">
        <meta property="og:url" content="">
        <meta property="og:image" content="">

        <!-- Icons -->
        <!-- The following icons can be replaced with your own, they are used by desktop and mobile browsers -->
        <link rel="shortcut icon" href="assets/media/favicons/favicon.png">
        <link rel="icon" type="image/png" sizes="192x192" href="assets/media/favicons/favicon-192x192.png">
        <link rel="apple-touch-icon" sizes="180x180" href="assets/media/favicons/apple-touch-icon-180x180.png">
        <!-- END Icons -->

        <!-- Stylesheets -->

        <!-- Page JS Plugins CSS -->
        <link rel="stylesheet" href="assets/js/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css">
        <link rel="stylesheet" href="assets/js/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css">
        <link rel="stylesheet" href="assets/js/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="assets/js/plugins/jquery-tags-input/jquery.tagsinput.min.css">
        <link rel="stylesheet" href="assets/js/plugins/jquery-auto-complete/jquery.auto-complete.min.css">
        <link rel="stylesheet" href="assets/js/plugins/ion-rangeslider/css/ion.rangeSlider.css">
        <link rel="stylesheet" href="assets/js/plugins/dropzonejs/dist/dropzone.css">
        <link rel="stylesheet" href="assets/js/plugins/flatpickr/flatpickr.min.css">

        <!-- Fonts and Codebase framework -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito+Sans:300,400,400i,600,700&display=swap">
        <link rel="stylesheet" id="css-main" href="assets/css/codebase.min.css">

        <!-- You can include a specific file from css/themes/ folder to alter the default color theme of the template. eg: -->
        <!-- <link rel="stylesheet" id="css-theme" href="assets/css/themes/flat.min.css"> -->
        <!-- END Stylesheets -->
    </head>
    <body>
<div id="page-loader" class="show"></div>
	<div id="page-container"
		class="sidebar-mini sidebar-o sidebar-inverse enable-page-overlay side-scroll page-header-fixed page-header-glass page-header-inverse main-content-boxed">

		<!-- Sidebar -->

		<nav id="sidebar">
			<!-- Sidebar Content -->
			<div class="sidebar-content">
				<!-- Side Header -->
				<div class="content-header content-header-fullrow px-15">
					<!-- Mini Mode -->
					<div class="content-header-section sidebar-mini-visible-b">
						<!-- Logo -->
						<span
							class="content-header-item font-w700 font-size-xl float-left animated fadeIn">
							<span class="text-dual-primary-dark">c</span><span
							class="text-primary">b</span>
						</span>
						<!-- END Logo -->
					</div>
					<!-- END Mini Mode -->

					<!-- Normal Mode -->
					<div
						class="content-header-section text-center align-parent sidebar-mini-hidden">
						<!-- Close Sidebar, Visible only on mobile screens -->
						<!-- Layout API, functionality initialized in Template._uiApiLayout() -->
						<button type="button"
							class="btn btn-circle btn-dual-secondary d-lg-none align-v-r"
							data-toggle="layout" data-action="sidebar_close">
							<i class="fa fa-times text-danger"></i>
						</button>
						<!-- END Close Sidebar -->

						<!-- Logo -->
						<div class="content-header-item">
							<a class="link-effect font-w700" href="index.html"> <i
								class="si si-fire text-primary"></i> <span
								class="font-size-xl text-dual-primary-dark">code</span><span
								class="font-size-xl text-primary">base</span>
							</a>
						</div>
						<!-- END Logo -->
					</div>
					<!-- END Normal Mode -->
				</div>
				<!-- END Side Header -->

				<!-- Side User -->
				<div
					class="content-side content-side-full content-side-user px-10 align-parent">
					<!-- Visible only in mini mode -->
					<div class="sidebar-mini-visible-b align-v animated fadeIn">
						<img class="img-avatar img-avatar32" src="<%=srcImmagineProfilo%>">
					</div>
					<!-- END Visible only in mini mode -->

					<!-- Visible only in normal mode -->
					<div class="sidebar-mini-hidden-b text-center">
						<a class="img-link" href="profile.jsp"> <img
							class="img-avatar" src="<%=srcImmagineProfilo%>">
						</a>
						<ul class="list-inline mt-10">
							<li class="list-inline-item"><a
								class="link-effect text-dual-primary-dark font-size-sm font-w600 text-uppercase"
								href="profile.jsp"><%=user.getCognome()+" "+user.getNome()%></a></li>
							<li class="list-inline-item">
								<!-- Layout API, functionality initialized in Template._uiApiLayout() -->
								<a class="link-effect text-dual-primary-dark"
								data-toggle="layout" data-action="sidebar_style_inverse_toggle"
								href="javascript:void(0)"> <i class="si si-drop"></i>
							</a>
							</li>
							<li class="list-inline-item"><a
								class="link-effect text-dual-primary-dark" data-toggle="modal"
								data-target="#logoutModal"> <i class="si si-logout"></i>
							</a></li>
						</ul>
					</div>
					<!-- END Visible only in normal mode -->
				</div>
				<!-- END Side User -->

				<!-- Side Navigation -->
				<div class="content-side content-side-full">
					<ul class="nav-main">
						<li><a href="dashboard.jsp"><i class="si si-cup"></i><span
								class="sidebar-mini-hide">Dashboard</span></a></li>

						<li><a class="nav-submenu" data-toggle="nav-submenu" href="#"><i
								class="si si-vector"></i><span class="sidebar-mini-hide">Dipendenti
							</span><span class="font-size-s text-primary">(crud)</span></a>
							<ul>
								<li><a href="gestutenti?cmd=viewall&tipo=dipendente">Visualizza
										Dipendenti</a></li>
								<li><a href="nuovoDipendente.jsp">Inserisci Nuovo
										Dipendente</a></li>
							</ul></li>
						<li><a class="nav-submenu" data-toggle="nav-submenu" href="#"><i
								class="si si-vector"></i><span class="sidebar-mini-hide">Amministratori
							</span><span class="font-size-s text-primary">(crud)</span></a>
							<ul>
								<li><a href="gestutenti?cmd=viewall&tipo=amministratore">Visualizza
										Amministratori</a></li>
								<li><a href="nuovoAmministratore.jsp">Inserisci Nuovo
										Dipendente</a></li>
							</ul></li>



						<li><a class="nav-submenu" data-toggle="nav-submenu" href="#"><i
								class="si si-puzzle"></i><span class="sidebar-mini-hide">Software
							</span><span class="font-size-s text-primary">(crud)</span></a>
							<ul>
								<li><a href="gestsoftware?cmd=viewall">Visualizza
										software</a></li>
								<li><a href="nuovoSoftware.jsp">Inserisci nuovo
										software</a></li>
								<li><a href="#">Altro</a></li>
							</ul></li>

						<li><a class="nav-submenu" data-toggle="nav-submenu" href="#"><i
								class="si si-flag"></i><span class="sidebar-mini-hide">Lavorazioni
							</span><span class="font-size-s text-primary">(crud)</span></a>
							<ul>
								<li><a href="gestlavorazioni?cmd=viewall">Visualizza lavorazioni <span
										class="font-size-s text-primary">(crud)</span></a></li>
								<li><a href="nuovaLavorazione.jsp">Inserisci nuova lavorazione</a></li>
								<li><a href="#">Altro</a></li>
							</ul></li>
							
						<li><a class="nav-submenu" data-toggle="nav-submenu" href="#"><i
								class="si si-flag"></i><span class="sidebar-mini-hide">Clienti
							</span><span class="font-size-s text-primary">(crud)</span></a>
							<ul>
								<li><a href="visualizzaClienti.jsp">Visualizza Clienti<span
										class="font-size-s text-primary">(crud)</span></a></li>
								<li><a href="nuovoCliente.jsp">Inserisci nuovo Cliente</a></li>
								<li><a href="#">Altro</a></li>
							</ul></li>
							
							
							
							<li><a class="nav-submenu" data-toggle="nav-submenu" href="#"><i
								class="si si-flag"></i><span class="sidebar-mini-hide">Ordini
							</span><span class="font-size-s text-primary">(crud)</span></a>
							<ul>
								<li><a href="visualizzaClienti.jsp">Visualizza Ordini<span
										class="font-size-s text-primary">(crud)</span></a></li>
								<li><a href="prova.jsp">Inserisci nuovo ordine</a></li>
								<li><a href="#">Altro</a></li>
							</ul></li>
					</ul>
				</div>
				<!-- END Side Navigation -->
			</div>
			<!-- Sidebar Content -->
		</nav>
		<!-- END Sidebar -->

		<!-- Header -->
		<header id="page-header">
			<!-- Header Content -->
			<div class="content-header">
				<!-- Left Section -->
				<div class="content-header-section">
					<!-- Toggle Sidebar -->
					<!-- Layout API, functionality initialized in Template._uiApiLayout() -->
					<button type="button" class="btn btn-circle btn-dual-secondary"
						data-toggle="layout" data-action="sidebar_toggle">
						<i class="fa fa-navicon"></i>
					</button>
					<!-- END Toggle Sidebar -->
				</div>
				<!-- END Left Section -->

				<!-- Right Section -->
				<div class="content-header-section">
					<!-- User Dropdown -->
					<div class="btn-group" role="group">
						<button type="button" class="btn btn-rounded btn-dual-secondary"
							id="page-header-user-dropdown" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false">
							<i class="fa fa-user d-sm-none"></i> <span
								class="d-none d-sm-inline-block"><%=user.getCognome()+" "+user.getNome()%></span>
						</button>
					</div>
					<a class="link-effect text-dual-primary-dark" data-toggle="modal"
						data-target="#logoutModal"> <i class="si si-logout"></i>
					</a>
					<!-- END Toggle Side Overlay -->
				</div>
				<!-- END Right Section -->
			</div>
			<!-- END Header Content -->

			<!-- Header Loader -->
			<!-- Please check out the Activity page under Elements category to see examples of showing/hiding it -->
			<div id="page-header-loader" class="overlay-header bg-primary">
				<div class="content-header content-header-fullrow text-center">
					<div class="content-header-item">
						<i class="fa-spin text-white"></i>
					</div>
				</div>
			</div>
			<!-- END Header Loader -->
		</header>
		<!-- END Header -->
       
            <!-- Main Container -->
            <main id="main-container">

             <!-- Hero -->
     <div class="bg-image" style="background-image: url('assets/media/photos/photo26@2x.jpg');">
                    <div class="bg-black-op-75">
                        <div class="content content-top content-full text-center">
                            <div class="py-20">
                                <h1 class="h2 font-w700 text-white mb-10">  <i class="fa fa-plus text-muted mr-5"></i>Nuovo Ordine</h1>
                                <h2 class="h4 font-w400 text-white-op mb-0"> inserisci le informazioni e aggiungi un nuovo ordine!</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END Hero -->

                <!-- Breadcrumb -->
                <div class="bg-body-light border-b">
                    <div class="content py-5 text-center">
                        <nav class="breadcrumb bg-body-light mb-0">
                        <a class="breadcrumb-item" href="dashboard.jsp">Dashboard</a>
                            <a class="breadcrumb-item" href="visualizzaPacchetti.jsp">Lavorazioni Software</a>
                            <span class="breadcrumb-item active">Nuova Lavorazione</span>
                        </nav>
                    </div>
                </div>
                <!-- END Breadcrumb -->



                  <!-- Page Content -->
                  <div class="content">
                    <div class="block block-rounded block-fx-shadow">
                        <div class="block-content">
                            <form action="gestordini?cmd=nuovo" method="POST">

                                <!-- Vital Info -->
                                <h2 class="content-heading text-black">Scelta del Cliente</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Scegli il cliente interessato ad acquistare i nostri prodotti.
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                  			 <div class="form-group">
                                                <label for="cliente">Cliente</label>
                                                <select class="form-control form-control-lg" id="cliente" name="cliente">
                                                    <option selected="selected" hidden>Seleziona cliente</option>
                                                    <sql:query var="clienti" dataSource="${myDS}">
										   		    select * from clienti;
										    		</sql:query>
													<c:forEach var="row" items="${clienti.rows}">
													<option value="${row.codCliente}"><c:out
													value="${row.ragioneSociale}" /></option>
													</c:forEach>
                                                </select>
                                            </div>
                                    </div>
                                </div>
                                <!-- END Vital Info -->





 							<!-- software -->
                                <h2 class="content-heading text-black">Inserisci software che intende acquistare</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Inserisci i software che intende acquistare il cliente
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                            <label class="col-12" for="example-select2-multiple">Multiple Values</label>
                                            <div class="col-lg-12">
                                                <select class="js-select2 form-control" id="software" name="software" style="width: 100%;" data-placeholder="Scegli i pacchetti software..." multiple>
                                                    <option></option>
                                                    <sql:query var="software" dataSource="${myDS}">
										   		    select * from software;
										    		</sql:query>
													<c:forEach var="row" items="${software.rows}">
													<option value="${row.codSoftware}"><c:out
													value="${row.nome}" /></option>
													</c:forEach>
                                                </select>
                                            </div>
                                    </div>
                                </div>
                                <!-- END->




 								<!-- Additional Info -->
                                <h2 class="content-heading text-black">Descrizione dell'ordine(opzionale)</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Aggiungi una breve descrizione dell'ordine
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group">
                                            <label for="descrizione">Descrizione</label>
                                            <textarea class="form-control form-control-lg" id="descrizione" name="descrizione" rows="8" placeholder="es: ordine contenente x pacchetti software presso l'azienda X s.rl." maxlength="255"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Additional Info -->



                               

                                <!-- Form Submission -->
                                <div class="row items-push">
                                    <div class="col-lg-7 offset-lg-4">
                                        <div class="form-group">
                                            <button type="submit" class="btn btn-alt-success">
                                                <i class="fa fa-plus mr-5"></i>
                                                Inserisci questo ordine
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Form Submission -->
                            </form>
                        </div>
                    </div>
                </div>
                <!-- END Page Content -->

            </main>
            <!-- END Main Container -->

            

          <%@include file="footer.jsp"%>
           
        <script src="assets/js/codebase.core.min.js"></script>

        <!--
            Codebase JS

            Custom functionality including Blocks/Layout API as well as other vital and optional helpers
            webpack is putting everything together at assets/_es6/main/app.js
        -->
        <script src="assets/js/codebase.app.min.js"></script>

        <!-- Page JS Plugins -->
        <script src="assets/js/plugins/pwstrength-bootstrap/pwstrength-bootstrap.min.js"></script>
        <script src="assets/js/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
        <script src="assets/js/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
        <script src="assets/js/plugins/bootstrap-maxlength/bootstrap-maxlength.min.js"></script>
        <script src="assets/js/plugins/select2/js/select2.full.min.js"></script>
        <script src="assets/js/plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
        <script src="assets/js/plugins/jquery-auto-complete/jquery.auto-complete.min.js"></script>
        <script src="assets/js/plugins/masked-inputs/jquery.maskedinput.min.js"></script>
        <script src="assets/js/plugins/ion-rangeslider/js/ion.rangeSlider.min.js"></script>
        <script src="assets/js/plugins/dropzonejs/dropzone.min.js"></script>
        <script src="assets/js/plugins/flatpickr/flatpickr.min.js"></script>

        <!-- Page JS Code -->
        <script src="assets/js/pages/be_forms_plugins.min.js"></script>

        <!-- Page JS Helpers (Flatpickr + BS Datepicker + BS Colorpicker + BS Maxlength + Select2 + Masked Input + Range Sliders + Tags Inputs plugins) -->
        <script>jQuery(function(){ Codebase.helpers(['flatpickr', 'datepicker', 'colorpicker', 'maxlength', 'select2', 'masked-inputs', 'rangeslider', 'tags-inputs']); });</script>
    </body>
</html>