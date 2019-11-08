package br.ufrj.fes.scoa.controller;

import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.model.Curso;
import br.ufrj.fes.scoa.model.CursoDAO;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

public class CadastrarCursoController implements Initializable {

	@FXML
	private TextField codigoF;
	@FXML
	private TextField nomeF;

	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub				
		
	}

	@FXML
	public void cadastrar(ActionEvent event) {
		String nome = nomeF.getText();
		String codigo = codigoF.getText();		
		Curso curso;
		try {					
			curso = new Curso(codigo, nome);
			CursoDAO.cadastrar(curso);
			Alert alert = new Alert(AlertType.INFORMATION);
			alert.setTitle("Cadastrado com sucesso");
			alert.setHeaderText(null);
			alert.setContentText("Curso cadastrado!");
			alert.showAndWait();			
			Stage scene = (Stage) codigoF.getScene().getWindow();
			scene.close();			
		} catch (Exception e) {
			Alert alert = new Alert(AlertType.ERROR);
			alert.setTitle("Erro ao cadastrar");
			alert.setHeaderText(null);
			alert.setContentText(e.getMessage());
			alert.showAndWait();
		}
	}
}
