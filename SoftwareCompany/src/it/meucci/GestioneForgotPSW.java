package it.meucci;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GestioneForgotPSW
 */
@WebServlet("/gestforgot")
public class GestioneForgotPSW extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public  String email;
	public int code;
	   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneForgotPSW() {
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
		
		
		String comando = request.getParameter("cmd");;
		
		
		
		//verifyemail
		if(comando.equals("verifyemail")) {
		try {

		    email=request.getParameter("email");
			System.out.println("email inserita dall'utente : " +email);
			System.out.println("sto cercando di connettermi al db");
			DBManager db=new DBManager();
			if(db.controlEmail(email)==true) {
				System.out.println("lo rimando su sendCode.html");
				response.sendRedirect("ForgotPSW\\sendCode.html");
			}
			else {
				response.sendRedirect("forgot.jsp");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
		
		
		//sendcode
		else if(comando.equals("sendcode")) {
		try {
			  //creazione del codice di verifica
	        int new_code;
	         new_code = 10000 + new Random().nextInt(90000); // 10000 - 99999
	         code=new_code;
	         System.out.println("il codice � :"+code);
	         
	         
		        SendMail sender = new SendMail();
		 		String RECIPIENT=email;
		 		String[] to = { RECIPIENT }; // list of recipient email addresses
		        String subject = "Codice di verifica per il recupero della password";
		        String body = "Gentile utente il suo codice di verifica � il seguente : "+code+ " la preghiamo di inserirlo nel sito per autenticare l'account";
		        
				String messaggioDaInviare ="<!DOCTYPE html>"
						+ "<html lang='en'>"
						+ " <head>"
						+ "<meta charset='UTF-8'>"
								+ "<meta http-equiv='X-UA-Compatible' content='IE=edge'>"
										+ "<meta name='viewport' content='width=device-width, initial-scale=1.0\'>"
								+ "<title>Messaggio</title>"
								+ "</head>"
								+ "<body style='text-align: center; font-size: larger;'>"
								+ "<p style=\"color: #2C4964; font-size:40px; font-weight: 900; font-family:sans-serif;\">Medilab</p>"
										+ "<p style=\"color: #2C4964; font-size: x-large; font-weight: 900;\">Gentile cliente, per reimpostare la password utilizzare il seguende codice:</p>"
												+ "<p style=\"color: green; font-size: 40px; font-weight: 900;\"><strong>"+code+"</strong></p>"
						+"<p style=\"color: yellowgreen;\"><strong>Per qualsiasi dubbio o problema non esitare a contattarci tramite telefono o email,siamo a vostra disposizione.</strong></p>"
						+"<p style=\"color: #2C4964; font-size: x-large; font-weight: 900;\">Medilab le augura una buona giornata.</p>"
						+"</body>"
						+"</html>";
						
		        
		      //invio dell'email con i parametri
				sender.sendFromGMail(to, subject,messaggioDaInviare,null,null);
		        
		        response.sendRedirect("ForgotPSW\\verifyCode.html");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
		
		
		
		
		
		
				
		else if(comando.equals("codecontrol")) {
		
		//control code
		int code_validation=Integer.parseInt(request.getParameter("code"));
		System.out.println("sto controllando il codice");
		System.out.println("codice giusto : " +code);
		System.out.println("codice inserito dall'utente "+code_validation);
		if(code==code_validation) {
			System.out.println("i codici corrispondono");
			System.out.println("reindirizzo il client verso resetPSW.html");
			response.sendRedirect("ForgotPSW\\resetPSW.html");
		}
		else {
			System.out.println("l'utente ha sbagliato il codice lo inoltro su verifyCodeError.html");
			response.sendRedirect("ForgotPSW\\verifyCodeError.html");
		}
		
		}
		
		
		
		
		//resetpsw
		else if(comando.equals("resetpsw")) {
		String password = request.getParameter("password");
		System.out.println("il cliente ha inserito una nuova password : "+password);
		
	
		try {
			DBManager db=new  DBManager();
			db.resetPassword(email, password);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("ora lo reindirizzo su successResetPSW.html");
		response.sendRedirect("ForgotPSW\\successResetPSW.html");
		}
		
		

		
		
		
		
	}

}
