package it.meucci;

public class Prestazione {

	private int codPrestazione;
	private String nome;
	private int codDipartimento;
	
	
	
	public Prestazione() {
		// TODO Auto-generated constructor stub
	super();
	}



		public Prestazione(int codPrestazione, String nome, int codDipartimento) {
		super();
		this.codPrestazione = codPrestazione;
		this.nome = nome;
		this.codDipartimento = codDipartimento;
	}



		public int getCodPrestazione() {
			return codPrestazione;
		}



		public void setCodPrestazione(int codPrestazione) {
			this.codPrestazione = codPrestazione;
		}



		public String getNome() {
			return nome;
		}



		public void setNome(String nome) {
			this.nome = nome;
		}



		public int getCodDipartimento() {
			return codDipartimento;
		}



		public void setCodDipartimento(int codDipartimento) {
			this.codDipartimento = codDipartimento;
		}



		@Override
		public String toString() {
			return "Prestazione [codPrestazione=" + codPrestazione + ", nome=" + nome + ", codDipartimento="
					+ codDipartimento + "]";
		}

	
	
	
}
