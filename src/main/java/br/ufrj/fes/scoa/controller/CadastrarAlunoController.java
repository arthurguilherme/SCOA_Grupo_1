package br.ufrj.fes.scoa.controller;

import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.model.Aluno;
import br.ufrj.fes.scoa.model.AlunoDAO;
import br.ufrj.fes.scoa.model.Curso;
import br.ufrj.fes.scoa.model.CursoDAO;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.PasswordField;
import javafx.event.ActionEvent;

public class CadastrarAlunoController implements Initializable {

	@FXML TextField nome;
	@FXML TextField cpf;
	@FXML TextField rg;
	@FXML TextField login;
	@FXML PasswordField senha;
	@FXML ChoiceBox<Curso> cursos;
	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub				
		cursos.getItems().addAll(CursoDAO.getCursos());
		cursos.getSelectionModel().selectFirst();
	}

	@FXML
	public void cadastrar(ActionEvent event) {
		String nomeAluno = nome.getText();
		String cpfAluno = cpf.getText();
		String rgAluno = rg.getText();
		Curso cursoAluno = cursos.getValue();
		Aluno aluno;
		try {					
			aluno = new Aluno(nomeAluno,cpfAluno, rgAluno, cursoAluno);
			aluno.setLogin(login.getText());
			aluno.setSenha(senha.getText());
			AlunoDAO.cadastrar(aluno);
			Alert alert = new Alert(AlertType.INFORMATION);
			alert.setTitle("Cadastrado com sucesso");
			alert.setHeaderText(null);
			alert.setContentText("Aluno cadastrado!");
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
