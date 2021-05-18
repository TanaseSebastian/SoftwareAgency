package it.meucci;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Servlet implementation class GestioneQueryServlet
 */
@WebServlet("/gestquery")
public class GestioneQueryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Logger logger = LogManager.getLogger(GestioneQueryServlet.class); 
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneQueryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");
		   DBManager db;

		//----------------QUERY 1---------------------------//		
		if(comando.equals("query1")) {
			try { 
			       int codSoftware=Integer.parseInt(request.getParameter("software"));
			       logger.info("software scelto: "+codSoftware);
			       
			       //funzione che dato il codice software mi trova la lavorazione
			       db= new DBManager();
			       int codeLavorazione=db.getCodeLavorazione(codSoftware);			       
			       //personale coinvolto in una lavorazione
			       response.sendRedirect("gestpersonale?cmd=viewall&id="+codeLavorazione);
			}
			catch (Exception e)
			{
				e.printStackTrace();
				response.sendRedirect("404.jsp");
			}
		}
		
			
		else if(comando.equals("query2")) {
			ArrayList<Lavorazione> elenco= new ArrayList<Lavorazione>();
			try { 
				   //prelevo la data di inizio dalla jsp
				   String  inizio=(String)request.getParameter("inizio");
				   //prelevo la data di fine dalla jsp
			       String  fine=(String)request.getParameter("fine");
			       logger.info("Data inizio: "+inizio+" data fine: "+fine);
			       //inizializzo db e setto elenco lavorazioni solo terminate
			       	db= new DBManager();
					elenco=db.getLavorazioniTerminate(inizio,fine);
					//ELENCO Lavorazioni
					db.close();
					request.setAttribute("ELENCO_LAVORAZIONI", elenco);
					RequestDispatcher rd = request.getRequestDispatcher("visualizzaLavorazioni.jsp");
					rd.forward(request, response);
			     
			}
			catch (Exception e)
			{
				e.printStackTrace();
				response.sendRedirect("404.jsp");
			}
		}
		
		
		else if(comando.equals("query3")) {
			ArrayList<Lavorazione> elenco= new ArrayList<Lavorazione>();
			try { 
			       //inizializzo db e setto elenco lavorazioni che non sono terminate
			       	db= new DBManager();
					elenco=db.getLavorazioniNonEseguite();
					//ELENCO Lavorazioni
					db.close();
					request.setAttribute("ELENCO_LAVORAZIONI", elenco);
					RequestDispatcher rd = request.getRequestDispatcher("visualizzaLavorazioni.jsp");
					rd.forward(request, response);
			}
			catch (Exception e)
			{
				e.printStackTrace();
				response.sendRedirect("404.jsp");
			}
		}
		
		
		//--------GESTIONE PERSONALE----------------//
				if(comando.equals("query4")) {
					ArrayList<Dipendente> elenco= new ArrayList<Dipendente>();
					try 
					{
							db= new DBManager();
							elenco=db.getPersonaleOrdered();
							//ELENCO DIPENDENTI
							db.close();
							request.setAttribute("ELENCO_DIPENDENTI", elenco);
							RequestDispatcher rd = request.getRequestDispatcher("visualizzaDipendenti.jsp");
							rd.forward(request, response);
						
					} catch (Exception e) {
						e.printStackTrace();
						response.sendRedirect("404.jsp");
						// TODO: handle exception
					}
				}
		
	}
		
		
		
		
		
		

	}
