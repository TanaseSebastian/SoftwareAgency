<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
  ArrayList<Personale> elenco;
  int i;
  Personale p;
%>
<%
String righe=(String)session.getAttribute("numeroRighe");
if(righe==null){
	righe="10";
}
	DBManager db=new DBManager();
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@include file="header.jsp"%>
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

<!-- Main Container -->
<main id="main-container">



	<!-- Hero -->
	<div class="bg-image"
		style="background-image: url('assets/media/photos/photo26@2x.jpg');">
		<div class="bg-black-op-75">
			<div class="content content-top content-full text-center">
				<div class="py-20">
					<h1 class="h2 font-w700 text-white mb-10">Visualizza Clienti</h1>
					<h2 class="h4 font-w400 text-white-op mb-0">in questa sezione
						potrai vedere tutti i clienti che si sono registrati oppure che
						sono stati inseriti da un personale qualificato.</h2>
						<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
					<br> <a type="button" class="btn btn-outline-success "
						href="nuovoCliente.jsp"> <i class="fa fa-plus"
						aria-hidden="true"></i> aggiungi un nuovo cliente
					</a>
					<%} %>
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
					class="breadcrumb-item active">Visualizza Clienti</span>
			</nav>
		</div>
	</div>
	<!-- END Breadcrumb -->



	<!-- Page Content -->
	<div class="content">

		<%=messaggio%>
		<%request.getSession().setAttribute("MESSAGGIO", ""); %>


		<!-- Dynamic Table Full -->
		<div class="block">
			<div class="block-header block-header-default">
				<h3 class="block-title">Tabella Clienti</h3>
			</div>
			<div class="table-responsive">
				<form id="form" method="post">
					<!-- DataTables -->
					<table class="table table-bordered table-striped table-vcenterd"
						id="dataTable" width="100%" cellspacing="0"
						data-page-length=<%=righe%>>
						<%request.getSession().setAttribute("numeroRighe", "10"); %>
						<thead>
						<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
							<div style="margin-bottom: 10px; margin-top: 20px;"">
								<button type="submit"
									class="col-md-3 btn btn-outline-danger ml-10 "
									onclick="if(confirm('Sei sicuro di voler eliminare definitivamente questi clienti dalla lavorazione? ATTENZIONE: i clienti che  hanno effettuato ordini NON VERRANNO ELIMINATI')){submitForm('gestclienti?cmd=elimina')}else{return false}">
									<i class="fa fa-trash" aria-hidden="true"></i>Elimina i clienti selezionati
								</button>
							</div>
							<%} %>
							<div style="margin-bottom: 10px; margin-top: 20px;"">
								<button type="button"
									class="col-md-3 btn btn-outline-primary ml-10 "
									data-target="#chooseEntries" data-toggle="modal"
									data-id="visualizzaClienti.jsp"
									id="changeEntriesButton">
									<i class="fa fa-eye" aria-hidden="true"></i> Cambia numero
									righe
							</div>
							<div style="margin-bottom: 10px; margin-top: 20px;"></div>
							<tr>
							<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
								<th><input type="checkbox" id="checkboxAll"
									onclick='$(".check").prop("checked",$ (this).prop("checked"));'>Seleziona tutto</th>
								<%} %>
								<th>Codice Cliente</th>
								<th>Nome</th>
								<th>indirizzo</th>
								<th>Ragione Sociale</th>
								<th>Partita iva</th>
								<th>Pec/Email aziendale</th>
								<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
								<th>Aggiorna</th>
								<%} %>
							</tr>
						</thead>
						<tbody>
							<sql:query var="clienti" dataSource="${myDS}">
       							 SELECT * FROM clienti;
    						</sql:query>
							<c:forEach var="row" items="${clienti.rows}">
								<tr>
								<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
									<td><input type="checkbox" class="check" name="check" value="${row.codCliente}"/></td>
									<%} %>
									<td><c:out value="${row.codCliente}" /></td>
									<td><c:out value="${row.nome}" /></td>
									<td><c:out value="${row.indirizzo}" /></td>
									<td><c:out value="${row.ragioneSociale}" /></td>
									<td><c:out value="${row.partitaIva}" /></tPer qualsiasi dubbio o problema non esitare a contattarci tramite telefono o emad>
									<td><c:out value="${row.pec}" /></td>
									<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
									<td><a href="gestclienti?cmd=aggiorna&id=${row.codCliente}"><i
										class="fa fa-pencil" aria-hidden="true"></i></a></td>
										<%} %>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
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