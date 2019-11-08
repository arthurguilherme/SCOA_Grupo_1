package br.ufrj.fes.scoa.model;

import br.ufrj.fes.scoa.util.StringUtils;

public class Disciplina {
	private String codigo;
	private String nome;
	private Curso curso;
	private int cargaHoraria;
	private int periodo;
	
	public Disciplina(String codigoDisciplina, String nome) throws Exception {
		if (StringUtils.isNullOrEmpty(nome) ||
				StringUtils.isNullOrEmpty(codigoDisciplina)) {
			throw new Exception("Entre com o código da Disciplina e o nome da Disciplina!");
		}
		this.codigo = codigoDisciplina;
		this.nome = nome;
	}
	
	public Disciplina(String codigo, String nome, Curso curso, int carga, int periodo) throws Exception {
		if (StringUtils.isNullOrEmpty(nome) ||
				StringUtils.isNullOrEmpty(codigo)) {
			throw new Exception("Entre com o código da Disciplina e o nome da Disciplina!");
		}
		this.codigo = codigo;
		this.nome = nome;
		this.curso = curso;
		this.cargaHoraria = carga;
		this.periodo = periodo;
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

	public String getCodigo() {
		return codigo;
	}	
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return String.format("Cod = %s | Nome = %s | Curso = %s | Carga = %d | periodo = %d",
				codigo, nome, curso.getCodigo(), cargaHoraria, periodo);
	}
	
}
