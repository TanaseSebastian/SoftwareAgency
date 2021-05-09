package it.meucci;

public class Software
{
	private int codSoftware;
	private int codResponsabile;
	private String nome;
	private String descrizione;
	private int tempoGiorniUomo;
	private String costo;
	public int getCodSoftware() {
		return codSoftware;
	}
	public void setCodSoftware(int codSoftware) {
		this.codSoftware = codSoftware;
	}
	public int getCodResponsabile() {
		return codResponsabile;
	}
	public void setCodResponsabile(int codResponsabile) {
		this.codResponsabile = codResponsabile;
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
	public int getTempoGiorniUomo() {
		return tempoGiorniUomo;
	}
	public void setTempoGiorniUomo(int tempoGiorniUomo) {
		this.tempoGiorniUomo = tempoGiorniUomo;
	}
	public String getCosto() {
		return costo;
	}
	public void setCosto(String costo) {
		this.costo = costo;
	}
	@Override
	public String toString() {
		return "software [codSoftware=" + codSoftware + ", codResponsabile=" + codResponsabile + ", nome=" + nome
				+ ", descrizione=" + descrizione + ", tempoGiorniUomo=" + tempoGiorniUomo + ", costo=" + costo + "]";
	}
	public Software(int codSoftware, int codResponsabile, String nome, String descrizione, int tempoGiorniUomo,
			String costo) {
		super();
		this.codSoftware = codSoftware;
		this.codResponsabile = codResponsabile;
		this.nome = nome;
		this.descrizione = descrizione;
		this.tempoGiorniUomo = tempoGiorniUomo;
		this.costo = costo;
	}
	public Software() {
		super();
	}

	
	
}