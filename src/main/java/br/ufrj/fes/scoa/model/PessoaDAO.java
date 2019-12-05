package br.ufrj.fes.scoa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import br.ufrj.fes.scoa.ConexaoFactory;
import br.ufrj.fes.scoa.util.CryptoUtils;

public class PessoaDAO {
	public static final int ADMIN = 127;
	public static final int ALUNO = 1;
	public static final int PROFESSOR = 2;
	public static final int NAO_REGISTRADO = -1;	
	
	public static int login(String usuario, String senha) {
		String query = "SELECT * FROM pessoa WHERE login = ? and senha = ?";
		try (Connection conexao = ConexaoFactory.criarConexao();
			PreparedStatement ps = conexao.prepareStatement(query)) {
			ps.setString(1, usuario);
			ps.setString(2, CryptoUtils.sha256(senha));
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				int perfil = rs.getInt("perfil");	
				if (perfil == 0) {
					return NAO_REGISTRADO;
				}
				return perfil;
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return NAO_REGISTRADO;
			
	}
	
}	
