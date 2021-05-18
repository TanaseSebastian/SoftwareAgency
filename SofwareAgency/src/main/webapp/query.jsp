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
                                <h1 class="h2 font-w700 text-white mb-10">  <i class="fa fa-plus text-muted mr-5"></i>Ricerche avanzate</h1>
                                <h2 class="h4 font-w400 text-white-op mb-0"> Scegli il tipo di ricerca che preferisci!.</h2>
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
                            <span class="breadcrumb-item active">Ricerche avanzate</span>
                        </nav>
                    </div>
                </div>
                <!-- END Breadcrumb -->



                  <!-- Page Content -->
                  <div class="content">
                   <!-- Single Item -->
                    <h2 class="content-heading">Ricerche avanzate Query chieste dalla traccia d'esame</h2>
                    <div class="block">
                        <div class="block-header block-header-default">
                            <h3 class="block-title">Scegli la query che preferisci</h3>
                        </div>
                        <div class="block-content">
                            <div id="accordion" role="tablist" aria-multiselectable="true">
                                <div class="block block-bordered block-rounded mb-2">
                                    <div class="block-header" role="tab" id="accordion_h1">
                                        <a class="font-w600" data-toggle="collapse" data-parent="#accordion" href="#accordion_q1" aria-expanded="true" aria-controls="accordion_q1">Query n.1</a>
                                    </div>
                                    <div id="accordion_q1" class="collapse show" role="tabpanel" aria-labelledby="accordion_h1" data-parent="#accordion">
                                        <div class="block-content">
                                        <form action="gestquery?cmd=query1" method="post">
                                            <p>Elenco delle persone coinvolte nello sviluppo di un pacchetto software specificato.</p>
                                            <label for="software">Seleziona Software</label>
                                                <select class="form-control col-md-6" id="software" name="software">
                                                    <option selected="selected" hidden>Seleziona software</option>
                                                    <sql:query var="software" dataSource="${myDS}">
										   		    select * from software;
										    		</sql:query>
													<c:forEach var="row" items="${software.rows}">
													<option value="${row.codSoftware}"><c:out
													value="${row.nome}" /></option>
													</c:forEach>
                                                </select>
                                                
                                                 <!-- Form Submission -->
                             
		                                        <div class="form-group mt-10">
		                                            <button type="submit" class="btn btn-alt-success">
		                                                <i class="fa fa-eye mr-5"></i>
		                                                Visualizza persone coinvolte
		                                            </button>
		                                        </div>
                              
										</form>
                                        </div>
                                    </div>
                                </div>
                                <div class="block block-bordered block-rounded mb-2">
                                    <div class="block-header" role="tab" id="accordion_h2">
                                        <a class="font-w600" data-toggle="collapse" data-parent="#accordion" href="#accordion_q2" aria-expanded="true" aria-controls="accordion_q2">Query n.2</a>
                                    </div>
                                    <div id="accordion_q2" class="collapse" role="tabpanel" aria-labelledby="accordion_h2" data-parent="#accordion">
                                        <div class="block-content">
                                              <form action="gestquery?cmd=query2" method="post">
                                           <p>Elenco dei pacchetti software terminati in un periodo di tempo, con nome pacchetto, data inizio, data fine, responsabile</p>     
                                                 <!-- Form Submission -->
		                                        <div class="form-group mt-10">
		                                         <label>Data Inizio</label> <input type="date" name="inizio">
		                                         <label>Data Fine</label><input type="date" name="fine">
		                                            <button type="submit" class="btn btn-alt-success">
		                                                <i class="fa fa-eye mr-5"></i>
		                                                Visualizza pacchetti terminati
		                                            </button>
		                                        </div>
                              
										</form>
                                        </div>
                                    </div>
                                </div>
                                <div class="block block-bordered block-rounded mb-2">
                                    <div class="block-header" role="tab" id="accordion_h3">
                                        <a class="font-w600" data-toggle="collapse" data-parent="#accordion" href="#accordion_q3" aria-expanded="true" aria-controls="accordion_q3">Query n.3</a>
                                    </div>
                                    <div id="accordion_q3" class="collapse" role="tabpanel" aria-labelledby="accordion_h3" data-parent="#accordion">
                                        <div class="block-content">
                                                  <form action="gestquery?cmd=query3" method="post">
                                       			<p>Elenco dei pacchetti iniziati ma ancora non conclusi, con nome pacchetto,data inizio, costo previsto e numero giorni previsti.</p>
                                                 <!-- Form Submission -->
		                                        <div class="form-group mt-10">
		                                            <button type="submit" class="btn btn-alt-success">
		                                                <i class="fa fa-eye mr-5"></i>
		                                                Visualizza pacchetti software non conclusi
		                                            </button>
		                                        </div>
                              
										</form>
                                        </div>
                                    </div>
                                </div>
                                <div class="block block-bordered block-rounded mb-2">
                                    <div class="block-header" role="tab" id="accordion_h4">
                                        <a class="font-w600" data-toggle="collapse" data-parent="#accordion" href="#accordion_q4" aria-expanded="true" aria-controls="accordion_q4">Query n.4</a>
                                    </div>
                                    <div id="accordion_q4" class="collapse" role="tabpanel" aria-labelledby="accordion_h4" data-parent="#accordion">
                                        <div class="block-content">
											<form action="gestquery?cmd=query4" method="post">
                                       		 <p>Elenco del personale suddiviso per provincia in ordine di data nascita</p>
                                                 <!-- Form Submission -->
		                                        <div class="form-group mt-10">
		                                            <button type="submit" class="btn btn-alt-success">
		                                                <i class="fa fa-eye mr-5"></i>
		                                                Visualizza personale
		                                            </button>
		                                        </div>
										</form>
                                        </div>
                                    </div>
                                </div>
                                <div class="block block-bordered block-rounded">
                                    <div class="block-header" role="tab" id="accordion_h5">
                                        <a class="font-w600" data-toggle="collapse" data-parent="#accordion" href="#accordion_q5" aria-expanded="true" aria-controls="accordion_q5">Query 5</a>
                                    </div>
                                    <div id="accordion_q5" class="collapse" role="tabpanel" aria-labelledby="accordion_h5" data-parent="#accordion">
                                        <div class="block-content">
                                           <form action="visualizzaAmmontare.jsp">
                                            <p>Ammontare degli stipendi suddivisi per qualifica.</p>
                                            	<div class="form-group mt-10">
		                                            <button type="submit" class="btn btn-alt-success">
		                                                <i class="fa fa-eye mr-5"></i>
		                                                Visualizza ammontare degli stipendi
		                                            </button>
		                                        </div>
										</form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END Single Item -->

                </div>
                <!-- END Page Content -->

            </main>
            <!-- END Main Container -->


		<%@include file="footer.jsp"%>
        <%@include file="librerie.jsp"%>
    </body>
</html>