<%@ page language="java" import="java.util.*,it.meucci.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@include file= "header.jsp" %>
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
                                <h1 class="h2 font-w700 text-white mb-10">Nuovo Dipendente</h1>
                                <h2 class="h4 font-w400 text-white-op mb-0">Completa i campi e inserisci un nuovo dipendente .</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END Hero -->

                <!-- Breadcrumb -->
                <div class="bg-body-light border-b">
                    <div class="content py-5 text-center">
                        <nav class="breadcrumb bg-body-light mb-0">
                            <a class="breadcrumb-item" href="personale.jsp">Personale Aziendale</a>
                            <span class="breadcrumb-item active">Nuovo Dipendente</span>
                        </nav>
                    </div>
                </div>
                <!-- END Breadcrumb -->

<!-- Page Content -->
<div class="content">
   <!-- Bootstrap Forms Validation -->
                    <div class="block">
                        <div class="block-header block-header-default">
                            <h3 class="block-title">Form Nuovo Dipendente</h3>
                            <div class="block-options">
                                <button type="button" class="btn-block-option">
                                    <i class="si si-wrench"></i>
                                </button>
                            </div>
                        </div>
                        <div class="block-content">
                            <div class="row justify-content-center py-20">
                                <div class="col-xl-6">
                                    <!-- jQuery Validation functionality is initialized in js/pages/be_forms_validation.min.js which was auto compiled from _es6/pages/be_forms_validation.js -->
                                    <!-- For more info and examples you can check out https://github.com/jzaefferer/jquery-validation -->
                                    <form class="js-validation-bootstrap" action="gestutenti?cmd=nuovoDipendente" method="post">
                                         <%=messaggio%>
                                         <%request.getSession().setAttribute("MESSAGGIO", ""); %>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="cf">Codice Fiscale <span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" id="cf" name="cf" placeholder="Inserisci il codice fiscale"  required="required" minlength="16" maxlength="16" title="Inserire un codice fiscale valido">
                                            </div>
                                        </div>
                                          <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="cognome">Cognome <span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" id="cognome" name="cognome" placeholder="Inserire il cognome" required="required" title="inserire un cognome">
                                            </div>
                                        </div>
                                         <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="nome">Nome <span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" id="nome" name="nome" placeholder="inserire il nome" required="required" title="inserire un nome">
                                            </div>
                                        </div>
                                         <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="username">Username <span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" id="username" name="username" placeholder="inserire username" required="required" title="inserire un username">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="email">Email <span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                                <input type="email" class="form-control" id="email" name="email" placeholder="Inserire l'email" required="required" title="inserire una email valida">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="phone">Numero cellulare <span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" pattern="[0-9]+" id="phone" name="phone" placeholder="3400000000" minlenght="10" maxlength="10" title="inserire un numero cellulare valido">
                                            </div>
                                        </div>
                                         <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="dipartimento">Dipartimento<span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                            <sql:query var="dipartimenti" dataSource="${myDS}">
										        SELECT * FROM Dipartimenti;
										    </sql:query>
                                                <select class="form-control" id="dipartimento" name="dipartimento" required="required" title="inserire un dipartimento d'appartenenza">
                                                    <option value="" hidden>Selezionare dipartimenti</option>
                                                    <c:forEach var="row" items="${dipartimenti.rows}">
															<option value="${row.codDipartimento}"><c:out value="${row.nome}"/></option>
													</c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="qualifica">Qualifica professionale <span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                                <select class="form-control" id="qualifica" name="qualifica" required="required" title="inserire una qualifica">
                                                    <option value="" hidden>Selezionare qualifica</option>
                                                    <option value="Dirigente">Dirigente</option>
                                                    <option value="Responsabile">Responsabile</option>
                                                    <option value="Impiegato">Impiegato</option>
                                                    <option value="Operaio">Operaio</option>
                                                </select>
                                            </div>
                                        </div>
                                         <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="professione">Nome Professione <span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" id="professione" name="professione" placeholder="inserisci il nome completo  della professione" required="required" title="inserire il nome della professione">
                                            </div>
                                        </div>
                                          <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="assunzione">Data Assunzione <span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                               <input type="text" class="date col-lg-12" id="assunzione" name="assunzione" placeholder="Anno-mese-giorno" required="required" title="inserire la data dell'assunzione del dipendente">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="nascita">Data di Nascita <span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                               <input type="text" class="date col-lg-12" id="nascita" name="nascita" placeholder="Anno-mese-giorno" required="required" title="inserire la data di nascita del dipendente">
                                            </div>
                                        </div>
                                         <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="provincia">Provincia<span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                                <input type="text" class="form-control" id="provincia" name="provincia" placeholder="inserire la provincia" minlenght="2" maxlength="2" required="required" title="inserire una provincia">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                        <label class="col-lg-4 col-form-label" for="stipendio">Stipendio <span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text">
                                                            <i class="fa fa-euro"></i>
                                                        </span>
                                                    </div>
                                                     <input type="number" class="form-control" id="stipendio" name="stipendio" placeholder="25000.00" min=0 max=9999999.99  step=0.01  required="required" title="inserire lo stipendio del dipendente">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label">Amministratore<span class="text-danger">*</span></label>
                                            <div class="col-lg-8">
                                              <select class="form-control" id="amministratore" name="amministratore" required="required" title="inserire tipo dipendente">
                                                    <option value="" hidden>Selezionare privilegi</option>
                                                    <option value="N">Questo dipendente ha privilegi STANDARD</option>
                                                    <option value="Y">Questo dipendente ha i privilegi di AMMINISTRATORE</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-lg-8 ml-auto">
                                                <button type="submit" class="btn btn-alt-primary">Submit</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- Bootstrap Forms Validation -->
</div>
<!-- END Page Content -->

</main>
<!-- END Main Container -->

<%@include file= "footer.jsp" %>