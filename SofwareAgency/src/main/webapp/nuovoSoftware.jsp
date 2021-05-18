<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@include file= "header.jsp"%>
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
     <div class="bg-image" style="background-image: url('assets/media/photos/photo26@2x.jpg');">
                    <div class="bg-black-op-75">
                        <div class="content content-top content-full text-center">
                            <div class="py-20">
                                <h1 class="h2 font-w700 text-white mb-10">  <i class="fa fa-plus text-muted mr-5"></i>Nuovo Software</h1>
                                <h2 class="h4 font-w400 text-white-op mb-0"> inserisci le informazioni e aggiungi un nuovo software !.</h2>
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
                            <a class="breadcrumb-item" href="visualizzaPacchetti.jsp">Pacchetti software</a>
                            <span class="breadcrumb-item active">Nuovo Software</span>
                        </nav>
                    </div>
                </div>
                <!-- END Breadcrumb -->



                  <!-- Page Content -->
                  <div class="content">
                    <div class="block block-rounded block-fx-shadow">
                        <div class="block-content">
                            <form action="gestsoftware?cmd=nuovoSoftware" method="POST">

                                <!-- Vital Info -->
                                <h2 class="content-heading text-black">Informazioni generali</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Presta attenzione in quanto questi sono i dati che i clienti vedranno per prima.
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group">
                                            <label for="re-listing-name">Nome</label>
                                            <input type="text" class="form-control form-control-lg" id="nome" name="nome" placeholder="es: Tieni il conto ">
                                        </div>
                                        <div class="form-group">
                                            <label for="re-listing-address">Tempo in termini di Giorni/Uomo</label>
                                            <input type="number" class="form-control form-control-lg" id="tempo" name="tempo" placeholder="es: 450" min="10">
                                        </div>
                                        <div class="form-group">
                                           <label for="stipendio">Costo del pacchetto software (IVA esclusa)</label>
										
											<div class="input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"> <i class="fa fa-euro"></i>
													</span>
												</div>
												<input type="number" class="form-control" id="costo"
													name="costo" placeholder="1500.00" min=0 max=9999999.99
													step=0.01 required="required"
													title="inserire il costo del software">
											
										</div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Vital Info -->

                                <!-- Additional Info -->
                                <h2 class="content-heading text-black">Descrizione del software</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Aggiungi una breve descrizione del pacchetto software
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group">
                                            <label for="re-listing-description">Descrizione</label>
                                            <textarea class="form-control form-control-lg" id="descrizione" name="descrizione" rows="8" placeholder="es: Tieni il conto è un pacchetto software gestionale pensato per le PMI capace di risolvere tutte le esigenze,in modo pratico e veloce, riguardanti la contabilità e la fatturazione elettronica." maxlength="255"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Additional Info -->
                                
                                
                                
                                  <!-- responsabile Info -->
                                <h2 class="content-heading text-black">Responsabile pacchetto software</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Scegli il Project Manager più adatto per questo software.Gestirà le lavorazioni e guiderà il team di sviluppo nell' implementazione,aggiornamento e manutenzione del software.
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                <label for="re-listing-bedrooms">Project Manager</label>
                                                <select class="form-control form-control-lg" id="responsabile" name="responsabile">
                                                    <!--   se la persona è un amministratore o dirigente può inserire qualsiasi amministratore -->
                                                      <%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
                                                    <option selected="selected" hidden>Seleziona</option>
                                                    <sql:query var="manager" dataSource="${myDS}">
										   		    select * from dipendenti Where codDipartimento=2 and qualificaProfessionale="Responsabile";
										    		</sql:query>
										    		<%}//chiudo primo if
													else if(user.getQualificaProfessionale().equals("Responsabile")) {%>
													<!-- il responsabile può inserire solamente un software di cui è responsabile -->
													 <sql:query var="manager" dataSource="${myDS}">
										   		    select * from dipendenti Where codiceDipendente=<%=user.getCodiceDipendente() %>;
										    		</sql:query>
													<%} %>
													<c:forEach var="row" items="${manager.rows}">
													<option value="${row.codiceDipendente}"><c:out
													value="${row.cognome} ${row.nome}" /></option>
													</c:forEach>
                                                </select>
                                            </div>
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
                                                Agiungi questo software
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
        <%@include file="librerie.jsp"%>
    </body>
</html>