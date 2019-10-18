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

public class EditarAlunoController implements Initializable {
	@FXML
	private TextField matricula;
	@FXML
	private TextField nome;
	@FXML
	private TextField cpf;
	@FXML
	private TextField rg;
	@FXML
	private ChoiceBox<Curso> cursos;
	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub
		cursos.getItems().addAll(CursoDAO.getCursos());
		//cursos.getSelectionModel().selectFirst();
		matricula.setDisable(true);		
	}	
	
	public void initEditarAluno(Aluno aluno) {	
		matricula.setText(Integer.toString(aluno.getMatricula()));
		nome.setText(aluno.getNome());
		cpf.setText(aluno.getCpf());
		rg.setText(aluno.getRg());		
		cursos.getSelectionModel().select(aluno.getCurso());
	}
	
	@FXML
	public void atualizar(ActionEvent event) {
		String nomeAluno = nome.getText();
		String cpfAluno = cpf.getText();
		String rgAluno = rg.getText();
		Curso cursoAluno = cursos.getValue();
		Aluno aluno;
		try {					
			aluno = new Aluno(nomeAluno,cpfAluno, rgAluno, cursoAluno);
			AlunoDAO.atualizar(aluno);
			Alert alert = new Alert(AlertType.INFORMATION);
			alert.setTitle("Atualizado com sucesso");
			alert.setHeaderText(null);
			alert.setContentText("Dados do aluno atualizados!");
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
