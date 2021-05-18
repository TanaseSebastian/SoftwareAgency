package it.meucci;

public class TestStampaFattura {

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub

		CreateFatturaPDF pdf=new CreateFatturaPDF();
		pdf.stampa("10", null, 0);
		
	}

}
