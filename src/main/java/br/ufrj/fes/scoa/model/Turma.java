package br.ufrj.fes.scoa.model;

public class Turma {
	private int codigo;
	private Disciplina disciplina;
	private int vagas;
	private Professor professor;
	private int aulas;

	public int getCodigo() {
		return codigo;
	}
	
	public Disciplina getDisciplina() {
		return disciplina;
	}
	
	public int getVagas() {
		return vagas;
	}
	
	public Professor getProfessor() {
		return professor;
	}
	
	public int getAulas() {
		return aulas;
	}
}
