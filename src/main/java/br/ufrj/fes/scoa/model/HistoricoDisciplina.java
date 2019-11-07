package br.ufrj.fes.scoa.model;

public class HistoricoDisciplina {
	private Disciplina disciplina;
	private Aluno aluno;
	private float presenca;
	private int grau;
		
	public HistoricoDisciplina(Disciplina disciplina, Aluno aluno) {
		this.disciplina = disciplina;
		this.aluno = aluno;
	}

	public Disciplina getDisciplina() {
		return disciplina;
	}

	public Aluno getAluno() {
		return aluno;
	}

	public float getPresenca() {
		return presenca;
	}

	public void setPresenca(float presenca) {
		this.presenca = presenca;
	}

	public int getGrau() {
		return grau;
	}

	public void setGrau(int grau) {
		this.grau = grau;
	}
	
	
}
