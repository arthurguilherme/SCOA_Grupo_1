package br.ufrj.fes.scoa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
			ps.setString(1, disciplina.getCodigo());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				throw new Exception("Disciplina já cadastrada!");
			}
			
			ps2 = conexao.prepareStatement("INSERT INTO disciplina (codigo, nome, carga, codigo_curso, periodo) VALUES (?, ?, ?, ?, ?)");
			ps2.setString(1, disciplina.getCodigo());
			ps2.setString(2, disciplina.getNome());
			ps2.setInt(3, disciplina.getCargaHoraria());
			ps2.setString(4, disciplina.getCurso().getCodigo());
			ps2.setInt(5, disciplina.getPeriodo());
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

	public static List<Disciplina> getDisciplinas(Curso curso) throws Exception {
		String query = "SELECT * from disciplina WHERE codigo_curso = ?";
		List<Disciplina> disciplinas = new ArrayList<>();
		ResultSet rs = null;
		try (Connection conexao = ConexaoFactory.criarConexao();
			PreparedStatement ps = conexao.prepareStatement(query)) {
			ps.setString(1, curso.getCodigo());			
			rs = ps.executeQuery();
			while (rs.next()) {
				disciplinas.add(new Disciplina(rs.getString("codigo"), rs.getString("nome"), curso, rs.getInt("carga"), rs.getInt("periodo")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					
				}
			}
		}
		
		return disciplinas;
	}
	
	public static void atualizar(String oldCodigo, Disciplina disciplina) throws Exception {
		String query = "UPDATE disciplina SET codigo = ?, nome = ?, carga = ?, periodo = ? WHERE codigo = ?";
		try (Connection conexao = ConexaoFactory.criarConexao();
				PreparedStatement ps = conexao.prepareStatement(query)) {
			ps.setString(1, disciplina.getCodigo());
			ps.setString(2, disciplina.getNome());
			ps.setInt(3, disciplina.getCargaHoraria());
			ps.setInt(4, disciplina.getPeriodo());
			ps.setString(5, oldCodigo);
			ps.execute();
			
		}

	}
	
	public static void remover(Disciplina disciplina) throws Exception {
		String query = "DELETE FROM disciplina WHERE codigo = ?";
		try (Connection conexao = ConexaoFactory.criarConexao();
				PreparedStatement ps = conexao.prepareStatement(query)) {				
					ps.setString(1, disciplina.getCodigo());
					ps.executeUpdate();
				} 

	}
}
