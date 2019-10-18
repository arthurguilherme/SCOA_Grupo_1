package br.ufrj.fes.scoa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import br.ufrj.fes.scoa.ConexaoFactory;



public class AlunoDAO {
	public static List<Aluno> getAlunos() {
		String query = "SELECT a.matricula, p.nome, p.cpf, p.rg, "
				+ "a.situacao, c.codigo, c.nome as curso_nome FROM pessoa as p "
				+ "INNER JOIN aluno as a ON p.cpf = a.cpf_pessoa "
				+ "INNER JOIN curso as c ON c.codigo = a.curso";
		List<Aluno> alunos = new ArrayList<>();
		try (Connection conexao = ConexaoFactory.criarConexao();
			PreparedStatement ps = conexao.prepareStatement(query);
			ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				alunos.add(new Aluno(rs.getInt("matricula"), 
						rs.getString("situacao"), rs.getString("nome"), 
						rs.getString("cpf"), rs.getString("rg"), 
						new Curso(rs.getString("codigo"), rs.getString("curso_nome"))));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return alunos;
			
	}
	
	public static void atualizar(Aluno aluno) throws Exception {
		String query = "UPDATE pessoa as p INNER JOIN aluno as a ON a.cpf_pessoa = p.cpf" + 
				" SET p.cpf = ?, p.nome = ?, p.rg = ?, a.curso = ?" + 
				 "WHERE p.cpf = ?";
		try (Connection conexao = ConexaoFactory.criarConexao();
			PreparedStatement ps = conexao.prepareStatement(query)) {
				ps.setString(1, aluno.getCpf());
				ps.setString(2, aluno.getNome());
				ps.setString(3, aluno.getRg());
				ps.setString(4, aluno.getCurso().getCodigo());
				//ps.setString(5,  aluno.getSituacao());
				ps.setString(5, aluno.getCpf());
				ps.execute();
			}
	}
	
	public static void remover(Aluno aluno) throws Exception {
		String query = "DELETE FROM pessoa WHERE cpf = ?";
		try (Connection conexao = ConexaoFactory.criarConexao();
				PreparedStatement ps = conexao.prepareStatement(query)) {				
					ps.setString(1, aluno.getCpf());
					ps.executeUpdate();
				} 
	}
	
	public static void cadastrar(Aluno aluno) throws Exception {
		Connection conexao = null;
		PreparedStatement ps = null;		
		PreparedStatement ps2 = null;
		PreparedStatement ps3 = null;		
		//CallableStatement cs = null;
		try {
			conexao = ConexaoFactory.criarConexao();
			ps = conexao.prepareStatement("SELECT 1 FROM pessoa WHERE cpf = ?");			
			ps.setString(1, aluno.getCpf());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				throw new Exception("Aluno já cadastrado!");
			}
			
			ps2 = conexao.prepareStatement("INSERT INTO pessoa (cpf, rg, nome) VALUES (?, ?, ?)");
			ps2.setString(1, aluno.getCpf());
			ps2.setString(2, aluno.getRg());
			ps2.setString(3, aluno.getNome());
			ps2.execute();
		
			 
			ps3 = conexao.prepareStatement("INSERT INTO aluno (cpf_pessoa, curso) VALUES (?, ?)");
			ps3.setString(1, aluno.getCpf());
			ps3.setString(2, aluno.getCurso().getCodigo());
			ps3.execute();
			
			
			/*
			 * ps2 = conexao.
			 * prepareStatement("INSERT INTO pessoa (cpf, rg, nome) VALUES (?, ?, ?)");
			 * ps2.setString(1, aluno.getCpf()); ps2.setString(2, aluno.getRg());
			 * ps2.setString(3, aluno.getNome()); ps2.execute();
			 * 
			 * 
			 * ps3 = conexao.
			 * prepareStatement("INSERT INTO aluno (cpf_pessoa, curso) VALUES (?, ?)");
			 * ps3.setString(1, aluno.getCpf()); ps3.setString(2,
			 * aluno.getCurso().getCodigo()); ps3.execute();
			 */		
			
			/*
			 * cs = conexao.prepareCall("call inserir_aluno (?, ?, ?, ?)"); cs.setString(1,
			 * aluno.getCpf()); cs.setString(2, aluno.getRg()); cs.setString(3,
			 * aluno.getNome()); cs.setString(4, aluno.getCurso().getCodigo());
			 * cs.executeQuery();
			 */
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
