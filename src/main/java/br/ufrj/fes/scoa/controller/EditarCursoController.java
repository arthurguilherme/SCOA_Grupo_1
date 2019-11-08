package br.ufrj.fes.scoa.controller;

import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.model.Aluno;
import br.ufrj.fes.scoa.model.AlunoDAO;
import br.ufrj.fes.scoa.model.Curso;
import br.ufrj.fes.scoa.model.CursoDAO;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.TextField;
import javafx.scene.control.Alert.AlertType;
import javafx.stage.Stage;

public class EditarCursoController implements Initializable {
	@FXML
	private TextField codigoF;
	@FXML
	private TextField nomeF;
	
	private String oldCodigo;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub
	}	
	

	@FXML
	public void atualizar(ActionEvent event) {
		String codigo = codigoF.getText();
		String nome = nomeF.getText();		
		Curso curso = null;
		try {					
			curso = new Curso(codigo, nome);
			CursoDAO.atualizar(oldCodigo, curso);
			Alert alert = new Alert(AlertType.INFORMATION);
			alert.setTitle("Atualizado com sucesso");
			alert.setHeaderText(null);
			alert.setContentText("Dados do curso atualizados!");
			alert.showAndWait();			
			Stage scene = (Stage) nomeF.getScene().getWindow();
			scene.close();			
		} catch (Exception e) {
			Alert alert = new Alert(AlertType.ERROR);
			alert.setTitle("Erro ao atualizar");
			alert.setHeaderText(null);
			alert.setContentText(e.getMessage());
			alert.showAndWait();
		}
	}

	public void initEditarCurso(Curso selectedItem) {		
		oldCodigo = selectedItem.getCodigo();
		codigoF.setText(oldCodigo);
		nomeF.setText(selectedItem.getNome());
	}
	

}
