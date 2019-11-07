package br.ufrj.fes.scoa.model;

import br.ufrj.fes.scoa.util.StringUtils;

public class Disciplina {
	private String codigoDisciplina;
	private String nome;
	private Curso curso;
	private int cargaHoraria;
	private int periodo;
	
	public Disciplina(String codigoDisciplina, String nome) throws Exception {
		if (StringUtils.isNullOrEmpty(nome) ||
				StringUtils.isNullOrEmpty(codigoDisciplina)) {
			throw new Exception("Entre com o código da Disciplina e o nome da Disciplina!");
		}
		this.codigoDisciplina = codigoDisciplina;
		this.nome = nome;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public int getCargaHoraria() {
		return cargaHoraria;
	}

	public void setCargaHoraria(int cargaHoraria) {
		this.cargaHoraria = cargaHoraria;
	}

	public int getPeriodo() {
		return periodo;
	}

	public void setPeriodo(int periodo) {
		this.periodo = periodo;
	}

	public String getCodigoDisciplina() {
		return codigoDisciplina;
	}	
	
}
