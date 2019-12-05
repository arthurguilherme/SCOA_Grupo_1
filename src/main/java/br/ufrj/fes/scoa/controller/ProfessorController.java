package br.ufrj.fes.scoa.controller;

import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.App;
import br.ufrj.fes.scoa.IApp;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;

public class ProfessorController implements Initializable, IApp {

	private App application;  
	@Override
	public void setApp(App application) {
		// TODO Auto-generated method stub
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

}
