package br.ufrj.fes.scoa.model;

import java.sql.Connection;
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
				cursos.add(new Curso(codigo));
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			Logger.getLogger(App.class.getName()).log(Level.SEVERE, null, e1);
		}

		return cursos;
	}

}
