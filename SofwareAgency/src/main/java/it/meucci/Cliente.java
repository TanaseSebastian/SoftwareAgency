package it.meucci;

public class Cliente {

	private int codCliente;
	private String nome;
	private String indirizzo;
	private String ragioneSociale;
	private String partitaIva;
	private String username;
	private String pws;
	private String pec;
	
	
	
	
	
	public int getCodCliente() {
		return codCliente;
	}





	public void setCodCliente(int codCliente) {
		this.codCliente = codCliente;
	}





	public String getNome() {
		return nome;
	}





	public void setNome(String nome) {
		this.nome = nome;
	}





	public String getIndirizzo() {
		return indirizzo;
	}





	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}





	public String getRagioneSociale() {
		return ragioneSociale;
	}





	public void setRagioneSociale(String ragioneSociale) {
		this.ragioneSociale = ragioneSociale;
	}





	public String getPartitaIva() {
		return partitaIva;
	}





	public void setPartitaIva(String partitaIva) {
		this.partitaIva = partitaIva;
	}





	public String getUsername() {
		return username;
	}





	public void setUsername(String username) {
		this.username = username;
	}





	public String getPws() {
		return pws;
	}





	public void setPws(String pws) {
		this.pws = pws;
	}





	public String getPec() {
		return pec;
	}





	public void setPec(String pec) {
		this.pec = pec;
	}





	public Cliente(int codCliente, String nome, String indirizzo, String ragioneSociale, String partitaIva,
			String username, String pws, String pec) {
		super();
		this.codCliente = codCliente;
		this.nome = nome;
		this.indirizzo = indirizzo;
		this.ragioneSociale = ragioneSociale;
		this.partitaIva = partitaIva;
		this.username = username;
		this.pws = pws;
		this.pec = pec;
	}


	



	@Override
	public String toString() {
		return "Cliente [codCliente=" + codCliente + ", nome=" + nome + ", indirizzo=" + indirizzo + ", ragioneSociale="
				+ ragioneSociale + ", partitaIva=" + partitaIva + ", username=" + username + ", pws=" + pws + ", pec="
				+ pec + "]";
	}





	public Cliente() {
		super();
	}
	
	
}
