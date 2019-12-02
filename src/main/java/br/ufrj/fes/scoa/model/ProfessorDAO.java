package br.ufrj.fes.scoa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.ufrj.fes.scoa.ConexaoFactory;



public class ProfessorDAO {
	public static List<Professor> getProfessores() {
		String query = "SELECT * FROM pessoa as p INNER JOIN professor as pr ON p.cpf = pr.cpf_pessoa";				
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
		String query = "UPDATE pessoa SET cpf = ?, nome = ?, rg = ? WHERE cpf = ?";		
		PreparedStatement ps2 = null;
		try (Connection conexao = ConexaoFactory.criarConexao();
			PreparedStatement ps = conexao.prepareStatement(query)) {
				ps.setString(1, prof.getCpf());
				ps.setString(2, prof.getNome());
				ps.setString(3, prof.getRg());
				ps.setString(4, oldCpf);
				ps.execute();				
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
			
			ps2 = conexao.prepareStatement("INSERT INTO pessoa (cpf, rg, nome) VALUES (?, ?, ?)");
			ps2.setString(1, prof.getCpf());
			ps2.setString(2, prof.getRg());
			ps2.setString(3, prof.getNome());
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
