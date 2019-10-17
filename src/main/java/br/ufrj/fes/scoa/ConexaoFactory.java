package br.ufrj.fes.scoa;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoFactory {
	public static Connection criarConexao() throws SQLException {
		 String nomeBD = "u115800830_scoa";
		 String url = "jdbc:mysql://sql308.main-hosting.eu:3306/" + nomeBD + "?noAccessToProcedureBodies=true";
	     String usuario = "u115800830_root";
	     String senha = "12345";
//		 String nomeBD = "scoa";
//		 String url = "jdbc:mysql://192.168.0.183:3306/" + nomeBD + "?noAccessToProcedureBodies=true";
//	     String usuario = "root";
//	     String senha = "root";	        
	     Connection conexao = null;
	     conexao = DriverManager.getConnection(url, usuario, senha);	         
	     return conexao;
	}
}
