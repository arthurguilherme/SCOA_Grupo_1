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

public class CursoDAO {	
	public static List<Curso> getCursos() {
		List<Curso> cursos = new ArrayList<>();
		String query = "SELECT * FROM curso";
		try (Connection conexao = ConexaoFactory.criarConexao();
			Statement st = conexao.createStatement();
			ResultSet rs = st.executeQuery(query)){
			
			while (rs.next()) {
				String codigo = rs.getString("codigo");
				cursos.add(new Curso(codigo, rs.getString("nome")));
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			Logger.getLogger(App.class.getName()).log(Level.SEVERE, null, e1);
		}

		return cursos;
	}
	
	public static void cadastrar(Curso curso) throws Exception {
		Connection conexao = null;
		PreparedStatement ps = null;		
		PreparedStatement ps2 = null;
		PreparedStatement ps3 = null;		
		//CallableStatement cs = null;
		try {
			conexao = ConexaoFactory.criarConexao();
			ps = conexao.prepareStatement("SELECT 1 FROM curso WHERE codigo = ?");			
			ps.setString(1, curso.getCodigo());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				throw new Exception("Curso já cadastrado!");
			}
			
			ps2 = conexao.prepareStatement("INSERT INTO curso (codigo, nome) VALUES (?, ?)");
			ps2.setString(1, curso.getCodigo());
			ps2.setString(2, curso.getNome());
			
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

	public static void atualizar(String oldCodigo, Curso curso) throws Exception {
		String query = "UPDATE curso SET codigo = ?, nome = ? WHERE codigo = ?";
		try (Connection conexao = ConexaoFactory.criarConexao();
				PreparedStatement ps = conexao.prepareStatement(query)) {
			ps.setString(1, curso.getCodigo());
			ps.setString(2, curso.getNome());
			ps.execute();
			
		}

	}
	
	public static void remover(Curso curso) throws Exception {
		String query = "DELETE FROM curso WHERE codigo = ?";
		try (Connection conexao = ConexaoFactory.criarConexao();
				PreparedStatement ps = conexao.prepareStatement(query)) {				
					ps.setString(1, curso.getCodigo());
					ps.executeUpdate();
				} 

	}

}
