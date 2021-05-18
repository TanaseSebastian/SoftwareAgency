package it.meucci;

public class DettaglioOrdine {

	private String codOrdine;
	private String codSoftware;
	public String getCodOrdine() {
		return codOrdine;
	}
	public void setCodOrdine(String codOrdine) {
		this.codOrdine = codOrdine;
	}
	public String getCodSoftware() {
		return codSoftware;
	}
	public void setCodSoftware(String codSoftware) {
		this.codSoftware = codSoftware;
	}
	public DettaglioOrdine(String codOrdine, String codSoftware) {
		super();
		this.codOrdine = codOrdine;
		this.codSoftware = codSoftware;
	}
	public DettaglioOrdine() {
		super();
	}
	@Override
	public String toString() {
		return "DettaglioOrdine [codOrdine=" + codOrdine + ", codSoftware=" + codSoftware + "]";
	}
	
}
