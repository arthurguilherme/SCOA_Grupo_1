package br.ufrj.fes.scoa.controller;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.App;
import br.ufrj.fes.scoa.IApp;
import javafx.event.ActionEvent;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;

public class AdminController implements Initializable, IApp {
	
	private App application;    
    
	@Override
    public void setApp(App application){
        this.application = application;
    }    

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub		
	}
	
	@FXML 
	public void deslogar(ActionEvent event) {
		application.deslogar();
	}

	@FXML
	public void gerenciarAluno(ActionEvent event) {
		Stage stage = new Stage();	    
		try {
			Parent root = FXMLLoader.load(
			    App.class.getResource("/GerenciarAluno.fxml"));
			stage.setScene(new Scene(root));
		    stage.setTitle("Gerenciar Aluno");
		    stage.initModality(Modality.WINDOW_MODAL);
		    stage.initOwner(
		        ((Node)event.getSource()).getScene().getWindow() );
		    stage.show();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	    
	}
	
	@FXML
	public void gerenciarCurso(ActionEvent event) {
		Stage stage = new Stage();	    
		try {
			Parent root = FXMLLoader.load(
			    App.class.getResource("/GerenciarCurso.fxml"));
			stage.setScene(new Scene(root));
		    stage.setTitle("Gerenciar curso");
		    stage.initModality(Modality.WINDOW_MODAL);
		    stage.initOwner(
		        ((Node)event.getSource()).getScene().getWindow() );
		    stage.show();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	    
	}
	
	@FXML
	public void gerenciarDisciplina(ActionEvent event) {
		Stage stage = new Stage();	    
		try {
			Parent root = FXMLLoader.load(
			    App.class.getResource("/SelecionarCurso.fxml"));
			stage.setScene(new Scene(root));
		    stage.setTitle("Gerenciar disciplina");
		    stage.initModality(Modality.WINDOW_MODAL);
		    stage.initOwner(
		        ((Node)event.getSource()).getScene().getWindow() );
		    stage.show();
			/*
			 * root = FXMLLoader.load( App.class.getResource("/GerenciarDisciplina.fxml"));
			 * stage.setScene(new Scene(root)); stage.show();
			 */
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	    
	}
	
	@FXML
	public void gerenciarProfessor(ActionEvent event) {
		Stage stage = new Stage();	    
		try {
			Parent root = FXMLLoader.load(
			    App.class.getResource("/GerenciarProfessor.fxml"));
			stage.setScene(new Scene(root));
		    stage.setTitle("Gerenciar Professor");
		    stage.initModality(Modality.WINDOW_MODAL);
		    stage.initOwner(
		        ((Node)event.getSource()).getScene().getWindow() );
		    stage.show();
			/*
			 * root = FXMLLoader.load( App.class.getResource("/GerenciarDisciplina.fxml"));
			 * stage.setScene(new Scene(root)); stage.show();
			 */
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	    
	}
}
