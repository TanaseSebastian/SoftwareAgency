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

		// Leggo le propriet� da file properties
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


	
	public int verificaCredenziali(String username, String password) throws Exception {
		String sql = "SELECT * FROM UTENTI WHERE USERNAME=? AND PSW=md5(?);";
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
	
	//FUNZIONE CHE RESTITUISCE GLI UTENTI
		public Utente getUser(String username) throws Exception 
		{
			String sql="SELECT * FROM UTENTI WHERE USERNAME=?";
			PreparedStatement pstm=connessione.prepareStatement(sql);
			pstm.setString(1,username);
			rs= pstm.executeQuery();
			Utente user=new Utente();
			while(rs.next())
			{
				user=new Utente(rs.getString(1),rs.getString(2),rs.getString(3),
	                    rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getString(9)); 
			}
			return user;
		}

	public boolean checkUsername(String username) throws Exception {
		String q = "SELECT * FROM UTENTI WHERE USERNAME='" + username + "';";
		rs = query.executeQuery(q);
		return rs.next();
	}

	public int insertRegistration(String cf, String nome, String cognome, String username, String email,String phone, String password)
			throws Exception {
		String sql = "INSERT INTO utenti(CF,NOME,COGNOME,USERNAME,EMAIL,PHONE,PSW) VALUES (?,?,?,?,?,?,md5(?));";
		PreparedStatement pstm=connessione.prepareStatement(sql);
		pstm.setString(1,cf);
		pstm.setString(2,nome);
		pstm.setString(3,cognome);
		pstm.setString(4,username);
		pstm.setString(5,email);
		pstm.setString(6,phone);
		pstm.setString(7,password);
		int nRighe= pstm.executeUpdate();
		return nRighe;
	}
	public int insertAmministrator(String cf, String nome, String cognome, String username, String email,String phone, String password)
			throws Exception {
		String sql = "INSERT INTO utenti  VALUES (?,?,?,?,?,?,md5(?),?);";
		PreparedStatement pstm=connessione.prepareStatement(sql);
		pstm.setString(1,cf);
		pstm.setString(2,nome);
		pstm.setString(3,cognome);
		pstm.setString(4,username);
		pstm.setString(5,email);
		pstm.setString(6,phone);
		pstm.setString(7,password);
		pstm.setString(8,"Y");
		int nRighe= pstm.executeUpdate();
		return nRighe;
	}
    //metodo che mi verifica se l'email esiste nel database-----------------
    public boolean controlEmail(String email) throws SQLException {
		 String email_validation="";
		 
       	 String sql = "Select * from UTENTI Where Email='" + email +"';";
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
	
    	//metodo che resetta la password------------------------------------------
  		public void resetPassword(String email,String password) throws SQLException {
  			
  			try {
  	  			Statement update = connessione.createStatement();
  	  			 String sql = "UPDATE Utenti "+ "SET" + " PSW = "+"md5('"+password+"') " + "WHERE"+ " Email = "+"'"+email+"'; ";
  	  			 logger.info(sql);
  	  			 update.executeUpdate(sql);
  	  		        
  	  		  logger.info("password modificata ");
			} catch (Exception e) {
				e.printStackTrace();
			}

  		  
  			
  		}
  		//----------------------------------------------------------------------------------
	
	
  		//funzione che mi resituisce i dottori di un particolare dipartimento
  		public ArrayList<Dottore> getDottori(String dipartimento) throws Exception 
  		{
  			ArrayList<Dottore> elenco = new ArrayList<Dottore>();
  			
  			String sql="SELECT * FROM DOTTORI WHERE codDipartimento ="+dipartimento+";";
  			rs=query.executeQuery(sql);
  			Dottore d;
  			
  			while(rs.next())
  			{
  				d=new Dottore(rs.getInt(1),rs.getString(2),rs.getString(3),
  	                    rs.getString(4),rs.getString(5),rs.getInt(6)); 
  				elenco.add(d);
  			}
  			
  			logger.info("DOTTORI CARICATI: " + elenco.size());
  			
  			return elenco;
  		}
  		
  		
  		
  		
  		
  	//funzione che mi resituisce le prestazioni di un particolare dipartimento
  		public ArrayList<Prestazione> getPrestazioni(String dipartimento) throws Exception 
  		{
  			ArrayList<Prestazione> elenco = new ArrayList<Prestazione>();
  			
  			String sql="SELECT * FROM PRESTAZIONI WHERE codDipartimento ="+dipartimento+";";
  			rs=query.executeQuery(sql);
  			Prestazione p;
  			
  			while(rs.next())
  			{
  				p=new Prestazione(rs.getInt(1),rs.getString(2),rs.getInt(3)); 
  				elenco.add(p);
  			}
  			
  			logger.info("PRESTAZIONI CARICATE: " + elenco.size());
  			
  			return elenco;
  		}
  		
  		
  		
  		
  		
  		//funzione che permette l'inserimento di una prenotazione
  		public int insertPrenotazione(Prenotazione p) throws Exception
  		{
  		int nRighe=0;
  		String sqlInsert = "INSERT INTO PRENOTAZIONI(codFisc,codDottore,codPrestazione,dateTime,commento) VALUES (?,?,?,?,?);";
  		PreparedStatement pstm=connessione.prepareStatement(sqlInsert);
  		pstm.setString(1, p.getCodFisc());
  		pstm.setInt(2, p.getCodDottore());
  		pstm.setInt(3, p.getCodPrestazione());
  		pstm.setString(4, p.getDateTime());
  		pstm.setString (5, p.getCommento());
  		nRighe= pstm.executeUpdate();
  		return nRighe;
  		}
  		
  		
  		

		//funzione che restituisce la email di un utente
		public String getEmail(String cf)throws Exception {
			String sql="SELECT EMAIL FROM UTENTI WHERE CF='"+cf+"' ;";
			rs = query.executeQuery(sql);
			String s = "";
			if (rs.next()) {
				String EMAIL = rs.getString("EMAIL");
				s = EMAIL;
			}
			logger.info(s);
			return s;
		}
		
		
		//funzione che restituisce il nome completp di un utente
		public String getFullName(String cf)throws Exception {
			String sql="SELECT COGNOME,NOME FROM UTENTI WHERE CF='"+cf+"' ;";
			rs = query.executeQuery(sql);
			String s = "";
			if (rs.next()) {
				String COGNOME = rs.getString("COGNOME");
				String NOME = rs.getString("NOME");
				s = COGNOME+" "+NOME;
			}
			//logger.info(s);
			return s;
		}
		
		
		//funzione che restituisce il nome di un dottore dato il codice identificativo
		public String getDoctorName(String codDottore)throws Exception {
			String sql="SELECT Cognome,Nome FROM DOTTORI WHERE codDottore="+codDottore+" ;";
			rs = query.executeQuery(sql);
			String s = "";
			if (rs.next()) {
				String Cognome= rs.getString("Cognome");
				String Name=rs.getString("Nome");
				s = Cognome+" "+Name;
			}
			//logger.info(s);
			return s;
		}
		
	

		
		//funzione che restituisce la data in formato italiano
		public String getItalianDate(String date)throws Exception {
			String sql1="  SET lc_time_names = 'it_IT';";
			//logger.info("Stringa arrivata = "+date);
			String sql="select date_format("+"'"+date+"'"+",'%W %d %M %Y') as DATA;";
			//logger.info(sql);
			rs2 = query.executeQuery(sql1);
			rs = query.executeQuery(sql);
			//logger.info("Query scritta");
			String s="";
			if (rs.next()) {
				//logger.info("entrato nell'if");
				String data = rs.getString(1);
				s =data; 
				//logger.info("ho preso la data dal db,data in italiano: "+ s);
			}
			return s;
		}

  		
	
	//--------------------------INIZIO PARTE DEL DB MANAGER CHE GESTISCE LE RICHIESTE SULLE PRENOTAZIONI---------------------------
	
	public ArrayList<Prenotazione> getPrenotazioni() throws Exception 
	{
		ArrayList<Prenotazione> elenco = new ArrayList<Prenotazione>();
		
		String sql="SELECT * FROM Prenotazioni;";
		rs=query.executeQuery(sql);
		Prenotazione p;
		
		while(rs.next())
		{
			p=new Prenotazione(rs.getInt(1),rs.getString(2),rs.getString(3),
                    rs.getInt(4),rs.getString(5),rs.getInt(6),rs.getString(7)); 
			elenco.add(p);
		}
		
		logger.info("PRENOTAZIONI CARICATE: " + elenco.size());
		
		return elenco;
	}
	
	//funzione che restituisce i dati di una particolare Prenotazione
	public Prenotazione getPrenotazione(String id) throws Exception 
	{
		Prenotazione p = new Prenotazione();
		
		String sql="SELECT * FROM Prenotazioni WHERE codPrenotazione='"+id+"';";
		rs=query.executeQuery(sql);
		
		if (rs.next()) {
			p=new Prenotazione(rs.getInt(1),rs.getString(2),rs.getString(3),
                    rs.getInt(4),rs.getString(5),rs.getInt(6),rs.getString(7)); 
		}
		return p;
	}
	
	
	
	
	
	
	//funzione che restituisce il nome della prestazione dato il codice identificativo
	public String getPrestazioneName(String codPrestazione)throws Exception {
		String sql="SELECT Nome FROM PRESTAZIONI WHERE codPrestazione="+codPrestazione+" ;";
		rs = query.executeQuery(sql);
		String s = "";
		if (rs.next()) {
			String Name = rs.getString("Nome");
			s =Name;
		}
		//logger.info(s);
		return s;
	}
	
	
	
	//funzione che elimina un array di Ogetti di tipo Prenotazione
	
	public int deletePrenotazioni(String[] id) throws Exception 
	{
		String delimiter = ",";
		String s=String.join(delimiter, id);
		String deleteSql="DELETE FROM prenotazioni  WHERE codPrenotazione IN ("+s+");";
		logger.info("QUERY:"+deleteSql);
		int nRighe=query.executeUpdate(deleteSql);
		logger.info("Numero Prenotazioni eliminate dal db:"+nRighe);
		return nRighe;
	}
	
	public int setStatoPrenotazioni(String[] id,String stato) throws Exception 
	{
		String delimiter = ",";
		String s=String.join(delimiter, id);
		String sql="UPDATE prenotazioni\r\n"
		+"SET stato ='"+stato+"' WHERE codPrenotazione IN ("+s+");";
		logger.info("QUERY:"+sql);
		int nRighe=query.executeUpdate(sql);
		logger.info("Numero Prenotazioni modificate dal db:"+nRighe);
		return nRighe;
	}
	
	
	
	//FUNZIONE CHE MODIFICA UNA PRENOTAZIONE
	public int modificaPrenotazione(Prenotazione p) throws Exception
	{			
	int nRighe=0;
	String sqlInsert = "UPDATE prenotazioni\r\n"
			+ "SET codPrenotazione= ?, dateTime= ?, commento= ?, codPrestazione= ?, codFisc= ?, codDottore= ? \r\n"
			+ "WHERE codPrenotazione= ?;";
	PreparedStatement pstm=connessione.prepareStatement(sqlInsert);
	pstm.setInt(1, p.getCodPrenotazione());
	pstm.setString(2,  p.getDateTime());
	pstm.setString(3, p.getCommento());
	pstm.setInt(4, p.getCodPrestazione());
	pstm.setString (5, p.getCodFisc());
	pstm.setFloat(6,p.getCodDottore());
	pstm.setInt(7,p.getCodPrenotazione());
	nRighe= pstm.executeUpdate();
	return nRighe;
	}
	
	
	//FUNZIONE CHE RESTITUISCE IL NUMERO DI PRENOTAZIONI DATO LO STATO
		public String getNumPrenotazioni(String stato) throws Exception
		{		
		String s="";
		String sql = "SELECT count(*) FROM PRENOTAZIONI WHERE STATO=? ;";
		PreparedStatement pstm=connessione.prepareStatement(sql);
		pstm.setString(1, stato);
		rs=pstm.executeQuery();
		if (rs.next()) {
			String count = rs.getString(1);
			s =count;
		}
		//logger.info(s);
		return s;
		}
	
		
		//FUNZIONE CHE RESTITUISCE IL NUMERO DI CLIENTI
				public String getNumClienti() throws Exception
				{		
				String s="";
				String sql = "SELECT DISTINCT COUNT(*) FROM UTENTI WHERE AMMINISTRATORE=\"N\" ;";
				rs = query.executeQuery(sql);
				if (rs.next()) {
					String count = rs.getString(1);
					s =count;
				}
				//logger.info(s);
				return s;
				}
	
				
		//GESTIONE DEI CLIENTI ----------------------------------------
				public ArrayList<Utente> getClienti() throws Exception 
				{
					ArrayList<Utente> elenco = new ArrayList<Utente>();
					
					String sql="SELECT * FROM UTENTI WHERE AMMINISTRATORE='N';";
					rs=query.executeQuery(sql);
					Utente c;
					
					while(rs.next())
					{
						c=new Utente(rs.getString(1),rs.getString(2),rs.getString(3),
			                    rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getString(9)); 
						elenco.add(c);
					}
					
					logger.info("CLIENTI CARICATI: " + elenco.size());
					
					return elenco;
				}
				
				//funzione che restituisce i dati di un particolare cliente 
				public Utente getCliente(String id) throws Exception 
				{
					Utente c = new Utente();
					
					String sql="SELECT * FROM UTENTI WHERE CF='"+id+"';";
					rs=query.executeQuery(sql);
					
					if (rs.next()) {
						c=new Utente(rs.getString(1),rs.getString(2),rs.getString(3),
			                    rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getString(9)); 
					}
					return c;
				}
				
				public int modificaCliente(String cf,String email,String phone,String username) throws SQLException 
				{			
					int nRighe=0;
					String sqlInsert = "UPDATE UTENTI\r\n"
							+ "SET USERNAME= ?, EMAIL= ?, PHONE= ?\r\n"
							+ "WHERE CF= ?;";
					PreparedStatement pstm=connessione.prepareStatement(sqlInsert);
					pstm.setString(1, username);
					pstm.setString(2,  email);
					pstm.setString(3, phone);
					pstm.setString(4, cf);
					nRighe= pstm.executeUpdate();
					return nRighe;
				}
				
				//funzione che elimina un array di Oggetti di tipo Cliente
				
				public int deleteClienti(String[] id) throws Exception 
				{
					String delimiter = ",";
					String s=String.join(delimiter, id);
					String deleteSql="DELETE FROM UTENTI  WHERE CF IN ('"+s+"');";
					logger.info("QUERY:"+deleteSql);
					int nRighe=query.executeUpdate(deleteSql);
					logger.info("Numero Clienti eliminati dal db:"+nRighe);
					return nRighe;
				}
				
		//GESTIONE DEGLI AMMINISTRATORI ----------------------------------------
				public ArrayList<Utente> getAmministratori() throws Exception 
				{
					ArrayList<Utente> elenco = new ArrayList<Utente>();
					
					String sql="SELECT * FROM UTENTI WHERE AMMINISTRATORE='Y';";
					rs=query.executeQuery(sql);
					Utente a;
					
					while(rs.next())
					{
						a=new Utente(rs.getString(1),rs.getString(2),rs.getString(3),
			                    rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getString(9)); 
						elenco.add(a);
					}
					
					logger.info("AMMINISTRATORI CARICATI: " + elenco.size());
					
					return elenco;
				}
				
				//funzione che restituisce i dati di un particolare amministratore 
				public Utente getAmministratore(String id) throws Exception 
				{
					Utente a = new Utente();
					
					String sql="SELECT * FROM UTENTI WHERE CF='"+id+"';";
					rs=query.executeQuery(sql);
					
					if (rs.next()) {
						a=new Utente(rs.getString(1),rs.getString(2),rs.getString(3),
			                    rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getString(9)); 
					}
					return a;
				}
				
				public Utente getUtente(String id) throws Exception 
				{
					Utente u = new Utente();
					
					String sql="SELECT * FROM UTENTI WHERE CF='"+id+"';";
					rs=query.executeQuery(sql);
					
					if (rs.next()) {
						u=new Utente(rs.getString(1),rs.getString(2),rs.getString(3),
			                    rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getString(9)); 
					}
					return u;
				}
	
	
	
	public int insertFattura(Fattura f,String file) throws Exception
	{
	int nRighe=0;
	File theFile = new File(file);
	FileInputStream input = new FileInputStream(theFile);
	String sqlInsert = "INSERT INTO fatture(codicePrenotazione,importo,documento) VALUES (?,?,?)";
	PreparedStatement pstm=connessione.prepareStatement(sqlInsert);
	pstm.setString(1, f.getCodicePrenotazione());
	pstm.setDouble(2, f.getPrezzo());
	pstm.setBinaryStream(3, input);
	nRighe= pstm.executeUpdate();
	return nRighe;
	}
	
	public int insertDoctor( String nome, String cognome, String phone, String email, int codDipartimento )
			throws Exception {
		String sql = "INSERT INTO DOTTORI(nome,cognome,phone,email,codDipartimento)  VALUES (?,?,?,?,?);";
		PreparedStatement pstm=connessione.prepareStatement(sql);
		pstm.setString(1,nome);
		pstm.setString(2,cognome);
		pstm.setString(3,phone);
		pstm.setString(4,email);
		pstm.setInt(5,codDipartimento);
		int nRighe= pstm.executeUpdate();
		return nRighe;
	}
	
	//metodo per vedere le fatture
	public int viewFattura(String id) throws Exception
	{
	int nRighe=0;
	String sql = "select documento from fatture where codiceFattura=?";
	PreparedStatement pstm=connessione.prepareStatement(sql);
	pstm.setString(1, id);
	
	// 3. Set up a handle to the file
	
	// Leggo le proprietà da file properties
			Properties prop;
			ReadPropertyFileFromClassPath obj = new ReadPropertyFileFromClassPath();
			prop = obj.loadProperties("DB.properties");
			String pathStampe = prop.getProperty("pathStampe");
	
	File theFile = new File(pathStampe+"documento.pdf");
	FileOutputStream output = new FileOutputStream(theFile);
	rs=pstm.executeQuery();
	if (rs.next()) {

		InputStream input = rs.getBinaryStream("documento"); 
		logger.info("sto leggendo il documeto dal database...");
		
		byte[] buffer = new byte[1024];
		while (input.read(buffer) > 0) {
			output.write(buffer);
		}
		
		logger.info("\nIl file è stato salvato in: " + theFile.getAbsolutePath());
		
		logger.info("\nCompletato con successo!");
	}
	return nRighe;
	}
	
	
	public int insertImage(String cf,String image) throws Exception{
		
		String sql = "UPDATE UTENTI\r\n"
				+ "SET Image= ? \r\n"
				+ "WHERE CF= ?;";
		PreparedStatement pstm=connessione.prepareStatement(sql);
		pstm.setString(1,image);
		pstm.setString(2,cf);
		int nRighe= pstm.executeUpdate();
		logger.info("immagine inserita");
		return nRighe;
	}
	
	
	public void close() throws Exception {
		query.close();
		connessione.close();
	}
}
