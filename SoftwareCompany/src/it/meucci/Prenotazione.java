package it.meucci;

public class Prenotazione {

	private int codPrenotazione;
	private String dateTime;
	private String commento;
	private int  codPrestazione;
	private String 	codFisc;
	private int codDottore;
	private String stato;
	
	
	public Prenotazione() {
		super();
	}


	public int getCodPrenotazione() {
		return codPrenotazione;
	}


	public void setCodPrenotazione(int codPrenotazione) {
		this.codPrenotazione = codPrenotazione;
	}


	public String getDateTime() {
		return dateTime;
	}


	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}


	public String getCommento() {
		return commento;
	}


	public void setCommento(String commento) {
		this.commento = commento;
	}


	public int getCodPrestazione() {
		return codPrestazione;
	}


	public void setCodPrestazione(int codPrestazione) {
		this.codPrestazione = codPrestazione;
	}


	public String getCodFisc() {
		return codFisc;
	}


	public void setCodFisc(String codFisc) {
		this.codFisc = codFisc;
	}


	public int getCodDottore() {
		return codDottore;
	}


	public void setCodDottore(int codDottore) {
		this.codDottore = codDottore;
	}


	public String getStato() {
		return stato;
	}


	public void setStato(String stato) {
		this.stato = stato;
	}


	public Prenotazione(int codPrenotazione, String dateTime, String commento, int codPrestazione, String codFisc,
			int codDottore, String stato) {
		super();
		this.codPrenotazione = codPrenotazione;
		this.dateTime = dateTime;
		this.commento = commento;
		this.codPrestazione = codPrestazione;
		this.codFisc = codFisc;
		this.codDottore = codDottore;
		this.stato = stato;
	}


	@Override
	public String toString() {
		return "Prenotazione [codPrenotazione=" + codPrenotazione + ", dateTime=" + dateTime + ", commento=" + commento
				+ ", codPrestazione=" + codPrestazione + ", codFisc=" + codFisc + ", codDottore=" + codDottore
				+ ", stato=" + stato + "]";
	}


	
	
	
	
	
}
