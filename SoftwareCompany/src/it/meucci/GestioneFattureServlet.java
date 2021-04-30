package it.meucci;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.ByteArrayOutputStream;

/**
 * Servlet implementation class GestioneFattureServlet
 */
@WebServlet("/gestfatture")
public class GestioneFattureServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneFattureServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comando = request.getParameter("cmd");
		DBManager db;
		
		
		
		
		//funzione che visualizza e restituisce alla jsp i dettagli di un prodotto
				if(comando.equals("visualizzaFattura"))
				{
					String id= request.getParameter("id");
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
					  response.setHeader("Content-Disposition","inline;filename=fattura.pdf");
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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
