package it.meucci;

public class Dipendente {
		private int codiceDipendente;
		private String cf;
		private String nome;
		private String cognome;
		private String username;
		private String email;
		private String phone;
		private String psw;
		private String qualificaProfessionale;
		private String nomeProfessione;
		private String dataAssunzione;
		private String dataNascita;
		private String provincia;
		private String stipendio;
		private int anniAnzianita;
		private String amministratore;
		private int codDipartimento;
		private String immagineProfilo;
		public String getCodiceRegistrazione() {
			return codiceRegistrazione;
		}
		public void setCodiceRegistrazione(String codiceRegistrazione) {
			this.codiceRegistrazione = codiceRegistrazione;
		}
		private String codiceRegistrazione;
		
		public int getCodiceDipendente() {
			return codiceDipendente;
		}
		public void setCodiceDipendente(int codiceDipendente) {
			this.codiceDipendente = codiceDipendente;
		}
		public String getCf() {
			return cf;
		}
		public void setCf(String cf) {
			this.cf = cf;
		}
		public String getNome() {
			return nome;
		}
		public void setNome(String nome) {
			this.nome = nome;
		}
		public String getCognome() {
			return cognome;
		}
		public void setCognome(String cognome) {
			this.cognome = cognome;
		}
		public String getUsername() {
			return username;
		}
		public void setUsername(String username) {
			this.username = username;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getPhone() {
			return phone;
		}
		public void setPhone(String phone) {
			this.phone = phone;
		}
		public String getPsw() {
			return psw;
		}
		public void setPsw(String psw) {
			this.psw = psw;
		}
		public String getQualificaProfessionale() {
			return qualificaProfessionale;
		}
		public void setQualificaProfessionale(String qualificaProfessionale) {
			this.qualificaProfessionale = qualificaProfessionale;
		}
		public String getNomeProfessione() {
			return nomeProfessione;
		}
		public void setNomeProfessione(String nomeProfessione) {
			this.nomeProfessione = nomeProfessione;
		}
		public String getDataAssunzione() {
			return dataAssunzione;
		}
		public void setDataAssunzione(String dataAssunzione) {
			this.dataAssunzione = dataAssunzione;
		}
		public String getDataNascita() {
			return dataNascita;
		}
		public void setDataNascita(String dataNascita) {
			this.dataNascita = dataNascita;
		}
		public String getProvincia() {
			return provincia;
		}
		public void setProvincia(String provincia) {
			this.provincia = provincia;
		}
		public String getStipendio() {
			return stipendio;
		}
		public void setStipendio(String stipendio) {
			this.stipendio = stipendio;
		}
		public int getAnniAnzianita() {
			return anniAnzianita;
		}
		public void setAnniAnzianita(int anniAnzianita) {
			this.anniAnzianita = anniAnzianita;
		}
		public String getAmministratore() {
			return amministratore;
		}
		public void setAmministratore(String amministratore) {
			this.amministratore = amministratore;
		}
		public int getCodDipartimento() {
			return codDipartimento;
		}
		public void setCodDipartimento(int codDipartimento) {
			this.codDipartimento = codDipartimento;
		}
		public String getImmagineProfilo() {
			return immagineProfilo;
		}
		public void setImmagineProfilo(String immagineProfilo) {
			this.immagineProfilo = immagineProfilo;
		}
		
		
		public Dipendente() {
			super();
		}
		public Dipendente(int codiceDipendente, String cf, String nome, String cognome, String username, String email,
				String phone, String psw, String qualificaProfessionale, String nomeProfessione, String dataAssunzione,
				String dataNascita, String provincia, String stipendio, int anniAnzianita, String amministratore,
				int codDipartimento, String immagineProfilo, String codiceRegistrazione) {
			super();
			this.codiceDipendente = codiceDipendente;
			this.cf = cf;
			this.nome = nome;
			this.cognome = cognome;
			this.username = username;
			this.email = email;
			this.phone = phone;
			this.psw = psw;
			this.qualificaProfessionale = qualificaProfessionale;
			this.nomeProfessione = nomeProfessione;
			this.dataAssunzione = dataAssunzione;
			this.dataNascita = dataNascita;
			this.provincia = provincia;
			this.stipendio = stipendio;
			this.anniAnzianita = anniAnzianita;
			this.amministratore = amministratore;
			this.codDipartimento = codDipartimento;
			this.immagineProfilo = immagineProfilo;
			this.codiceRegistrazione = codiceRegistrazione;
		}
		@Override
		public String toString() {
			return "Dipendente [codiceDipendente=" + codiceDipendente + ", cf=" + cf + ", nome=" + nome + ", cognome="
					+ cognome + ", username=" + username + ", email=" + email + ", phone=" + phone + ", psw=" + psw
					+ ", qualificaProfessionale=" + qualificaProfessionale + ", nomeProfessione=" + nomeProfessione
					+ ", dataAssunzione=" + dataAssunzione + ", dataNascita=" + dataNascita + ", provincia=" + provincia
					+ ", stipendio=" + stipendio + ", anniAnzianita=" + anniAnzianita + ", amministratore="
					+ amministratore + ", codDipartimento=" + codDipartimento + ", immagineProfilo=" + immagineProfilo
					+ ", codiceRegistrazione=" + codiceRegistrazione + "]";
		}
		
		
		
		
		
		
		
		
	
}
