package br.ufrj.fes.scoa.controller;

import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.model.Professor;
import br.ufrj.fes.scoa.model.ProfessorDAO;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

public class CadastrarProfessorController implements Initializable {

	@FXML TextField nome;
	@FXML TextField cpf;
	@FXML TextField rg;
	@FXML TextField login;
	@FXML PasswordField senha;

	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub
		
	}
	
	
	@FXML
	public void cadastrar(ActionEvent event) {		
		String nomeProf = nome.getText();
		String cpfProf = cpf.getText();
		String rgProf = rg.getText();
		Professor professor;
		try {					
			professor = new Professor(nomeProf,cpfProf, rgProf);			
			ProfessorDAO.cadastrar(professor);
			Alert alert = new Alert(AlertType.INFORMATION);
			alert.setTitle("Cadastrado com sucesso");
			alert.setHeaderText(null);
			alert.setContentText("Professor cadastrado!");
			alert.showAndWait();			
			Stage scene = (Stage) nome.getScene().getWindow();
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
