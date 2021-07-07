<%@ page language="java" import="it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<!-- Main Container -->
<main id="main-container">
	<!-- Page Content -->
	<!-- User Info -->
	<div class="bg-image bg-image-bottom"
		style="background-image: url('assets/media/photos/photo13@2x.jpg');">
		<div class="bg-black-op-75 py-30">
			<div class="content content-full text-center">
				<!-- Avatar -->
				<div class="mb-15">
					<a class="img-link"> <img
						class="img-avatar img-avatar96 img-avatar-thumb"
						src="<%=srcImmagineProfilo%>">
					</a>
				</div>
				<!-- END Avatar -->

				<!-- Personal -->
				<h1 class="h3 text-white font-w700 mb-10"><%=user.getCognome() + " " + user.getNome()%></h1>
				<h2 class="h5 text-white-op">
					<%=user.getNomeProfessione()%> presso
					<a class="text-primary-light" href="javascript:void(0)">@SeTech</a>
				</h2>
				<!-- END Personal -->

				<!-- Actions -->
				<a href="dashboard.jsp"
					class="btn btn-rounded btn-hero btn-sm btn-alt-secondary mb-5">
					<i class="fa fa-arrow-left mr-5"></i> Torna alla dashboard
				</a>
				<!-- END Actions -->
			</div>
		</div>
	</div>
	<!-- END User Info -->

	<!-- Main Content -->
	<div class="content">
		<!-- User Profile -->
		<%=messaggio%>
		<%
		request.getSession().setAttribute("MESSAGGIO", "");
		%>
		<div class="block">
			<div class="block-header block-header-default">
				<h3 class="block-title">
					<i class="fa fa-user-circle mr-5 text-muted"></i> Modifica immagine
					profilo
				</h3>
			</div>
			<div class="block-content">
				<div class="row items-push">
					<div class="col-lg-3">
						<p class="text-muted">In questa sezione hai l'opportunita' di
							cambiare il tuo avatar! scegli una foto e aggiorna il profilo.Per
							visualizzare le modifiche bisogna riaccedere.</p>
					</div>
					<div class="col-lg-7 offset-lg-1">
						<div class="form-group row">
							<div class="col-md-10 col-xl-6">
								<div class="push">
									<img class="img-avatar" src="<%=srcImmagineProfilo%>"
										id="avatarImg" name="avatarImg" alt="">
								</div>
								<div class="custom-file">
									<form action="gestutenti?cmd=adminUpdateImage" method="POST"
										class="signin-form " enctype="multipart/form-data">
										<input type="text" class="form-control" name="codiceDipendente"
											id="codiceDipendente" value="<%=user.getCodiceDipendente()%>"
											readonly="readonly" hidden="hidden"> <label
											for="avatarNewImg" class="btn btn-primary"
											style="margin-top: 10px;"
											onclick="if(confirm('Attenzione,per poter salvare le modifiche successivamente cliccare su Aggiorna foto profilo')){}else{ return false }">Cambia
											foto profilo</label> <input type="file" id="avatarNewImg"
											name="avatarNewImg" accept="image/png, image/jpeg"
											multiple="false" hidden="hidden">
										<button type="submit" class="btn btn-outline-primary">Aggiorna
											foto profilo</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				</form>
			</div>
		</div>
		<!-- END User Profile -->


		<div class="block">
			<div class="block-header block-header-default">
				<h3 class="block-title">
					<i class="fa fa-user-circle mr-5 text-muted"></i> User Profile
				</h3>
			</div>
			<div class="col-lg-3">
						<p class="text-muted">In questa sezione puoi aggiornare i tuoi dati generali,subito dopo sarai rimandato sul login per riaccedere e visualizzare le modifiche da te assegnate.</p>
					</div>
			<div class="block-content">
				<form class="js-validation-bootstrap"
							action="gestutenti?cmd=aggiornaDati" method="post">
							<%=messaggio%>
							<%request.getSession().setAttribute("MESSAGGIO", ""); %>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="cf">Codice
									Fiscale <span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="cf" name="cf"
										value="<%=user.getCf()%>" readonly="readonly">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="cognome">Cognome
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="cognome"
										name="cognome" value="<%=user.getCognome()%>" readonly="readonly">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="nome">Nome <span
									class="text-danger">*</span></label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="nome" name="nome"
										 value="<%=user.getNome()%>" readonly="readonly">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="username">Username
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="username"
										name="username" placeholder="inserire username"
										required="required" title="inserire un username" value="<%=user.getUsername()%>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="email">Email
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="email" class="form-control" id="email"
										name="email" placeholder="Inserire l'email" value="<%=user.getEmail()%>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="phone">Numero
									cellulare <span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" pattern="[0-9]+"
										id="phone" name="phone" placeholder="3400000000"
										minlenght="10" maxlength="10" value="<%=user.getPhone()%>">
								</div>
							</div>
							
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="provincia">Provincia di residenza<span
									class="text-danger">*</span></label>
								<div class="col-lg-8">
									<select id="provincia" name="provincia">
									<option selected="selected" value="<%=user.getProvincia()%>">Provincia attuale: <%=user.getProvincia()%></option>
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
								<div class="col-lg-8 ml-auto">
									<button type="submit" class="btn btn-alt-primary">Aggiorna dati</button>
								</div>
							</div>
						</form>
			</div>
		</div>
		<!-- END User Profile -->


		<!-- Change Password -->
		<div class="block">
			<div class="block-header block-header-default">
				<h3 class="block-title">
					<i class="fa fa-asterisk mr-5 text-muted"></i> Change Password
				</h3>
			</div>
			<div class="block-content">
				<form class="js-validation-material" action="gestutenti?cmd=setPasswordOnly" method="post">
					<div class="row items-push">
										<div id="js-pw-strength2-container" class="form-group col-md-4">
											<div class="form-material">
												<input type="text" id="cf" name="cf" value="<%=user.getCf()%>" hidden>
												<input type="password"  class="js-pw-strength2 form-control" name="password" id="password" class="form-control" placeholder="Inserisci Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Deve contenere almeno un numero,una lettera maiuscola e una lettera minuscola, e deve essere composta da almeno 8 o più caratteri" required onchange='check_pass();'/>

											</div>
											<div
												class="js-pw-strength2-progress pw-strength-progress mt-5"></div>
											<p class="js-pw-strength2-feedback form-text"></p>
										</div>
										<div class="form-group col-md-4">
											<div class="form-material col-md-12">
												<input type="password" name="confirm_password" id="confirm_password" class="form-control" placeholder="Conferma Password" required onchange='check_pass();'/>
											</div>
										</div>
										<div class="form-group col-md-4">
											<button type="submit"
												class="btn btn-sm btn-hero btn-noborder btn-success mt-30" id="submit" name="submit" disabled>
												aggiorna password <i class="fa fa-check ml-5"></i>
											</button>
										</div>
					</div>
				</form>
			</div>
		</div>
		<!-- END Change Password -->
	</div>
	<!-- END Main Content -->
	<!-- END Page Content -->
</main>
<!-- END Main Container -->
<%@include file="footer.jsp"%>
<%@include file="librerie.jsp"%>
 <script type="text/javascript">
 function check_pass() {
	    if (document.getElementById('password').value ==
	            document.getElementById('confirm_password').value) {
	        document.getElementById('submit').disabled = false;
	    } else {
	        document.getElementById('submit').disabled = true;
	    }
	}
  </script>
</body>
</html>