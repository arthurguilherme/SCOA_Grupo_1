package br.ufrj.fes.scoa.controller;

import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.model.Curso;
import br.ufrj.fes.scoa.model.CursoDAO;
import br.ufrj.fes.scoa.model.Disciplina;
import br.ufrj.fes.scoa.model.DisciplinaDAO;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.TextField;
import javafx.scene.control.Alert.AlertType;
import javafx.stage.Stage;

public class CadastrarDisciplinaController implements Initializable {
	
	@FXML 
	private TextField codigoF;
	@FXML
	private TextField nomeF;
	@FXML
	private TextField cargaF;
	@FXML
	private TextField periodoF;
	
	private Curso codCurso;
	
	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub
		
	}
	
	@FXML
	public void cadastrar(ActionEvent event) {
		String nome = nomeF.getText();
		String codigo = codigoF.getText();		
		Disciplina disciplina;
		try {					
			//int carga = Integer.parseInt(cargaF.getText());
			//int periodo = Integer.parseInt(periodoF.getText());
			disciplina = new Disciplina(codigo, nome, codCurso, 1,2);			
			DisciplinaDAO.cadastrar(disciplina);
			Alert alert = new Alert(AlertType.INFORMATION);
			alert.setTitle("Cadastrado com sucesso");
			alert.setHeaderText(null);
			alert.setContentText("Disciplina cadastrada!");
			alert.showAndWait();			
			Stage scene = (Stage) codigoF.getScene().getWindow();
			scene.close();			
		} catch (Exception e) {
			Alert alert = new Alert(AlertType.ERROR);
			alert.setTitle("Erro ao cadastrar");
			alert.setHeaderText(null);
			System.err.println(e);
			alert.setContentText(e.getMessage());
			alert.showAndWait();
		}
	}
	
	public void initCurso(Curso c) {
		codCurso = c;
	}

}
