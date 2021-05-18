package it.meucci;
import java.time.LocalDateTime; // Import the LocalDateTime class
import java.time.format.DateTimeFormatter; // Import the DateTimeFormatter class
import java.util.ArrayList;
import java.util.Properties;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.tomcat.util.http.fileupload.ByteArrayOutputStream;

/**
 * Servlet implementation class GestioneOrdiniServlet
 */
@WebServlet("/gestordini")
public class GestioneOrdiniServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Logger logger = LogManager.getLogger(GestioneOrdiniServlet.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneOrdiniServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");
		DBManager db;

		//--------GESTIONE ORDINI----------------//
		
		//dettagli di un software
		if(comando.equals("dettagli"))
		{
			String id= request.getParameter("id");
			ArrayList<DettaglioOrdine> elenco= new ArrayList<DettaglioOrdine>();
			Ordine o=new Ordine();
			try {
				db= new DBManager();
				o = db.getOrdine(id);
				elenco=db.getDettagliOrdine(id);
				db.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//logger.info(p.toString());
			request.setAttribute("ORDINE",o);
			request.setAttribute("ELENCO_DETTAGLI", elenco);
			RequestDispatcher rd = request.getRequestDispatcher("dettaglioOrdine.jsp");
			rd.forward(request, response);
		}
		
		
		//---funzione che elimina un ordine-----//
		else if(comando.equals("elimina")) {
				String codiceOrdine=request.getParameter("id");
				logger.info("Ordine DA ELIMINARE :"+codiceOrdine);
					try {
						db = new DBManager();
						db.deleteOrdine(codiceOrdine);
						db.close();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					response.sendRedirect("visualizzaOrdini.jsp");
				}
		
		
		else if(comando.equals("fattura")){
			String id= request.getParameter("id");
			ArrayList<DettaglioOrdine> elenco= new ArrayList<DettaglioOrdine>();
			Ordine o=new Ordine();
			try {
				db= new DBManager();
				o = db.getOrdine(id);
				elenco=db.getDettagliOrdine(id);
				db.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//logger.info(p.toString());
			request.setAttribute("ORDINE",o);
			request.setAttribute("ELENCO_DETTAGLI", elenco);
			RequestDispatcher rd = request.getRequestDispatcher("creaFattura.jsp");
			rd.forward(request, response);
		}
		
		
		else if(comando.equals("visualizzaFattura"))
		{
			int id= Integer.parseInt(request.getParameter("id"));
			try {
				db= new DBManager();
				db.viewFattura(id);
				db.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//pdf convertito in flusso di byte e inviato all'interno del browser
			
			
			// Leggo le proprietà da file properties
			Properties prop;
			ReadPropertyFileFromClassPath obj = new ReadPropertyFileFromClassPath();
			prop = obj.loadProperties("DB.properties");
			String pathStampe = prop.getProperty("pathStampe");
			
			
			  OutputStream out =null; String filePath=pathStampe+"documento.pdf";
			  File file=new File(filePath); if(file.exists()) { out =
			  response.getOutputStream();
			  response.setContentType("application/pdf;charset=UTF-8");
			  response.setHeader("Content-Disposition","inline;filename=documento.pdf");
			  FileInputStream fis = new FileInputStream(file); ByteArrayOutputStream bos =
			  new ByteArrayOutputStream(); byte[] buf = new byte [4096];
			  
			  try { for (int readNum; (readNum = fis.read(buf)) != -1;) { bos.write(buf, 0
			 ,readNum); } } catch (Exception e) { e.printStackTrace(); }
			  
			  byte[] bytes =bos.toByteArray(); int lengthRead = 0; InputStream is = new
			  ByteArrayInputStream(bytes);
			  
			  while ((lengthRead = is.read(buf)) > 0) { out.write(buf); }
			  
			  fis.close(); bos.close(); is.close(); out.close();
			  }

		}
		
		
		
		
		
			
			}
		

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");;

		//----------------NUOVA LAVORAZIONE--------------------------//		
		if(comando.equals("nuovo")) {
			//ho bisogno di creare un datetime
		    LocalDateTime myDateObj = LocalDateTime.now();
		    logger.info("Before formatting: " + myDateObj);
		    DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

		    String formattedDate = myDateObj.format(myFormatObj);
		    logger.info("After formatting: " + formattedDate);
		    
		    //creo oggetto ordine
			Ordine o=new Ordine();
			o.setCodCliente(Integer.parseInt(request.getParameter("cliente")));
			o.setDataOrdine(formattedDate);
			o.setDescrizione(request.getParameter("descrizione"));
			logger.info(o.toString());
			
			String codSoftware[]=request.getParameterValues("software");
			logger.info("il codice cliente è:"+o.getCodCliente());
			logger.info(o.toString());

			try { 
				DBManager db = new DBManager();
				db.insertOrdine(o);
				logger.info("nuova ordine inserito con successo nel db");
				int codOrdine=db.getOrderCode(o.getCodCliente(), o.getDataOrdine());
				
				for(int i=0;i<codSoftware.length;i++) {
					logger.info(codSoftware[i]);
					db.inserisciDettaglioOrdine(codOrdine,codSoftware[i]);
					}
				//div che contiene il messaggio di ringraziamento,ovvero l'operazione il codice è stato eseguito correttamente
				String thankyoupage="<div class=\"jumbotron text-center\">\r\n"
						+ "  <h1 class=\"display-3\" style=\"color: green; font-weight: bold;\">Il nuovo ordine è stato registrato correttamente <i class=\"fa fa-check-circle\" aria-hidden=\"true\"></i></h1>\r\n"
						+ "  <hr>\r\n"
						+ "</div>";

				request.getSession().setAttribute("MESSAGGIO", thankyoupage);
				response.sendRedirect("visualizzaOrdini.jsp");
			}
			catch(Exception e){
				e.printStackTrace(); logger.info("Operazione non andata a buon fine");
				String errorpage="<div class=\"jumbotron text-center\">\r\n" +
						"  <h1 class=\"display-3\" style=\"color: red; font-weight: bold;\">Spiacenti<i class=\"fa fa-times\" aria-hidden=\"true\"></i> username già in uso.</h1>\r\n"
						+ "  <hr>\r\n" + "</div>"; request.getSession().setAttribute("MESSAGGIO",
								errorpage);
						response.sendRedirect("nuovoOrdine.jsp");
			}
		}
		
		
		
		
		else if(comando.equals("stampaFattura"))
		{
			
			//leggo le informazioni dalla jsp
			String codiceOrdine=request.getParameter("codiceOrdine");
			String nomeCliente=request.getParameter("ragione");
			String email=request.getParameter("email");
			String nomeAggiunta=null;
			float prezzoAggiunta=0;
			
			if(request.getParameter("nomeaggiunta")==null || request.getParameter("nomeaggiunta").equals("") || request.getParameter("aggiunta")==null){}
			else {
			nomeAggiunta=request.getParameter("nomeaggiunta");
			prezzoAggiunta=Float.parseFloat(request.getParameter("aggiunta"));
			}
			logger.info("codice ordine "+codiceOrdine+" nome cliente: "+nomeCliente+" email cliente: "+email+" aggiunta: "+nomeAggiunta+" prezzo aggiunta: "+prezzoAggiunta);
			//AnotherThing method is called even when the user enters no data, because the testString eleme
			// Leggo le proprietà da file properties
			Properties prop;
			ReadPropertyFileFromClassPath obj = new ReadPropertyFileFromClassPath();
			prop = obj.loadProperties("DB.properties");
			String pathStampe = prop.getProperty("pathStampe");
			String pathStileFattura = prop.getProperty("pathStileFattura");
			CreateFatturaPDF pdf;			
			String filePATH=pathStampe+"fattura.pdf";
			String allegatoName="fattura.pdf";
			
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
					+ "<p style=\"color: black; font-size: x-large; font-weight: 900;\">Gentile Cliente: "+nomeCliente+" , Setech la ringrazia per aver acquistato i nostri prodotti,è grazie alla fiducia di clienti come lei che</p>"
					+"<p style=\"color: #197ED1; font-size: x-large; font-weight: 900;\">Setech si afferma ogni giorno sempre di più come leader di mercato.</strong></p>"
					+ "<p>Le riportiamo di seguito la copia della fattura dell'ordine da lei effettuato:</p>"
					+"<p style=\"color: #197ED1;\"><strong>Per qualsiasi dubbio o problema non esitare a contattarci tramite telefono o email.</strong></p>"
					+"<p style=\"color: #197ED1; font-size: x-large; font-weight: 900;\">Setech le augura una buona giornata.</p>"
					+"</body>"
					+"</html>";
		
		try {
			//ho bisogno di creare un datetime
		    LocalDateTime myDateObj = LocalDateTime.now();
		    logger.info("Before formatting: " + myDateObj);
		    DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

		    String formatDate = myDateObj.format(myFormatObj);
		    logger.info("After formatting: " + formatDate);
			pdf=new CreateFatturaPDF();
			//leggo l'importo totale che mi restituisce la funzione stampa
			double importo= pdf.round(pdf.stampa(codiceOrdine,nomeAggiunta,prezzoAggiunta), 2);
			logger.info("prezzo totale fattura "+importo);
			logger.info("funzione stampa fattura eseguita");
			DBManager db=new DBManager();
			logger.info("inserimento fattura");
			//inserisco tutti i dati all'interno del db
			db.insertFattura(formatDate,importo,filePATH);
			SendMail sender = new SendMail();
			String RECIPIENT=email;
			String[] to = { RECIPIENT }; // list of recipient email addresses
			//invio dell'email con i parametri
			logger.info("invio email");
			sender.sendFromGMail(to, "Setech,Copia della Fattura",messaggioDaInviare,filePATH,allegatoName);
			logger.info("email inviata con successo");
			//recupero id della fattura
			int codiceFattura=db.getFatturaCode(importo, formatDate);
			db.inserisciFattura(Integer.parseInt(codiceOrdine), codiceFattura);
			logger.info("fattura inserita come chiave esterna nell'ordine");
			db.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		
		response.sendRedirect("visualizzaOrdini.jsp");
		
		}
		
		
		
		}
		
		
	}


