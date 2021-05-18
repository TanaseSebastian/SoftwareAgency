package it.meucci;

import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class SendMail {

	public SendMail() {
		// TODO Auto-generated constructor stub
	}
	
	//dati account
	 private static String from = "prglogin@gmail.com";  // Inserire lo username GMail (la parte prima di "@gmail.com")
	    private static String pass = "HeDj2NSwBQ5yanU"; //  password dell'account Gmail
	
	//funzione che invia l'email
	public static void sendFromGMail(String[] to, String subject, String body,String allegatoPATH,String allegatoName) {
        Properties props = System.getProperties();
        String host = "smtp.gmail.com";
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.user", from);
        props.put("mail.smtp.password", pass);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        
        Session session = Session.getDefaultInstance(props);
        

        MimeMessage message = new MimeMessage(session);

       
            
            if(allegatoName!=null) {
            //parte con allegato

                try {
                	message.setFrom(new InternetAddress(from));
                    InternetAddress[] toAddress = new InternetAddress[to.length];

                    // To get the array of addresses
                    for( int i = 0; i < to.length; i++ ) {
                        toAddress[i] = new InternetAddress(to[i]);
                    }

                    for( int i = 0; i < toAddress.length; i++) {
                        message.addRecipient(Message.RecipientType.TO, toAddress[i]);
                    }

                    message.setSubject(subject);

                    MimeBodyPart messageBodyPart = new MimeBodyPart();
                    MimeBodyPart messageBodyPart1 = new MimeBodyPart();
                    Multipart multipart = new MimeMultipart();
                    
                    String file = allegatoPATH;
                    String fileName = allegatoName;
                    DataSource source = new FileDataSource(file);
                    messageBodyPart.setDataHandler(new DataHandler(source));
                    messageBodyPart.setFileName(fileName);
                    messageBodyPart1.setContent(body, "text/html; charset=utf-8");
                    multipart.addBodyPart(messageBodyPart);
                    multipart.addBodyPart(messageBodyPart1);
                    
                    
                    //parte con immagine logo
                    // second part (the image)
                    messageBodyPart = new MimeBodyPart();
                    DataSource fds = new FileDataSource
                      ("/home/sebastian/_logo.png");
                    messageBodyPart.setDataHandler(new DataHandler(fds));
                    messageBodyPart.setHeader("Content-ID","<image>");

                    // add it
                    multipart.addBodyPart(messageBodyPart);
                    
                    
                    
                    
                    message.setContent(multipart);
                   
                    System.out.println("Sto inviando..");

                    Transport transport = session.getTransport("smtp");
                    transport.connect(host, from, pass);
                    transport.sendMessage(message, message.getAllRecipients());
                    transport.close();
                    
                    System.out.println("Email inviata.");

                } catch (MessagingException e) {
                    e.printStackTrace();
                }
              }
            else {
            
            	 try {
                     message.setFrom(new InternetAddress(from));
                     InternetAddress[] toAddress = new InternetAddress[to.length];

                     // To get the array of addresses
                     for( int i = 0; i < to.length; i++ ) {
                         toAddress[i] = new InternetAddress(to[i]);
                     }

                     for( int i = 0; i < toAddress.length; i++) {
                         message.addRecipient(Message.RecipientType.TO, toAddress[i]);
                     }
                     
                     message.setSubject(subject);
                     
                     MimeMultipart multipart = new MimeMultipart("related");
                     BodyPart messageBodyPart = new MimeBodyPart();
                     
                     messageBodyPart.setContent(body, "text/html; charset=utf-8");
                     
                     multipart.addBodyPart(messageBodyPart);
                     
                     // second part (the image)
                     messageBodyPart = new MimeBodyPart();
                     DataSource fds = new FileDataSource
                       ("/home/sebastian/_logo.png");
                     messageBodyPart.setDataHandler(new DataHandler(fds));
                     messageBodyPart.setHeader("Content-ID","<image>");

                     // add it
                     multipart.addBodyPart(messageBodyPart);

                     // put everything together
                     message.setContent(multipart);
            
            
            
            Transport transport = session.getTransport("smtp");
            transport.connect(host, from, pass);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
        }
        catch (AddressException ae) {
            ae.printStackTrace();
        }
        catch (MessagingException me) {
            me.printStackTrace();
        }
    }
	}
}
