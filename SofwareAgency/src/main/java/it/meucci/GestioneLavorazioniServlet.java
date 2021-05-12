package it.meucci;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Servlet implementation class GestioneLavorazioniServlet
 */
@WebServlet("/gestlavorazioni")
public class GestioneLavorazioniServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Logger logger = LogManager.getLogger(GestioneLavorazioniServlet.class);   
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneLavorazioniServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");
		DBManager db;

		//--------GESTIONE LAVORAZIONI----------------//
		if(comando.equals("viewall")) {
			ArrayList<Lavorazione> elenco= new ArrayList<Lavorazione>();
			try 
			{
				db= new DBManager();
				elenco=db.getLavorazioni();
				//ELENCO Lavorazioni
				db.close();
				request.setAttribute("ELENCO_LAVORAZIONI", elenco);
				RequestDispatcher rd = request.getRequestDispatcher("visualizzaLavorazioni.jsp");
				rd.forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("404.jsp");
				// TODO: handle exception
			}
		}



		//dettagli di una lavorazione
		else if(comando.equals("dettagli"))
		{
			String id= request.getParameter("id");
			Lavorazione l=new Lavorazione();
			try {
				db= new DBManager();
				l = db.getLavorazione(id);
				db.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//logger.info(p.toString());
			request.setAttribute("LAVORAZIONE", l);
			RequestDispatcher rd = request.getRequestDispatcher("dettaglioLavorazione.jsp");
			rd.forward(request, response);
		}


		//funzione che aggiorna i dati di una lavorazione
		else if(comando.equals("aggiorna"))
		{

			String id= request.getParameter("id");
			Lavorazione l=new Lavorazione();
			try {
				db= new DBManager();
				l = db.getLavorazione(id);
				db.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//System.out.println(p.toString());
			request.setAttribute("LAVORAZIONE", l);
			RequestDispatcher rd = request.getRequestDispatcher("aggiornaLavorazione.jsp");
			rd.forward(request, response);
		}

	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");;


		//----------------NUOVA LAVORAZIONE--------------------------//		
		if(comando.equals("nuovaLavorazione")) {
			Lavorazione l=new Lavorazione();
			l.setCodSoftware(Integer.parseInt(request.getParameter("software")));
			l.setNome(request.getParameter("nome"));
			l.setDataInizio(request.getParameter("inizio"));
			l.setDescrizione(request.getParameter("descrizione"));
			l.setRepository(request.getParameter("repository"));
			logger.info(l.toString());

			try { 
				DBManager db = new DBManager();
				db.insertLavorazione(l);
				logger.info("nuova lavorazione inserita con successo nel db");


				//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente
				String thankyoupage="<div class=\"jumbotron text-center\">\r\n"
						+ "  <h1 class=\"display-3\" style=\"color: green; font-weight: bold;\">La nuova lavorazione è stata registrata correttamente<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></h1>\r\n"
						+ "  <hr>\r\n"
						+ "</div>";

				request.getSession().setAttribute("MESSAGGIO", thankyoupage);
				response.sendRedirect("gestlavorazioni?cmd=viewall");
			}
			catch (Exception e)
			{
				e.printStackTrace();
				response.sendRedirect("404.jsp");
			}
		}

		else if(comando.equals("elimina")) {
			if(request.getParameterValues("check")==null) {
				System.out.println("nessun elemento selezionato");
			}
			else {
				String idLavorazioni[]=request.getParameterValues("check");
				logger.info("LAVORAZIONI DA ELIMINARE :");
				for(int i=0;i<idLavorazioni.length;i++) {
					System.out.println("ID Lavorazione = "+idLavorazioni[i]);
				}
				DBManager db;
				try {
					db = new DBManager();
					db.deletelavorazione(idLavorazioni);
					db.close();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			response.sendRedirect("gestlavorazioni?cmd=viewall");
		}


		//funzione che modifica la lavorazione		
		else if(comando.equals("modifica")) {

			//nuovo ogetto lavorazione
			Lavorazione l=new Lavorazione();
			//prendo il parametro datafine dalla request
			String datafine =request.getParameter("fine");
			//completo il restante degli attributi
			int codLavorazione=Integer.parseInt(request.getParameter("codLavorazione"));
			l.setCodLavorazione(codLavorazione);
			l.setCodSoftware(Integer.parseInt(request.getParameter("software")));
			l.setNome(request.getParameter("nome"));
			l.setDataInizio(request.getParameter("inizio"));
			l.setDescrizione(request.getParameter("descrizione"));
			l.setRepository(request.getParameter("repository"));
			
			//controllo se datafine devo o non devo manipolarla
			if(datafine.equals("noDataFine"))
				{//inizio if
				logger.info("data fine vuota per cui non la metto nell'aggiornamento");
				logger.info(l.toString());
						try { 
							//inizializzo db manager	  
							DBManager db=new DBManager();
							db.aggiornaLavorazioneSenzaDataFine(l);
							db.close();
							//div che contiene il messaggio di ringraziamento,ovvero il codice è stato eseguito correttamente 
							String modCorretto="<div class=\"jumbotron text-center\">\r\n"
									+ "<p class=\"lead\" style=\"color: green; font-weight: bold;\"> la lavorazione è stata modificato con successo!<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></p>\r\n"
									+ "<hr>\r\n" + "</div>";
							//rimando su visualizza lavorazioni con messaggio di operazione andata a buon fine
							request.getSession().setAttribute("MESSAGGIO", modCorretto);
							response.sendRedirect("gestlavorazioni?cmd=viewall");
							}
						catch(Exception e){
							//stampo solo su console tutto il stack trace in caso di errore
							e.printStackTrace();
							logger.info("Operazione non andata a buon fine");
							//scrivo div contenente  messaggio d'errore
							String errorpage="<div class=\"jumbotron text-center\">\r\n" +
									"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> non è possibile modificare la lavorazione.</h1>\r\n"
									+ "  <hr>\r\n" + "</div>";
							request.getSession().setAttribute("MESSAGGIO",errorpage);
							//lo rimando indietro
							response.sendRedirect("gestlavorazioni?cmd=aggiorna&id="+codLavorazione);
									
						}
				}//fine if
			
			else {
				logger.info("data fine non è null,per cui setto la variabile nell'ogetto lavorazione");
				l.setDataFine(datafine);
				logger.info(l.toString());
				logger.info("eseguo l'aggiornamento con data fine");
				try { 
					//inizializzo db manager	  
					DBManager db=new DBManager();
					db.aggiornaLavorazioneConDataFine(l);
					db.close();
					//div che contiene il messaggio di ringraziamento,ovvero il codice è stato eseguito correttamente 
					String modCorretto="<div class=\"jumbotron text-center\">\r\n"
							+ "<p class=\"lead\" style=\"color: green; font-weight: bold;\"> la lavorazione è stata modificato con successo!<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></p>\r\n"
							+ "<hr>\r\n" + "</div>";
					//rimando su visualizza lavorazioni con messaggio di operazione andata a buon fine
					request.getSession().setAttribute("MESSAGGIO", modCorretto);
					response.sendRedirect("gestlavorazioni?cmd=viewall");
					}
				catch(Exception e){
					//stampo solo su console tutto il stack trace in caso di errore
					e.printStackTrace();
					logger.info("Operazione non andata a buon fine");
					//scrivo div contenente  messaggio d'errore
					String errorpage="<div class=\"jumbotron text-center\">\r\n" +
							"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> non è possibile modificare la lavorazione.</h1>\r\n"
							+ "  <hr>\r\n" + "</div>";
					request.getSession().setAttribute("MESSAGGIO",errorpage);
					//lo rimando indietro
					response.sendRedirect("gestlavorazioni?cmd=aggiorna&id="+codLavorazione);
							
				}
				}

		}
		
		
		
		
		//--------------CAMBI DI STATO LAVORAZIONI-------------------//
		//funzione che cambio lo stato della Lavorazione in:Eseguita
		else if(comando.equals("eseguita")) {

			if(request.getParameterValues("check")==null) {
				System.out.println("nessun elemento selezionato");
			}
			else
			{
				String idLavorazioni[]=request.getParameterValues("check");
				for(int i=0;i<idLavorazioni.length;i++) {
					}
				DBManager db;
				try {
					db = new DBManager();
					db.setStatoLavorazioni(idLavorazioni, "Eseguita");
					db.setDataFineCurrentDate(idLavorazioni);
					//div che contiene il messaggio di ringraziamento,ovvero il codice è stato eseguito correttamente 
					String modCorretto="<div class=\"jumbotron text-center\">\r\n"
							+ "<p class=\"lead\" style=\"color: green; font-weight: bold;\"> le lavorazioni sono state modificate con successo!<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></p>\r\n"
							+ "<hr>\r\n" + "</div>";
					//rimando su visualizza lavorazioni con messaggio di operazione andata a buon fine
					request.getSession().setAttribute("MESSAGGIO", modCorretto);
					response.sendRedirect("gestlavorazioni?cmd=viewall");
				} 
				catch(Exception e){
					//stampo solo su console tutto il stack trace in caso di errore
					e.printStackTrace();
					logger.info("Operazione non andata a buon fine");
					//scrivo div contenente  messaggio d'errore
					String errorpage="<div class=\"jumbotron text-center\">\r\n" +
							"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> non è stato possibile modificare le lavorazioni</h1>\r\n"
							+ "  <hr>\r\n" + "</div>";
					request.getSession().setAttribute("MESSAGGIO",errorpage);
					//lo rimando indietro
					response.sendRedirect("gestlavorazioni?cmd=viewall");
							
				}
			}

		}
		
		
		
		//funzione che cambio lo stato della Lavorazione in:Non eseguita
				else if(comando.equals("noneseguita")) {

					if(request.getParameterValues("check")==null) {
						System.out.println("nessun elemento selezionato");
					}
					else
					{
						String idLavorazioni[]=request.getParameterValues("check");
						for(int i=0;i<idLavorazioni.length;i++) {
							}
						DBManager db;
						try {
							db = new DBManager();
							db.setStatoLavorazioni(idLavorazioni, "Non eseguita");
							db.setDataFineCurrentDate(idLavorazioni);
							//div che contiene il messaggio di ringraziamento,ovvero il codice è stato eseguito correttamente 
							String modCorretto="<div class=\"jumbotron text-center\">\r\n"
									+ "<p class=\"lead\" style=\"color: green; font-weight: bold;\"> le lavorazioni sono state modificate con successo!<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></p>\r\n"
									+ "<hr>\r\n" + "</div>";
							//rimando su visualizza lavorazioni con messaggio di operazione andata a buon fine
							request.getSession().setAttribute("MESSAGGIO", modCorretto);
							response.sendRedirect("gestlavorazioni?cmd=viewall");
						} 
						catch(Exception e){
							//stampo solo su console tutto il stack trace in caso di errore
							e.printStackTrace();
							logger.info("Operazione non andata a buon fine");
							//scrivo div contenente  messaggio d'errore
							String errorpage="<div class=\"jumbotron text-center\">\r\n" +
									"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> non è stato possibile modificare le lavorazioni</h1>\r\n"
									+ "  <hr>\r\n" + "</div>";
							request.getSession().setAttribute("MESSAGGIO",errorpage);
							//lo rimando indietro
							response.sendRedirect("gestlavorazioni?cmd=viewall");
									
						}
					}

				}
		
		
	
		
		//funzione che cambio lo stato della Lavorazione in:In lavorazione
				else if(comando.equals("inlavorazione")) {
					if(request.getParameterValues("check")==null) {
						System.out.println("nessun elemento selezionato");
					}
					else
					{
						String idLavorazioni[]=request.getParameterValues("check");
						for(int i=0;i<idLavorazioni.length;i++) {
							}
						DBManager db;
						try {
							db = new DBManager();
							db.setStatoLavorazioni(idLavorazioni, "In lavorazione");
							db.setDataFineNull(idLavorazioni);
							db.close();
							//div che contiene il messaggio di ringraziamento,ovvero il codice è stato eseguito correttamente 
							String modCorretto="<div class=\"jumbotron text-center\">\r\n"
									+ "<p class=\"lead\" style=\"color: green; font-weight: bold;\"> le lavorazioni sono state modificate con successo!<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></p>\r\n"
									+ "<hr>\r\n" + "</div>";
							//rimando su visualizza lavorazioni con messaggio di operazione andata a buon fine
							request.getSession().setAttribute("MESSAGGIO", modCorretto);
							response.sendRedirect("gestlavorazioni?cmd=viewall");
						} 
						catch(Exception e){
							//stampo solo su console tutto il stack trace in caso di errore
							e.printStackTrace();
							logger.info("Operazione non andata a buon fine");
							//scrivo div contenente  messaggio d'errore
							String errorpage="<div class=\"jumbotron text-center\">\r\n" +
									"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> non è stato possibile modificare le lavorazioni</h1>\r\n"
									+ "  <hr>\r\n" + "</div>";
							request.getSession().setAttribute("MESSAGGIO",errorpage);
							//lo rimando indietro
							response.sendRedirect("gestlavorazioni?cmd=viewall");
									
						}
					}

					
				}
				
		
		
		
		
		//--------------------------------------------------------//
		


	}
	//------------------------------------------------//

	}


