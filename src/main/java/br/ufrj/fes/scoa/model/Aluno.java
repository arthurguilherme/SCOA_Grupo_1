package br.ufrj.fes.scoa.model;

public class Aluno extends Pessoa {	
	private int matricula;
	private String situacao;
	private Curso curso;
	
	public Aluno(int id, String nome, String cpf, String rg, Curso curso) throws Exception {
		super(id, nome, cpf, rg);	
		matricula = -1;
		setCurso(curso);
	}	
	
	public Aluno(int id, int matricula, String situacao, String nome, String cpf, String rg, Curso curso) throws Exception {
		this(id, nome, cpf, rg, curso);		
		this.matricula = matricula;
		this.situacao = situacao;
	}
	
	public void setSituacao(String situacao) {
		this.situacao = situacao;
	}
	
	public String getSituacao() {
		return situacao;
	}
	
	public int getMatricula() {
		return matricula;
	}	

	
	public Curso getCurso() {	
		return curso;
	}
	
	public void setCurso(Curso curso) {		
		this.curso = curso;
	}
}
