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
		String cf = request.getParameter("codiceFiscale");
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirm_password = request.getParameter("confirm_password");
		logger.info("un nuovo utente si sta registrando nell'applicazione, utente="+cf+ " "+nome+" "+cognome+" "+username+" "+email+" "+phone);

		try {
			DBManager db = new DBManager();
			if (db.checkUsername(username) == false) {
				db.insertRegistration(cf,nome, cognome, username, email, phone, password);
				logger.info("registrazione dell'utente avvenuta con successo,rimando su login.jsp");
				response.sendRedirect("login.jsp");
			} else {
				logger.error("registrazione dell'utente non avvenuta,rimando su registrazione.jsp");
				request.getSession().setAttribute("MESSAGGIO", "<p class='text-center text-danger'>Username gia' esistente</p>");
				response.sendRedirect("registration.jsp");}
			db.close();
		} catch (Exception e) {
			
			e.printStackTrace();
			logger.error("registrazione dell'utente non avvenuta,rimando su registrazione.jsp");
			request.getSession().setAttribute("MESSAGGIO", "<p class='text-center text-danger'>Username gia' esistente</p>");
			response.sendRedirect("registration.jsp");
		}
	}
	
	
	else if(comando.equals("login")) { 
	Utente user;
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	logger.info("utente sta accedendo all'applicazione username_utente= "+username);
	try {
		DBManager db = new DBManager();
		int trovati=db.verificaCredenziali(username, password);
		if (trovati==1)
		{
			//UTENTE IN SESSIONE
			user = db.getUser(username);
			request.getSession().setAttribute("SESSION_USER", user);
			request.getSession().setAttribute("utente_loggato", "true");
			if(user.getAMMINISTRATORE().equals("N")) {
				logger.info("l'utente e' un cliente,per cui rimando sulla index dove puo' effettuare un'appuntamento.");
				response.sendRedirect("index.jsp");
			}
			else if(user.getAMMINISTRATORE().equals("Y")) {
				logger.info("l'utente e' un amministratore,lo sto facendo accedere al panello di amministrazione.");
				response.sendRedirect("dashboard.jsp");
			}
		}
		else {
			logger.info("utente non riconosciuto,rimando su login.jsp e avviso l'utente delle credenziali probabilmente errate.");
			request.getSession().setAttribute("MESSAGGIO", "<p class='text-center text-danger'>Username o Password errati</p>");
			response.sendRedirect("login.jsp");
		}
		db.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
	}
	
	}
}