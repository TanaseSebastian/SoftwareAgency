<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!ArrayList<Lavorazione> elenco;
	int i;
	Lavorazione l;%>
<%
//jstl
String righe = (String) session.getAttribute("numeroRighe");
if (righe == null) {
	righe = "10";
}
DBManager db = new DBManager();
elenco = (ArrayList<Lavorazione>) request.getAttribute("ELENCO_LAVORAZIONI");
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
						Lavorazioni</h1>
					<h2 class="h4 font-w400 text-white-op mb-0">in questa sezione
						potrai vedere tutte le lavorazioni software .</h2>
						 <%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
						<br>
							<a type="button" class="btn btn-outline-success"
									href="nuovaLavorazione.jsp"><i class="fa fa-plus"
									aria-hidden="true"></i> Inserisci nuova lavorazione</a>
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
					class="breadcrumb-item active">Visualizza Lavorazioni</span>
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
				<h3 class="block-title">Tabella Lavorazioni Software</h3>
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
						
						  <%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
						<h3 class="block-title">Una volta selezionate le Lavorazioni interessate è possibile utilizzare le seguenti funzioni:</h3>
                              <!--   solamente amministratori dirigenti e responsabili possono cambiare lo stato di una lavorazione-->
								<button type="submit" class="col-md-2 btn btn-success" onclick="if(confirm('Sei sicuro di voler modificare lo stato di queste operazioni in: Eseguita ?')){submitForm('gestlavorazioni?cmd=eseguita')}else{submitForm('gestlavorazioni?cmd=view')}">Cambia stato delle Lavorazioni selezionate in:<strong>Eseguite </strong>  <i class="fa fa-check-circle-o" aria-hidden="true"></i></button>
                                 <button type="submit" class="col-md-2  btn btn-warning" onclick="if(confirm('Sei sicuro di voler modificare lo stato di queste operazioni in: Non eseguita ?')){submitForm('gestlavorazioni?cmd=noneseguita')}else{submitForm('gestlavorazioni?cmd=view')}">Cambia stato delle Lavorazioni selezionate in: <strong>Non Eseguite </strong> <i class="fa fa-times-circle-o" aria-hidden="true"></i></button>
                                 <button type="submit" class="col-md-2  btn btn-primary" onclick="if(confirm('Sei sicuro di voler modificare lo stato di queste operazioni in: In lavorazione ?')){submitForm('gestlavorazioni?cmd=inlavorazione')}else{submitForm('gestlavorazioni?cmd=view')}">Cambia stato delle Lavorazioni selezionate in: <strong>In lavorazione </strong> <i class="fa fa-clock-o" aria-hidden="true"></i></button>
								 <button type="submit"
									class="col-md-1 btn btn-danger"
									onclick="if(confirm('Sei sicuro di voler eliminare definitivamente queste lavorazioni dal database?')){submitForm('gestlavorazioni?cmd=elimina')}else{return false}">
									<i class="fa fa-trash" aria-hidden="true"></i> Elimina lavorazioni selezionate
								</button>
								<%} %>
									<h3 class="block-title text-right"></h3>
									<button type="button" class="col-md-3 btn btn-outline-primary" data-target="#chooseEntries" data-toggle="modal"
									data-id="visualizzaLavorazioni.jsp" id="changeEntriesButton">
									<i class="fa fa-eye" aria-hidden="true"></i> Cambia numero
									righe
								</button>
						<thead>
									<h3 class="block-title" style="margin-top: 10px;">Esporta tabella:</h3>
							<tr>
							  <%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
								<th><input type="checkbox" id="checkboxAll"
									onclick='$(".check").prop("checked",$ (this).prop("checked"));'>Seleziona
									tutto</th>
								<%} %>
								<th>Dettagli</th>
								<th>Codice Lavorazione</th>
								<th>Stato Lavorazione</th>
								<th>Nome lavorazione</th>
								<th>Software della lavorazione</th>
								<th>Data Inizio</th>
								<th>Data Fine</th>
								<th>Costo Previsto</th>
								  <%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
								<th>Aggiorna</th>
								<%} %>
								<th>Personale coinvolto</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (i = 0; i < elenco.size(); i++) {
								l = (Lavorazione)elenco.get(i);
							%>
							<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
							<tr>
							  <%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
								<td>
								<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
								<input type="checkbox" class="check" name="check"
									value="<%=l.getCodLavorazione()%>">
								<%}//chiudo primo if
								else if(db.verificaLavorazioneResponsabile(l.getCodSoftware(), user.getCodiceDipendente())==1 && user.getQualificaProfessionale().equals("Responsabile")) {%>
								<!-- il responsabile può manipolare solamente le lavorazioni di cui è responsabile -->
								<input type="checkbox" class="check" name="check"
									value="<%=l.getCodLavorazione()%>">
								<%} %>	
								
									</td>
									<%} %>
								<td><a
									href="gestlavorazioni?cmd=dettagli&id=<%=l.getCodLavorazione()%>"><i
										class="fa fa-info-circle" aria-hidden="true"></i></a></td>
								<td><%=l.getCodLavorazione()%></td>
								 <%if(l.getStato().equals("In lavorazione")){ %>
							    <td class="btn-primary"><%=l.getStato()%> <i class="fa fa-gears"></i> </td>
							    <%}else if(l.getStato().equals("Non eseguita")){ %>
							    <td class="btn-warning"><%=l.getStato()%> <i class="fa fa-times-circle"></i> </td>
							    <%}else if(l.getStato().equals("Eseguita")){%>
							    <td class="btn-success"><%=l.getStato()%> <i class="fa fa-check-square"></i> </td>
							    <%}%>
								<td><%=l.getNome()%></td>
								<td><%=db.getSoftwareName(String.valueOf(l.getCodSoftware()))%></td>
								<td><%=l.getDataInizio()%></td>
								<%if(l.getDataFine()==null){%> <td>lavorazione non conclusa... <br> <strong>DATA FINE PREVISTA:<%=db.getDataFinePrevista(l.getDataInizio(), db.getGiorniUomoSoftware(l.getCodSoftware()))%></strong></td><%}else{%>
								<td><%=l.getDataFine()%></td><%}%>
								<td>€<%=db.getCostoSoftware(l.getCodSoftware())%></td>
								 <%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente") || user.getQualificaProfessionale().equals("Responsabile")){%>
								<td>
								<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
								<a href="gestlavorazioni?cmd=aggiorna&id=<%=l.getCodLavorazione()%>"><i class="fa fa-pencil" aria-hidden="true"></i></a>
								<%}//chiudo primo if
								else if(db.verificaLavorazioneResponsabile(l.getCodSoftware(), user.getCodiceDipendente())==1 && user.getQualificaProfessionale().equals("Responsabile")) {%>
								<!-- il responsabile può manipolare solamente le lavorazioni di cui è responsabile -->
								<a href="gestlavorazioni?cmd=aggiorna&id=<%=l.getCodLavorazione()%>"><i class="fa fa-pencil" aria-hidden="true"></i></a>
								<%} %>	
									</td>
									<%} %>												
							    <td><a class="btn btn-alt-primary" href="gestpersonale?cmd=viewall&id=<%=l.getCodLavorazione()%>">Visualizza personale coinvolto <i class="fa fa-wrench mr-5"></i></a></td>
							</tr>
							<%}else if(db.verificaLavorazioneDipendente(user.getCodiceDipendente(), l.getCodLavorazione())==1){%>
								<td><a href="gestlavorazioni?cmd=dettagli&id=<%=l.getCodLavorazione()%>"><i class="fa fa-info-circle" aria-hidden="true"></i></a></td>
								<td><%=l.getCodLavorazione()%></td>
								<%if(l.getStato().equals("In lavorazione")){ %>
							    <td class="btn-primary"><%=l.getStato()%> <i class="fa fa-gears"></i> </td>
							    <%}else if(l.getStato().equals("Non eseguita")){ %>
							    <td class="btn-warning"><%=l.getStato()%> <i class="fa fa-times-circle"></i> </td>
							    <%}else if(l.getStato().equals("Eseguita")){%>
							    <td class="btn-success"><%=l.getStato()%> <i class="fa fa-check-square"></i> </td>
							    <%}%>
								<td><%=l.getNome()%></td>
								<td><%=db.getSoftwareName(String.valueOf(l.getCodSoftware()))%></td>
									<td><%=l.getDataInizio()%></td>
								<%if(l.getDataFine()==null){%> <td>lavorazione non conclusa... <br> <strong>DATA FINE PREVISTA:<%=db.getDataFinePrevista(l.getDataInizio(), db.getGiorniUomoSoftware(l.getCodSoftware()))%></strong></td><%}else{%>
								<td><%=l.getDataFine()%></td><%}%>
								<td>€<%=db.getCostoSoftware(l.getCodSoftware())%></td>
								 <td><a class="btn btn-alt-primary" href="gestpersonale?cmd=viewall&id=<%=l.getCodLavorazione()%>">Visualizza personale coinvolto <i class="fa fa-wrench mr-5"></i></a></td>
							<%}%>
							<%} %>	
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