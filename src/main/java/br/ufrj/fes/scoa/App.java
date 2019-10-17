package br.ufrj.fes.scoa;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import br.ufrj.fes.scoa.controller.AdminController;
import br.ufrj.fes.scoa.controller.LoginController;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

public class App extends Application {

	private Stage stage;

    public static void main(String[] args) {
        launch();
    }

    @Override
    public void start(Stage primaryStage) {
        try {
            stage = primaryStage;
            stage.setTitle("Scoa");
            abrirPainelLogin();
            primaryStage.show();            
        } catch (Exception ex) {
        	Logger.getLogger(App.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

        
    public boolean logar(String userId, String password) {
		abrirPainelAdmin();
		return true;
    }
    
    public void deslogar() {
    	abrirPainelLogin();
    }
    
    public void verificarConexao() {
    	try (Connection con = ConexaoFactory.criarConexao()) {
    		// empty
    	} catch (SQLException e) {
    		Alert alert = new Alert(AlertType.ERROR);
			alert.setTitle("Erro ao conectar ao BD");
			alert.setHeaderText(null);
			alert.setContentText("Verifique conexão com o BD");
			alert.showAndWait();
    	}
    }
    
    private void abrirPainelAdmin() {    
        try {
        	AdminController admin = (AdminController) replaceSceneContent("/Admin.fxml");
            admin.setApp(this);
           
        } catch (Exception ex) {
            Logger.getLogger(App.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void abrirPainelLogin() {
        try {
            LoginController login = (LoginController) replaceSceneContent("/Login.fxml");
            login.setApp(this);
           
        } catch (Exception ex) {
            Logger.getLogger(App.class.getName()).log(Level.SEVERE, null, ex);
        }
        //verificarConexao();
    }

    private Initializable replaceSceneContent(String fxml) throws Exception {
    	FXMLLoader loader = new FXMLLoader();
    	loader.setLocation(getClass().getResource(fxml));
    	AnchorPane page = (AnchorPane) loader.load(); 
    	Scene scene = new Scene(page);
		/*
		 * String css = this.getClass().getResource("/Login.css").toExternalForm();
		 * System.out.println(css); page.getStylesheets().add(css);
		 */
    	stage.setScene(scene);
    	return (Initializable) loader.getController();
    }

}