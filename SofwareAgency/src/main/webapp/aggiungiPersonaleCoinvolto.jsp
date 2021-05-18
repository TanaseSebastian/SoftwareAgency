<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@include file="header.jsp"%>
<%
// Leggo le proprietà da file properties
prop = obj.loadProperties("DB.properties");
String userDB = prop.getProperty("Username");
String pwDB = prop.getProperty("Pasword");
%>
<%
String righe=(String)session.getAttribute("numeroRighe");
if(righe==null){
	righe="10";
}
	DBManager db=new DBManager();
	String codiceLavorazione = (String)request.getAttribute("codiceLavorazione");
	String dipartimento = (String)request.getAttribute("dipartimento");
	System.out.println("codice lavorazione: "+codiceLavorazione);
	System.out.println("dipartimento scelto: "+dipartimento);
%>

<style>
#dataTable_wrapper {
    height: 80vh;
}
</style>


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
					<h1 class="h2 font-w700 text-white mb-10">Aggiungi il personale desiderato</h1>
					<h2 class="h4 font-w400 text-white-op mb-0">Indica il personale da inserire,successivamente 'aggiungi personale scelto'.</h2>
					<br>
					<a type="button" class="btn btn-primary"
						data-target="#chooseDepartment" data-toggle="modal">
						<i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i> Torna indietro
					</a>
				</div>
			</div>
		</div>
	</div>
	<!-- END Hero -->
	
	<!-- Page Content -->
	<div class="content">

		<%=messaggio%>
		<%request.getSession().setAttribute("MESSAGGIO", ""); %>
			
			<div class="row">
			<button type="submit"
				class="col-md-12 btn btn-success btn-lg "
				onclick="if(confirm('Sei sicuro di voler aggiungere questi utenti alla lavorazione?')){submitForm('gestpersonale?cmd=aggiungi')}else{return false}">
			<!-- 	onclick="if(confirm('Sei sicuro di voler aggiungere questi dipendenti all'interno di questa lavorazione?')){submitForm('gestpersonale?cmd=aggiungi')}else{return false}"> -->
				<i class="fa fa-plus" aria-hidden="true"></i> Aggiungi personale scelto
			</button>
			</div>
		 					

	 <!-- Checkable Table (.js-table-checkable class is initialized in Helpers.tableToolsCheckable()) -->
                   <h2 class="content-heading">Tabella del personale disponibile REPARTO: <%=db.getNomeDipartimento(dipartimento) %></h2>
                   
                        <div class="table-responsive">
                        <form id="form" method="post">
                         <input type="text" id="idLavorazione" name="idLavorazione" value="<%=codiceLavorazione%>" hidden>
                            <!-- If you put a checkbox in thead section, it will automatically toggle all tbody section checkboxes -->
                            <table class="js-table-checkable table table-hover" id="dataTable" cellspacing="0"
						data-page-length='-1'>
                                <thead>
                                    <tr>
                                        <th class="text-center">
                                            <label class="css-control css-control-primary css-checkbox py-0">
                                                <input type="checkbox" class="css-control-input" name="check-all" id="checkboxAll"
												onclick='$(".check").prop("checked",$ (this).prop("checked"));'>
                                                <span class="css-control-indicator"></span>
                                            </label>
                                        </th>
                                        <th class="d-none d-sm-table-cell" style="width: 35%;">Nome&Professione</th>
                                        <th class="d-none d-sm-table-cell" style="width: 25%;">Email</th>
                                        <th class="d-none d-sm-table-cell" style="width: 10%;">Phone</th>
                                        <th class="d-none d-sm-table-cell" style="width: 10%;">Anni di Anzianita'</th>
                                        <th class="d-none d-sm-table-cell" style="width: 10%;">Provincia di Residenza</th>
                                    </tr>
                                </thead>
                                <tbody>
                                
                                	<sql:query var="dottori" dataSource="${myDS}">
								        SELECT * from dipendenti where codDipartimento=<%=dipartimento%> and codiceDipendente NOT IN(SELECT personale_coinvolto.codDipendente from personale_coinvolto WHERE personale_coinvolto.codLavorazione=<%=codiceLavorazione%>) 
								    </sql:query>
                                
                                	<c:forEach var="row" items="${dottori.rows}">
									 <tr>
                                        <td class="text-center">
                                            <label class="css-control css-control-primary css-checkbox">
                                                <input type="checkbox" class="css-control-input check" name="check" value="${row.codiceDipendente}">
                                                <span class="css-control-indicator"></span>
                                            </label>
                                        </td>
                                        <td>
                                            <p class="font-w600 mb-10"><c:out value="${row.cognome} ${row.nome} Codice Fiscale:${row.cf}"/></p>
                                            <p class="text-muted mb-0"><c:out value="Professione: ${row.nomeProfessione}"/></p>
                                        </td>
                                        <td class="d-none d-sm-table-cell">
                                            <span class="badge badge-primary"><c:out value="${row.email}"/></span>
                                        </td>
                                        <td class="d-none d-sm-table-cell">
                                            <em class="text-muted"><c:out value="${row.phone}"/></em>
                                        </td>
                                        <td class="d-none d-sm-table-cell">
                                            <em class="text-muted"><c:out value="${row.anniAnzianita}"/></em>
                                        </td>
                                        <td class="d-none d-sm-table-cell">
                                            <em class="text-muted"><c:out value="${row.provincia}"/></em>
                                        </td>
                                    </tr>
								</c:forEach>
								</tbody>
                            </table>
                            <form>
                        </div>
                    
                    <!-- END Checkable Table -->
	</div>
	<!-- END Page Content -->

</main>
<!-- END Main Container -->

<%@include file="footer.jsp"%>
<%@include file="librerie.jsp"%>
</body>
</html>