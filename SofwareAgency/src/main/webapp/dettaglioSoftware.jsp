<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

	Software s = (Software)request.getAttribute("PACCHETTO_SOFTWARE");
	DBManager db=new DBManager();
%>
<%@include file="header.jsp"%>
<!-- Main Container -->
<main id="main-container">




	<!-- Hero -->
	<div class="bg-image"
		style="background-image: url('assets/media/photos/photo26@2x.jpg');">
		<div class="bg-black-op-75">
			<div class="content content-top content-full text-center">
				<div class="py-20">
					<h1 class="h2 font-w700 text-white mb-10">Dettaglio software</h1>
					<h2 class="h4 font-w400 text-white-op mb-0">in questa sezione
						vi sono tutte le informazioni riguardanti questo software .</h2>
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
				<a class="breadcrumb-item" href="gestsoftware?cmd=viewall">Pacchetti software</a>
				 <span class="breadcrumb-item active">Dettaglio Pacchetto software</span>
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
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group">
                                            <label for="re-listing-name">Nome</label>
                                            <input type="text" class="form-control form-control-lg" id="nome" name="nome" value="<%=s.getNome() %>" readonly="readonly">
                                        </div>
                                        <div class="form-group">
                                            <label for="re-listing-address">Tempo in termini di Giorni/Uomo</label>
                                            <input type="number" class="form-control form-control-lg" id="tempo" readonly="readonly" name="tempo" value="<%=s.getTempoGiorniUomo() %>" min="10">
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
													step=0.01 required="required" readonly="readonly" value="<%=s.getCosto() %>"
													>
											
										</div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Vital Info -->s

                                <!-- Additional Info -->
                                <h2 class="content-heading text-black">Descrizione del software</h2>
                                <div class="row items-push">
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group">
                                            <label for="re-listing-description">Descrizione</label>
                                            <textarea class="form-control form-control-lg" id="descrizione" name="descrizione" rows="8"  maxlength="255" readonly="readonly"><%=s.getDescrizione() %></textarea>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Additional Info -->
                                
                                
                                
                                  <!-- responsabile Info -->
                                <h2 class="content-heading text-black">Responsabile pacchetto software</h2>
                                <div class="row items-push">
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                <label for="re-listing-bedrooms">Project Manager</label>
                                                <select class="form-control form-control-lg" id="responsabile" name="responsabile">
                                                    <option selected="selected" hidden><%=db.getFullName(String.valueOf(s.getCodResponsabile()))%></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Additional Info -->
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