package it.meucci;

public class Utente {

	private String CF,NOME,COGNOME,USERNAME,EMAIL,PHONE,PSW,AMMINISTRATORE,IMAGE;
	
	
	public Utente() {
		// TODO Auto-generated constructor stub
	}


	public String getCF() {
		return CF;
	}


	public void setCF(String cF) {
		CF = cF;
	}


	public String getNOME() {
		return NOME;
	}


	public void setNOME(String nOME) {
		NOME = nOME;
	}


	public String getCOGNOME() {
		return COGNOME;
	}


	public void setCOGNOME(String cOGNOME) {
		COGNOME = cOGNOME;
	}


	public String getUSERNAME() {
		return USERNAME;
	}


	public void setUSERNAME(String uSERNAME) {
		USERNAME = uSERNAME;
	}


	public String getEMAIL() {
		return EMAIL;
	}


	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}


	public String getPHONE() {
		return PHONE;
	}


	public void setPHONE(String pHONE) {
		PHONE = pHONE;
	}


	public String getPSW() {
		return PSW;
	}


	public void setPSW(String pSW) {
		PSW = pSW;
	}


	public String getAMMINISTRATORE() {
		return AMMINISTRATORE;
	}


	public void setAMMINISTRATORE(String aMMINISTRATORE) {
		AMMINISTRATORE = aMMINISTRATORE;
	}

	public Utente(String cF, String nOME, String cOGNOME, String uSERNAME, String eMAIL, String pHONE, String pSW,
			String aMMINISTRATORE, String iMAGE) {
		super();
		CF = cF;
		NOME = nOME;
		COGNOME = cOGNOME;
		USERNAME = uSERNAME;
		EMAIL = eMAIL;
		PHONE = pHONE;
		PSW = pSW;
		AMMINISTRATORE = aMMINISTRATORE;
		IMAGE = iMAGE;
	}


	public String getIMAGE() {
		return IMAGE;
	}


	public void setIMAGE(String iMAGE) {
		IMAGE = iMAGE;
	}


	@Override
	public String toString() {
		return "Utente [CF=" + CF + ", NOME=" + NOME + ", COGNOME=" + COGNOME + ", USERNAME=" + USERNAME + ", EMAIL="
				+ EMAIL + ", PHONE=" + PHONE + ", PSW=" + PSW + ", AMMINISTRATORE=" + AMMINISTRATORE + ", IMAGE="
				+ IMAGE + "]";
	}


	
	


	
	
	
	

}
