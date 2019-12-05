package br.ufrj.fes.scoa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.ufrj.fes.scoa.ConexaoFactory;
import br.ufrj.fes.scoa.util.CryptoUtils;
import br.ufrj.fes.scoa.util.StringUtils;



public class ProfessorDAO {
	public static List<Professor> getProfessores() {
		String query = "SELECT * FROM pessoa as p INNER JOIN professor as pr ON p.cpf = pr.cpf_pessoa ORDER BY pr.matricula";				
		List<Professor> professores = new ArrayList<>();
		try (Connection conexao = ConexaoFactory.criarConexao();
			PreparedStatement ps = conexao.prepareStatement(query);
			ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				professores.add(new Professor(rs.getString("nome"), 
						rs.getString("cpf"), rs.getString("rg"), 
						rs.getInt("matricula")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return professores;
			
	}
	
	public static void atualizar(String oldCpf, Professor prof) throws Exception {
		PreparedStatement ps = null;		
		try (Connection conexao = ConexaoFactory.criarConexao()) {				
			if (StringUtils.isNullOrEmpty(prof.getLogin()) || StringUtils.isNullOrEmpty(prof.getSenha())) {
				String query = "UPDATE pessoa SET cpf = ?, nome = ?, rg = ? WHERE cpf = ?";
				System.out.println("Update 1");
				ps = conexao.prepareStatement(query);
				ps.setString(1, prof.getCpf());
				ps.setString(2, prof.getNome());
				ps.setString(3, prof.getRg());
				ps.setString(4, oldCpf);
			} else {
				String query = "UPDATE pessoa SET cpf = ?, nome = ?, rg = ?, login = ?, senha = ? WHERE cpf = ?";
				System.out.println("Update 2");
				ps = conexao.prepareStatement(query);
				ps.setString(1, prof.getCpf());
				ps.setString(2, prof.getNome());
				ps.setString(3, prof.getRg());
				ps.setString(4, prof.getLogin());
				ps.setString(5, CryptoUtils.sha256(prof.getSenha()));
				ps.setString(6, oldCpf);					
			}
			ps.execute();
	
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {}
			}			
		}
	}
	
	public static void remover(Professor professor) throws Exception {
		String query = "DELETE FROM pessoa WHERE cpf = ?";
		try (Connection conexao = ConexaoFactory.criarConexao();
				PreparedStatement ps = conexao.prepareStatement(query)) {				
					ps.setString(1, professor.getCpf());
					ps.executeUpdate();
				} 
	}
	
	public static void cadastrar(Professor prof) throws Exception {
		Connection conexao = null;
		PreparedStatement ps = null;		
		PreparedStatement ps2 = null;
		PreparedStatement ps3 = null;		
		//CallableStatement cs = null;
		try {
			conexao = ConexaoFactory.criarConexao();
			ps = conexao.prepareStatement("SELECT 1 FROM pessoa WHERE cpf = ?");			
			ps.setString(1, prof.getCpf());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				throw new Exception("Professor já cadastrado!");
			}
			
			ps2 = conexao.prepareStatement("INSERT INTO pessoa (cpf, rg, nome, login, senha, perfil) VALUES (?, ?, ?, ?, ?, ?)");
			ps2.setString(1, prof.getCpf());
			ps2.setString(2, prof.getRg());
			ps2.setString(3, prof.getNome());	
			ps2.setString(4,  prof.getLogin());
			ps2.setString(5,  CryptoUtils.sha256(prof.getSenha()));
			ps2.setInt(6,  PessoaDAO.PROFESSOR);
			ps2.execute();
		
			 
			ps3 = conexao.prepareStatement("INSERT INTO professor (cpf_pessoa) VALUES (?)");
			ps3.setString(1, prof.getCpf());
			ps3.execute();		
			

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
                if (ps3 != null) {
                    ps3.close();
                }
            } catch (SQLException se) {}
            
			/*try {
                if (cs != null) {
                    cs.close();
                }
            } catch (SQLException se) {}*/
			
			try {
                if (conexao != null) {
                    conexao.close();
                }
            } catch (SQLException se) {}
			
		}
	}
}
