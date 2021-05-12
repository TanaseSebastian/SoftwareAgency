package it.meucci;

public class Personale {

	private int codLavorazione;
	private int codDipendente;
	private String descrizione;
	private String dataInizio;
	private String dataFine;
	public int getCodLavorazione() {
		return codLavorazione;
	}
	public void setCodLavorazione(int codLavorazione) {
		this.codLavorazione = codLavorazione;
	}
	public int getCodDipendente() {
		return codDipendente;
	}
	public void setCodDipendente(int codDipendente) {
		this.codDipendente = codDipendente;
	}
	public String getDataInizio() {
		return dataInizio;
	}
	public void setDataInizio(String dataInizio) {
		this.dataInizio = dataInizio;
	}
	public String getDataFine() {
		return dataFine;
	}
	public void setDataFine(String dataFine) {
		this.dataFine = dataFine;
	}
	
	
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public Personale() {
		super();
	}
	public Personale(int codLavorazione, int codDipendente, String descrizione, String dataInizio, String dataFine) {
		super();
		this.codLavorazione = codLavorazione;
		this.codDipendente = codDipendente;
		this.descrizione = descrizione;
		this.dataInizio = dataInizio;
		this.dataFine = dataFine;
	}
	@Override
	public String toString() {
		return "Personale [codLavorazione=" + codLavorazione + ", codDipendente=" + codDipendente + ", descrizione="
				+ descrizione + ", dataInizio=" + dataInizio + ", dataFine=" + dataFine + "]";
	}
	
	
	
	
	
	
	
}
