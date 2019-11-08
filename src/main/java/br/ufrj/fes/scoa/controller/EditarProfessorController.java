package br.ufrj.fes.scoa.controller;

import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.model.Disciplina;
import br.ufrj.fes.scoa.model.DisciplinaDAO;
import br.ufrj.fes.scoa.model.Professor;
import br.ufrj.fes.scoa.model.ProfessorDAO;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.scene.control.Alert.AlertType;
import javafx.stage.Stage;

public class EditarProfessorController implements Initializable {
	@FXML
	private TextField matricula;
	@FXML
	private TextField nome;
	@FXML
	private TextField cpf;
	@FXML
	private TextField rg;
	
	private String oldCpf;
	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub
		matricula.setDisable(true);
	}
	
	public void initEditarProfessor(Professor selectedItem) {
		matricula.setText(Integer.toString(selectedItem.getMatricula()));
		nome.setText(selectedItem.getNome());
		cpf.setText(selectedItem.getCpf());
		rg.setText(selectedItem.getRg());
		oldCpf = selectedItem.getCpf();
	}
	
	@FXML
	public void atualizar(ActionEvent event) {	
		Professor prof = null;
		try {					
			prof = new Professor(nome.getText(), cpf.getText(), rg.getText(), Integer.parseInt(matricula.getText()));
			ProfessorDAO.atualizar(oldCpf, prof);
			Alert alert = new Alert(AlertType.INFORMATION);
			alert.setTitle("Atualizado com sucesso");
			alert.setHeaderText(null);
			alert.setContentText("Dados do professor atualizados!");
			alert.showAndWait();			
			Stage scene = (Stage) nome.getScene().getWindow();
			scene.close();			
		} catch (Exception e) {
			Alert alert = new Alert(AlertType.ERROR);
			alert.setTitle("Erro ao atualizar");
			alert.setHeaderText(null);
			alert.setContentText(e.getMessage());
			alert.showAndWait();
		}
	}
	

}
