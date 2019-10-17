package br.ufrj.fes.scoa.model;

public class Curso {	
	private String codigo;
	private String nome;
	
	public Curso(String codigo) {
		this.codigo = codigo;
		this.nome = "";
	}
	
	public Curso(String codigo, String nome) {
		this.codigo = codigo;
		this.nome = nome;
	}
	
	public String getCodigo() {
		if (codigo == null) {
			return "";
		}
		return codigo;
	}	

	public String getNome() {
		return nome;
	}
	
	@Override
	public String toString() {
		return nome;
	}
	
	@Override
	public boolean equals(Object obj) {
		// TODO Auto-generated method stub
		if (this == obj) 
			return true;
		if (obj == null || this.getClass() != obj.getClass())
			return false;
		
		Curso curso = (Curso) obj;		
		return this.codigo.equals(curso.codigo);		
	}
}
