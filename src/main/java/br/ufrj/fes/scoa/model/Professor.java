package br.ufrj.fes.scoa.model;

public class Professor extends Pessoa {
	private int matricula;

	public Professor(String nome, String cpf, String rg) throws Exception {
		super(nome, cpf, rg);		
	}
	
	public Professor(String nome, String cpf, String rg, int matricula) throws Exception {
		super(nome, cpf, rg);
		this.matricula = matricula;
	}
	
	public void setMatricula(int mat) {
		this.matricula = mat;
	}

	public int getMatricula() {
		return matricula;
	}
	
}
