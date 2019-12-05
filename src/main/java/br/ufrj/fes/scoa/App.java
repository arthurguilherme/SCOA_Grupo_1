package br.ufrj.fes.scoa;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import br.ufrj.fes.scoa.controller.AdminController;
import br.ufrj.fes.scoa.controller.LoginController;
import br.ufrj.fes.scoa.model.PessoaDAO;
import br.ufrj.fes.scoa.util.StringUtils;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;


import static br.ufrj.fes.scoa.model.PessoaDAO.*;

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

        
    public void logar(String usuario, String senha) {
    	int perfil = NAO_REGISTRADO;
    	if (!StringUtils.isNullOrEmpty(usuario) && !StringUtils.isNullOrEmpty(senha)) {
    		perfil = PessoaDAO.login(usuario, senha);
    	} 
    	
		switch (perfil) {
			case ALUNO:
				abrirPainel("/Aluno.fxml");
				break;
			case PROFESSOR:
				abrirPainel("/Professor.fxml");
				break;
			case ADMIN:
				abrirPainel("/Admin.fxml");
				break;
			default:
				Alert alert = new Alert(AlertType.ERROR);
				alert.setTitle("Login incorreto");
				alert.setHeaderText(null);
				alert.setContentText("Verifique usuário e senha");
				alert.showAndWait();
		}
    }
    
    private void abrirPainel(String painel) {
    	 try {
    		 IApp app = (IApp) replaceSceneContent(painel);
             app.setApp(this);
            
         } catch (Exception ex) {
             Logger.getLogger(App.class.getName()).log(Level.SEVERE, null, ex);
         }
		
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