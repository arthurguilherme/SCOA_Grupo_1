package br.ufrj.fes.scoa.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.ufrj.fes.scoa.*;


public class AlunoDAO {
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
			 * cs = conexao.prepareCall("call inserir_aluno (?, ?, ?, ?)");
			 * 
			 * cs.setString(1, aluno.getCpf()); cs.setString(2, aluno.getRg());
			 * cs.setString(3, aluno.getNome()); cs.setString(4,
			 * aluno.getCurso().getCodigo());
			 */
			//cs.executeQuery();
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
