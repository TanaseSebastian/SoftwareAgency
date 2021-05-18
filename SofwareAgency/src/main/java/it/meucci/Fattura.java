package it.meucci;

public class Fattura {

	String codFattura,dataEmissione,codOrdine;
	float importo;;

	
	public String getCodFattura() {
		return codFattura;
	}


	public void setCodFattura(String codFattura) {
		this.codFattura = codFattura;
	}


	public String getDataEmissione() {
		return dataEmissione;
	}


	public void setDataEmissione(String dataEmissione) {
		this.dataEmissione = dataEmissione;
	}


	public float getImporto() {
		return importo;
	}


	public void setImporto(float importo) {
		this.importo = importo;
	}

	public String getCodOrdine() {
		return codOrdine;
	}


	public void setCodOrdine(String codOrdine) {
		this.codOrdine = codOrdine;
	}
	

	public Fattura(String codFattura, String dataEmissione, String codOrdine, float importo) {
		super();
		this.codFattura = codFattura;
		this.dataEmissione = dataEmissione;
		this.codOrdine = codOrdine;
		this.importo = importo;
	}


	@Override
	public String toString() {
		return "Fattura [codFattura=" + codFattura + ", dataEmissione=" + dataEmissione + ", codOrdine=" + codOrdine
				+ ", importo=" + importo + "]";
	}


	public Fattura() {
		super();
	}


}
