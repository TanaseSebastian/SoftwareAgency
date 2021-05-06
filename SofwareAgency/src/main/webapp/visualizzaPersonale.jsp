<%@ page language="java" import="java.util.*,it.meucci.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file= "header.jsp" %>
<%!
ArrayList<Dipendente> elenco;
int i;
Dipendente d;
%>
<%
	DBManager db=new DBManager();
	elenco = (ArrayList<Dipendente>)request.getAttribute("ELENCO_DIPENDENTI");
%>
    <!-- Main Container -->
    <main id="main-container">


     <!-- Hero -->
     <div class="bg-image" style="background-image: url('assets/media/photos/photo26@2x.jpg');">
                    <div class="bg-black-op-75">
                        <div class="content content-top content-full text-center">
                            <div class="py-20">
                                <h1 class="h2 font-w700 text-white mb-10">Elenco personale</h1>
                                <h2 class="h4 font-w400 text-white-op mb-0">Di seguito la lista di tutto il personale che compone l'azienda.</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END Hero -->

                <!-- Breadcrumb -->
                <div class="bg-body-light border-b">
                    <div class="content py-5 text-center">
                        <nav class="breadcrumb bg-body-light mb-0">
                            <a class="breadcrumb-item active" href="personale.jsp">Personale Aziendale</a>
                        </nav>
                    </div>
                </div>
                <!-- END Breadcrumb -->

<!-- Page Content -->
<div class="content">

                    <h2 class="content-heading">DataTables Plugin</h2>
                    

<!-- Dynamic Table Full -->
<div class="block">
    <div class="block-header block-header-default">
        <h3 class="block-title">Una volta selezionati i dipendenti interessati è possibile eliminarli tramite l'apposita funzione:</h3>
    </div>
    <div class="block-content block-content-full">
        <form action="" method="post" id="form">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" data-page-length=<%//=righe%>>
                                 <%request.getSession().setAttribute("numeroRighe", "10"); %>
                                 <button type="submit" class="col-md-3 btn btn-danger" onclick="if(confirm('Sei sicuro di voler eliminare definitivamente queste operazioni dal database?')){submitForm('gestutenti?cmd=elimina')}else{return false}">Elimina i clienti selezionati <i class="fa fa-trash"></i></button>
                                    <thead>
                                    <div style="margin-bottom: 10px; margin-top: 20px;"">
                                     <button type="button" class="col-md-3 btn btn-outline-primary ml-10 " data-target="#chooseEntries" data-toggle="modal" data-id="visualizzaClienti.jsp" id="changeEntriesButton">Cambia numero righe <i class="fa fa-eye" aria-hidden="true"></i>
                                     </button>
                                  </div>
                                        <tr>
                                        	<th><input type="checkbox" id="checkboxAll"> Seleziona tutto</th>
                                         	<th>Dettagli</th>
                                            <th>Codice Dipendente</th>
                                            <th>Full Name</th>
                                            <th>Qualifica</th>
                                            <th>Aggiorna</th>
                                           <!--  <th>Fattura</th> -->
                                        </tr>
                                    </thead>
										<tbody>
										   <%										  
										  for(i=0;i<elenco.size();i++) 
										    {
											 d=(Dipendente)elenco.get(i);
										    
										 %>
										    <tr>
										    <td><input type="checkbox" class="check" name="check" value="<%=d.getCodiceDipendente()%>"></td>
										    <td><a href="gestutenti?cmd=visualizza&id=<%=d.getCodiceDipendente()%>"><i class="fa fa-info-circle"></i></a> </td>
										 	<td><%= d.getCodiceDipendente()%></td>
										 	<td><%= d.getCognome()+" "+d.getNome()%></td>
											<td><%= d.getQualificaProfessionale()%></td>
										 	<td><a href="gestutenti?cmd=aggiorna&id=<%=d.getCodiceDipendente()%>"><i class="fa fa-user-edit"></i></a></td>
										 	<!-- <td><a class="btn btn-outline-success" href="#">Crea fattura per questa prenotazione <i class="fas fa-file-invoice"></i></a></td> -->
										 </tr>
										 
										  <%
										     }
										 %>
										  </tbody>
                                </table>
                                <br>
                                </form>
    </div>
</div>
<!-- END Dynamic Table Full -->
</div>
<!-- END Page Content -->

</main>
<!-- END Main Container -->


        <!-- Terms Modal -->
        <div class="modal fade" id="modal-terms" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-popin">
                <div class="modal-content">
                    <div class="block block-themed block-transparent mb-0">
                        <div class="block-header bg-primary-dark">
                            <h3 class="block-title">Terms &amp; Conditions</h3>
                            <div class="block-options">
                                <button type="button" class="btn-block-option" data-dismiss="modal" aria-label="Close">
                                    <i class="si si-close"></i>
                                </button>
                            </div>
                        </div>
                        <div class="block-content">
                            <h4 class="mb-10">1. General</h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ultrices, justo vel imperdiet gravida, urna ligula hendrerit nibh, ac cursus nibh sapien in purus. Mauris tincidunt tincidunt turpis in porta. Integer fermentum tincidunt auctor.</p>
                            <h4 class="mb-10">2. Account</h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ultrices, justo vel imperdiet gravida, urna ligula hendrerit nibh, ac cursus nibh sapien in purus. Mauris tincidunt tincidunt turpis in porta. Integer fermentum tincidunt auctor.</p>
                            <h4 class="mb-10">3. Service</h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ultrices, justo vel imperdiet gravida, urna ligula hendrerit nibh, ac cursus nibh sapien in purus. Mauris tincidunt tincidunt turpis in porta. Integer fermentum tincidunt auctor.</p>
                            <h4 class="mb-10">4. Payments</h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ultrices, justo vel imperdiet gravida, urna ligula hendrerit nibh, ac cursus nibh sapien in purus. Mauris tincidunt tincidunt turpis in porta. Integer fermentum tincidunt auctor.</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-alt-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-alt-primary" data-dismiss="modal">
                            <i class="fa fa-check"></i> Ok
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- END Terms Modal -->




<%@include file= "footer.jsp" %>