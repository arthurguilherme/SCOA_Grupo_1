package br.ufrj.fes.scoa;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoFactory {
	public static Connection criarConexao() throws SQLException {
		 String nomeBD = "scoa";
		 String url = "jdbc:mysql://localhost:3306/" + nomeBD;
	     String usuario = "root";
	     String senha = "root";	         
	     Connection conexao = null;
	     conexao = DriverManager.getConnection(url, usuario, senha);	         
	     return conexao;
	}
}
