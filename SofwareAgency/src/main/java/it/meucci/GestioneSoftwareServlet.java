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
 * Servlet implementation class GestioneSoftwareServlet
 */
@WebServlet("/gestsoftware")
public class GestioneSoftwareServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Logger logger = LogManager.getLogger(GestioneSoftwareServlet.class);   
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GestioneSoftwareServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");
		DBManager db;

		//--------GESTIONE SOFTWARE----------------//
		if(comando.equals("viewall")) {
			ArrayList<Software> elenco= new ArrayList<Software>();
			try 
			{
				db= new DBManager();
				elenco=db.getPacchettiSoftware();
				//ELENCO SOFTWARE
				db.close();
				request.setAttribute("ELENCO_SOFTWARE", elenco);
				RequestDispatcher rd = request.getRequestDispatcher("visualizzaPacchetti.jsp");
				rd.forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("404.jsp");
				// TODO: handle exception
			}
		}



		//dettagli di un software
		else if(comando.equals("dettagli"))
		{
			String id= request.getParameter("id");
			Software s=new Software();
			try {
				db= new DBManager();
				s = db.getSoftware(id);
				db.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//logger.info(p.toString());
			request.setAttribute("PACCHETTO_SOFTWARE", s);
			RequestDispatcher rd = request.getRequestDispatcher("dettaglioSoftware.jsp");
			rd.forward(request, response);
		}


		//funzione che aggiorna i dati di un software
		else if(comando.equals("aggiorna"))
		{

			String id= request.getParameter("id");
			Software s=new Software();
			try {
				db= new DBManager();
				s = db.getSoftware(id);
				db.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//System.out.println(p.toString());
			request.setAttribute("PACCHETTO_SOFTWARE", s);
			RequestDispatcher rd = request.getRequestDispatcher("aggiornaSoftware.jsp");
			rd.forward(request, response);

		}

	}



	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		String comando = request.getParameter("cmd");;


		//----------------NUOVO SOFTWARE---------------------------//		
		if(comando.equals("nuovoSoftware")) {
			Software s=new Software();
			s.setNome(request.getParameter("nome"));
			s.setTempoGiorniUomo(Integer.parseInt(request.getParameter("tempo")));
			s.setCosto(request.getParameter("costo"));
			s.setDescrizione(request.getParameter("descrizione"));
			s.setCodResponsabile(Integer.parseInt(request.getParameter("responsabile")));
			logger.info(s.toString());

			try { 
				DBManager db = new DBManager();
				db.insertSoftware(s);
				logger.info("nuovo software inserito con successo nel db");


				//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente
				String thankyoupage="<div class=\"jumbotron text-center\">\r\n"
						+ "  <h1 class=\"display-3\" style=\"color: green; font-weight: bold;\">Il software è stato registrato correttamente<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></h1>\r\n"
						+ "  <hr>\r\n"
						+ "</div>";

				request.getSession().setAttribute("MESSAGGIO", thankyoupage);
				response.sendRedirect("gestsoftware?cmd=viewall");
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
				String idSoftware[]=request.getParameterValues("check");
				System.out.println("SOFTWARE DA ELIMINARE :");
				for(int i=0;i<idSoftware.length;i++) {
					System.out.println("ID SOFTWARE = "+idSoftware[i]);
				}
				DBManager db;
				try {
					db = new DBManager();
					db.deleteSoftware(idSoftware);
					db.close();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			response.sendRedirect("gestsoftware?cmd=viewall");
		}


		//funzione che modifica l'utente			
		else if(comando.equals("modifica")) {
			Software s=new Software();
			s.setCodSoftware(Integer.parseInt(request.getParameter("codSoftware")));
			s.setNome(request.getParameter("nome"));
			s.setTempoGiorniUomo(Integer.parseInt(request.getParameter("tempo")));
			s.setCosto(request.getParameter("costo"));
			s.setDescrizione(request.getParameter("descrizione"));
			s.setCodResponsabile(Integer.parseInt(request.getParameter("responsabile")));
			logger.info(s.toString());

			try { DBManager db=new DBManager();
			db.aggiornaSoftware(s); db.close(); 
			//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente 
			String modCorretto="<div class=\"jumbotron text-center\">\r\n"
					+
					"  <p class=\"lead\" style=\"color: green; font-weight: bold;\"> il pacchetto software è stato modificato con successo!<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></p>\r\n"
					+ "  <hr>\r\n" + "</div>";

			request.getSession().setAttribute("MESSAGGIO", modCorretto);
			response.sendRedirect("gestsoftware?cmd=viewall");
			}
			catch(Exception e){
				e.printStackTrace(); System.out.println("Operazione non andata a buon fine");
				String errorpage="<div class=\"jumbotron text-center\">\r\n" +
						"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> non è possibile modificare il pacchetto software.</h1>\r\n"
						+ "  <hr>\r\n" + "</div>"; request.getSession().setAttribute("MESSAGGIO",
								errorpage); 			response.sendRedirect("gestsoftware?cmd=viewall");
			}

		}


	}
	//------------------------------------------------//

}
