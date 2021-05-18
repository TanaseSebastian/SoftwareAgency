package it.meucci;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Servlet implementation class GestioneClientiServlet
 */
@WebServlet("/gestclienti")
public class GestioneClientiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Logger logger = LogManager.getLogger(GestioneClientiServlet.class);  
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneClientiServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");
		DBManager db;
		
		//funzione che aggiorna un cliente
		 if(comando.equals("aggiorna"))
		{

			String id= request.getParameter("id");
			Cliente c=new Cliente();
			try {
				db= new DBManager();
				c= db.getCliente(id);
				db.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//System.out.println(p.toString());
			request.setAttribute("CLIENTE", c);
			RequestDispatcher rd = request.getRequestDispatcher("aggiornaCliente.jsp");
			rd.forward(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");;


		//----------------NUOVA LAVORAZIONE--------------------------//		
		if(comando.equals("nuovo")) {
			Cliente c=new Cliente();
			c.setNome(request.getParameter("nome"));
			c.setIndirizzo(request.getParameter("indirizzo"));
			c.setRagioneSociale(request.getParameter("ragione"));
			c.setPartitaIva(request.getParameter("iva"));
			c.setPec(request.getParameter("email"));
			c.setUsername(request.getParameter("username"));
			PasswordGenerator p=new PasswordGenerator();
			c.setPws(p.generateStrongPassword());
			logger.info(c.toString());

			try { 
				DBManager db = new DBManager();
				db.insertCliente(c);
				logger.info("nuova cliente inserita con successo nel db");
				
				//inizializzo l'email sender
				SendMail sender = new SendMail();
				String RECIPIENT=c.getPec();
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
						+ "<p style=\"color: black; font-size: x-large; font-weight: 900;\">Gentile cliente: "+c.getRagioneSociale()+", Codebase l'ha registrata con successo nel nostro sistema.</p>"
						+ "<h2>Le riportiamo di seguito le credenziali per poter accedere nell'area riservata:</h2>"
						+ "<p>username :<strong style='color:#197ED1;'>"+c.getUsername()+"</strong></p>"
						+ "<p>Password: <strong style='color:#197ED1;'>"+c.getPws()+"</p>"
						+"<br>"
						+"<br>"
						+"<a style=\"padding: 20px; border-radius: 30px; background-color:#197ED1; color:white; text-decoration: none; font-weight: bolder; margin: 10px; margin-bottom: 10px;\"  href=\"http://localhost:8080/SofwareAgency/login.jsp\">Esegui il login</a>"
						+"<br>"
						+"<br>"
						+"<h3>importante: <strong>attenzione si consiglia di cambiare la password dopo essersi loggati</strong></h3>"
						+"<p style=\"color: #197ED1;\"><strong>Per qualsiasi dubbio o problema non esitare a contattarci tramite telefono o email.</strong></p>"
						+"<p style=\"color: #197ED1; font-size: x-large; font-weight: 900;\">Codebase le augura una buona giornata.</p>"
						+"</body>"
						+"</html>";


				//invio dell'email con i parametri
				sender.sendFromGMail(to, "Codebase,registrazione eseguita",messaggioDaInviare,null,null);
				
				
				
				

				//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente
				String thankyoupage="<div class=\"jumbotron text-center\">\r\n"
						+ "  <h1 class=\"display-3\" style=\"color: green; font-weight: bold;\">Il nuovo cliente è stata registrato correttamente e sono state mandate le credenziali d'accesso per mail <i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></h1>\r\n"
						+ "  <hr>\r\n"
						+ "</div>";

				request.getSession().setAttribute("MESSAGGIO", thankyoupage);
				response.sendRedirect("visualizzaClienti.jsp");
			}
			catch(Exception e){
				e.printStackTrace(); System.out.println("Operazione non andata a buon fine");
				String errorpage="<div class=\"jumbotron text-center\">\r\n" +
						"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> username già in uso.</h1>\r\n"
						+ "  <hr>\r\n" + "</div>"; request.getSession().setAttribute("MESSAGGIO",
								errorpage);
						response.sendRedirect("nuovoCliente.jsp");
			}
		}
		
		//funzione che modifica il cliente			
				else if(comando.equals("modifica")) {
					Cliente c=new Cliente();
					c.setCodCliente(Integer.parseInt(request.getParameter("codiceCliente")));
					c.setNome(request.getParameter("nome"));
					c.setIndirizzo(request.getParameter("indirizzo"));
					c.setRagioneSociale(request.getParameter("ragione"));
					c.setPartitaIva(request.getParameter("iva"));
					c.setPec(request.getParameter("email"));
					c.setUsername(request.getParameter("username"));

					logger.info(c.toString());

					try { DBManager db=new DBManager();
					db.aggiornaCliente(c); db.close(); 
					//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente 
					String modCorretto="<div class=\"jumbotron text-center\">\r\n"
							+
							"  <p class=\"lead\" style=\"color: green; font-weight: bold;\"> il cliente è stato modificato con successo!<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></p>\r\n"
							+ "  <hr>\r\n" + "</div>";

					request.getSession().setAttribute("MESSAGGIO", modCorretto);
					response.sendRedirect("visualizzaClienti.jsp");
					}
					catch(Exception e){
						e.printStackTrace(); System.out.println("Operazione non andata a buon fine");
						String errorpage="<div class=\"jumbotron text-center\">\r\n" +
								"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> non è possibile modificare il cliente.</h1>\r\n"
								+ "  <hr>\r\n" + "</div>"; request.getSession().setAttribute("MESSAGGIO",
										errorpage); 			response.sendRedirect("");
					}

				}
		
		//---funzione che elimina uno o più dipendenti-----//
		else if(comando.equals("elimina")) {
			String tipo=request.getParameter("tipo");
			if(request.getParameterValues("check")==null) {
				logger.info("nessun elemento selezionato");
			}
			else {
				String codiceCliente[]=request.getParameterValues("check");
				logger.info("Dipendenti DA ELIMINARE :");
				DBManager db;
				for(int i=0;i<codiceCliente.length;i++) {
					logger.info("ID CLIENTE = "+codiceCliente[i]);
					try {
						db = new DBManager();
						db.deleteCliente(codiceCliente[i]);
						db.close();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				
			}
			response.sendRedirect("visualizzaClienti.jsp");
		}
		
		
		
		
				//------cambio password cliente----//
				else if(comando.equals("changepassword"))
				{
					String id = request.getParameter("id");
					String password = request.getParameter("password");
					logger.info(id+" "+password);
					try
					{
						DBManager db = new DBManager();
						//imposto la password nuova
						db.resetPasswordCliente(id, password);
						//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente
						String passCorretta="<div class=\"jumbotron text-center\">\r\n"
								+ "  <p class=\"lead\" style=\"color: green; font-weight: bold;\">La password è stata modificata con successo!<i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></p>\r\n"
								+ "  <hr>\r\n"
								+ "</div>";
						
						
						request.getSession().setAttribute("MESSAGGIO", passCorretta);
						
						response.sendRedirect("gestclienti?cmd=aggiorna&id="+id);
						
					} 
					catch (Exception e) {
						e.printStackTrace();
						
						String errorpage="<div class=\"jumbotron text-center\">\r\n"
								+ "  <h5 class=\"lead\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> la password non è stata modificata</h5>\r\n"		
								+ "  <hr>\r\n"
								+ "</div>";
						request.getSession().setAttribute("MESSAGGIO", errorpage);
						
						response.sendRedirect("gestclienti?cmd=aggiorna&id="+id);
					}
				}
		
		
	}

}
