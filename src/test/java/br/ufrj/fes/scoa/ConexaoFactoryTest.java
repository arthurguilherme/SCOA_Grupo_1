package br.ufrj.fes.scoa;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.sql.SQLException;

import org.junit.jupiter.api.Test;

/**
 * 
 * Testa conexão com o banco de dados
 *
 */

public class ConexaoFactoryTest {
	 @Test
	 void testaConexaoComBD() {
		 boolean is_OK = true;
		 try {
			 ConexaoFactory.criarConexao();
		 } catch (SQLException e) {
			// empty
			 is_OK = false;
		 }
		 assertEquals(is_OK, true);
	 }
}
