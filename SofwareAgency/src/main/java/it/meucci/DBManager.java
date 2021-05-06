package it.meucci;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.tomcat.util.http.fileupload.ByteArrayOutputStream;


public class DBManager{

	//inizializzo il logger
	static Logger logger = LogManager.getLogger(DBManager.class); 
	private static Properties prop;
	private Connection connessione;
	private Statement query;
	private ResultSet rs;
	private ResultSet rs2;
	private String urlDB;
	private String userDB;
	private String pwDB;

	public DBManager() throws Exception{
		
		
//------------------STARTUP DBMANAGER---------------------------------------//		

		// Leggo le proprietà da file properties
		ReadPropertyFileFromClassPath obj = new ReadPropertyFileFromClassPath();
		prop = obj.loadProperties("DB.properties");

		urlDB = prop.getProperty("Url");
		userDB = prop.getProperty("Username");
		pwDB = prop.getProperty("Pasword");



		// creazione della connessione
		// registrazione dei driver
		Class.forName("com.mysql.cj.jdbc.Driver");

		// instauro connessione al db
		connessione = DriverManager.getConnection(urlDB, userDB, pwDB);

		// creo la query
		query = connessione.createStatement();
	}
//--------------------------------------------------------------------------//


//-------------inzio dei metodi del DBManager---------------------//



	//verifica credenziali dell'utente
	public int verificaCredenziali(String username, String password) throws Exception {
		String sql = "SELECT * FROM Dipendenti WHERE USERNAME=? AND PSW=md5(?);";
		PreparedStatement pstm=connessione.prepareStatement(sql);
		pstm.setString(1,username);
		pstm.setString(2,password);
		rs= pstm.executeQuery();
		int count = 0;

		while (rs.next()) {
			++count;
			// Conto il numero di righe
		}
		return count;
	}
	
	
	//verifica le credenziali di accesso per la registrazione
		public int verificaCredenzialidiRegistrazione(String username, String codiceRegistrazione) throws Exception {
			String sql = "SELECT * FROM Dipendenti WHERE USERNAME=? AND codiceRegistrazione=md5(?);";
			PreparedStatement pstm=connessione.prepareStatement(sql);
			pstm.setString(1,username);
			pstm.setString(2,codiceRegistrazione);
			rs= pstm.executeQuery();
			int count = 0;

			while (rs.next()) {
			    ++count;
			    // Conto il numero di righe
			}
			return count;
		}

	//funzione che dato l'username restituisce un oggetto dipendente
	public Dipendente getUser(String username) throws Exception 
	{
		String sql="SELECT * FROM Dipendenti WHERE USERNAME=?";
		PreparedStatement pstm=connessione.prepareStatement(sql);
		pstm.setString(1,username);
		rs= pstm.executeQuery();
		Dipendente user=new Dipendente();
		while(rs.next())
		{
			user=new Dipendente		(rs.getInt(1),rs.getString(2),rs.getString(3), rs.getString(4), rs.getString(5),rs.getString(6),
					rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11),
					rs.getString(12), rs.getString(13),rs.getString(14), rs.getInt(15), rs.getString(16),
					rs.getInt(17), rs.getString(18),rs.getString(19));
		}

		logger.info(user.toString());
		return user;
	}
	
	 //funzione che controlla se l'username utente esiste già
	 public boolean checkUsername(String username) throws Exception { String q =
	 "SELECT * FROM Dipendenti WHERE USERNAME='" + username + "';"; rs =
	  query.executeQuery(q); return rs.next(); }
	 
	 //funzione che registra un nuovo dipendente
	 public int insertDipendente(Dipendente d)
				throws Exception {
			String sql = "INSERT INTO dipendenti(cf,nome,cognome,username,email,phone,qualificaProfessionale,nomeProfessione,dataAssunzione,dataNascita,provincia,stipendio,Amministratore,codDipartimento,codiceRegistrazione) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,md5(?));";
			PreparedStatement pstm=connessione.prepareStatement(sql);
			pstm.setString(1,d.getCf());
			pstm.setString(2,d.getNome());
			pstm.setString(3,d.getCognome());
			pstm.setString(4,d.getUsername());
			pstm.setString(5,d.getEmail());
			pstm.setString(6,d.getPhone());
			pstm.setString(7,d.getQualificaProfessionale());
			pstm.setString(8,d.getNomeProfessione());
			pstm.setString(9,d.getDataAssunzione());
			pstm.setString(10,d.getDataNascita());
			pstm.setString(11,d.getProvincia());
			pstm.setString(12,d.getStipendio());
			pstm.setString(13,d.getAmministratore());
			pstm.setInt(14,d.getCodDipartimento());
			pstm.setString(15,d.getCodiceRegistrazione());
			int nRighe= pstm.executeUpdate();
			return nRighe;
		}
	 
	//metodo che resetta la password con codice fiscale---------------------------------
		public int resetPassword(String cf,String password) throws SQLException {
			int nRighe=0;
			try {
	  			 String sql = "UPDATE Dipendenti SET psw = md5(?) WHERE Cf = ?";
	  			PreparedStatement pstm=connessione.prepareStatement(sql);
				pstm.setString(1,password);
				pstm.setString(2,cf);
	  			logger.info(pstm.toString());
	  			nRighe= pstm.executeUpdate();
	  		  if(nRighe==1)logger.info("password modificata ");
	  		
			} catch (Exception e) {
				e.printStackTrace();
			}
			return nRighe;
		}
		
		
		//metodo che resetta la password con codice fiscale---------------------------------
				public int resetPasswordEmail(String email,String password) throws SQLException {
					int nRighe=0;
					try {
			  			 String sql = "UPDATE Dipendenti SET psw = md5(?) WHERE email = ?";
			  			PreparedStatement pstm=connessione.prepareStatement(sql);
						pstm.setString(1,password);
						pstm.setString(2,email);
			  			logger.info(pstm.toString());
			  			nRighe= pstm.executeUpdate();
			  		  if(nRighe==1)logger.info("password modificata ");
			  		
					} catch (Exception e) {
						e.printStackTrace();
					}
					return nRighe;
				}
		
		
		//metodo che rende attivato il codice registrazione
				public int activeRegistration(String cf) throws SQLException {
					int nRighe=0;
					try {
						 String sql = "UPDATE Dipendenti SET codiceRegistrazione = ? WHERE Cf = ?";
				  			PreparedStatement pstm=connessione.prepareStatement(sql);
							pstm.setString(1,"activated");
							pstm.setString(2,cf);
							logger.info(pstm.toString());
				  			nRighe= pstm.executeUpdate();
				  			if(nRighe==1)logger.info("codice registrazione attivato ");
					} catch (Exception e) {
						e.printStackTrace();
					}
					return nRighe;
				}
				
				
				
				
			    //metodo che mi verifica se l'email esiste nel database-----------------
			    public boolean controlEmail(String email) throws SQLException {
					 String email_validation="";
					 
			       	 String sql = "Select * from Dipendenti Where Email='" + email +"';";
			            rs = query.executeQuery(sql);

			        	while(rs.next())
			   		{
			              email_validation = rs.getString("Email");
			   		}
			        	if(email.equals(email_validation)){
			        		logger.info("email true");
			        		return true;
			        		
			        	}
			        	
			        	else
			        		logger.info("email false");
			        		return false;
			    }
			    //----------------------------------------------------------------------------
				
	 
			    //metodo che mi verifica se l'utente si è registrato esiste nel database-----------------
			    public boolean activatedCodRegistrazione(String email) throws SQLException {
					 String email_validation="";
					 
			       	 String sql = "Select * from Dipendenti Where Email='" + email +"';";
			            rs = query.executeQuery(sql);

			        	while(rs.next())
			   		{
			              email_validation = rs.getString("codiceRegistrazione");
			   		}
			        	if(email.equals("activated")){
			        		logger.info("rimando true,il codice Registrazione risulta essere attivato");
			        		return true;
			        		
			        	}
			        	
			        	else
			        		logger.info("rimando false il codice Registrazione non risulta essere attivato");
			        		return false;
			    }
			    //----------------------------------------------------------------------------
				
			  //GESTIONE DEI CLIENTI ----------------------------------------
				public ArrayList<Dipendente> getPersonale(String tipo) throws Exception 
				{
					ArrayList<Dipendente> elenco = new ArrayList<Dipendente>();
					String sql;
					if(tipo.equals("dipendente"))
						sql="SELECT * FROM Dipendenti WHERE AMMINISTRATORE='N';";
					else
						sql="SELECT * FROM Dipendenti WHERE AMMINISTRATORE='Y';";
					rs=query.executeQuery(sql);
					Dipendente d;
					
					while(rs.next())
					{
						d=new Dipendente();
						d.setCodiceDipendente(rs.getInt("codiceDipendente"));
						d.setNome(rs.getString("nome"));
						d.setCognome(rs.getString("cognome"));
						d.setQualificaProfessionale(rs.getString("qualificaProfessionale"));
						d.setNomeProfessione(rs.getString("nomeProfessione"));
						d.setStipendio(rs.getString("stipendio"));
						d.setCodDipartimento(rs.getInt("codDipartimento"));
						d.setImmagineProfilo(rs.getString("immagineProfilo"));
						d.setAmministratore(rs.getString("amministratore"));
						elenco.add(d);
					}
					
					logger.info("DIPENDENTI CARICATI: " + elenco.size());
					
					return elenco;
				}
	 
	public void close() throws Exception {
		query.close();
		connessione.close();
	}
}