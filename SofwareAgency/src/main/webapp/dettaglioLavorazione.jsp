<%@ page language="java" import="java.util.*,it.meucci.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Lavorazione l = (Lavorazione)request.getAttribute("LAVORAZIONE");
	DBManager db=new DBManager();
	String datafine=l.getDataFine();
	if(datafine==null)
	datafine="data fine al momento non disponibile in quanto questa lavorazione è ancora in corso";
%>
<%@include file= "header.jsp"%>

            <!-- Main Container -->
            <main id="main-container">

             <!-- Hero -->
     <div class="bg-image" style="background-image: url('assets/media/photos/photo26@2x.jpg');">
                    <div class="bg-black-op-75">
                        <div class="content content-top content-full text-center">
                            <div class="py-20">
                                <h1 class="h2 font-w700 text-white mb-10">  <i class="fa fa-plus text-muted mr-5"></i>Dettaglio lavorazione</h1>
                                <h2 class="h4 font-w400 text-white-op mb-0"> Visualizza i dettagli di questa lavorazione</h2>
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
                            <a class="breadcrumb-item" href="gestlavorazioni?cmd=viewall">Lavorazioni Software</a>
                            <span class="breadcrumb-item active">Dettagli Lavorazione</span>
                        </nav>
                    </div>
                </div>
                <!-- END Breadcrumb -->



                  <!-- Page Content -->
                  <div class="content">
                    <div class="block block-rounded block-fx-shadow">
                        <div class="block-content">
                            <form action="gestlavorazioni?cmd=nuovaLavorazione" method="POST">

                                <!-- Vital Info -->
                                <h2 class="content-heading text-black">Informazioni generali</h2>
                                <div class="row items-push">
                                    <div class="col-lg-7 offset-lg-1">
                                   			<div class="form-group">
                                                <label for="codLavorazione">Codice Lavorazione</label>
                                                <input type="text" class="form-control form-control-lg" name="codLavorazione" value="<%=l.getCodLavorazione()%>" readonly="readonly">
                                            </div>
                                  			 <div class="form-group">
                                                <label for="software">Codice Software</label>
                                                <input type="text" class="form-control form-control-lg" id="codSoftware" name="codSoftware" readonly="readonly" value="<%=l.getCodSoftware()%>">
                                            </div>
                                             <div class="form-group">
                                                <label for="software">Nome Software</label>
                                                <input type="text" class="form-control form-control-lg" id="nomeSoftware" name="nomeSoftware" readonly="readonly" value="<%=db.getSoftwareName(String.valueOf(l.getCodSoftware()))%>">
                                            </div>
                                        <div class="form-group">
                                            <label for="re-listing-name">Nome Lavorazione</label>
                                            <input type="text" class="form-control form-control-lg" id="nome" name="nome" value="<%=l.getNome()%>">
                                        </div>
                                        <div class="form-group">
                                            <label for="re-listing-address">Data Inizio Lavorazione</label>
                                            <input type="text" class="form-control form-control-lg" id="inizio"
										name="inizio" value="<%=l.getDataInizio() %>" readonly="readonly">
                                        </div>
                                        <div class="form-group">
                                            <label for="re-listing-address">Data Fine Lavorazione</label>
                                            <input type="text" class="form-control form-control-lg" id="fine"
										name="fine" value="<%=datafine%>" readonly="readonly">
                                        </div>
                                    </div>
                                </div>
                                <!-- END Vital Info -->

                                <!-- Additional Info -->
                                <h2 class="content-heading text-black">Descrizione della lavorazione</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            breve descrizione della lavorazione
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group">
                                            <label for="descrizione">Descrizione</label>
                                            <textarea class="form-control form-control-lg" id="descrizione" name="descrizione" readonly="readonly" rows="8"  maxlength="255"><%=l.getDescrizione()%></textarea>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Additional Info -->
                                
                                
                                
                                  <!-- responsabile Info -->
                                <h2 class="content-heading text-black">Integrazione con github</h2>
                                <div class="row items-push">
                                    <div class="col-lg-3">
                                        <p class="text-muted">
                                            link del repository github.
                                        </p>
                                    </div>
                                    <div class="col-lg-7 offset-lg-1">
                                        <div class="form-group row">
                                            <div class="col-md-8">
                                                 <%if(l.getRepository()==null || l.getRepository().equals("") || l.getRepository().equals("#")){%>
                                                 <a id="repository" name="repository">Questa lavorazione non contiene link repository github</a>
                                                 <%}else{ %>
                                            	<a id="repository" name="repository" href="<%=l.getRepository()%>" target="_blank">Clicca qui per visualizzare il repositoy github di questa lavorazione</a>
                                            	<%} %>
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