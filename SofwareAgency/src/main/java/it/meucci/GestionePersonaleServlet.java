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
				RequestDispatcher rd = request.getRequestDispatcher("visualizzaPersonaleCoinvolto.jsp");
				rd.forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("404.jsp");
				// TODO: handle exception
			}
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
	}
	

}
