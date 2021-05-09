<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!doctype html>
<html lang="it" class="no-focus">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">

<title>Codebase</title>
<!-- Icons -->
<!-- The following icons can be replaced with your own, they are used by desktop and mobile browsers -->
<link rel="shortcut icon" href="assets/media/favicons/favicon.png">
<link rel="icon" type="image/png" sizes="192x192"
	href="assets/media/favicons/favicon-192x192.png">
<link rel="apple-touch-icon" sizes="180x180"
	href="assets/media/favicons/apple-touch-icon-180x180.png">
<!-- END Icons -->
<!-- Page JS Plugins CSS -->
<!-- Custom styles for this page -->
<link href="app/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<!-- Stylesheets -->
<!-- questo serve per il modal di benvenuto -->
<link rel="stylesheet" href="assets/js/plugins/slick/slick.css">
<link rel="stylesheet" href="assets/js/plugins/slick/slick-theme.css">
<!-- -Questo per lo stile-->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Nunito+Sans:300,400,400i,600,700&display=swap">
<link rel="stylesheet" id="css-main" href="assets/css/codebase.min.css">
<link rel="stylesheet"
	href="assets/js/plugins/flatpickr/flatpickr.min.css">

<style>
.paginate_button {
	padding: 10px;
	margin: 5px;
	cursor: pointer;
	border: 1px solid #4268D6;
}

.paginate_button:hover {
	background-color: #4268D6;
}

a:not([href]):hover {
	color: white;
	text-decoration: none;
}
</style>
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


						<li class="nav-main-heading"><span
							class="sidebar-mini-visible">P.A.</span><span
							class="sidebar-mini-hidden">Personale aziendale</span></li>
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



						<li class="nav-main-heading"><span
							class="sidebar-mini-visible">P.S.</span><span
							class="sidebar-mini-hidden">Pacchetti software</span></li>
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



						<li class="nav-main-heading"><span
							class="sidebar-mini-visible">L.S.</span><span
							class="sidebar-mini-hidden">Lavorazioni SOFTWARE</span></li>
						<li><a class="nav-submenu" data-toggle="nav-submenu" href="#"><i
								class="si si-flag"></i><span class="sidebar-mini-hide">Lavorazioni
							</span><span class="font-size-s text-primary">(crud)</span></a>
							<ul>
								<li><a href="#">Visualizza lavorazioni <span
										class="font-size-s text-primary">(crud)</span></a></li>
								<li><a href="#">Inserisci nuova lavorazione</a></li>
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