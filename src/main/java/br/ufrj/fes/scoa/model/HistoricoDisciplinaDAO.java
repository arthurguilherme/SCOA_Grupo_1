package br.ufrj.fes.scoa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.ufrj.fes.scoa.ConexaoFactory;

public class HistoricoDisciplinaDAO {
	public static List<HistoricoDisciplina> getHistoricoDisciplinas() {
		String query = "SELECT * FROM historico_disciplina";
		List<HistoricoDisciplina> historicoDisciplinas= new ArrayList<>();
		try (Connection conexao = ConexaoFactory.criarConexao();
			PreparedStatement ps = conexao.prepareStatement(query);
			ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				historicoDisciplinas.add(new HistoricoDisciplina(rs.getFloat("presenca"), 
						rs.getInt("grau")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return historicoDisciplinas;
	}
	
	public static void adicionarHistorico(HistoricoDisciplina disciplina) throws Exception {
		Connection conexao = null;
		PreparedStatement ps = null;		
		PreparedStatement ps2 = null;
		PreparedStatement ps3 = null;		
		//CallableStatement cs = null;
		try {
			conexao = ConexaoFactory.criarConexao();
			
			ps2 = conexao.prepareStatement("INSERT INTO historico_disciplina (presenca, grau) VALUES (?, ?)");
			ps2.setFloat(1, disciplina.getPresenca());
			ps2.setInt(2, disciplina.getGrau());
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
