package br.ufrj.fes.scoa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import br.ufrj.fes.scoa.App;
import br.ufrj.fes.scoa.ConexaoFactory;

public class DisciplinaDAO {
	public static List<Disciplina> getDisciplinas() {
		String query = "SELECT * FROM disciplina";
		List<Disciplina> disciplinas= new ArrayList<>();
		try (Connection conexao = ConexaoFactory.criarConexao();
			PreparedStatement ps = conexao.prepareStatement(query);
			ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				disciplinas.add(new Disciplina(rs.getString("codigo"), 
						rs.getString("nome")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return disciplinas;
	}
	
	public static void cadastrar(Disciplina disciplina) throws Exception {
		Connection conexao = null;
		PreparedStatement ps = null;		
		PreparedStatement ps2 = null;
		PreparedStatement ps3 = null;		
		//CallableStatement cs = null;
		try {
			conexao = ConexaoFactory.criarConexao();
			ps = conexao.prepareStatement("SELECT 1 FROM disciplina WHERE codigo = ?");			
			ps.setString(1, disciplina.getCodigoDisciplina());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				throw new Exception("Aluno já cadastrado!");
			}
			
			ps2 = conexao.prepareStatement("INSERT INTO disciplina (codigo, nome, carga, periodo) VALUES (?, ?, ?)");
			ps2.setString(1, disciplina.getCodigoDisciplina());
			ps2.setString(2, disciplina.getNome());
			ps2.setInt(3, disciplina.getCargaHoraria());
			ps2.setInt(4, disciplina.getPeriodo());
			ps2.execute();

		} finally {
			try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException se) {}
			
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
