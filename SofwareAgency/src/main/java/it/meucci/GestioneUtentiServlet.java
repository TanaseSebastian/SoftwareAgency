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
 * Servlet implementation class GestioneUtentiServlet
 */
@WebServlet("/gestutenti")
public class GestioneUtentiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Logger logger = LogManager.getLogger(GestioneLogin.class); 
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GestioneUtentiServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");
		String tipo = request.getParameter("tipo");
		DBManager db;
		
		if(comando.equals("viewall")) {
			
			ArrayList<Dipendente> elenco= new ArrayList<Dipendente>();
			try 
			{
				db= new DBManager();
				if(tipo.equals("dipendenti"))
				elenco=db.getPersonale("dipendenti");
				else
				elenco=db.getPersonale("amministratore");
				db.close();
				
				//ELENCO CLIENTI
				request.setAttribute("ELENCO_DIPENDENTI", elenco);
				RequestDispatcher rd = request.getRequestDispatcher("visualizzaPersonale.jsp");
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
		String comando = request.getParameter("cmd");;

//----------------NUOVO DIPENDENTE---------------------------//		
		if(comando.equals("nuovoDipendente")) {
			Dipendente d=new Dipendente();
			d.setCf(request.getParameter("cf"));
			d.setNome(request.getParameter("nome"));
			d.setCognome(request.getParameter("cognome"));
			d.setEmail(request.getParameter("email"));
			d.setPhone(request.getParameter("phone"));
			d.setUsername(request.getParameter("username"));
			d.setCodDipartimento(Integer.parseInt(request.getParameter("dipartimento")));
			d.setQualificaProfessionale(request.getParameter("qualifica"));
			d.setNomeProfessione(request.getParameter("professione"));
			d.setDataAssunzione(request.getParameter("assunzione"));
			d.setDataNascita(request.getParameter("nascita"));
			d.setProvincia(request.getParameter("provincia"));
			d.setStipendio(request.getParameter("stipendio"));
			d.setAmministratore(request.getParameter("amministratore"));
			PasswordGenerator pg=new PasswordGenerator();
			d.setCodiceRegistrazione(pg.generateStrongPassword());
			logger.info(d.toString());


			try { 
				DBManager db = new DBManager();
				if (db.checkUsername(d.getUsername()) ==false)
				{
					db.insertDipendente(d);
					logger.info("nuovo dipendente inserito con successo nel db");
					//inizializzo l'email sender
					SendMail sender = new SendMail();
					String RECIPIENT=d.getEmail();
					String[] to = { RECIPIENT }; // list of recipient email addresses
					
					//costruisco il messaggio da inviare in formato html
					
					String messaggioDaInviare ="<!DOCTYPE html>"
							+ "<html lang='it'>"
							+ " <head>"
							+ "<meta charset='UTF-8'>"
									+ "<meta http-equiv='X-UA-Compatible' content='IE=edge'>"
											+ "<meta name='viewport' content='width=device-width, initial-scale=1.0\'>"
									+ "<title>Messaggio</title>"
									+ "</head>"
									+ "<body style='text-align: center; font-size: larger;'>"
									+ "<p style=\"color: #197ED1; font-size:40px; font-weight: 900; font-family:sans-serif;\">codebase</p>"
											+ "<p style=\"color: black; font-size: x-large; font-weight: 900;\">Caro collaboratore, Codebase l'ha registrata con successo nel nostro sistema.</p>"
													+ "<h2>Ecco le credenziali per completare la registrazione:</h2>"
													+ "<p>username :<strong style='color:#197ED1;'>"+d.getUsername()+"</strong></p>"
															+ "<p>Codice di registrazione: <strong style='color:#197ED1;'>"+d.getCodiceRegistrazione()+"</p>"
															+"<a style=\"padding: 20px; border-radius: 30px; background-color:#197ED1; color:white; text-decoration: none; font-weight: bolder; margin-top: 10px; margin-bottom: 10px;\"  href=\"http://localhost:8080/SofwareAgency/registrazione.jsp\">Completa la registrazione</a>"
															+"<h3>importante: <strong>attenzione a non perdere le credenziali,sono necessarie per completare la registrazione correttamente</strong></h3>"
							+"<p style=\"color: #197ED1;\"><strong>Per qualsiasi dubbio o problema non esitare a contattarci tramite telefono o email.</strong></p>"
							+"<p style=\"color: #197ED1; font-size: x-large; font-weight: 900;\">Codebase le augura una buona giornata.</p>"
							+"</body>"
							+"</html>";
					
					
					//invio dell'email con i parametri
					sender.sendFromGMail(to, "Codebase,registrazione eseguita",messaggioDaInviare,null,null);
					
					//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente
					String thankyoupage="<div class=\"jumbotron text-center\">\r\n"
							+ "  <h1 class=\"display-3\" style=\"color: green; font-weight: bold;\">Grazie! Il dipendendente è stato registrato correttamente<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></h1>\r\n"
							+ "  <p class=\"lead\"><strong>è stata inviata una mail a "+d.getEmail()+" per completare la registrazione</strong></p>\r\n"
							+ "  <hr>\r\n"
							+ "</div>";
					
					logger.info("il dipendente è stato registrato ed è stata mandata l'email per completare la registrazione");
					request.getSession().setAttribute("MESSAGGIO", thankyoupage);
					response.sendRedirect("visualizzaPersonale.jsp");
					
					
				}
				else {
					logger.info("username già esistente");
					String messaggio="<p class='text-center text-danger'>Username gia' esistente</p>";
					request.getSession().setAttribute("MESSAGGIO", messaggio);
					response.sendRedirect("nuovoDipendente.jsp"); db.close();
				}
			  }
			catch (Exception e)
			{
				e.printStackTrace();
				response.sendRedirect("404.jsp");
			}
		}
//----------------------------------------------------------------------//


		
		
//-------------------SET PASSWORD FIRST TIME------------------------//
		else if(comando.equals("setPassword"))
		{
			String cf = request.getParameter("cf");
			String password = request.getParameter("password");
			System.out.println(cf+" "+password);
			try
			{
				DBManager db = new DBManager();
				//imposto la password nuova
				db.resetPassword(cf, password);
				//rendo il codice registrazione attivato e quindi non riutilizzabile
				db.activeRegistration(cf);
				response.sendRedirect("dashboard.jsp");
				
			} 
			catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("404.jsp");
			}
		}
//------------------------------------------------------------------//		
		

	}

}
