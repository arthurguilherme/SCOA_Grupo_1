package br.ufrj.fes.scoa.model;

public class Curso {	
	private String codigo;
	
	public Curso(String codigo) {
		this.codigo = codigo;
	}
	
	public String getCodigo() {
		if (codigo == null) {
			return "";
		}
		return codigo;
	}
	
	@Override
	public String toString() {
		return codigo;
	}
}
