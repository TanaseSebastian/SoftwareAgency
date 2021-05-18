package it.meucci;

import java.awt.Color;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

public class CreateFatturaPDF {

	public CreateFatturaPDF() throws Exception {
		// TODO Auto-generated constructor stub
	}

	public double stampa(String codiceOrdine,String aggiunta,float prezzoAggiunta) throws Exception
	{
		
		//inizializzo db manager
		DBManager db = new DBManager();
		//creo un arraylist di dettagli ordine
		ArrayList<DettaglioOrdine> elenco= new ArrayList<DettaglioOrdine>();
		//creo un oggetto di tipo ordine
		Ordine o=new Ordine();
		//variabli d'appoggio
		int i;
		DettaglioOrdine d;
		Cliente c= new Cliente();
		  
		//mu prendo dal db le informazioni dell'ordine
		try {
			db= new DBManager();
			o = db.getOrdine(codiceOrdine);
			elenco=db.getDettagliOrdine(codiceOrdine);
			c=db.getCliente(String.valueOf(o.getCodCliente()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		double subtotale=0;
		String nome="TIENI IL CONTO";
		
		// Leggo le proprietà da file properties
		Properties prop;
		ReadPropertyFileFromClassPath obj = new ReadPropertyFileFromClassPath();
		prop = obj.loadProperties("DB.properties");
		String pathStampe = prop.getProperty("pathStampe");
		String pathStileFattura = prop.getProperty("pathStileFattura");
		
		
		
		String outputFileName = pathStampe+"fattura.pdf";
        // Create a document and add a page to it
        PDDocument document = new PDDocument();
        PDPage page1 = new PDPage(PDRectangle.A4);
            // PDRectangle.LETTER and others are also possible
        PDRectangle rect = page1.getMediaBox();
            // rect can be used to get the page width and height
        document.addPage(page1);

        // Create a new font object selecting one of the PDF base fonts
        PDFont fontPlain = PDType1Font.HELVETICA;
        PDFont fontBold = PDType1Font.HELVETICA_BOLD;
        PDFont fontItalic = PDType1Font.HELVETICA_OBLIQUE;
        PDFont fontMono = PDType1Font.COURIER;

        // Start a new content stream which will hold the content that's about to be created
        PDPageContentStream cos = new PDPageContentStream(document, page1);

        int line = 0;
        // add an image
        try {
            PDImageXObject ximage = PDImageXObject.createFromFile(pathStileFattura, document);
            float scale = 0.42f; // alter this value to set the image size
            cos.drawImage(ximage, 0, 0, ximage.getWidth()*scale, ximage.getHeight()*scale);
        } catch (IOException ioex) {
            System.out.println("No image for you");
        }

		
		  // Define a text content stream using the selected font, move the cursor and draw some text
		  cos.beginText(); cos.setFont(fontBold, 40);
		  cos.setNonStrokingColor(Color.black); cos.newLineAtOffset(60,
		  rect.getHeight() - 70*(++line)); cos.showText("FATTURA"); cos.endText();
		  cos.beginText(); cos.setFont(fontPlain, 12);
		  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(60,
		  rect.getHeight() - 320*(++line)); cos.showText("Setech S.R.L");
		  cos.endText(); cos.beginText(); cos.setFont(fontPlain, 12);
		  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(60,
		  rect.getHeight() - 220*(++line)); cos.showText("viale Ferrari 13 ");
		  cos.endText(); cos.beginText(); cos.setFont(fontPlain, 12);
		  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(60,
		  rect.getHeight() - 170*(++line)); cos.showText("73042,Casarano(LE)");
		  cos.endText(); cos.beginText(); cos.setFont(fontPlain, 12);
		  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(60,
		  rect.getHeight() - 140*(++line)); cos.showText("Italia"); cos.endText();
		  cos.beginText(); cos.setFont(fontPlain, 12);
		  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(60,
		  rect.getHeight() - 120*(++line)); cos.showText("P.iva:0123422873239");
		  cos.endText();
		  
		  
		  
		  //--------------PARTE DELLE PRESTAZIONI----------------//
		  
		  
		//prestazione
		  cos.beginText(); cos.setFont(fontBold, 15);
		  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(60,
		  rect.getHeight() - 30*(++line)); cos.showText("Fattura intestata a: "+c.getRagioneSociale()+" Partita iva: "+c.getPartitaIva());
		  cos.endText();
		  
		  
		  
		//scorrimento del vettore e scrittura sul pdf
			 for(i=0;i<elenco.size();i++) 
			    {
						d=(DettaglioOrdine)elenco.get(i);
						Software s=db.getSoftware(d.getCodSoftware());
						
			    
						
						 //prestazione
						  cos.beginText(); cos.setFont(fontBold, 15);
						  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(60,
						  rect.getHeight() - 30*(++line)); cos.showText("-ID:"+s.getCodSoftware()+" "+s.getNome());
						  cos.endText();
				 
						  
						  //totale
				        
						  cos.beginText(); cos.setFont(fontBold, 12);
						  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(470,
						  rect.getHeight() - 30*(line)); cos.showText("€"+s.getCosto());
						  cos.endText();
						
						
						subtotale+=Double.parseDouble(s.getCosto());
			    }
		  
		  
		  if(aggiunta!=null){
		  //aggiunta
		  cos.beginText(); cos.setFont(fontBold, 15);
		  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(60,
		  rect.getHeight() - 30*(++line)); cos.showText(aggiunta);
		  cos.endText();
 
		  
		  //prezzo aggiunta
        
		  cos.beginText(); cos.setFont(fontBold, 12);
		  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(470,
		  rect.getHeight() - 30*(line)); cos.showText("€"+prezzoAggiunta);
		  cos.endText();
		  
		  subtotale+=round(prezzoAggiunta,2);
		  
		  }
		  
		  
		  
		  //----------------FINE PARTE PRESTAZIONI-------------------//
		  
		  
		  double iva=round((subtotale*22)/100, 2);
		  double totale=round(subtotale+iva,2);
		  
		  //area sub totale,iva,totale
		  cos.beginText(); cos.setFont(fontMono, 12);
		  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(460,
		  rect.getHeight() - 567); cos.showText("€"+round(subtotale,2));
		  cos.endText();
		  
		  cos.beginText(); cos.setFont(fontMono, 12);
		  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(460,
		  rect.getHeight() - 585); cos.showText("€"+iva);
		  cos.endText();
		  
		  cos.beginText(); cos.setFont(fontBold, 15);
		  cos.setNonStrokingColor(Color.BLACK); cos.newLineAtOffset(460,
		  rect.getHeight() - 605); cos.showText("€"+totale);
		  cos.endText();
		  
        // close the content stream for page 2
        cos.close();

        // Save the results and ensure that the document is properly closed:
        document.save(outputFileName);
        document.close();
        
        return totale;
}

	public static double round(double value, int places) {
    if (places < 0) throw new IllegalArgumentException();

    long factor = (long) Math.pow(10, places);
    value = value * factor;
    long tmp = Math.round(value);
    return (double) tmp / factor;
}



}
