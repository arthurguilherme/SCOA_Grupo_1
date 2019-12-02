package br.ufrj.fes.scoa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import br.ufrj.fes.scoa.ConexaoFactory;



public class TurmaDAO {
	public static void cadastrar(Turma turma) throws Exception {
		String query = "INSERT INTO turma (codigo_disciplina, vagas, matricula_professor, qtd_aulas) VALUES(?, ?, ?, ?)";
		Connection conexao = null;
		PreparedStatement ps2 = null;
		try {
			conexao = ConexaoFactory.criarConexao();			
			ps2 = conexao.prepareStatement(query);
			ps2.setInt(1, turma.getCodigo());
			ps2.setInt(2, turma.getVagas());
			ps2.setInt(3, turma.getProfessor().getMatricula());
			ps2.setInt(4, turma.getAulas());
			ps2.execute();

		} finally {
			try {
        
                if (ps2 != null) {
                    ps2.close();
                }
            } catch (SQLException se) {}
			
			
			try {
                if (conexao != null) {
                    conexao.close();
                }
            } catch (SQLException se) {}
			
		}
		
	}
}
