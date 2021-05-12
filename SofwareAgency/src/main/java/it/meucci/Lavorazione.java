package it.meucci;

public class Lavorazione {
	private int codLavorazione;
	private int codSoftware;
	private String nome;
	private String descrizione;
	private String dataInizio;
	private String dataFine;
	private String stato;
	private String repository;
	public int getCodLavorazione() {
		return codLavorazione;
	}
	public void setCodLavorazione(int codLavorazione) {
		this.codLavorazione = codLavorazione;
	}
	public int getCodSoftware() {
		return codSoftware;
	}
	public void setCodSoftware(int codSoftware) {
		this.codSoftware = codSoftware;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getDataInizio() {
		return dataInizio;
	}
	public void setDataInizio(String dataInizio) {
		this.dataInizio = dataInizio;
	}
	public String getStato() {
		return stato;
	}
	public void setStato(String stato) {
		this.stato = stato;
	}
	public String getRepository() {
		return repository;
	}
	public void setRepository(String repository) {
		this.repository = repository;
	}	
	public String getDataFine() {
		return dataFine;
	}
	public void setDataFine(String dataFine) {
		this.dataFine = dataFine;
	}
	
	@Override
	public String toString() {
		return "Lavorazione [codLavorazione=" + codLavorazione + ", codSoftware=" + codSoftware + ", nome=" + nome
				+ ", descrizione=" + descrizione + ", dataInizio=" + dataInizio + ", dataFine=" + dataFine + ", stato="
				+ stato + ", repository=" + repository + "]";
	}
	public Lavorazione(int codLavorazione, int codSoftware, String nome, String descrizione, String dataInizio,
			String dataFine, String stato, String repository) {
		super();
		this.codLavorazione = codLavorazione;
		this.codSoftware = codSoftware;
		this.nome = nome;
		this.descrizione = descrizione;
		this.dataInizio = dataInizio;
		this.dataFine = dataFine;
		this.stato = stato;
		this.repository = repository;
	}
	public Lavorazione() {
		super();
	}	
	
	
	
}
