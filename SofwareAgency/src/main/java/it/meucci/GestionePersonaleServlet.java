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
 * Servlet implementation class GestionePersonaleServlet
 */
@WebServlet("/gestpersonale")
public class GestionePersonaleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Logger logger = LogManager.getLogger(GestionePersonaleServlet.class);  
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestionePersonaleServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");
		DBManager db;

		//--------GESTIONE PERSONALE COINVOLTO----------------//
		if(comando.equals("viewall")) {
			String codiceLavorazione=request.getParameter("id");
			
			ArrayList<Personale> elenco= new ArrayList<Personale>();
			try 
			{
				db= new DBManager();
				elenco=db.getPersonaleCoinvolto(codiceLavorazione);				
				//ELENCO personale coinvolto
				db.close();
				request.setAttribute("ELENCO_PERSONALE_COINVOLTO", elenco);
				request.setAttribute("codiceLavorazione", codiceLavorazione);
				RequestDispatcher rd = request.getRequestDispatcher("visualizzaPersonaleCoinvolto.jsp");
				rd.forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("404.jsp");
				// TODO: handle exception
			}
		}
		
		
		
				//dettagli di un personale coinvolto
				else if(comando.equals("dettagli"))
				{
					String id= request.getParameter("id");
					String cd= request.getParameter("cd");
					Personale p=new Personale();
					try {
						db= new DBManager();
						p = db.getDettagliPersonale(id,cd);
						db.close();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

					//logger.info(p.toString());
					request.setAttribute("PERSONALE", p);
					RequestDispatcher rd = request.getRequestDispatcher("dettaglioPersonale.jsp");
					rd.forward(request, response);
				}
		
		
				//funzione che aggiorna i dati del personale coinvolto
				else if(comando.equals("aggiorna"))
				{

					String id= request.getParameter("id");
					String cd= request.getParameter("cd");
					Personale p=new Personale();
					try {
						db= new DBManager();
						p = db.getDettagliPersonale(id,cd);
						db.close();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

					//System.out.println(p.toString());
					request.setAttribute("PERSONALE", p);
					RequestDispatcher rd = request.getRequestDispatcher("aggiornaPersonale.jsp");
					rd.forward(request, response);
				}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");
		DBManager db;

		//--------GESTIONE AGGIUNTA PERSONALE----------------//
		if(comando.equals("scegliDipartimento")) {
			String codiceLavorazione=request.getParameter("id");
			System.out.println("codice lavorazione nella pagina aggiungi personale: "+codiceLavorazione);
			String dipartimento=request.getParameter("dipartimento");
			try 
			{
				request.setAttribute("codiceLavorazione", codiceLavorazione);
				request.setAttribute("dipartimento", dipartimento);
				RequestDispatcher rd = request.getRequestDispatcher("aggiungiPersonaleCoinvolto.jsp");
				rd.forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("404.jsp");
				// TODO: handle exception
			}
		}
		
		
		else if(comando.equals("aggiungi")) {
			int codiceLavorazione=Integer.parseInt(request.getParameter("idLavorazione"));
			logger.info("codice lavorazione da manipolare="+codiceLavorazione);
			if(request.getParameterValues("check")==null) {
				System.out.println("nessun elemento selezionato");
			}
			else {
				String idPersonale[]=request.getParameterValues("check");
				for(int i=0;i<idPersonale.length;i++) {
					logger.info("PERSONALE DA AGGIUNGERE :"+idPersonale[i]);
				}
				
				try {
					db = new DBManager();
					for(int i=0;i<idPersonale.length;i++) {
						int id_personale=Integer.parseInt(idPersonale[i]);
						db.aggiungiPersonale(id_personale, codiceLavorazione);
					}
					db.close();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			response.sendRedirect("gestpersonale?cmd=viewall&id="+codiceLavorazione);
		}
		
		
		
		else if(comando.equals("elimina")) {
			System.out.println("sono entrato nella servlet");
			int codiceLavorazione=Integer.parseInt(request.getParameter("codiceLavorazione"));
			System.out.println("codice lavorazione:"+codiceLavorazione);
			if(request.getParameterValues("check")==null) {
				System.out.println("nessun elemento selezionato");
			}
			else {
				String idPersonale[]=request.getParameterValues("check");
				logger.info("PERSONALE DA ELIMINARE :");
				for(int i=0;i<idPersonale.length;i++) {
					System.out.println("ID DIPENDENTE = "+idPersonale[i]);
				}
				try {
					db = new DBManager();
					db.deletePersonale(idPersonale,codiceLavorazione);
					db.close();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			response.sendRedirect("gestpersonale?cmd=viewall&id="+codiceLavorazione);
		}
		
		
		
		//modifica deve poter modificare solamente descrizione, data inizio e data fine
		
				//funzione che modifica il personale coinvolto					
				else if(comando.equals("modifica")) {
					Personale p=new Personale();
					p.setCodLavorazione(Integer.parseInt(request.getParameter("codLavorazione")));
					p.setCodDipendente(Integer.parseInt(request.getParameter("codDipendente")));
					p.setDescrizione(request.getParameter("descrizione"));
					p.setDataInizio(request.getParameter("inizio"));
					String datafine= request.getParameter("fine");
					if(datafine.equals("in corso")) {
						try {
							logger.info(p.toString());
							db=new DBManager();
						db.aggiornapersonaleNoDataFine(p); db.close(); 
						//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente 
						String modCorretto="<div class=\"jumbotron text-center\">\r\n"
								+
								"  <p class=\"lead\" style=\"color: green; font-weight: bold;\"> il personale coinvolto è stato modificato con successo!<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></p>\r\n"
								+ "  <hr>\r\n" + "</div>";

						request.getSession().setAttribute("MESSAGGIO", modCorretto);
						response.sendRedirect("gestpersonale?cmd=viewall&id="+p.getCodLavorazione());
						}
						catch(Exception e){
							e.printStackTrace(); System.out.println("Operazione non andata a buon fine");
							String errorpage="<div class=\"jumbotron text-center\">\r\n" +
									"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> non è possibile modificare il personale coinvolto.</h1>\r\n"
									+ "  <hr>\r\n" + "</div>"; request.getSession().setAttribute("MESSAGGIO",
											errorpage); 		
									response.sendRedirect("gestpersonale?cmd=aggiorna&id="+p.getCodLavorazione());
						}
					}
					else {
						p.setDataFine(request.getParameter("fine"));
						logger.info(p.toString());

						try {
							db=new DBManager();
						db.aggiornapersonale(p); db.close(); 
						//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente 
						String modCorretto="<div class=\"jumbotron text-center\">\r\n"
								+
								"  <p class=\"lead\" style=\"color: green; font-weight: bold;\"> il personale coinvolto è stato modificato con successo!<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></p>\r\n"
								+ "  <hr>\r\n" + "</div>";

						request.getSession().setAttribute("MESSAGGIO", modCorretto);
						response.sendRedirect("gestpersonale?cmd=viewall&id="+p.getCodLavorazione());
						}
						catch(Exception e){
							e.printStackTrace(); System.out.println("Operazione non andata a buon fine");
							String errorpage="<div class=\"jumbotron text-center\">\r\n" +
									"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> non è possibile modificare il personale coinvolto.</h1>\r\n"
									+ "  <hr>\r\n" + "</div>"; request.getSession().setAttribute("MESSAGGIO",
											errorpage); 		
									response.sendRedirect("gestpersonale?cmd=aggiorna&id="+p.getCodLavorazione());
						}
					}
					
					
					

				}
		
		
		
	}
	

}
