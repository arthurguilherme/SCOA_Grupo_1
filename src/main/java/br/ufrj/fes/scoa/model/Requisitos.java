package br.ufrj.fes.scoa.model;

public class Requisitos extends Disciplina{
	private char tipo;
	
	public Requisitos(String codigoDisciplina, String nome) throws Exception {
		super(codigoDisciplina, nome);
	}

	public char getTipo() {
		return tipo;
	}

	public void setTipo(char tipo) {
		this.tipo = tipo;
	}
	
	
}
