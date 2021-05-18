<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!ArrayList<Software> elenco;
	int i;
	Software s;%>
<%
//jstl
String righe = (String) session.getAttribute("numeroRighe");
if (righe == null) {
	righe = "10";
}
DBManager db = new DBManager();
elenco = (ArrayList<Software>) request.getAttribute("ELENCO_SOFTWARE");
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
					<h1 class="h2 font-w700 text-white mb-10">Visualizza
						Pacchetti Software</h1>
					<h2 class="h4 font-w400 text-white-op mb-0">in questa sezione
						potrai vedere tutti i pacchetti software che possiede
						l'azienda .</h2>
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
					class="breadcrumb-item active">Visualizza Pacchetti Software</span>
			</nav>
		</div>
	</div>
	<!-- END Breadcrumb -->



	<!-- Page Content -->
	<div class="content">


		<%=messaggio%>
		<%
		request.getSession().setAttribute("MESSAGGIO", "");
		%>

		<!-- Dynamic Table Full -->
		<div class="block">
			<div class="block-header block-header-default">
				<h3 class="block-title">Tabella Pacchetti Software</h3>
			</div>
			<div class="table-responsive">
				<form id="form" method="post">
					<!-- DataTables -->
					<table class="table table-bordered table-striped table-vcenterd"
						id="dataTable" width="100%" cellspacing="0"
						data-page-length=<%=righe%>>
						<%
						request.getSession().setAttribute("numeroRighe", "10");
						%>
						<thead>
							<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
							<div style="margin-bottom: 10px; margin-top: 20px;"">
								<button type="submit"
									class="col-md-3 btn btn-outline-danger ml-10 "
									onclick="if(confirm('Sei sicuro di voler eliminare definitivamente questi pacchetti software dal database?')){submitForm('gestsoftware?cmd=elimina')}else{return false}">
									<i class="fa fa-trash" aria-hidden="true"></i> Elimina i
									pacchetti selezionati
								</button>
							</div>
							<%} %>
							<div style="margin-bottom: 10px; margin-top: 20px;"">
								<button type="button"
									class="col-md-3 btn btn-outline-primary ml-10 "
									data-target="#chooseEntries" data-toggle="modal"
									data-id="visualizzaPacchetti.jsp" id="changeEntriesButton">
									<i class="fa fa-eye" aria-hidden="true"></i> Cambia numero
									righe
								</button>
							</div>
							<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
							<div style="margin-bottom: 10px; margin-top: 20px;"">
								<a type="button" class="col-md-3 btn btn-outline-success ml-10 "
									href="nuovoSoftware.jsp"><i class="fa fa-plus"
									aria-hidden="true"></i> Inserisci nuovo pacchetto software</a>
							</div>
							<%}%>
							<tr>
							  <%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
								<th><input type="checkbox" id="checkboxAll"
									onclick='$(".check").prop("checked",$ (this).prop("checked"));'>Seleziona
									tutto</th>
								<%}%>
								<th>Dettagli</th>
								<th>Codice software</th>
								<th>Nome Software</th>
								<th>Tempo in Giorni/Uomo</th>
								<th>Costo</th>
								<th>Responsabile</th>
								<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
								<th>Aggiorna</th>
								<%} %>
							</tr>
						</thead>
						<tbody>
							<%
							for (i = 0; i < elenco.size(); i++) {
								s = (Software)elenco.get(i);
							%>
							<tr>
								<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
								<td>
								
								<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
								<input type="checkbox" class="check" name="check"
									value="<%=s.getCodSoftware()%>">
								<%}//chiudo primo if
								else if(user.getCodiceDipendente()==s.getCodResponsabile() && user.getQualificaProfessionale().equals("Responsabile")) {%>
								<!-- il responsabile può eliminare solamente i software di cui è responsabile -->
								<input type="checkbox" class="check" name="check"
									value="<%=s.getCodSoftware()%>">
								<%} %>	
									
									</td>
								<%} %>
								<td><a
									href="gestsoftware?cmd=dettagli&id=<%=s.getCodSoftware()%>"><i
										class="fa fa-info-circle" aria-hidden="true"></i></a></td>
								<td><%=s.getCodSoftware()%></td>
								<td><%=s.getNome()%></td>
								<td><%=s.getTempoGiorniUomo()%></td>
								<td><%="€" + s.getCosto()%></td>
								<td><%=db.getFullName(String.valueOf(s.getCodResponsabile()))%></td>
								<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
								<td>
								
								
								<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
								<a href="gestsoftware?cmd=aggiorna&id=<%=s.getCodSoftware()%>"><i
										class="fa fa-pencil" aria-hidden="true"></i></a>
								<%}//chiudo primo if
								else if(user.getCodiceDipendente()==s.getCodResponsabile() && user.getQualificaProfessionale().equals("Responsabile")) {%>
								<!-- il responsabile può modificare solamente i software di cui è responsabile -->
								<a href="gestsoftware?cmd=aggiorna&id=<%=s.getCodSoftware()%>"><i
										class="fa fa-pencil" aria-hidden="true"></i></a>
								<%} %>
										
										
										</td>
								<%} %>
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

</main>
<!-- END Main Container -->

<%@include file="footer.jsp"%>
<%@include file="librerie.jsp"%>
</body>
</html>