package br.ufrj.fes.scoa.model;

public class Professor extends Pessoa {
	private int matricula;

	public Professor(String nome, String cpf, String rg, int matricula) throws Exception {
		super(nome, cpf, rg);
		this.matricula = matricula;
	}

	public int getMatricula() {
		return matricula;
	}
	
}
