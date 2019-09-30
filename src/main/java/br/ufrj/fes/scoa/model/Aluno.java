package br.ufrj.fes.scoa.model;

public class Aluno extends Pessoa {	
	private Curso curso;
	
	public Aluno(String nome, String cpf, String rg, Curso curso) throws Exception {
		super(nome, cpf, rg);		
		setCurso(curso);
	}
	
	public Curso getCurso() {	
		return curso;
	}
	
	public void setCurso(Curso curso) {		
		this.curso = curso;
	}
}
