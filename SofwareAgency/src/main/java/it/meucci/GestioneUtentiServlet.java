package it.meucci;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Servlet implementation class GestioneUtentiServlet
 */
@MultipartConfig
@WebServlet("/gestutenti")
public class GestioneUtentiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Logger logger = LogManager.getLogger(GestioneUtentiServlet.class); 
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
		DBManager db;

		//--------GESTIONE PERSONALE----------------//
		if(comando.equals("viewall")) {
			String tipo = request.getParameter("tipo");;
			ArrayList<Dipendente> elenco= new ArrayList<Dipendente>();
			try 
			{
				db= new DBManager();
				if(tipo.equals("dipendente")) {
					elenco=db.getPersonale("dipendente");
					//ELENCO DIPENDENTI
					db.close();
					request.setAttribute("ELENCO_DIPENDENTI", elenco);
					RequestDispatcher rd = request.getRequestDispatcher("visualizzaDipendenti.jsp");
					rd.forward(request, response);
				}
				else if(tipo.equals("amministratore")) {
					elenco=db.getPersonale("amministratore");
					//ELENCO DIPENDENTI
					db.close();
					request.setAttribute("ELENCO_AMMINISTRATORI", elenco);
					RequestDispatcher rd = request.getRequestDispatcher("visualizzaAmministratori.jsp");
					rd.forward(request, response);
				}

			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("404.jsp");
				// TODO: handle exception
			}
		}

		//dettagli di un dipendente/amministratore
		else if(comando.equals("dettagli"))
		{
			String id= request.getParameter("id");
			Dipendente d=new Dipendente();
			try {
				db= new DBManager();
				d = db.getUser(id);
				db.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//logger.info(p.toString());
			request.setAttribute("DIPENDENTE", d);
			RequestDispatcher rd = request.getRequestDispatcher("dettaglioDipendente.jsp");
			rd.forward(request, response);

		}

		//funzione che aggiorna i dati di un cliente
		else if(comando.equals("aggiorna"))
		{

			String id= request.getParameter("id");
			String tipoUtente= request.getParameter("tipoutente");
			Dipendente d=new Dipendente();
			try {
				db= new DBManager();
				d = db.getUser(id);
				db.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//System.out.println(p.toString());
			request.setAttribute("UTENTE", d);
			request.setAttribute("tipoutente", tipoUtente);
			RequestDispatcher rd = request.getRequestDispatcher("aggiornaUtente.jsp");
			rd.forward(request, response);

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
							+"<img src=\"cid:image\">"
							+ "<p style=\"color: #197ED1; font-size:40px; font-weight: 900; font-family:sans-serif;\">Setech</p>"
							+ "<p style=\"color: black; font-size: x-large; font-weight: 900;\">Caro collaboratore, Setech l'ha registrata con successo nel nostro sistema.</p>"
							+ "<h2>Ecco le credenziali per completare la registrazione:</h2>"
							+ "<p>username :<strong style='color:#197ED1;'>"+d.getUsername()+"</strong></p>"
							+ "<p>Codice di registrazione: <strong style='color:#197ED1;'>"+d.getCodiceRegistrazione()+"</p>"
							+"<br>"
							+"<br>"
							+"<a style=\"padding: 20px; border-radius: 30px; background-color:#197ED1; color:white; text-decoration: none; font-weight: bolder; margin-top: 10px; margin-bottom: 10px;\"  href=\"http://localhost:8080/SofwareAgency/registrazione.jsp\">Completa la registrazione</a>"
							+"<br>"
							+"<br>"
							+"<h3>importante: <strong>attenzione a non perdere le credenziali,sono necessarie per completare la registrazione correttamente</strong></h3>"
							+"<p style=\"color: #197ED1;\"><strong>Per qualsiasi dubbio o problema non esitare a contattarci tramite telefono o email.</strong></p>"
							+"<p style=\"color: #197ED1; font-size: x-large; font-weight: 900;\">Setech le augura una buona giornata.</p>"
							+"</body>"
							+"</html>";


					//invio dell'email con i parametri
					sender.sendFromGMail(to, "Setech,registrazione eseguita",messaggioDaInviare,null,null);

					//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente
					String thankyoupage="<div class=\"jumbotron text-center\">\r\n"
							+ "  <h1 class=\"display-3\" style=\"color: green; font-weight: bold;\">Grazie! Il dipendente è stato registrato correttamente<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></h1>\r\n"
							+ "  <p class=\"lead\"><strong>è stata inviata una mail a "+d.getEmail()+" per completare la registrazione</strong></p>\r\n"
							+ "  <hr>\r\n"
							+ "</div>";

					logger.info("il dipendente è stato registrato ed è stata mandata l'email per completare la registrazione");
					request.getSession().setAttribute("MESSAGGIO", thankyoupage);
					response.sendRedirect("gestutenti?cmd=viewall&tipo=dipendente");


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
		//----------------NUOVO Amministratore---------------------------//		
		if(comando.equals("nuovoAmministratore")) {
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
			PasswordGenerator pg=new PasswordGenerator();
			d.setCodiceRegistrazione(pg.generateStrongPassword());
			logger.info(d.toString());


			try { 
				DBManager db = new DBManager();
				if (db.checkUsername(d.getUsername()) ==false)
				{
					db.insertAmministratore(d);
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
							+"<img src=\"cid:image\">"
							+ "<p style=\"color: #197ED1; font-size:40px; font-weight: 900; font-family:sans-serif;\">Setech</p>"
							+ "<p style=\"color: black; font-size: x-large; font-weight: 900;\">Caro collaboratore, Setech l'ha registrata con successo nel nostro sistema.</p>"
							+ "<h2>Ecco le credenziali per completare la registrazione:</h2>"
							+ "<p>username :<strong style='color:#197ED1;'>"+d.getUsername()+"</strong></p>"
							+ "<p>Codice di registrazione: <strong style='color:#197ED1;'>"+d.getCodiceRegistrazione()+"</p>"
							+"<br>"
							+"<br>"
							+"<a style=\"padding: 20px; border-radius: 30px; background-color:#197ED1; color:white; text-decoration: none; font-weight: bolder; margin-top: 10px; margin-bottom: 10px;\"  href=\"http://localhost:8080/SofwareAgency/registrazione.jsp\">Completa la registrazione</a>"
							+"<br>"
							+"<br>"
							+"<h3>importante: <strong>attenzione a non perdere le credenziali,sono necessarie per completare la registrazione correttamente</strong></h3>"
							+"<p style=\"color: #197ED1;\"><strong>Per qualsiasi dubbio o problema non esitare a contattarci tramite telefono o email.</strong></p>"
							+"<p style=\"color: #197ED1; font-size: x-large; font-weight: 900;\">Setech le augura una buona giornata.</p>"
							+"</body>"
							+"</html>";


					//invio dell'email con i parametri
					sender.sendFromGMail(to, "Setech,registrazione eseguita",messaggioDaInviare,null,null);

					//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente
					String thankyoupage="<div class=\"jumbotron text-center\">\r\n"
							+ "  <h1 class=\"display-3\" style=\"color: green; font-weight: bold;\">Grazie! l'amministratore è stato registrato correttamente<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></h1>\r\n"
							+ "  <p class=\"lead\"><strong>è stata inviata una mail a "+d.getEmail()+" per completare la registrazione</strong></p>\r\n"
							+ "  <hr>\r\n"
							+ "</div>";

					logger.info("l'amministratore  è stato registrato ed è stata mandata l'email per completare la registrazione");
					request.getSession().setAttribute("MESSAGGIO", thankyoupage);
					response.sendRedirect("gestutenti?cmd=viewall&tipo=amministratore");


				}
				else {
					logger.info("username già esistente");
					String messaggio="<p class='text-center text-danger'>Username gia' esistente</p>";
					request.getSession().setAttribute("MESSAGGIO", messaggio);
					response.sendRedirect("nuovoAmministratore.jsp"); db.close();
				}
			}
			catch (Exception e)
			{
				e.printStackTrace();
				response.sendRedirect("404.jsp");
			}
		}
		//------------------------------------------------//



		//---funzione che elimina uno o più dipendenti-----//
		else if(comando.equals("elimina")) {
			String tipo=request.getParameter("tipo");
			if(request.getParameterValues("check")==null) {
				logger.info("nessun elemento selezionato");
			}
			else {
				String codiceDipendenti[]=request.getParameterValues("check");
				logger.info("Dipendenti DA ELIMINARE :");
				for(int i=0;i<codiceDipendenti.length;i++) {
					logger.info("ID CLIENTE = "+codiceDipendenti[i]);
				}
				DBManager db;
				try {
					db = new DBManager();
					db.deleteDipendenti(codiceDipendenti);
					db.close();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			response.sendRedirect("gestutenti?cmd=viewall&tipo="+tipo);
		}



		//-------------------SET PASSWORD FIRST TIME------------------------//
		else if(comando.equals("setPassword"))
		{
			String cf = request.getParameter("cf");
			String password = request.getParameter("password");
			logger.info(cf+" "+password);
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
		
		//----------set password only con ritorno su login--------------//
		else if(comando.equals("setPasswordOnly"))
		{
			String cf = request.getParameter("cf");
			String password = request.getParameter("password");
			logger.info(cf+" "+password);
			try
			{
				DBManager db = new DBManager();
				//imposto la password nuova
				db.resetPassword(cf, password);
				response.sendRedirect("logout");

			} 
			catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("404.jsp");
			}
		}

		
		//------cambio password lato amministratore----//
		else if(comando.equals("changepassword"))
		{
			String tipoutente = request.getParameter("tipo");
			String id = request.getParameter("id");
			String cf = request.getParameter("cf");
			String password = request.getParameter("password");
			logger.info(cf+" "+password);
			try
			{
				DBManager db = new DBManager();
				//imposto la password nuova
				db.resetPassword(cf, password);
				//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente
				String passCorretta="<div class=\"jumbotron text-center\">\r\n"
						+ "  <p class=\"lead\" style=\"color: green; font-weight: bold;\">La password è stata modificata con successo!<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></p>\r\n"
						+ "  <hr>\r\n"
						+ "</div>";
				
				
				request.getSession().setAttribute("MESSAGGIO", passCorretta);
				
				response.sendRedirect("gestutenti?cmd=aggiorna&tipoutente="+tipoutente+"&id="+id);
				
			} 
			catch (Exception e) {
				e.printStackTrace();
				
				String errorpage="<div class=\"jumbotron text-center\">\r\n"
						+ "  <h5 class=\"lead\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> la password non è stata modificata</h5>\r\n"		
						+ "  <hr>\r\n"
						+ "</div>";
				request.getSession().setAttribute("MESSAGGIO", errorpage);
				
				response.sendRedirect("gestutenti?cmd=aggiorna&tipoutente="+tipoutente+"&id="+id);
			}
		}
		
		
		
		
		//metodo per cambio delle righe del datatables con ritorno sulla pagina in goback		
		else if(comando.equals("entries")) {
			String requestPage=request.getParameter("page");
			logger.info("La request page è "+requestPage);
			String righe=request.getParameter("select-entries");
			request.getSession().setAttribute("numeroRighe", righe);
			RequestDispatcher rd;
			switch (requestPage) {
			case "visualizzaAmministratori.jsp":
				response.sendRedirect("gestutenti?cmd=viewall&tipo=amministratore");
				break;
			case "visualizzaDipendenti.jsp":
				response.sendRedirect("gestutenti?cmd=viewall&tipo=dipendente");
				break;
			case "visualizzaPacchetti.jsp":
				response.sendRedirect("gestsoftware?cmd=viewall");
				break;
			case "visualizzaLavorazioni.jsp":
				response.sendRedirect("gestlavorazioni?cmd=viewall");
				break;
			case "visualizzaPersonaleCoinvolto.jsp":
				String id=request.getParameter("codiceLavorazione");
				response.sendRedirect("gestpersonale?cmd=viewall&id="+id);
				break;
			default:
				response.sendRedirect(requestPage);
				break;
			}
		}
		


		//funzione che modifica l'utente			
		else if(comando.equals("modifica")) {
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
			d.setAnniAnzianita(Integer.parseInt(request.getParameter("anni")));
			d.setProvincia(request.getParameter("provincia"));
			d.setStipendio(request.getParameter("stipendio"));
			d.setAmministratore(request.getParameter("amministratore"));
			String tipoutente = request.getParameter("tipoutente");
			System.out.println(tipoutente);

			logger.info(d.toString());

			try { DBManager db=new DBManager();
			db.aggiornaUtente(d); db.close(); 
			//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente 
			String modCorretto="<div class=\"jumbotron text-center\">\r\n"
					+
					"  <p class=\"lead\" style=\"color: green; font-weight: bold;\"> l'utente è stato modificato con successo!<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></p>\r\n"
					+ "  <hr>\r\n" + "</div>";

			request.getSession().setAttribute("MESSAGGIO", modCorretto);
			response.sendRedirect("gestutenti?cmd=viewall&tipo="+tipoutente);
			}
			catch(Exception e){
				e.printStackTrace(); System.out.println("Operazione non andata a buon fine");
				String errorpage="<div class=\"jumbotron text-center\">\r\n" +
						"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> non è possibile modificare l'utente.</h1>\r\n"
						+ "  <hr>\r\n" + "</div>"; request.getSession().setAttribute("MESSAGGIO",
								errorpage); 			response.sendRedirect("gestutenti?cmd=viewall&tipo="+tipoutente);
			}

		}
		
		
		
		
		//funzione che aggiorna dati dell'utente (dal proprio profilo)			
				else if(comando.equals("aggiornaDati")) {
					Dipendente d=new Dipendente();
					d.setCf(request.getParameter("cf"));
					d.setEmail(request.getParameter("email"));
					d.setPhone(request.getParameter("phone"));
					d.setUsername(request.getParameter("username"));
					d.setProvincia(request.getParameter("provincia"));

					logger.info(d.toString());

					try { DBManager db=new DBManager();
					db.aggiornaUtenteProfilo(d); db.close(); 
					response.sendRedirect("logout");
					}
					catch(Exception e){
						e.printStackTrace(); System.out.println("Operazione non andata a buon fine");
						String errorpage="<div class=\"jumbotron text-center\">\r\n" +
								"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> non è possibile modificare i dati.</h1>\r\n"
								+ "  <hr>\r\n" + "</div>"; request.getSession().setAttribute("MESSAGGIO",
										errorpage);
								response.sendRedirect("profile.jsp");
					}

				}
		
		
		
		//-------- FUNZIONE CHE AGGIRONA IMMAGINE DI PROFILO-----------------//
		else if(comando.equals("adminUpdateImage")) {
			String codiceDipendente = request.getParameter("codiceDipendente");
			Part file=request.getPart("avatarNewImg");
			
			String imageFileName=file.getSubmittedFileName();  // get selected image file name
			System.out.println("Selected Image File Name : "+imageFileName);
			
			
			
			// Leggo le proprietà da file properties
			Properties prop;
			ReadPropertyFileFromClassPath obj = new ReadPropertyFileFromClassPath();
			prop = obj.loadProperties("DB.properties");
			String pathImages= prop.getProperty("pathImages");

			String uploadPath=pathImages+imageFileName;  // upload path where we have to upload our actual image
			System.out.println("Upload Path : "+uploadPath);
			
			// Inserire l'immagine nella cartella immaginiProfilo
			
			try
			{
			
			FileOutputStream fos=new FileOutputStream(uploadPath);
			InputStream is=file.getInputStream();
			
			byte[] data=new byte[is.available()];
			is.read(data);
			fos.write(data);
			fos.close();
			DBManager db=new DBManager();
			db.insertImage(codiceDipendente, imageFileName);
			db.close();
			request.getSession().invalidate();
			RequestDispatcher rd = request.getRequestDispatcher("logout");
			rd.forward(request, response);
			}
			
			catch(Exception e){
				e.printStackTrace();
				System.out.println("Operazione non andata a buon fine");
				e.printStackTrace();
				String errorpage="<div class=\"jumbotron text-center\">\r\n"
						+ "  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> non è stato possibile modificare i dati.</h1>\r\n"
						+ "  <hr>\r\n"
						+ "</div>";
				request.getSession().setAttribute("MESSAGGIO", errorpage);
				response.sendRedirect("profile.jsp");
			}
			//**********************
		
	}
		
		
		
		
		
		

	}

}
