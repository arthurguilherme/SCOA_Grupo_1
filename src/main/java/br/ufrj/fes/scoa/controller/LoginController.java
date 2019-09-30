package br.ufrj.fes.scoa.controller;

import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.App;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.layout.AnchorPane;

/**
 * Login Controller.
 */
public class LoginController extends AnchorPane implements Initializable {

    @FXML
    TextField userId;
    @FXML
    PasswordField password;
    @FXML
    Button login;
    @FXML
    Label errorMessage;

    private App application;    
    
    public void setApp(App application){
        this.application = application;
    }    
    
    @Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub		
	}  
    
    @FXML 
    public void fazerLogin(ActionEvent event) {
    	// TODO Verificar login
    	application.logar(userId.getText(), password.getText());
    }    
   
}
