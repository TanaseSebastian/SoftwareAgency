<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@include file="header.jsp"%>
<%
	// Leggo le proprietà da file properties
	prop = obj.loadProperties("DB.properties");
	prop = obj.loadProperties("DB.properties");
	String userDB = prop.getProperty("Username");
	String pwDB = prop.getProperty("Pasword");
	Cliente c = (Cliente)request.getAttribute("CLIENTE");
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
					<h1 class="h2 font-w700 text-white mb-10">Aggiorna Cliente</h1>
					<h2 class="h4 font-w400 text-white-op mb-0">Modifica i campi e
						aggiorna il cliente .</h2>
				</div>
			</div>
		</div>
	</div>
	<!-- END Hero -->

	<!-- Breadcrumb -->
	<div class="bg-body-light border-b">
		<div class="content py-5 text-center">
			<nav class="breadcrumb bg-body-light mb-0">
				<a class="breadcrumb-item" href="visualizzaClienti">Visualizza Clienti</a>
				 <span class="breadcrumb-item active">Aggiorna Cliente</span>
			</nav>
		</div>
	</div>
	<!-- END Breadcrumb -->


		
	<!-- Page Content -->
	<div class="content">
		<!-- Bootstrap Forms Validation -->
		<div class="block">
			<div class="block-header block-header-default">
				<h3 class="block-title">Form Aggiorna Cliente</h3>
				<div class="block-options">
					<button type="button" class="btn-block-option">
						<i class="si si-wrench"></i>
					</button>
				</div>
			</div>
			<div class="block-content">
			<button type="submit" class="btn btn-outline-success"
					style="margin-left: 0%;" data-target="#resetPassword"
					data-toggle="modal">Modifica Password</button>
				<div class="row justify-content-center py-20">
					<div class="col-xl-6">
						<!-- jQuery Validation functionality is initialized in js/pages/be_forms_validation.min.js which was auto compiled from _es6/pages/be_forms_validation.js -->
						<!-- For more info and examples you can check out https://github.com/jzaefferer/jquery-validation -->
						<form class="js-validation-bootstrap"
							action="gestclienti?cmd=modifica" method="post">
							<%=messaggio%>
							<%request.getSession().setAttribute("MESSAGGIO", ""); %>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="nome">Nome azienda<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
								<input type="text" class="form-control" name="codiceCliente"
								id="codiceCliente" value="<%=c.getCodCliente()%>" hidden="hidden"
								readonly="readonly">
									<input type="text" class="form-control" id="nome" name="nome"
										placeholder="Inserisci il nome dell'azienda" required="required"
										title="Inserire il nome" value="<%=c.getNome()%>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="indirizzo">Indirizzo
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="indirizzo"
										name="indirizzo" placeholder="Inserire l'indirizzo dell'azienda "
										required="required" title="inserire l'indirizzo" value="<%=c.getIndirizzo()%>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="ragione">Ragione Sociale <span
									class="text-danger">*</span></label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="ragione" name="ragione"
										placeholder="inserire la ragione sociale dell'azienda" required="required"
										title="inserire la ragione sociale" value="<%=c.getRagioneSociale()%>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="iva">Partita IVA
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="iva"
										name="iva" placeholder="inserire partita iva dell'azienda"
										minlenght="11" maxlength="11"
										required="required" title="inserire partita iva" value="<%=c.getPartitaIva()%>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="email">PEC(preferibile)/Email valida
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="email" class="form-control" id="email"
										name="email" placeholder="@example.com"
										required="required" title="inserire una email valida" value="<%=c.getPec()%>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="username">Username<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" 
										id="username" name="username" placeholder="inserire un username"
										required="required"
										title="inserire un username valido" value="<%=c.getUsername()%>">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-lg-8 ml-auto">
									<button type="submit" class="btn btn-alt-primary">Aggiorna Cliente</button>
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



<!-- modulo per la modifica della password-->
<div class="modal" id="resetPassword" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4>Modifica Password dell'utente interessato.</h4>
			</div>
			<div class="modal-body">
				<form action="gestclienti?cmd=changepassword" method="post"
					id="form2">
					<div class="col-md-12 form-group">
						<div class="form-group mb-3">
							<input type="text" class="form-control" name="codiceCliente"
								id="codiceCliente" value="<%=c.getCodCliente()%>" hidden="hidden"
								readonly="readonly">
								<input type="text" class="form-control" name="id"
								id="id" value="<%=user.getCodiceDipendente()%>" hidden="hidden"
								readonly="readonly">
								<input type="text" class="form-control" hidden="hidden" name="email" id="email"
								value=<%=user.getEmail()%>> <label class="label"
								for="password">Password</label> <input type="password"
								name="password" id="password" class="form-control"
								placeholder="Inserisci Password"
								pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
								title="Deve contenere almeno un numero,una lettera maiuscola e una lettera minuscola, e deve essere composta da almeno 8 o più caratteri"
								required onchange='check_pass();' />
						</div>
						<div class="form-group mb-3">
							<label class="label" for="password">Conferma Password</label> <input
								type="password" name="confirm_password" id="confirm_password"
								class="form-control" placeholder="Conferma Password" required
								onchange='check_pass();' />
						</div>
					</div>
					<div class="text-center" style="margin-top: 30px;">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Annulla</button>
						<button type="submit" class="btn btn-primary" id="submit"
							name=submit>
							Modifica <i class="fa fa-arrow-right" aria-hidden="true"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>


<%@include file="footer.jsp"%>
<%@include file="librerie.jsp"%>
</body>
</html>