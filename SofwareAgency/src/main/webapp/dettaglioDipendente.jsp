<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

	Dipendente d = (Dipendente)request.getAttribute("DIPENDENTE");
	DBManager db=new DBManager();
%>
<%@include file="header.jsp"%>
<!-- Main Container -->
<main id="main-container">




	<!-- Hero -->
	<div class="bg-image"
		style="background-image: url('assets/media/photos/photo26@2x.jpg');">
		<div class="bg-black-op-75">
			<div class="content content-top content-full text-center">
				<div class="py-20">
					<h1 class="h2 font-w700 text-white mb-10">Dettaglio dipendente</h1>
					<h2 class="h4 font-w400 text-white-op mb-0">in questa sezione
						vi sono tutte le informazioni riguardanti questo dipendente .</h2>
				</div>
			</div>
		</div>
	</div>
	<!-- END Hero -->

	<!-- Breadcrumb -->
	<div class="bg-body-light border-b">
		<div class="content py-5 text-center">
			<nav class="breadcrumb bg-body-light mb-0">
				<a class="breadcrumb-item" href="dashboard.jsp">Dashboard</a> <span
					class="breadcrumb-item active">Personale Aziendale</span> <span
					class="breadcrumb-item active">Visualizza Personale</span>
			</nav>
		</div>
	</div>
	<!-- END Breadcrumb -->



	<!-- Page Content -->
	<div class="content">
		<h2 class="content-heading">Informazioni di <%=d.getCognome()+" "+d.getNome() %></h2>

		<!-- Dynamic Table Full -->
		<div class="block">
			<div class="block-header block-header-default">
				<h3 class="block-title">
					Dettagli dipendente
				</h3>
			</div>
			<div class="table-responsive">
				<!-- DataTables -->
				<table class="table table-bordered table-striped table-vcenterd"
					width="100%" cellspacing="0">
					<thead>
						<tr>
							<th>Codice Dipendente</th>
							<th>Codice Fiscale</th>
							<th>Cognome</th>
							<th>Nome</th>
							<th>Data di Nascita</th>
							<th>Provincia di residenza</th>
							<th>Username</th>
							<th>Email</th>
							<th>phone</th>
							<th>Qualifica Professionale</th>
							<th>Nome Professione</th>
							<th>Data Assunzione</th>
							<th>Stipendio</th>
							<th>Anni di anzianita'</th>
							<th>Dipartimento</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><%=d.getCodiceDipendente()%></td>
							<td><%=d.getCf()%></td>
							<td><%=d.getCognome()%></td>
							<td><%=d.getNome()%></td>
							<td><%=d.getDataNascita()%></td>
							<td><%=d.getProvincia()%></td>
							<td><%=d.getUsername()%></td>
							<td><%=d.getEmail()%></td>
							<td><%=d.getPhone()%></td>
							<td><%= d.getQualificaProfessionale()%></td>
							<td><%= d.getNomeProfessione()%></td>
							<td><%= d.getDataAssunzione()%></td>
							<td><%= "€"+d.getStipendio()%></td>
							<td><%=d.getAnniAnzianita()%></td>
							<td><%= db.getNomeDipartimento(String.valueOf(d.getCodDipartimento()))%></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- END Dynamic Table Full -->
	</div>
	<!-- END Page Content -->

</main>
<!-- END Main Container -->

<%@include file="footer.jsp"%>
<%@include file="librerie.jsp"%>
</body>
</html>