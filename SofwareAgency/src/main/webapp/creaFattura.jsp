<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
  ArrayList<DettaglioOrdine> elenco;
  int i;
  DettaglioOrdine d;
%>
<%

	elenco = (ArrayList<DettaglioOrdine>)request.getAttribute("ELENCO_DETTAGLI");
	Ordine o=(Ordine)request.getAttribute("ORDINE");
	DettaglioOrdine d;
	DBManager db=new DBManager();
	Cliente c=db.getCliente(String.valueOf(o.getCodCliente()));
	float prezzoTotale=0;
%>
<%@include file="header.jsp"%>
  <!-- Main Container -->
            <main id="main-container">

             <!-- Hero -->
     <div class="bg-image" style="background-image: url('assets/media/photos/photo26@2x.jpg');">
                    <div class="bg-black-op-75">
                        <div class="content content-top content-full text-center">
                            <div class="py-20">
                                <h1 class="h2 font-w700 text-white mb-10">  <i class="fa fa-plus text-muted mr-5"></i>Crea fattura</h1>
                                <h2 class="h4 font-w400 text-white-op mb-0"> In questa sezione puoi creare la fattura dell'ordine n: <%=o.getCodOrdine() %>!</h2>
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
                            <a class="breadcrumb-item" href="visualizzaOrdini.jsp">Visualizza Ordini</a>
                            <span class="breadcrumb-item active">Crea fattura</span>
                        </nav>
                    </div>
                </div>
                <!-- END Breadcrumb -->



                  <!-- Page Content -->
                  <div class="content">
                    <div class="block block-rounded block-fx-shadow">
                        <div class="block-content">
                            <form action="gestordini?cmd=stampaFattura" method="POST">

                                <!-- Vital Info -->
                                <h2 class="content-heading text-black">Informazioni riguardante il cliente</h2>
                                 <div class="form-group row">
								<label class="col-lg-4 col-form-label" for="nome">Codice Ordine<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
								<input type="text" class="form-control" name="codiceOrdine"
								id="codiceOrdine" value="<%=o.getCodOrdine()%>"
								readonly="readonly">
								</div>
							</div>
                                <div class="form-group row">
								<label class="col-lg-4 col-form-label" for="nome">Codice Cliente<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
								<input type="text" class="form-control" name="codiceCliente"
								id="codiceCliente" value="<%=c.getCodCliente()%>"
								readonly="readonly">
								</div>
							</div>
                               <div class="form-group row">
								<label class="col-lg-4 col-form-label" for="nome">Nome azienda<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="nome" name="nome"
										placeholder="Inserisci il nome dell'azienda" required="required"
										title="Inserire il nome" value="<%=c.getNome()%>" readonly="readonly">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="indirizzo">Indirizzo
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="indirizzo"
										name="indirizzo" placeholder="Inserire l'indirizzo dell'azienda "
										required="required" title="inserire l'indirizzo" value="<%=c.getIndirizzo()%>" readonly="readonly">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="ragione">Ragione Sociale <span
									class="text-danger">*</span></label>
								<div class="col-lg-8">
									<input type="text" class="form-control" id="ragione" name="ragione"
										placeholder="inserire la ragione sociale dell'azienda" required="required"
										title="inserire la ragione sociale" value="<%=c.getRagioneSociale()%>" readonly="readonly">
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
										required="required" title="inserire partita iva" value="<%=c.getPartitaIva()%>" readonly="readonly">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="email">PEC/Email
									<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="email" class="form-control" id="email"
										name="email" placeholder="@example.com"
										required="required" title="inserire una email valida" value="<%=c.getPec()%>" readonly="readonly">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="username">Username<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
									<input type="text" class="form-control" 
										id="username" name="username" placeholder="inserire un username"
										required="required"
										title="inserire un username valido" value="<%=c.getUsername()%>" readonly="readonly">
								</div>
							</div>
                                <!-- END Vital Info -->
                                


 							<!-- software -->
                            <h2 class="content-heading text-black">Software acquistati dal cliente e che compongono l'ordine</h2>
                                
                                    
									<% 										  
										  for(i=0;i<elenco.size();i++) 
										    {
													d=(DettaglioOrdine)elenco.get(i);
													Software s=db.getSoftware(d.getCodSoftware());
																 %>

 							<div class="form-group row">
 							<%prezzoTotale+=Float.parseFloat(s.getCosto());%>
								<label class="col-lg-4 col-form-label" for="nome">codice Pacchetto Software: <%=s.getCodSoftware()%> <br> Nome Pacchetto Software: <%=s.getNome()%><span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
								 <div class="input-group">
													<div class="input-group-prepend">
														<span class="input-group-text"> <i class="fa fa-euro"></i>
														</span>
													</div>
														<input type="text" class="form-control form-control-lg" value="<%=s.getCosto()%>" readonly="readonly">
													</div>
								</div>
							</div>
							
												<%
																     }
															%>
                                				
                                				
													
													
													
													<div class="form-group row">
								<label class="col-lg-4 col-form-label" for="nome">Importo totale fattura:<span class="text-danger">*</span>
								</label>
								<div class="col-lg-8">
								<div class="input-group">
													<div class="input-group-prepend">
														<span class="input-group-text"> <i class="fa fa-euro"></i>
														</span>
													</div>
														<input type="text" class="form-control form-control-lg"  id="tot" name="tot" value="<%=prezzoTotale%>" readonly="readonly">
													</div>
								</div>
							</div>
													
                                				
                                				
                                <!-- END->
			
			
								<!-- Additional price -->
                                <h2 class="content-heading text-black"> Costi aggiuntivi (opzionale)</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            In questa sezione puoi inserire dei costi aggiuntivi alla fattura se necessario
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group">
                                            <label for="nomeaggiunta">Descrizione costo aggiuntivo (20 carratteri max)</label>
                                            <br>
                                            <input type="text" class="form-control form-control-lg" id="nomeaggiunta" name="nomeaggiunta" maxlength="20">
                                        </div>
                                        <div class="form-group">
                                            <label for="descrizione">Importo del costo aggiuntivo</label>
                                            <div class="input-group">
													<div class="input-group-prepend">
														<span class="input-group-text"> <i class="fa fa-euro"></i>
														</span>
													</div>
														<input type="number" name="aggiunta" id="aggiunta" class="form-control form-control-lg"min=0 max=9999999.99
											step=0.01>
													</div>
                                        </div>
                                        <div class="form-group" id="totalediv" name="totalediv">
                                            <label for="descrizione">Riepilogo Importo totale</label>
                                            <div class="input-group">
													<div class="input-group-prepend">
														<span class="input-group-text"> <i class="fa fa-euro"></i>
														</span>
													</div>
														<input type="number" class="form-control form-control-lg"min=0 max=9999999.99
											step=0.01 readonly="readonly" value="<%=prezzoTotale%>" id="totale" name="totale">
													</div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Additional price -->



				


 								<!-- Additional Info -->
                                <h2 class="content-heading text-black">Descrizione dell'ordine</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            Sezione che comprende la descrizione dell'ordine 
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group">
                                            <label for="descrizione">Descrizione</label>
                                            <textarea class="form-control form-control-lg" id="descrizione" name="descrizione" rows="8"  maxlength="255" readonly="readonly"><%=o.getDescrizione()%></textarea>
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
                                                	Inserisci Fattura
                                            </button>
                                        </div>
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
<script>
$(document).ready(function() {
	$("#totalediv").hide();
    $("#aggiunta").keyup(function() {
    	var totale1=$("#tot").val();
        var aggiunta = $(this).val();
        if(aggiunta<1){
        	$("#totalediv").hide();
        }else{
        var totale = parseFloat(aggiunta)+parseFloat(totale1);
        $("#totale").val(totale);
        $("#totalediv").show();
        }
    });
});
</script>
</body>
</html>