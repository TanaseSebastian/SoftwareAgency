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

import com.twilio.rest.serverless.v1.service.AssetDeleter;


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


	//-------------INIZIO METODI---------------------//


	
	//------------GESTIONE DEI DIPENDENTI ----------------------------------//

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

	//funzione che dato il codice Dipendente restituisce un oggetto dipendente
	public Dipendente getUser(String codiceDipendente) throws Exception 
	{
		String sql="SELECT * FROM Dipendenti WHERE codiceDipendente=?";
		PreparedStatement pstm=connessione.prepareStatement(sql);
		pstm.setString(1,codiceDipendente);
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
	
	
	

	//funzione che dato il codice Dipendente restituisce un oggetto dipendente
	public Dipendente getUserbyUsername(String username) throws Exception 
	{
		String sql="SELECT * FROM Dipendenti WHERE username=?";
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
		pstm.setString(13,"N");
		pstm.setInt(14,d.getCodDipartimento());
		pstm.setString(15,d.getCodiceRegistrazione());
		int nRighe= pstm.executeUpdate();
		return nRighe;
	}



	//funzione che registra un nuovo amministratore
	public int insertAmministratore(Dipendente d)
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
		pstm.setString(13,"Y");
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


	//metodo che resetta la password con email--------------------------------
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


	
	//funzione che ritorna elenco dipendenti
	public ArrayList<Dipendente> getPersonale(String tipo) throws Exception 
	{
		ArrayList<Dipendente> elenco = new ArrayList<Dipendente>();
		String sql="";
		if(tipo.equals("dipendente"))
			sql="SELECT * FROM Dipendenti WHERE AMMINISTRATORE='N';";
		else if(tipo.equals("amministratore"))
			sql="SELECT * FROM Dipendenti WHERE AMMINISTRATORE='Y';";
		else
			sql="SELECT * FROM Dipendenti;";
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
			d.setDataNascita(rs.getString("dataNascita"));
			d.setProvincia(rs.getString("provincia"));
			d.setImmagineProfilo(rs.getString("immagineProfilo"));
			elenco.add(d);
		}

		logger.info("DIPENDENTI CARICATI: " + elenco.size());

		return elenco;
	}



	//metodo che mi restituisce il nome del dipartimento dato il nome dipartiemnto
	public String getNomeDipartimento(String codiceDipartimento) throws SQLException {
		String nomeDipartimento="";
		String sql="SELECT Nome FROM Dipartimenti WHERE codDipartimento='"+codiceDipartimento+"';";
		rs = query.executeQuery(sql);
		if (rs.next()) {
			String NOME = rs.getString("NOME");
			nomeDipartimento = NOME;
		}

		return nomeDipartimento;
	}
	
	
	//metodo che mi restituisce il full name di un dipendente dato il codiceDipendente
	public String getFullName(String codiceDipendente)throws Exception {
		String sql="SELECT cognome,nome FROM Dipendenti WHERE codiceDipendente='"+codiceDipendente+"' ;";
		rs = query.executeQuery(sql);
		String s = "";
		if (rs.next()) {
			String COGNOME = rs.getString("cognome");
			String NOME = rs.getString("nome");
			s = COGNOME+" "+NOME;
		}
		//logger.info(s);
		return s;
	}
	



	//funzione che elimina un array di Oggetti di tipo Dipendente
	public int deleteDipendenti(String[] id) throws Exception 
	{
		String delimiter = ",";
		String s=String.join(delimiter, id);
		String deleteSql="DELETE FROM Dipendenti  WHERE codiceDipendente IN ('"+s+"');";
		logger.info("QUERY:"+deleteSql);
		int nRighe=query.executeUpdate(deleteSql);
		logger.info("Numero Dipendenti eliminati dal db:"+nRighe);
		return nRighe;
	}


	//funzione che aggiorna un nuovo dipendente
		public int aggiornaUtente(Dipendente d)
				throws Exception {
			String sql="UPDATE dipendenti SET username = ?, email =?, phone = ?, qualificaProfessionale = ?, nomeProfessione = ?, dataAssunzione = ? , provincia = ?, stipendio = ?, anniAnzianita = ?, amministratore = ?, codDipartimento = ? WHERE cf = ? ";
			PreparedStatement pstm=connessione.prepareStatement(sql);
			pstm.setString(1,d.getUsername());
			pstm.setString(2,d.getEmail());
			pstm.setString(3,d.getPhone());
			pstm.setString(4,d.getQualificaProfessionale());
			pstm.setString(5,d.getNomeProfessione());
			pstm.setString(6,d.getDataAssunzione());
			pstm.setString(7,d.getProvincia());
			pstm.setString(8,d.getStipendio());
			pstm.setInt(9,d.getAnniAnzianita());
			pstm.setString(10,d.getAmministratore());
			pstm.setInt(11,d.getCodDipartimento());
			pstm.setString(12,d.getCf());
			int nRighe= pstm.executeUpdate();
			return nRighe;
		}
		
		
		//funzione che gestisce gli aggirnamenti mandati da profile.jsp
				public int aggiornaUtenteProfilo(Dipendente d)
						throws Exception {
					String sql="UPDATE dipendenti SET username = ?, email =?, phone = ?, provincia = ? WHERE cf = ? ";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,d.getUsername());
					pstm.setString(2,d.getEmail());
					pstm.setString(3,d.getPhone());
					pstm.setString(4,d.getProvincia());
					pstm.setString(5,d.getCf());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
		
		
		//funzione che permette di inserire le immagini di profilo
		public int insertImage(String codiceDipendente,String image) throws Exception{
			
			String sql = "UPDATE Dipendenti\r\n"
					+ "SET immagineProfilo= ? \r\n"
					+ "WHERE codiceDipendente= ?;";
			PreparedStatement pstm=connessione.prepareStatement(sql);
			pstm.setString(1,image);
			pstm.setString(2,codiceDipendente);
			int nRighe= pstm.executeUpdate();
			logger.info("immagine inserita");
			return nRighe;
		}
		
		//----------------------------------------------------------------//
		

		
		//----------------------PACCHETTI SOFTWARE---------------------------//
		
		//funzione che inserisce un pacchetto software
		public int insertSoftware(Software s)
				throws Exception {
			String sql = "INSERT INTO software(codResponsabile,nome,descrizione,tempoGiorniUomo,costo) VALUES (?,?,?,?,?);";
			PreparedStatement pstm=connessione.prepareStatement(sql);
			pstm.setInt(1,s.getCodResponsabile());
			pstm.setString(2,s.getNome());
			pstm.setString(3,s.getDescrizione());
			pstm.setInt(4,s.getTempoGiorniUomo());
			pstm.setString(5,s.getCosto());
			logger.info(pstm.toString());
			int nRighe= pstm.executeUpdate();
			return nRighe;
		}
		
		
		//funzione che dato il codice software restituisce un oggetto software per visualizzare i dettagli
				public Software getSoftware(String codiceSoftware) throws Exception 
				{
					String sql="SELECT * FROM software WHERE codSoftware=?";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,codiceSoftware);
					rs= pstm.executeQuery();
					Software s=new Software();
					while(rs.next())
					{
						s=new Software(rs.getInt(1),rs.getInt(2),rs.getString(3), rs.getString(4), rs.getInt(5),rs.getString(6));
					}

					logger.info(s.toString());
					return s;
				}
				
				
		
		
		
		//funzione che ritorna elenco software
		public ArrayList<Software> getPacchettiSoftware() throws Exception 
		{
			ArrayList<Software> elenco = new ArrayList<Software>();
			String sql="";
			sql="SELECT * FROM software;";
			rs=query.executeQuery(sql);
			Software s;

			while(rs.next())
			{
				s=new Software();
				s.setCodSoftware(rs.getInt("codSoftware"));
				s.setCodResponsabile(rs.getInt("codResponsabile"));
				s.setNome(rs.getString("nome"));
				s.setDescrizione(rs.getString("descrizione"));
				s.setTempoGiorniUomo(rs.getInt("tempoGiorniUomo"));
				s.setCosto(rs.getString("costo"));
				elenco.add(s);
			}

			logger.info("ELENCO SOFTWARE CARICATI: " + elenco.size());

			return elenco;
		}
		
		
		//funzione che elimina un array di Oggetti di tipo Software
		public int deleteSoftware(String[] id) throws Exception 
		{
			String delimiter = ",";
			String s=String.join(delimiter, id);
			String deleteSql="DELETE FROM software  WHERE codSoftware IN ('"+s+"');";
			logger.info("QUERY:"+deleteSql);
			int nRighe=query.executeUpdate(deleteSql);
			logger.info("Numero software eliminati dal db:"+nRighe);
			return nRighe;
		}
		
		
		//funzione che aggiorna un pacchetto software
				public int aggiornaSoftware(Software s)
						throws Exception {
					String sql="UPDATE software SET nome = ?, descrizione =?, tempoGiorniUomo = ?, costo = ?, codResponsabile = ?  WHERE codSoftware = ? ";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,s.getNome());
					pstm.setString(2,s.getDescrizione());
					pstm.setInt(3,s.getTempoGiorniUomo());
					pstm.setString(4,s.getCosto());
					pstm.setInt(5,s.getCodResponsabile());
					pstm.setInt(6,s.getCodSoftware());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
		
				
				
				
				//metodo che mi restituisce il nome di un software dato il codiceSoftware
				public String getSoftwareName(String codiceSoftware)throws Exception {
					String sql="SELECT nome FROM software WHERE codSoftware='"+codiceSoftware+"' ;";
					rs = query.executeQuery(sql);
					String s = "";
					if (rs.next()) {
						String NOME = rs.getString("nome");
						s = NOME;
					}
					//logger.info(s);
					return s;
				}
		//------------------------------------------------------------------//

				
		//------------------LAVORAZIONI---------------------//
				//funzione che inserisce una nuova lavorazione
				public int insertLavorazione(Lavorazione l)
						throws Exception {
					String sql = "INSERT INTO lavorazioni(codSoftware,nome,descrizione,dataInizio,repository) VALUES (?,?,?,?,?);";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,l.getCodSoftware());
					pstm.setString(2,l.getNome());
					pstm.setString(3,l.getDescrizione());
					pstm.setString(4,l.getDataInizio());
					pstm.setString(5,l.getRepository());
					logger.info(pstm.toString());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
				
				
				//funzione che ritorna elenco lavorazioni
				public ArrayList<Lavorazione> getLavorazioni() throws Exception 
				{
					ArrayList<Lavorazione> elenco = new ArrayList<Lavorazione>();
					String sql="";
					sql="SELECT * FROM lavorazioni;";
					rs=query.executeQuery(sql);
					Lavorazione l;

					while(rs.next())
					{
						l=new Lavorazione();
						l.setCodLavorazione(rs.getInt("codLavorazione"));
						l.setCodSoftware(rs.getInt("codSoftware"));
						l.setNome(rs.getString("nome"));
						l.setStato(rs.getString("stato"));
						l.setDescrizione(rs.getString("descrizione"));
						l.setDataInizio(rs.getString("dataInizio"));
						l.setDataFine(rs.getString("dataFine"));
						elenco.add(l);
					}

					logger.info("ELENCO LAVORAZIONI CARICATE: " + elenco.size());

					return elenco;
				}
				
				
				
				
				
				
				
				
				//funzione che elimina un array di Oggetti di tipo Lavorazione
				public int deletelavorazione(String[] id) throws Exception 
				{
					String delimiter = ",";
					String s=String.join(delimiter, id);
					String deleteSql="DELETE FROM lavorazioni WHERE codLavorazione IN ('"+s+"');";
					logger.info("QUERY:"+deleteSql);
					int nRighe=query.executeUpdate(deleteSql);
					logger.info("Numero lavorazioni eliminati dal db:"+nRighe);
					return nRighe;
				}
				
				
				//funzione che dato il codice lavorazione restituisce una lavorazione per visualizzare i dettagli
				public Lavorazione getLavorazione(String codicelavorazione) throws Exception 
				{
					String sql="SELECT * FROM lavorazioni WHERE codLavorazione=?";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,codicelavorazione);
					rs= pstm.executeQuery();
					Lavorazione l=new Lavorazione();
					while(rs.next())
					{
						l=new Lavorazione(rs.getInt(1),rs.getInt(2),rs.getString(3), rs.getString(4), rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8));
					}

					logger.info(l.toString());
					return l;
				}
				
				
				
				//funzione che aggiorna una lavorazione
				public int aggiornaLavorazioneCompleta(Lavorazione l)
						throws Exception {
					String sql="UPDATE lavorazioni SET codSoftware = ?, nome = ?, descrizione =?, dataInizio = ?, dataFine = ?, stato = ?,repository = ?  WHERE codLavorazione = ? ";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,l.getCodSoftware());
					pstm.setString(2,l.getNome());
					pstm.setString(3,l.getDescrizione());
					pstm.setString(4,l.getDataInizio());
					pstm.setString(5,l.getDataFine());
					pstm.setString(6,l.getStato());
					pstm.setString(7,l.getRepository());
					pstm.setInt(8,l.getCodLavorazione());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
				
				//funzione che aggiorna una lavorazione
				public int aggiornaLavorazioneConDataFine(Lavorazione l)
						throws Exception {
					String sql="UPDATE lavorazioni SET codSoftware = ?, nome = ?, descrizione =?, dataInizio = ?, dataFine = ?,repository = ?  WHERE codLavorazione = ? ";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,l.getCodSoftware());
					pstm.setString(2,l.getNome());
					pstm.setString(3,l.getDescrizione());
					pstm.setString(4,l.getDataInizio());
					pstm.setString(5,l.getDataFine());
					pstm.setString(6,l.getRepository());
					pstm.setInt(7,l.getCodLavorazione());
					System.out.println(pstm.toString());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
				
				//funzione che aggiorna una lavorazione
				public int aggiornaLavorazioneSenzaDataFine(Lavorazione l)
						throws Exception {
					String sql="UPDATE lavorazioni SET codSoftware = ?, nome = ?, descrizione =?, dataInizio = ?,repository = ?  WHERE codLavorazione = ? ";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,l.getCodSoftware());
					pstm.setString(2,l.getNome());
					pstm.setString(3,l.getDescrizione());
					pstm.setString(4,l.getDataInizio());
					pstm.setString(5,l.getRepository());
					pstm.setInt(6,l.getCodLavorazione());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
				
				
				
				public int setStatoLavorazioni(String[] id,String stato) throws Exception 
				{
					String delimiter = ",";
					String s=String.join(delimiter, id);
					String sql="UPDATE lavorazioni\r\n"
					+"SET stato ='"+stato+"' WHERE codLavorazione IN ("+s+");";
					logger.info("QUERY:"+sql);
					int nRighe=query.executeUpdate(sql);
					logger.info("Numero Lavorazioni modificate dal db:"+nRighe);
					return nRighe;
				}
				
				
				public int setDataFineCurrentDate(String[] id) throws Exception 
				{
					String delimiter = ",";
					String s=String.join(delimiter, id);
					String sql="UPDATE lavorazioni\r\n"
					+"SET datafine = UTC_DATE() WHERE codLavorazione IN ("+s+");";
					logger.info("QUERY:"+sql);
					int nRighe=query.executeUpdate(sql);
					logger.info("Numero Lavorazioni modificate dal db:"+nRighe);
					return nRighe;
				}
				
				
				public int setDataFineNull(String[] id) throws Exception 
				{
					String delimiter = ",";
					String s=String.join(delimiter, id);
					String sql="UPDATE lavorazioni\r\n"
					+"SET datafine = NULL WHERE codLavorazione IN ("+s+");";
					logger.info("QUERY:"+sql);
					int nRighe=query.executeUpdate(sql);
					logger.info("Numero Lavorazioni modificate dal db:"+nRighe);
					return nRighe;
				}
								
				
				
				
				
		//--------------------------------------------------//		
			
				
		//-----------------GESTIONE PERSONALE COINVOLTO--------------//
				
				//funzione che ritorna elenco del personale coinvolto
				public ArrayList<Personale> getPersonaleCoinvolto(String codiceLavorazione) throws Exception 
				{
					ArrayList<Personale> elenco = new ArrayList<Personale>();
					String sql="";
					sql="SELECT * FROM personale_coinvolto WHERE codLavorazione=?;";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,codiceLavorazione);
					rs= pstm.executeQuery();
					Personale p;
					while(rs.next())
					{
						p=new Personale();
						p.setCodLavorazione(rs.getInt("codLavorazione"));
						p.setCodDipendente(rs.getInt("codDipendente"));
						p.setDescrizione(rs.getString("Descrizione"));
						p.setDataInizio(rs.getString("dataInizio"));
						p.setDataFine(rs.getString("dataFine"));
						elenco.add(p);
					}
					logger.info("ELENCO PERSONALE_COINVOLTO CARICATE: " + elenco.size());
					return elenco;
				}
				
				
				
				//funzione che aggiunge personale in una lavorazione
				public int aggiungiPersonale(int codiceDipendente,int codLavorazione)
						throws Exception {
					String sql = "INSERT INTO personale_coinvolto(codLavorazione,codDipendente,dataInizio) VALUES (?,?,UTC_DATE());";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,codLavorazione);
					pstm.setInt(2,codiceDipendente);
					logger.info(pstm.toString());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
				
				
				//funzione che elimina un array di Oggetti di tipo Lavorazione
				public int deletePersonale(String[] id,int codiceLavorazione) throws Exception 
				{
					String delimiter = ",";
					String s=String.join(delimiter, id);
					String deleteSql="DELETE FROM personale_coinvolto WHERE codLavorazione="+codiceLavorazione+" and codDipendente IN ("+s+");";
					logger.info("QUERY:"+deleteSql);
					int nRighe=query.executeUpdate(deleteSql);
					logger.info("Numero personale eliminati dal db:"+nRighe);
					return nRighe;
				}
				
				
				//funzione che dato il codice lavorazione restituisce i dettagli
				public Personale getDettagliPersonale(String codicelavorazione,String codiceDipendente) throws Exception 
				{
					String sql="SELECT * FROM personale_coinvolto WHERE codLavorazione=? and codDipendente=?";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,codicelavorazione);
					pstm.setString(2,codiceDipendente);
					rs= pstm.executeQuery();
					Personale p=new Personale();
					while(rs.next())
					{
						p=new Personale();
						p.setCodLavorazione(rs.getInt("codLavorazione"));
						p.setCodDipendente(rs.getInt("codDipendente"));
						p.setDescrizione(rs.getString("Descrizione"));
						p.setDataInizio(rs.getString("dataInizio"));
						p.setDataFine(rs.getString("dataFine"));
					}
					logger.info(p.toString());
					return p;
				}
				
				
				//funzione che aggiorna il personale coinvolto
				public int aggiornapersonale(Personale p)
						throws Exception {
					String sql="UPDATE personale_coinvolto SET descrizione = ?, dataInizio = ?, dataFine = ?  WHERE codLavorazione = ? AND codDipendente=? ";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,p.getDescrizione());
					pstm.setString(2,p.getDataInizio());
					pstm.setString(3,p.getDataFine());
					pstm.setInt(4,p.getCodLavorazione());
					pstm.setInt(5,p.getCodDipendente());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
				
				
				
				//funzione che aggiorna il personale coinvolto
				public int aggiornapersonaleNoDataFine(Personale p)
						throws Exception {
					String sql="UPDATE personale_coinvolto SET descrizione = ?, dataInizio = ?  WHERE codLavorazione = ? AND codDipendente=? ";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,p.getDescrizione());
					pstm.setString(2,p.getDataInizio());
					pstm.setInt(3,p.getCodLavorazione());
					pstm.setInt(4,p.getCodDipendente());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
				
		//---------------------------------------------------------------------//		
				
				
		//---------------GESTIONE CLIENTI---------------------------//
				//funzione che registra un nuovo dipendente
				public int insertCliente(Cliente c)
						throws Exception {
					String sql = "INSERT INTO clienti(nome,indirizzo,ragioneSociale,partitaIva,pec,username,pws) VALUES (?,?,?,?,?,?,md5(?));";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,c.getNome());
					pstm.setString(2,c.getIndirizzo());
					pstm.setString(3,c.getRagioneSociale());
					pstm.setString(4,c.getPartitaIva());
					pstm.setString(5,c.getPec());
					pstm.setString(6,c.getUsername());
					pstm.setString(7,c.getPws());
					logger.info(pstm.toString());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
				
				
				/*
				 * //metodo che mi restituisce il nome di un dipendente dato il codiceDipendente
				 * public String getFullName(String codiceDipendente)throws Exception { String
				 * sql="SELECT cognome,nome FROM Dipendenti WHERE codiceDipendente='"
				 * +codiceDipendente+"' ;"; rs = query.executeQuery(sql); String s = ""; if
				 * (rs.next()) { String COGNOME = rs.getString("cognome"); String NOME =
				 * rs.getString("nome"); s = COGNOME+" "+NOME; } //logger.info(s); return s; }
				 */
				
				
				//funzione che aggiorna un nuovo dipendente
				public int aggiornaCliente(Cliente c)
						throws Exception {
					String sql="UPDATE clienti SET nome = ?, indirizzo =?, ragioneSociale = ?, partitaIva = ?, pec = ?, username = ?  WHERE codCliente = ? ";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,c.getNome());
					pstm.setString(2,c.getIndirizzo());
					pstm.setString(3,c.getRagioneSociale());
					pstm.setString(4,c.getPartitaIva());
					pstm.setString(5,c.getPec());
					pstm.setString(6,c.getUsername());
					pstm.setInt(7,c.getCodCliente());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
				

				//funzione che elimina un array di Oggetti di tipo cliente
				public int deleteClienti(String[] codiceClienti) throws Exception 
				{
					String delimiter = ",";
					String s=String.join(delimiter, codiceClienti);
					String deleteSql="DELETE FROM clienti WHERE codCliente IN ("+s+");";
					logger.info("QUERY:"+deleteSql);
					int nRighe=query.executeUpdate(deleteSql);
					logger.info("Numero personale eliminati dal db:"+nRighe);
					return nRighe;
				}
				
				
				//funzione che elimina un ogetto tipo cliente
				public int deleteCliente(String codiceCliente) throws Exception 
				{
					String deleteSql="DELETE FROM clienti WHERE codCliente="+codiceCliente+" ;";
					logger.info("QUERY:"+deleteSql);
					int nRighe=query.executeUpdate(deleteSql);
					logger.info("Numero personale eliminati dal db:"+nRighe);
					return nRighe;
				}
				
				
				//funzione che dato il codice lavorazione restituisce i dettagli
				public Cliente getCliente(String codiceCliente) throws Exception 
				{
					String sql="SELECT * FROM clienti WHERE codCliente=?";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,codiceCliente);
					rs= pstm.executeQuery();
					Cliente c=new Cliente();
					while(rs.next())
					{
						c=new Cliente();
						c.setCodCliente(rs.getInt("codCliente"));
						c.setNome(rs.getString("nome"));
						c.setIndirizzo(rs.getString("indirizzo"));
						c.setRagioneSociale(rs.getString("ragioneSociale"));
						c.setPartitaIva(rs.getString("partitaIva"));
						c.setPec(rs.getString("pec"));
						c.setUsername(rs.getString("username"));
					}
					logger.info(c.toString());
					return c;
				}
				
				//metodo che resetta la password con codiceCliente--------------------------------
				public int resetPasswordCliente(String codCliente,String password) throws SQLException {
					int nRighe=0;
					try {
						String sql = "UPDATE Clienti SET psw = md5(?) WHERE codCliente = ?";
						PreparedStatement pstm=connessione.prepareStatement(sql);
						pstm.setString(1,password);
						pstm.setString(2,codCliente);
						logger.info(pstm.toString());
						nRighe= pstm.executeUpdate();
						if(nRighe==1)logger.info("password modificata ");

					} catch (Exception e) {
						e.printStackTrace();
					}
					return nRighe;
				}
				
				
				//metodo che mi restituisce il nome di un azienda dato il codice Cliente
				public String getClienteName(int codiceCliente)throws Exception {
					String sql="SELECT nome FROM clienti WHERE codCliente='"+codiceCliente+"' ;";
					rs = query.executeQuery(sql);
					String s = "";
					if (rs.next()) {
						String NOME = rs.getString("nome");
						s = NOME;
					}
					//logger.info(s);
					return s;
				}
				
				
		//----------------------------------------------------------//
				
				
				//---------GESTIONE ORDINI----------//
				
				//funzione che inserisce un nuovo ordine
				public int insertOrdine(Ordine o)
						throws Exception {
					String sql = "INSERT INTO ordini(codCliente,dataOrdine,descrizione) VALUES (?,?,?);";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,o.getCodCliente());
					pstm.setString(2,o.getDataOrdine());
					pstm.setString(3,o.getDescrizione());
					logger.info(pstm.toString());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
				
				//funzione che dato il codice ordine restituisce un oggetto di tipo ordine
				public Ordine getOrdine(String codiceOrdine) throws Exception 
				{
					String sql="SELECT * FROM Ordini WHERE codOrdine=?";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,codiceOrdine);
					rs= pstm.executeQuery();
					Ordine o=new Ordine();
					while(rs.next())
					{
						o=new Ordine(rs.getInt(1),rs.getInt(2),rs.getString(3), rs.getString(4), rs.getString(5));
					}

					logger.info(o.toString());
					return o;
				}
				
				
				//metodo che restituisce il codice ordine di un ordine dato cliente e data
				public  int getOrderCode(int codCliente,String data) throws SQLException {
					String sql="SELECT codOrdine FROM ordini WHERE codCliente=? and dataOrdine=?;";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,codCliente);
					pstm.setString(2,data);
					rs= pstm.executeQuery();
					int codOrdine = 0;
					if (rs.next()) {
						codOrdine = rs.getInt("codOrdine");;
					}
					return codOrdine;
				}
				
				
				//funzione che inserisce un pacchetto software nel dettaglioOrdine
				public int inserisciDettaglioOrdine(int codOrdine,String codSoftware) throws Exception {
					String sql = "INSERT INTO dettagliOrdine VALUES (?,?);";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,codOrdine);
					pstm.setString(2,codSoftware);
					logger.info(pstm.toString());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
				
				
				
				
				
				//funzione che ritorna i dettagli di un ordine
				public ArrayList<DettaglioOrdine> getDettagliOrdine(String codiceOrdine) throws Exception 
				{
					ArrayList<DettaglioOrdine> elenco = new ArrayList<DettaglioOrdine>();
					String sql="";
					sql="SELECT * FROM dettagliordine WHERE codOrdine=?";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,codiceOrdine);
					rs= pstm.executeQuery();
					DettaglioOrdine dettaglio;
					while(rs.next())
					{
						dettaglio=new DettaglioOrdine();
						dettaglio.setCodOrdine(rs.getString("codOrdine"));
						dettaglio.setCodSoftware(rs.getString("codSoftware"));
						elenco.add(dettaglio);
					}
					logger.info("Dettaglio ordine, contiene numero software: " + elenco.size());
					return elenco;
				}

				
				
				//funzione che elimina un ogetto tipo ordine
				public int deleteOrdine(String codiceOrdine) throws Exception 
				{
					String deleteSql="DELETE FROM ordini WHERE codOrdine="+codiceOrdine+";";
					logger.info("QUERY:"+deleteSql);
					int nRighe=query.executeUpdate(deleteSql);
					logger.info("ordine eliminato con successo");
					return nRighe;
				}
				
				
				
				//----------------------------------//
				
				
				//-------------FATTURA----------------//
				public int insertFattura(String dataEmissione,double importo,String file) throws Exception
				{
				int nRighe=0;
				File theFile = new File(file);
				FileInputStream input = new FileInputStream(theFile);
				String sqlInsert = "INSERT INTO fatture(dataEmissione,importo,documento) VALUES (?,?,?)";
				PreparedStatement pstm=connessione.prepareStatement(sqlInsert);
				pstm.setString(1, dataEmissione);
				pstm.setDouble(2, importo);
				pstm.setBinaryStream(3, input);
				nRighe= pstm.executeUpdate();
				return nRighe;
				}
				
				
				//metodo che restituisce il codice fattura di una fattura dato importo e datetime
				public  int getFatturaCode(double importo,String data) throws SQLException {
					String sql="SELECT codFattura FROM fatture WHERE importo=? and dataEmissione=?;";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setDouble(1,importo);
					pstm.setString(2,data);
					rs= pstm.executeQuery();
					int codFattura = 0;
					if (rs.next()) {
						codFattura = rs.getInt(1);;
					}
					return codFattura;
				}
				
				
				//funzione che inserisce la chiave esterna codiceFattura in un ordine e cambia lo stato dell'ordine in eseguito
				public int inserisciFattura(int codOrdine,int codFattura) throws Exception {
					String sql = "UPDATE ordini SET codFattura = ? , stato='Eseguito' WHERE codOrdine = ?";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,codFattura);
					pstm.setInt(2,codOrdine);
					logger.info(pstm.toString());
					int nRighe= pstm.executeUpdate();
					return nRighe;
				}
				
				
				//metodo per vedere le fatture
				public int viewFattura(int id) throws Exception
				{
				int nRighe=0;
				String sql = "SELECT Documento from fatture where codFattura=?";
				PreparedStatement pstm=connessione.prepareStatement(sql);
				pstm.setInt(1, id);
				
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
				
				//----------------------------------//
				
				
				
				
				//---------------PARTE QUERY--------------------//
				
				//metodo che restituisce il codice lavorazione dato il codice software
				public  int getCodeLavorazione(int codSoftware) throws SQLException {
					String sql="SELECT codLavorazione FROM lavorazioni WHERE codSoftware=?;";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,codSoftware);
					rs= pstm.executeQuery();
					int codLavorazione = 0;
					if (rs.next()) {
						codLavorazione = rs.getInt("codLavorazione");;
					}
					return codLavorazione;
				}
				
			
				//funzione che ritorna elenco lavorazioni eseguite tra due date
				public ArrayList<Lavorazione> getLavorazioniTerminate(String inizio,String fine) throws Exception 
				{
					ArrayList<Lavorazione> elenco = new ArrayList<Lavorazione>();
					String sql="";
					sql="SELECT * FROM lavorazioni WHERE stato='Eseguita' and dataInizio>=? and dataFine<=?;";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,inizio);
					pstm.setString(2,fine);
					rs= pstm.executeQuery();
					Lavorazione l;

					while(rs.next())
					{
						l=new Lavorazione();
						l.setCodLavorazione(rs.getInt("codLavorazione"));
						l.setCodSoftware(rs.getInt("codSoftware"));
						l.setNome(rs.getString("nome"));
						l.setStato(rs.getString("stato"));
						l.setDescrizione(rs.getString("descrizione"));
						l.setDataInizio(rs.getString("dataInizio"));
						l.setDataFine(rs.getString("dataFine"));
						elenco.add(l);
					}

					logger.info("ELENCO LAVORAZIONI CARICATE: " + elenco.size());

					return elenco;
				}
				
				
				//funzione che ritorna elenco lavorazioni non eseguite
				public ArrayList<Lavorazione> getLavorazioniNonEseguite() throws Exception 
				{
					ArrayList<Lavorazione> elenco = new ArrayList<Lavorazione>();
					String sql="";
					sql="SELECT * FROM lavorazioni WHERE stato='In lavorazione';";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					rs= pstm.executeQuery();
					Lavorazione l;

					while(rs.next())
					{
						l=new Lavorazione();
						l.setCodLavorazione(rs.getInt("codLavorazione"));
						l.setCodSoftware(rs.getInt("codSoftware"));
						l.setNome(rs.getString("nome"));
						l.setStato(rs.getString("stato"));
						l.setDescrizione(rs.getString("descrizione"));
						l.setDataInizio(rs.getString("dataInizio"));
						l.setDataFine(rs.getString("dataFine"));
						elenco.add(l);
					}

					logger.info("ELENCO LAVORAZIONI CARICATE: " + elenco.size());

					return elenco;
				}
				
				//metodo che restituisce data di fine prevista dato l'inzio della lavorazione e i giorni uomo del software
				public String getDataFinePrevista(String dataInizio,int giorni) throws SQLException {
					String sql="SELECT DATE_ADD(?, INTERVAL ? DAY);";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setString(1,dataInizio);
					pstm.setInt(2,giorni);
					rs= pstm.executeQuery();
					String dataFinePrevista="";
					if (rs.next()) {
						dataFinePrevista = rs.getString(1);;
					}
					return dataFinePrevista;
				}
				
				
				
				//funzione che mi restituisce il costo di un software dato il codice software
				public  int getCostoSoftware(int codSoftware) throws SQLException {
					String sql="select software.costo from software where codSoftware=?;"; 
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,codSoftware);
					rs= pstm.executeQuery();
					int costo = 0;
					if (rs.next()) {
						costo = rs.getInt(1);;
					}
					return costo;
				}
				
				
				//funzione che restituisce i giorni uomo di un software data il codice software
				public  int getGiorniUomoSoftware(int codSoftware) throws SQLException {
					String sql="select software.tempoGiorniUomo from software where codSoftware=?;";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,codSoftware);
					rs= pstm.executeQuery();
					int giorniUomo = 0;
					if (rs.next()) {
						giorniUomo = rs.getInt(1);;
					}
					return giorniUomo;
				}
				
				//funzione che ritorna elenco personale ordinato per data di nascita e provincia
				public ArrayList<Dipendente> getPersonaleOrdered() throws Exception 
				{
					ArrayList<Dipendente> elenco = new ArrayList<Dipendente>();
					String sql="select * from dipendenti ORDER by dataNascita and provincia;";
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
						d.setDataNascita(rs.getString("dataNascita"));
						d.setProvincia(rs.getString("provincia"));
						d.setImmagineProfilo(rs.getString("immagineProfilo"));
						elenco.add(d);
					}

					logger.info("DIPENDENTI CARICATI: " + elenco.size());

					return elenco;
				}
				
				
				//funzione che mi permette di controllare se una lavorazione appartiene al responsabile che ta accedendo al sito
				public int verificaLavorazioneResponsabile(int codSostware, int codResponsabile) throws Exception {
					String sql="SELECT * FROM software where codSoftware=? and codResponsabile=? ";
					PreparedStatement pstm=connessione.prepareStatement(sql);
					pstm.setInt(1,codSostware);
					pstm.setInt(2,codResponsabile);
					rs= pstm.executeQuery();
					int count = 0;

					while (rs.next()) {
						++count;
						// Conto il numero di righe
					}
					return count;
				}
				// query per gli ammontare degli stipendi
				//SELECT SUM(stipendio),qualificaProfessionale from dipendenti GROUP BY qualificaProfessionale
				//SELECT SUM(stipendio),nomeProfessione from dipendenti GROUP BY nomeProfessione
				
				//----------------------------------------------//
				
				
				
				
				
				
	public void close() throws Exception {
		query.close();
		connessione.close();
	}
}
