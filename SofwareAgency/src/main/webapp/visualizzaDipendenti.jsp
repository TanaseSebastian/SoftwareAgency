<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
  ArrayList<Dipendente> elenco;
  int i;
  Dipendente d;
%>
<%
String righe=(String)session.getAttribute("numeroRighe");
if(righe==null){
	righe="10";
}
	DBManager db=new DBManager();
	elenco = (ArrayList<Dipendente>)request.getAttribute("ELENCO_DIPENDENTI");
	String srcImmagineProfiloUtente="";
%>
<%@include file="header.jsp"%>
<!-- Main Container -->
<main id="main-container">




     <!-- Hero -->
     <div class="bg-image" style="background-image: url('assets/media/photos/photo26@2x.jpg');">
                    <div class="bg-black-op-75">
                        <div class="content content-top content-full text-center">
                            <div class="py-20">
                                <h1 class="h2 font-w700 text-white mb-10">Visualizza Dipendenti</h1>
                                <h2 class="h4 font-w400 text-white-op mb-0">in questa sezione potrai vedere tutto i dipendenti che compongono l'azienda .</h2>
                                <br>
                                
                                <%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
                               <!--  nuovo dipendente -->
                                <a type="button"
								class="btn btn-outline-success "
								href="nuovoDipendente.jsp"><i class="fa fa-plus"
									aria-hidden="true"></i> Inserisci nuovo dipendente</a>
							  <!-- nuovo dipendente -->
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
                        <a class="breadcrumb-item" href="dashboard.jsp">Dashboard</a>
                            <span class="breadcrumb-item active">Personale Aziendale</span>
                            <span class="breadcrumb-item active">Visualizza Dipendenti</span>
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
				<h3 class="block-title">
					Tabella Dipendenti
				</h3>
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
					<!-- elimina -->
					<div style="margin-bottom: 10px; margin-top: 20px;"">
							<button type="submit" class="col-md-3 btn btn-outline-danger ml-10 "
						onclick="if(confirm('Sei sicuro di voler eliminare definitivamente queste operazioni dal database?')){submitForm('gestutenti?cmd=elimina&tipo=dipendente')}else{return false}">
					<i class="fa fa-trash" aria-hidden="true"></i> Elimina i
									clienti selezionati
					</button>
					</div>
				   <!-- elimina -->
					<%}%>	
						
						<div style="margin-bottom: 10px; margin-top: 20px;"">
							<button type="button"
								class="col-md-3 btn btn-outline-primary ml-10 "
								data-target="#chooseEntries" data-toggle="modal"
								data-id="visualizzaDipendenti.jsp" id="changeEntriesButton"><i class="fa fa-eye" aria-hidden="true"></i> Cambia numero
									righe
						</div>
						<div style="margin-bottom: 10px; margin-top: 20px;"">
						</div>
						<tr>
						<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
							<th><input type="checkbox" id="checkboxAll" onclick='$(".check").prop("checked",$ (this).prop("checked"));'>Seleziona tutto</th>
							<%} %>
							<th>Immagine Profilo</th>
							<th>Dettagli</th>
							<th>Codice Dipendente</th>
							<th>Full Name</th>
							<th>Qualifica Professionale</th>
							<th>Nome Professione</th>
							<th>Stipendio</th>
							<th>Dipartimento</th>
							<th>Data Di Nascita</th>
							<th>Provincia</th>
							<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
							<th>Aggiorna</th>
							<%} %>
						</tr>
					</thead>
					<tbody>
						<% 										  
										  for(i=0;i<elenco.size();i++) 
										    {
											 d=(Dipendente)elenco.get(i);
										    
										 %>
						<tr>
							<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
 							<td><input type="checkbox" class="check" name="check" value="<%=d.getCodiceDipendente()%>"></td>
 							<%} %>
 							
 							<td>
								 								<%
								 							System.out.println(d.getImmagineProfilo());
								 							srcImmagineProfiloUtente="immaginiProfilo/"+d.getImmagineProfilo();
								 							System.out.println(srcImmagineProfiloUtente);
																	%>
 							<img class="img-avatar img-avatar32" src="<%=srcImmagineProfiloUtente%>">
 							</td>						
 							<td><a href="gestutenti?cmd=dettagli&id=<%=d.getCodiceDipendente()%>"><i class="fa fa-info-circle" aria-hidden="true"></i></a></td>
							<td><%=d.getCodiceDipendente()%></td>
							<td><%=d.getCognome()+" "+d.getNome()%></td>
							<td><%= d.getQualificaProfessionale()%></td>
							<td><%= d.getNomeProfessione()%></td>
							<td><%= "€"+d.getStipendio()%></td>
							<td><%= db.getNomeDipartimento(String.valueOf(d.getCodDipartimento()))%></td>
							<td><%=d.getDataNascita()%></td>
							<td><%=d.getProvincia()%></td>
							<%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
							<td><a href="gestutenti?cmd=aggiorna&tipoutente=dipendente&id=<%=d.getCodiceDipendente()%>"><i class="fa fa-pencil" aria-hidden="true"></i></a></td>
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