package it.meucci;

public class Ordine {

	private int codOrdine;
	private int codCliente;
	private String dataOrdine;
	private String descrizione;
	private String stato;
	
	public int getCodOrdine() {
		return codOrdine;
	}
	public void setCodOrdine(int codOrdine) {
		this.codOrdine = codOrdine;
	}
	public int getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(int codCliente) {
		this.codCliente = codCliente;
	}
	public String getDataOrdine() {
		return dataOrdine;
	}
	public void setDataOrdine(String dataOrdine) {
		this.dataOrdine = dataOrdine;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getStato() {
		return stato;
	}
	public void setStato(String stato) {
		this.stato = stato;
	}
	public Ordine() {
		super();
	}
	
	public Ordine(int codOrdine, int codCliente, String dataOrdine, String descrizione, String stato) {
		super();
		this.codOrdine = codOrdine;
		this.codCliente = codCliente;
		this.dataOrdine = dataOrdine;
		this.descrizione = descrizione;
		this.stato = stato;
	}
	@Override
	public String toString(){
		return "Ordine [codOrdine=" + codOrdine + ", codCliente=" + codCliente + ", dataOrdine=" + dataOrdine + "]";
	}	
}