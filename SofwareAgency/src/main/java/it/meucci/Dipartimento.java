package it.meucci;
public class Dipartimento {
	private String nome;
	private String phone;
	private String descrizione;

	public String getNome(){
		return nome;
	}

	public void setNome(String nome){
		this.nome=nome;
	}

	public String getPhone(){
		return phone;
	}

	public void setPhone(String phone){
		this.phone=phone;
	}

	public String getDescrizione(){
		return descrizione;
	}

	public void setDescrizione(String descrizione){
		this.descrizione=descrizione;
	}

	public Dipartimento(String nome, String phone, String descrizione) {
		super();
		this.nome = nome;
		this.phone = phone;
		this.descrizione = descrizione;
	}

	public Dipartimento() {
		super();
	}

	@Override
	public String toString() {
		return "Dipartimenti [nome=" + nome + ", phone=" + phone + ", descrizione=" + descrizione + "]";
	}
	
	
	
}
