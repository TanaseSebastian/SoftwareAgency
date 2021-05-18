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
                                <h1 class="h2 font-w700 text-white mb-10">  <i class="fa fa-plus text-muted mr-5"></i>Nuova lavorazione</h1>
                                <h2 class="h4 font-w400 text-white-op mb-0"> inserisci le informazioni e aggiungi una nuova lavorazione!.</h2>
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
                            <form action="gestlavorazioni?cmd=nuovaLavorazione" method="POST">

                                <!-- Vital Info -->
                                <h2 class="content-heading text-black">Informazioni generali</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Presta attenzione in quanto questi sono i dati che si vedranno per prima.
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                  			 <div class="form-group">
                                                <label for="software">Software</label>
                                                <select class="form-control form-control-lg" id="software" name="software">
                                                 <%if(user.getAmministratore().equals("Y") || user.getQualificaProfessionale().equals("Dirigente")){%>
                                                    <option selected="selected" hidden>Seleziona software</option>
                                                    <sql:query var="software" dataSource="${myDS}">
										   		    select * from software WHERE software.codSoftware NOT IN (select lavorazioni.codSoftware from lavorazioni);
										    		</sql:query>
										    		<%}//chiudo primo if
													else if(user.getQualificaProfessionale().equals("Responsabile")) {%>
													<sql:query var="software" dataSource="${myDS}">
										   		    select * from software WHERE software.codResponsabile=<%=user.getCodiceDipendente()%> and software.codSoftware NOT IN (select lavorazioni.codSoftware from lavorazioni) 
										    		</sql:query>
													<%} %>
													<c:forEach var="row" items="${software.rows}">
													<option value="${row.codSoftware}"><c:out
													value="${row.nome}" /></option>
													</c:forEach>
                                                </select>
                                            </div>
                                        <div class="form-group">
                                            <label for="re-listing-name">Nome Lavorazione</label>
                                            <input type="text" class="form-control form-control-lg" id="nome" name="nome" placeholder="es: Implementazione software:Tieni il conto versione 1.0">
                                        </div>
                                        <div class="form-group">
                                            <label for="re-listing-address">Data Inizio Lavorazione</label>
                                            <input type="text" class="date form-control form-control-lg" id="inizio"
										name="inizio" placeholder="Anno-mese-giorno"
										required="required"
										title="inserire la data di nascita del dipendente">
                                        </div>
                                    </div>
                                </div>
                                <!-- END Vital Info -->

                                <!-- Additional Info -->
                                <h2 class="content-heading text-black">Descrizione della lavorazione</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Aggiungi una breve descrizione della lavorazione
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group">
                                            <label for="descrizione">Descrizione</label>
                                            <textarea class="form-control form-control-lg" id="descrizione" name="descrizione" rows="8" placeholder="es: l'obiettivo di questa lavorazione è implementare la prima versione del software:'Tieni il conto' creando un prodotto funzionante e vendibile nel mercato." maxlength="255"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Additional Info -->
                                
                                
                                
                                  <!-- responsabile Info -->
                                <h2 class="content-heading text-black">Integrazione con github (opzionale)</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Se desideri utilizzare github per questa implementazione,inserisci il link del repository.Darai la possibilità al personale coinvolto in questa lavorazione di accedervi direttamente.
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                 <label for="repository">Link github repository</label>
                                            	<input type="text" class="form-control form-control-lg" id="repository" name="repository" placeholder="Inserisci qui il link... ">
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
                                                Agiungi questa lavorazione
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