package it.meucci;
//codDottore,nome,cognome,phone,email,codDipartimento,
public class Dottore {
	private int codDottore;
	private String nome;
	private String cognome;
	private String phone;
	private String email;
	private int codDipartimento;
	public Dottore() {
		super();
	}
	public Dottore(int codDottore, String nome, String cognome, String phone, String email, int codDipartimento) {
		super();
		this.codDottore = codDottore;
		this.nome = nome;
		this.cognome = cognome;
		this.phone = phone;
		this.email = email;
		this.codDipartimento = codDipartimento;
	}
	public int getCodDottore() {
		return codDottore;
	}
	public void setCodDottore(int codDottore) {
		this.codDottore = codDottore;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getCognome() {
		return cognome;
	}
	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getCodDipartimento() {
		return codDipartimento;
	}
	public void setCodDipartimento(int codDipartimento) {
		this.codDipartimento = codDipartimento;
	}
	@Override
	public String toString() {
		return "Dottore [codDottore=" + codDottore + ", nome=" + nome + ", cognome=" + cognome + ", phone=" + phone
				+ ", email=" + email + ", codDipartimento=" + codDipartimento + "]";
	}
}