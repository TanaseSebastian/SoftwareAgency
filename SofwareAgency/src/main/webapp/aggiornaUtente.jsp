<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@include file="header.jsp"%>
<%
Dipendente d = (Dipendente) request.getAttribute("UTENTE");
String utente = (String) request.getAttribute("tipoutente");

// Leggo le proprietà da file properties
prop = obj.loadProperties("DB.properties");
prop = obj.loadProperties("DB.properties");
String userDB = prop.getProperty("Username");
String pwDB = prop.getProperty("Pasword");
DBManager db = new DBManager();
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
					<h1 class="h2 font-w700 text-white mb-10">
						Aggiorna
						<%=utente%></h1>
					<h2 class="h4 font-w400 text-white-op mb-0">
						Aggiorna i dati di
						<%=d.getCognome() + " " + d.getNome()%>
						.
					</h2>
				</div>
			</div>
		</div>
	</div>
	<!-- END Hero -->

	<!-- Breadcrumb -->
	<div class="bg-body-light border-b">
		<div class="content py-5 text-center">
			<nav class="breadcrumb bg-body-light mb-0">
				<a class="breadcrumb-item" href="dashboard.jsp">Dashboard</a> <a
					class="breadcrumb-item"
					href="gestutenti?cmd=viewall&tipo=<%=utente%>">Visualizza <%=utente%>/i
				</a> <span class="breadcrumb-item active">Nuovo <%=utente%></span>
			</nav>
		</div>
	</div>
	<!-- END Breadcrumb -->

	<!-- Page Content -->
	<div class="content">
		<!-- Bootstrap Forms Validation -->
		<div class="block">
			<div class="block-header block-header-default">
				<h3 class="block-title">Aggiornamento dati</h3>
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
							action="gestutenti?cmd=modifica&tipoutente=<%=utente%>"
							method="post">
							<%=messaggio%>
							<%
							request.getSession().setAttribute("MESSAGGIO", "");
							%>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="cf">Codice
									Fiscale <span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="cf" name="cf"
										value="<%=d.getCf()%>" readonly="readonly">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="cognome">Cognome
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="cognome"
										name="cognome" value="<%=d.getCognome()%>" readonly="readonly">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="nome">Nome <span
									class="text-danger">*</span></label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="nome" name="nome"
										value="<%=d.getNome()%>" readonly="readonly">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="username">Username
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="username"
										name="username" placeholder="inserire username"
										required="required" title="inserire un username"
										value="<%=d.getUsername()%>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="email">Email
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="email" class="form-control" id="email"
										name="email" placeholder="Inserire l'email"
										value="<%=d.getEmail()%>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="phone">Numero
									cellulare <span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" pattern="[0-9]+"
										id="phone" name="phone" placeholder="3400000000"
										minlenght="10" maxlength="10" value="<%=d.getPhone()%>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="dipartimento">Dipartimento<span
									class="text-danger">*</span></label>
								<div class="col-lg-8">
									<sql:query var="dipartimenti" dataSource="${myDS}">
										        SELECT * FROM Dipartimenti;
										    </sql:query>
									<select class="form-control" id="dipartimento"
										name="dipartimento" required="required"
										title="inserire un dipartimento d'appartenenza">
										<option value="<%=d.getCodDipartimento()%>"
											selected="selected">Dipartimento attuale
											d'appartenenza:
											<%=db.getNomeDipartimento(String.valueOf(d.getCodDipartimento()))%></option>
										<c:forEach var="row" items="${dipartimenti.rows}">
											<option value="${row.codDipartimento}"><c:out
													value="${row.nome}" /></option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="qualifica">Qualifica
									professionale <span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<select class="form-control" id="qualifica" name="qualifica"
										required="required" title="inserire una qualifica">
										<option value="<%=d.getQualificaProfessionale()%>"
											selected="selected">Qualifica attuale:
											<%=d.getQualificaProfessionale()%></option>
										<option value="Dirigente">Dirigente</option>
										<option value="Responsabile">Responsabile</option>
										<option value="Impiegato">Impiegato</option>
										<option value="Operaio">Operaio</option>
									</select>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="professione">Nome
									Professione <span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="professione"
										name="professione"
										placeholder="inserisci il nome completo  della professione"
										required="required" title="inserire il nome della professione"
										value="<%=d.getNomeProfessione()%>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="assunzione">Data
									Assunzione <span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="date col-lg-12" id="assunzione"
										name="assunzione" placeholder="Anno-mese-giorno"
										required="required"
										title="inserire la data dell'assunzione del dipendente"
										value="<%=d.getDataAssunzione()%>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="anni">Anni
									di anzianita' <span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<div class="input-group">
										<input type="number" class="form-control" id="anni"
											name="anni" min=0 max=100 required="required"
											title="inserire gli anni di anzianita'"
											value="<%=d.getAnniAnzianita()%>">
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="provincia">Provincia
									di residenza<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<select id="provincia" name="provincia">
										<option selected="selected" value="<%=d.getProvincia()%>">Provincia
											attuale:
											<%=d.getProvincia()%></option>
										<option value="ag">Agrigento</option>
										<option value="al">Alessandria</option>
										<option value="an">Ancona</option>
										<option value="ao">Aosta</option>
										<option value="ar">Arezzo</option>
										<option value="ap">Ascoli Piceno</option>
										<option value="at">Asti</option>
										<option value="av">Avellino</option>
										<option value="ba">Bari</option>
										<option value="bt">Barletta-Andria-Trani</option>
										<option value="bl">Belluno</option>
										<option value="bn">Benevento</option>
										<option value="bg">Bergamo</option>
										<option value="bi">Biella</option>
										<option value="bo">Bologna</option>
										<option value="bz">Bolzano</option>
										<option value="bs">Brescia</option>
										<option value="br">Brindisi</option>
										<option value="ca">Cagliari</option>
										<option value="cl">Caltanissetta</option>
										<option value="cb">Campobasso</option>
										<option value="ci">Carbonia-iglesias</option>
										<option value="ce">Caserta</option>
										<option value="ct">Catania</option>
										<option value="cz">Catanzaro</option>
										<option value="ch">Chieti</option>
										<option value="co">Como</option>
										<option value="cs">Cosenza</option>
										<option value="cr">Cremona</option>
										<option value="kr">Crotone</option>
										<option value="cn">Cuneo</option>
										<option value="en">Enna</option>
										<option value="fm">Fermo</option>
										<option value="fe">Ferrara</option>
										<option value="fi">Firenze</option>
										<option value="fg">Foggia</option>
										<option value="fc">Forl&igrave;-Cesena</option>
										<option value="fr">Frosinone</option>
										<option value="ge">Genova</option>
										<option value="go">Gorizia</option>
										<option value="gr">Grosseto</option>
										<option value="im">Imperia</option>
										<option value="is">Isernia</option>
										<option value="sp">La spezia</option>
										<option value="aq">L'aquila</option>
										<option value="lt">Latina</option>
										<option value="le">Lecce</option>
										<option value="lc">Lecco</option>
										<option value="li">Livorno</option>
										<option value="lo">Lodi</option>
										<option value="lu">Lucca</option>
										<option value="mc">Macerata</option>
										<option value="mn">Mantova</option>
										<option value="ms">Massa-Carrara</option>
										<option value="mt">Matera</option>
										<option value="vs">Medio Campidano</option>
										<option value="me">Messina</option>
										<option value="mi">Milano</option>
										<option value="mo">Modena</option>
										<option value="mb">Monza e della Brianza</option>
										<option value="na">Napoli</option>
										<option value="no">Novara</option>
										<option value="nu">Nuoro</option>
										<option value="og">Ogliastra</option>
										<option value="ot">Olbia-Tempio</option>
										<option value="or">Oristano</option>
										<option value="pd">Padova</option>
										<option value="pa">Palermo</option>
										<option value="pr">Parma</option>
										<option value="pv">Pavia</option>
										<option value="pg">Perugia</option>
										<option value="pu">Pesaro e Urbino</option>
										<option value="pe">Pescara</option>
										<option value="pc">Piacenza</option>
										<option value="pi">Pisa</option>
										<option value="pt">Pistoia</option>
										<option value="pn">Pordenone</option>
										<option value="pz">Potenza</option>
										<option value="po">Prato</option>
										<option value="rg">Ragusa</option>
										<option value="ra">Ravenna</option>
										<option value="rc">Reggio di Calabria</option>
										<option value="re">Reggio nell'Emilia</option>
										<option value="ri">Rieti</option>
										<option value="rn">Rimini</option>
										<option value="rm">Roma</option>
										<option value="ro">Rovigo</option>
										<option value="sa">Salerno</option>
										<option value="ss">Sassari</option>
										<option value="sv">Savona</option>
										<option value="si">Siena</option>
										<option value="sr">Siracusa</option>
										<option value="so">Sondrio</option>
										<option value="ta">Taranto</option>
										<option value="te">Teramo</option>
										<option value="tr">Terni</option>
										<option value="to">Torino</option>
										<option value="tp">Trapani</option>
										<option value="tn">Trento</option>
										<option value="tv">Treviso</option>
										<option value="ts">Trieste</option>
										<option value="ud">Udine</option>
										<option value="va">Varese</option>
										<option value="ve">Venezia</option>
										<option value="vb">Verbano-Cusio-Ossola</option>
										<option value="vc">Vercelli</option>
										<option value="vr">Verona</option>
										<option value="vv">Vibo valentia</option>
										<option value="vi">Vicenza</option>
										<option value="vt">Viterbo</option>
									</select>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="stipendio">Stipendio
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text"> <i class="fa fa-euro"></i>
											</span>
										</div>
										<input type="number" class="form-control" id="stipendio"
											name="stipendio" placeholder="25000.00" min=0 max=9999999.99
											step=0.01 required="required"
											title="inserire lo stipendio del dipendente"
											value="<%=d.getStipendio()%>">
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="amministratore">Amministratore
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<select class="form-control" id="amministratore"
										name="amministratore" required="required"
										title="inserire un tipo di privilegi">
										<option value="<%=d.getAmministratore()%>" selected="selected">Mantieni
											Privilegi attuali</option>
										<option value="N">Questo utente non ha privilegi di
											amministratore</option>
										<option value="Y">CONSENTO i privilegi di
											AMMINISTRATORE a questo utente</option>
									</select>
								</div>
							</div>
							<div class="form-group row">
								<div class="col-lg-8 ml-auto">
									<button type="submit" class="btn btn-alt-primary">
										Aggiorna
										<%=utente%></button>
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
				<form action="gestutenti?cmd=changepassword" method="post"
					id="form2">
					<div class="col-md-12 form-group">
						<div class="form-group mb-3">
								<input type="text" class="form-control" name="id"
								id="id" value="<%=d.getCodiceDipendente()%>" hidden="hidden"
								readonly="readonly">
								<input type="text" class="form-control" name="cf"
								id="cf" value="<%=d.getCf()%>" hidden="hidden"
								readonly="readonly">
								<input type="text" class="form-control" hidden="hidden" name="email" id="email"
								value=<%=d.getEmail()%>> <label class="label"
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