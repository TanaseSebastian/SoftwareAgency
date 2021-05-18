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
					<h1 class="h2 font-w700 text-white mb-10">Visualizza Ordini</h1>
					<h2 class="h4 font-w400 text-white-op mb-0">in questa sezione
						potrai vedere tutti gli ordini eseguiti e in attesa.</h2>
					<br> <a type="button" class="btn btn-outline-success "
						href="nuovoCliente.jsp"> <i class="fa fa-plus"
						aria-hidden="true"></i> aggiungi un nuovo ordine
					</a>
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
					class="breadcrumb-item active">Visualizza Ordini</span>
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
				<h3 class="block-title">Tabella Ordini</h3>
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
								<button type="button"
									class="col-md-3 btn btn-outline-primary ml-10 "
									data-target="#chooseEntries" data-toggle="modal"
									data-id="visualizzaOrdini.jsp"
									id="changeEntriesButton">
									<i class="fa fa-eye" aria-hidden="true"></i> Cambia numero
									righe
							</div>
							<div style="margin-bottom: 10px; margin-top: 20px;"></div>
							<tr>
								<th>Codice Ordine</th>
								<th>Dettagli ordine</th>
								<th>Cliente</th>
								<th>Stato dell'ordine</th>
								<th>Data e ora emissione dell'ordine</th>
								<th>Descrizione</th>
								<th>Elimina</th>
								<th>Fattura</th>
							</tr>
						</thead>
						<tbody>
							<sql:query var="clienti" dataSource="${myDS}">
       							 SELECT * FROM ordini;
    						</sql:query>
							<c:forEach var="row" items="${clienti.rows}">
								<tr>
									<td><c:out value="${row.codOrdine}" /></td>
									<td><a href="gestordini?cmd=dettagli&id=${row.codOrdine}"s><i
										class="fa fa-info-circle" aria-hidden="true"></i></a></td>
										
									<c:set var="codOrdine" value="${row.codOrdine}"/>
									<% int codOrdine=(Integer)pageContext.getAttribute("codOrdine");%>
									
									<c:set var="codCliente" value="${row.codCliente}"/>
									<% int codCliente=(Integer)pageContext.getAttribute("codCliente");%>
									<td><%=db.getClienteName(codCliente)%></td>
									
									
									<c:set var="stato" value="${row.stato}"/>
									<% String stato=(String)pageContext.getAttribute("stato");%>									
									 <%if(stato.equals("In attesa")){ %>
							    <td class="btn-primary"><%=stato%> <i class="fa fa-gears"></i> </td>
							    <%}else if(stato.equals("Non eseguito")){ %>
							    <td class="btn-warning"><%=stato%> <i class="fa fa-times-circle"></i> </td>
							    <%}else if(stato.equals("Eseguito")){%>
							    <td class="btn-success"><%=stato%> <i class="fa fa-check-square"></i> </td>
							    <%}%>
								
									<td><c:out value="${row.dataOrdine}"/></td>
									<td><c:out value="${row.descrizione}"/>
									
									
									
									 <%if(stato.equals("In attesa")){ %>
							  <td><a href="gestordini?cmd=elimina&id=<%=codOrdine%>"
									class="btn btn-danger confirmation">
									<i class="fa fa-trash" aria-hidden="true"></i>
								</a></td>  
							    <%}else if(stato.equals("Non eseguito")){ %>
							  <td><a href="gestordini?cmd=elimina&id=<%=codOrdine%>"
									class="btn btn-danger confirmation">
									<i class="fa fa-trash" aria-hidden="true"></i>
								</a></td>   
							    <%}else if(stato.equals("Eseguito")){%>
							    <td><button type="button"
									class="btn">
									<i class="fa fa-trash" aria-hidden="true"></i>
								</button disabled></td> 
							    <%}%>
										
										<%if(stato.equals("Eseguito")){ %>
										 	<td>
										 	<a class="btn btn-alt-success" href="gestordini?cmd=visualizzaFattura&id=${row.codFattura}" target="_blank">Visualizza Fattura <i class="fa fa-file-text-o" aria-hidden="true"></i></a>
										 	<a class="btn btn-alt-danger" href="gestordini?cmd=fattura&id=<%=codOrdine%>" style="margin-top: 5px;">Storna fattura e crea una nuova<i class="fa fa-trash" aria-hidden="true"></i></a>
										 	</td>
											<%}else{%>
											<td><a class="btn btn-alt-primary" href="gestordini?cmd=fattura&id=<%=codOrdine%>">Crea fattura per questo ordine <i class="fa fa-file-text-o" aria-hidden="true"></i>
											</a></td>
											<%}%>
								</tr>
							</c:forEach>
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
<script type="text/javascript">
    $('.confirmation').on('click', function () {
        return confirm('Sei sicuro di voler eliminare questo ordine?');
    });
</script>
</body>
</html>