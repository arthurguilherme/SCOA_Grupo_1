package br.ufrj.fes.scoa.model;

import br.ufrj.fes.scoa.util.StringUtils;

public class Pessoa {
	private String cpf;
	private String rg;
	private String nome;
	
	// TODO verificar cpf
	public Pessoa(String nome, String cpf, String rg) throws Exception {
		if (StringUtils.isNullOrEmpty(nome) ||
				StringUtils.isNullOrEmpty(cpf) || 
				StringUtils.isNullOrEmpty(rg)) {
			throw new Exception("Entre com nome, cpf e rg!");
		}
		this.cpf = cpf;
		this.nome = nome;
		this.rg = rg;
	}
	
	public String getCpf() {
		return cpf;
	}

	public String getRg() {
		return rg;
	}

	public String getNome() {
		return nome;
	}
}
