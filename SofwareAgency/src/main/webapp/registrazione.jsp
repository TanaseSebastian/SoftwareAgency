<%@ page language="java" import="it.meucci.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
String messaggio = (String) session.getAttribute("MESSAGGIO");
if (messaggio == null)
	messaggio = "";
%>
<!doctype html>
<html lang="en" class="no-focus">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">

         <title>SeTech</title>

        <meta name="description" content="SeTech">
        <meta name="author" content="pixelcave">
        <meta name="robots" content="noindex, nofollow">

        <!-- Open Graph Meta -->
        <meta property="og:title" content="SeTech">
        <meta property="og:site_name" content="SeTech">
        <meta property="og:description" content="SeTech">
        <meta property="og:type" content="website">
        <meta property="og:url" content="">
        <meta property="og:image" content="">

        <!-- Icons -->
        <!-- The following icons can be replaced with your own, they are used by desktop and mobile browsers -->
        <link rel="shortcut icon" href="assets/media/favicons/logo.png.png">
        <link rel="icon" type="image/png" sizes="192x192" href="assets/media/favicons/logo.png">
        <link rel="apple-touch-icon" sizes="180x180" href="assets/media/favicons/logo.png">
        <!-- END Icons -->
        
        <!-- Stylesheets -->

        <!-- Fonts and Codebase framework -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito+Sans:300,400,400i,600,700&display=swap">
        <link rel="stylesheet" id="css-main" href="assets/css/codebase.min.css">

        <!-- You can include a specific file from css/themes/ folder to alter the default color theme of the template. eg: -->
        <!-- <link rel="stylesheet" id="css-theme" href="assets/css/themes/flat.min.css"> -->
        <!-- END Stylesheets -->
    </head>
    <body>
        <div id="page-container" class="main-content-boxed">

            <!-- Main Container -->
            <main id="main-container">

                <!-- Page Content -->
                <div class="bg-image" style="background-image: url('assets/media/photos/photo34@2x.jpg');">
                    <div class="row mx-0 bg-earth-op">
                        <div class="hero-static col-md-6 col-xl-8 d-none d-md-flex align-items-md-end">
                            <div class="p-30 invisible" data-toggle="appear">
                                <p class="font-size-h3 font-w600 text-white mb-5">
                                    Siamo molto contenti che stai per far parte della nostra famiglia!
                                </p>
                                <p class="font-size-h5 text-white">
                                    <i class="fa fa-angles-right"></i> Registra il tuo account e inzia a scoprire SeTech!
                                </p>
                                <p class="font-italic text-white-op">
                                    Copyright &copy; <span class="js-year-copy"></span>
                                </p>
                            </div>
                        </div>
                        <div class="hero-static col-md-6 col-xl-4 d-flex align-items-center bg-white">
                            <div class="content content-full">
                                <!-- Header -->
                                <div class="px-30 py-10">
                                    <a class="link-effect font-w700" href="login.jsp">
                                        <img style="height: 25px;"
							 src="assets/img/_logo.png"> <span
								class="font-size-xl text-dual-primary-dark">Se</span><span
								class="font-size-xl text-primary">Tech</span>
                                    </a>
                                    <h1 class="h3 font-w700 mt-30 mb-10">Registra nuovo account</h1>
                                    <h2 class="h5 font-w400 text-muted mb-0">Perfavore inserisci i tuoi dati</h2>
                                </div>
                                <!-- END Header -->

                                <!-- Sign Up Form -->
                                <!-- jQuery Validation functionality is initialized with .js-validation-signup class in js/pages/op_auth_signup.min.js which was auto compiled from _es6/pages/op_auth_signup.js -->
                                <!-- For more examples you can check out https://github.com/jzaefferer/jquery-validation -->
                                <form class="js-validation-signup px-30" action="gestlogin?cmd=register" method="post">
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <div class="form-material floating">
                                                <input type="text" class="form-control" id="username" name="username" required="required" title="perfavore inserisci un username valido,almeno 5 caratteri">
                                                <label for="signup-username">Username</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <div class="form-material floating">
                                                <input type="password" class="form-control" id="codiceRegistrazione" name="codiceRegistrazione" required="required" minlength="20" maxlength="20"  title="il codice deve contenere 20 caratteri">
                                                <label for="signup-password">Codice Registrazione</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" id="condizioni" name="condizioni" required="required" title="bisogna accettare i termini e condizioni.">
                                                <label for="condizioni">Accetto Termini &amp; Condizioni</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-sm btn-hero btn-alt-success">
                                            <i class="fa fa-plus mr-10"></i> Registra account
                                        </button>
                                         <%=messaggio%>
										<%request.getSession().setAttribute("MESSAGGIO", ""); %>
                                        <div class="mt-30">
                                            <a class="link-effect text-muted mr-10 mb-5 d-inline-block" href="#" data-toggle="modal" data-target="#modal-terms">
                                                <i class="fa fa-book text-muted mr-5"></i> Leggi Termini
                                            </a>
                                            <a class="link-effect text-muted mr-10 mb-5 d-inline-block" href="login.jsp">
                                                <i class="fa fa-user text-muted mr-5"></i> Vai al login
                                            </a>
                                        </div>
                                    </div>
                                </form>
                                <!-- END Sign Up Form -->
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END Page Content -->

            </main>
            <!-- END Main Container -->
        </div>
        <!-- END Page Container -->

        <!-- Terms Modal -->
        <div class="modal fade" id="modal-terms" tabindex="-1" role="dialog" aria-labelledby="modal-terms" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-slidedown" role="document">
                <div class="modal-content">
                    <div class="block block-themed block-transparent mb-0">
                        <div class="block-header bg-primary-dark">
                            <h3 class="block-title">Termini &amp; Condizioni</h3>
                            <div class="block-options">
                                <button type="button" class="btn-block-option" data-dismiss="modal" aria-label="Close">
                                    <i class="si si-close"></i>
                                </button>
                            </div>
                        </div>
                        <div class="block-content">
                        <textarea rows="10" cols="80">Setech S.r.l.Società con unico socio – Direzione e  Coordinamento di Setech S.r.l. VIA CELDIT 2 – 12100 CUNEO – ITALIATEL. +39 0171 412470  FAX +39 0171 411826 chemicalcontrolsrl@eurofins.com www.eurofins.itCapitale sociale € 80.000 i.v. Registro delle imprese di Cuneo 00644710048 R.E.A. C.C.I.A.A. Cuneo 114739 Cod.Fiscale – Partita I.V.A. 00644710048Pag. 1 di 6 Termini e condizioni generali di fornitura di servizi (Italia) 1. Definizioni Nei presenti Termini e condizioni generali di fornitura di servizi, i seguenti termini avranno il significato di seguito loro attribuito: Campione/i: il  campione  e/o  materiale  consegnato  dal  Cliente  ad  ES  al  fine  di  sottoporlo  ad  esame  / analisi.Cliente: il soggetto che trasmette a ES un Ordine al fine di concludere con ES un contratto di prestazione di servizi. Contratto:  il  contratto  di  prestazione  di  servizi  di  volta  in  volta  concluso  fra  ES  ed  il  Cliente  ed assoggettato ai presenti Termini e Condizioni. ES: Eurofins Scientific Italia S.r.l. e/o le sue società controllate e collegate ai sensi dell’art. 2359 cod. civ. Modello d’Ordine: il modulo d’ordine predefinito di ES. Ordine: la richiesta che il Cliente indirizza a ES a mezzo del Modello d’Ordine od altrimenti, finalizzata adusufruire dei servizi offerti da ES. Parti: collettivamente ES ed il Cliente. Piano di Campionamento: il piano che precisa quali campioni di quali materie prime e prodotti finiti e con quale frequenza debbano essere analizzati da ES. Prezzo: il corrispettivo dei servizi resi da ES al Cliente ed oggetto del Contratto. Rapporto/i  di  Analisi: il  rapporto  contenente  i  risultati,  nonché  eventuali  interpretazioni,  valutazioni, consulenze e conclusioni delle analisi commissionate a ES dal Cliente. Termini e Condizioni: i presenti termini e condizioni generali di contratto di fornitura di servizi. 2. Principi generali 2.1.  Tutti i Contratti intercorsi tra ES ed i Clienti sono regolati da questi Termini e Condizioni.  2.2.  Un  Contratto  assoggettato  a  questi  Termini  e Condizioni  si  considera  perfezionato  quando  un Ordine  viene  accettato  da  ES.  Un  Ordine  è  considerato  come  accettato  da  ES  se  (a)  ES  inizia  a dare esecuzione a quell’Ordine, o (b) ES conferma l’Ordine per iscritto. 2.3.  Ciascun  Ordine  è  irrevocabile  e  costituisce  proposta  contrattuale  del  Cliente  e,  pertanto,  sarà vincolante  per  ES  solo  se  ed  in  quanto  dalla  stessa  accettato  con  le  modalità  di  cui  al  precedente articolo  2.2).  Ogni  Ordine  accettato  da  ES  sarà  considerato  come  un  autonomo  e  separato Contratto.  2.4.  ES si riserva la facoltà di modificare nel tempo i presenti Termini e Condizioni. A ciascun Contratto sono applicabili i Termini e Condizioni vigenti al momento della trasmissione dell’Ordine. 2.5.  Questi  Termini  e  Condizioni  sostituiscono  ogni  precedente  accordo,  verbalmente  o  per  iscritto, eventualmente   intercorso   tra   le   Parti   e   prevalgono su   ogni   disposizione   confliggente   od incompatibile  eventualmente  contenuta  in  successivi  accordi  intercorsi  tra  le  Parti,  salva  espressa previsione  scritta  di  deroga  ai  presenti  Termini  e Condizioni.  In  ogni  caso,  nessuna  modifica, rinuncia  o  alterazione  dei  presenti  Termini  e  Condizioni  è  vincolante  nei  confronti  di  ES,  se  non espressamente  approvata  da  ES.  Eventuali  condizioni  generali  di  acquisto  del  Cliente  non  sono accettate e comunque sono derogate in favore dei presenti Termini e Condizioni</textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-alt-secondary" data-dismiss="modal">Chiudi</button>
                        <button type="button" class="btn btn-alt-success" data-dismiss="modal">
                            <i class="fa fa-check"></i> Perfetto
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- END Terms Modal -->


        <!--
            Codebase JS Core

            Vital libraries and plugins used in all pages. You can choose to not include this file if you would like
            to handle those dependencies through webpack. Please check out assets/_es6/main/bootstrap.js for more info.

            If you like, you could also include them separately directly from the assets/js/core folder in the following
            order. That can come in handy if you would like to include a few of them (eg jQuery) from a CDN.

            assets/js/core/jquery.min.js
            assets/js/core/bootstrap.bundle.min.js
            assets/js/core/simplebar.min.js
            assets/js/core/jquery-scrollLock.min.js
            assets/js/core/jquery.appear.min.js
            assets/js/core/jquery.countTo.min.js
            assets/js/core/js.cookie.min.js
        -->
        <script src="assets/js/codebase.core.min.js"></script>

        <!--
            Codebase JS

            Custom functionality including Blocks/Layout API as well as other vital and optional helpers
            webpack is putting everything together at assets/_es6/main/app.js
        -->
        <script src="assets/js/codebase.app.min.js"></script>

        <!-- Page JS Plugins -->
        <script src="assets/js/plugins/jquery-validation/jquery.validate.min.js"></script>

        <!-- Page JS Code -->
        <script src="assets/js/pages/op_auth_signup.min.js"></script>
    </body>
</html>