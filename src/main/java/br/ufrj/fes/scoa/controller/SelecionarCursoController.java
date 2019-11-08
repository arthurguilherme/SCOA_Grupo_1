package br.ufrj.fes.scoa.controller;

import java.io.IOException;
import java.net.URL;
import java.util.Optional;
import java.util.ResourceBundle;

import javax.swing.JOptionPane;

import br.ufrj.fes.scoa.App;
import br.ufrj.fes.scoa.model.Curso;
import br.ufrj.fes.scoa.model.CursoDAO;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.Alert.AlertType;
import javafx.stage.Modality;
import javafx.stage.Stage;

public class SelecionarCursoController implements Initializable {
	
	@FXML ChoiceBox<Curso> cursos;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub
		cursos.getItems().addAll(CursoDAO.getCursos());
		cursos.getSelectionModel().selectFirst();
	}
	
	
	@FXML
	public void gerenciarDisciplina(ActionEvent event) { 		
		Stage stage = new Stage();	    
		try {
			FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource("/GerenciarDisciplina.fxml"));
			Parent root = fxmlLoader.load();
			stage.setScene(new Scene(root));
		    stage.setTitle("Editar disciplina");
		    stage.initModality(Modality.WINDOW_MODAL);
		    stage.initOwner(
		        ((Node)event.getSource()).getScene().getWindow() );
		    Curso curso = cursos.getSelectionModel().getSelectedItem();
		    if (curso != null) {
		    	GerenciarDisciplinaController editar =  fxmlLoader.<GerenciarDisciplinaController>getController();
		    	editar.initDisciplina(curso);
		    	stage.showAndWait();
		    } else {
		    	Alert alert = new Alert(AlertType.ERROR);
				alert.setTitle("Selecione curso!");
		    }
		    		   
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	   
	}

	
   
   
}

