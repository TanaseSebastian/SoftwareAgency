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
	elenco = (ArrayList<Personale>)request.getAttribute("ELENCO_PERSONALE_COINVOLTO");
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
					<h1 class="h2 font-w700 text-white mb-10">Visualizza Personale
						Coinvolto</h1>
					<h2 class="h4 font-w400 text-white-op mb-0">in questa sezione
						potrai vedere tutto i dipendenti coinvolti in questa lavorazione.</h2>
					<br>
					<button type="button" class="btn btn-outline-success "
						data-target="#chooseDepartment" data-toggle="modal">
						<i class="fa fa-plus" aria-hidden="true"></i> aggiungi personale
						coinvolto
					</button>
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
					class="breadcrumb-item active">Lavorazioni Software</span> <span
					class="breadcrumb-item active">Visualizza Personale
					Coinvolto</span>
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
				<h3 class="block-title">Tabella Personale Coinvolto</h3>
			</div>
			<div class="table-responsive">
				<form id="form" method="post">
					<!-- DataTables -->
					<table class="table table-bordered table-striped table-vcenterd"
						id="dataTable" width="100%" cellspacing="0"
						data-page-length=<%=righe%>>
						<%request.getSession().setAttribute("numeroRighe", "10"); %>
						<thead>
							<div style="margin-bottom: 10px; margin-top: 20px;"">
								<button type="submit"
									class="col-md-3 btn btn-outline-danger ml-10 "
									onclick="if(confirm('Sei sicuro di voler eliminare definitivamente queste operazioni dal database?')){submitForm('gestutenti?cmd=elimina&tipo=dipendente')}else{return false}">
									<i class="fa fa-trash" aria-hidden="true"></i>Elimina i
									dipendenti selezionati
								</button>
							</div>
							<div style="margin-bottom: 10px; margin-top: 20px;"">
								<button type="button"
									class="col-md-3 btn btn-outline-primary ml-10 "
									data-target="#chooseEntries" data-toggle="modal"
									data-id="visualizzaDipendenti.jsp" id="changeEntriesButton">
									<i class="fa fa-eye" aria-hidden="true"></i> Cambia numero
									righe
							</div>
							<div style="margin-bottom: 10px; margin-top: 20px;"></div>
							<tr>
								<th><input type="checkbox" id="checkboxAll"
									onclick='$(".check").prop("checked",$ (this).prop("checked"));'>Seleziona
									tutto</th>
								<th>Dettagli</th>
								<th>Codice Dipendente</th>
								<th>Full Name</th>
								<th>Nome Professione</th>
								<th>Data inzio</th>
								<th>Data Fine</th>
								<th>Aggiorna</th>
							</tr>
						</thead>
						<tbody>
							<% 										  
							  for(i=0;i<elenco.size();i++) 
							    {
								 p=(Personale)elenco.get(i);
							    Dipendente d=db.getUser(String.valueOf(p.getCodDipendente()));
							 %>
							<tr>
								<td><input type="checkbox" class="check" name="check"
									value="<%=d.getCodiceDipendente()%>"></td>
								<td><a
									href="gestlavorazioni?cmd=dettagli&id=<%=p.getCodLavorazione()%>"><i
										class="fa fa-info-circle" aria-hidden="true"></i></a></td>
								<td><%=d.getCodiceDipendente()%></td>
								<td><%=d.getCognome()+" "+d.getNome()%></td>
								<td><%= d.getNomeProfessione()%></td>
								<%-- <td><%= db.getNomeDipartimento(String.valueOf(d.getCodDipartimento()))%></td> --%>
								<td><%=p.getDataInizio()%></td>
								<td><%=p.getDataFine()%></td>
								<td><a
									href="gestutenti?cmd=aggiorna&tipoutente=dipendente&id=<%=d.getCodiceDipendente()%>"><i
										class="fa fa-pencil" aria-hidden="true"></i></a></td>
							</tr>

							<%
										     }
										 %>
						</tbody>
					</table>
				</form>
			</div>
		</div>
		<!-- END Dynamic Table Full -->
	</div>
	<!-- END Page Content -->

	<!-- modulo per scegliere il dipartimento dei dipendenti-->
	<div class="modal" id="chooseDepartment" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4>Indicare il dipartimento d'appartenenza del personale
						desiderato.</h4>
				</div>
				<div class="modal-body">
					<form action="gestpersonale?cmd=scegliDipartimento" method="post" id="chooseDepartmentForm"
						name="chooseEntriesForm" role="form">
						<div class="col-md-12 form-group">
							<center>
								<sql:query var="dipartimenti" dataSource="${myDS}">
										        SELECT * FROM Dipartimenti WHERE NOT Nome="Amministrazione";
										    </sql:query>
								<select class="form-control" id="dipartimento"
									name="dipartimento" required="required"
									title="inserire un dipartimento d'appartenenza">
									<option value="" hidden>Selezionare dipartimento</option>
									<c:forEach var="row" items="${dipartimenti.rows}">
										<option value="${row.codDipartimento}"><c:out
												value="${row.nome}" /></option>
									</c:forEach>
								</select>
								<input type="text" value="<%=p.getCodLavorazione()%>" name="id" readonly="readonly" hidden>
							</center>
						</div>
						<div class="text-center" style="margin-top: 30px;">
							<button type="button" class="btn btn-danger" data-dismiss="modal">Annulla</button>
							<button type="submit" class="btn btn-primary">
								Prosegui <i class="fa fa-arrow-right" aria-hidden="true"></i>
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</main>
<!-- END Main Container -->

<%@include file="footer.jsp"%>
<%@include file="librerie.jsp"%>
</body>
</html>