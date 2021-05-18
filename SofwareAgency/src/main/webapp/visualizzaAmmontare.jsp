<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
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
					<h1 class="h2 font-w700 text-white mb-10">Visualizza Ammontare Stipendi</h1>
					<h2 class="h4 font-w400 text-white-op mb-0">in questa sezione
						potrai vedere gli ammontare degli stipendi in base a qualifica professionale e anche nome professione.</h2>
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
					class="breadcrumb-item active">Visualizza Ammontare Stipendi</span>
			</nav>
		</div>
	</div>
	<!-- END Breadcrumb -->



	<!-- Page Content -->
	<div class="content">
		
		<!-- Dynamic Table Full -->
		<div class="block">
			<div class="block-header block-header-default">
				<h3 class="block-title">Tabella Ammontare Stipendi in base a qualifica professionale</h3>
					</div>
			<div class="table-responsive">
				<form id="form" method="post">
					<!-- DataTables -->
					<table class="table table-bordered table-striped table-vcenterd"
						id="dataTable" width="100%" cellspacing="0"
						data-page-length="-1">
						<thead>
							<div style="margin-bottom: 10px; margin-top: 20px;"></div>
							<tr>
								<th>Qualifica Professionale</th>
								<th>Ammontare Stipendi</th>
							</tr>
						</thead>
						<tbody>
							<sql:query var="ammontare" dataSource="${myDS}">
       							 SELECT SUM(stipendio) as stipendi,qualificaProfessionale from dipendenti GROUP BY qualificaProfessionale;
    						</sql:query>
							<c:forEach var="row" items="${ammontare.rows}">
								<tr>
									<td><c:out value="${row.qualificaProfessionale}" /></td>
									<td>€<c:out value="${row.stipendi}"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
			</div>
		</div>
		<!-- END Dynamic Table Full -->
		
		
		
		<!-- Dynamic Table Full -->
		<div class="block">
			<div class="block-header block-header-default">
				<h3 class="block-title">Tabella Ammontare Stipendi in base a Nome Professione</h3>
					</div>
			<div class="table-responsive">
				<form id="form" method="post">
					<!-- DataTables -->
					<table class="table table-bordered table-striped table-vcenterd"
						id="dataTable2"  width="100%" cellspacing="0"
						data-page-length="-1">
						<%request.getSession().setAttribute("numeroRighe", "10"); %>
						<thead>
							<div style="margin-bottom: 10px; margin-top: 20px;"></div>
							<tr>
								<th>Nome Professione</th>
								<th>Ammontare Stipendi</th>
							</tr>
						</thead>
						<tbody>
							<sql:query var="ammontare" dataSource="${myDS}">
       							 SELECT SUM(stipendio) as stipendi,nomeProfessione from dipendenti GROUP BY nomeProfessione;
    						</sql:query>
							<c:forEach var="row" items="${ammontare.rows}">
								<tr>
									<td><c:out value="${row.nomeProfessione}" /></td>
									<td>€<c:out value="${row.stipendi}"/></td>
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
</body>
</html>