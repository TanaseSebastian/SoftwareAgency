package it.meucci;
import org.apache.logging.log4j.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class gestioneLogin
 */
@WebServlet("/gestlogin")
public class GestioneLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Logger logger = LogManager.getLogger(GestioneLogin.class); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");
		if(comando.equals("register")) {
		Dipendente user;
		String username = request.getParameter("username");
		String codiceRegistrazione = request.getParameter("codiceRegistrazione");
		logger.info("un nuovo utente si sta registrando nell'applicazione, utente="+username);

		try {
			//controllo se l'utente esiste nel database
			DBManager db = new DBManager();
			int trovati=db.verificaCredenzialidiRegistrazione(username, codiceRegistrazione);
			if (trovati==1)
			{
					//UTENTE IN SESSIONE
				   user = db.getUserbyUsername(username);
				  request.getSession().setAttribute("SESSION_USER", user);
				  request.getSession().setAttribute("utente_loggato", "true");
				  request.getSession().setAttribute("Benvenuto", "true");
				 
				if(user.getAmministratore().equals("N")) {
					logger.info("l'utente e' un dipendente,per cui rimando su benvenuto nella dashboard.");
					response.sendRedirect("dashboard.jsp");
				}
				else if(user.getAmministratore().equals("Y")) {
					logger.info("l'utente e' un amministratore,lo sto facendo accedere al panello di amministrazione.");
					response.sendRedirect("dashboard.jsp");
				}
			}
			else {
				logger.info("utente non riconosciuto,rimando su login.jsp e avviso l'utente delle credenziali probabilmente errate.");
				request.getSession().setAttribute("MESSAGGIO", "<p class='text-danger'>Username o codice errati</p>");
				response.sendRedirect("registrazione.jsp");
			}
			db.close();
		} catch (Exception e) {
			response.sendRedirect("404.jsp");
		}
	}
	
	
	 if(comando.equals("login")) { 
	Dipendente user;
	String username = request.getParameter("login-username");
	String password = request.getParameter("login-password");
	logger.info("utente sta accedendo all'applicazione username_utente= "+username);
	try {
		//controllo se l'utente esiste nel database
		DBManager db = new DBManager();
		int trovati=db.verificaCredenziali(username, password);
		if (trovati==1)
		{
			//UTENTE IN SESSIONE
			user = db.getUserbyUsername(username);
			  request.getSession().setAttribute("SESSION_USER", user);
			  request.getSession().setAttribute("utente_loggato", "true");
			  request.getSession().setAttribute("Benvenuto", "false");
			 
			if(user.getAmministratore().equals("N")) {
				logger.info("l'utente NON e' un amministratore,lo sto facendo accedere al panello di amministrazione con limitazioni.");
				response.sendRedirect("dashboard.jsp");
			}
			else if(user.getAmministratore().equals("Y")) {
				logger.info("l'utente e' un amministratore,lo sto facendo accedere al panello di amministrazione con privilegi elevati.");
				response.sendRedirect("dashboard.jsp");
			}
		}
		else {
			logger.info("utente non riconosciuto,rimando su login.jsp e avviso l'utente delle credenziali probabilmente errate.");
			request.getSession().setAttribute("MESSAGGIO", "<p class='text-danger'>Username o Password errati</p>");
			response.sendRedirect("login.jsp");
		}
		db.close();
	} catch (Exception e) {
		response.sendRedirect("404.jsp");
		e.printStackTrace();
	}
	}
	
	}
}