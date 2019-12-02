package br.ufrj.fes.scoa.controller;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.App;
import br.ufrj.fes.scoa.model.Aluno;
import br.ufrj.fes.scoa.model.AlunoDAO;
import br.ufrj.fes.scoa.model.Curso;
import br.ufrj.fes.scoa.model.CursoDAO;
import javafx.application.Platform;
import javafx.beans.binding.Bindings;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Modality;
import javafx.stage.Stage;

public class GerenciarCursoController implements Initializable {
		@FXML
		private TextField filterField;
		@FXML
	    private TableView<Curso> tabela;
	    @FXML	
	    private TableColumn<Curso, String> codCol;
	    @FXML
	    private TableColumn<Curso, String> nomeCol;	     
	    @FXML
	    private Button editar;	    
	    @FXML
	    private Button remover;
	
	    
	    private ObservableList<Curso> observableCurso;
	    FilteredList<Curso> filteredData;
	    
	    
	   	@Override
		public void initialize(URL location, ResourceBundle resources) {
			// TODO Auto-generated method stub
	   		codCol.setCellValueFactory(new PropertyValueFactory<Curso, String>("codigo"));
	   		nomeCol.setCellValueFactory(new PropertyValueFactory<Curso, String>("nome"));			
					
			editar.disableProperty().bind(Bindings.isEmpty(tabela.getSelectionModel().getSelectedItems()));
			remover.disableProperty().bind(Bindings.isEmpty(tabela.getSelectionModel().getSelectedItems()));
			filterField.setPromptText("Filtrar resultados");	
			carregarListaDeCursos();
			Platform.runLater(() -> {
				tabela.requestFocus();
			    tabela.getSelectionModel().select(0);
			    tabela.scrollTo(0);
			});
			
		}
		
		private void carregarListaDeCursos() {
			try {
				observableCurso = FXCollections.observableArrayList();	
				observableCurso.addAll(CursoDAO.getCursos());
				filteredData = new FilteredList<>(observableCurso, p -> true);
		        
				filterField.textProperty().addListener((observable, oldValue, newValue) -> {
		            filteredData.setPredicate(curso -> {
		                if (newValue == null || newValue.isEmpty()) {
		                    return true;
		                }
		                
		                String lowerCaseFilter = newValue.toLowerCase();
		                
		                if (curso.getNome().toLowerCase().contains(lowerCaseFilter)) {
		                    return true; // Filter matches first name.
		                } else if (curso.getCodigo().toLowerCase().contains(lowerCaseFilter)) {
		                    return true; // Filter matches last name.
		                }
		                return false; // Does not match.
		            });
		        });					
				tabela.setItems(filteredData);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		@FXML
		public void editar(ActionEvent event) {			
			Stage stage = new Stage();	    
			try {
				FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource("/EditarCurso.fxml"));
				Parent root = fxmlLoader.load();
				stage.setScene(new Scene(root));
			    stage.setTitle("Editar curso");
			    stage.initModality(Modality.WINDOW_MODAL);
			    stage.initOwner(
			        ((Node)event.getSource()).getScene().getWindow() );
			    EditarCursoController editar =  fxmlLoader.<EditarCursoController>getController();
			    editar.initEditarCurso(tabela.getSelectionModel().getSelectedItem());
			    stage.showAndWait();
			    carregarListaDeCursos();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	   
		}
		
		@FXML
		public void remover(ActionEvent event) {
			Curso curso = tabela.getSelectionModel().getSelectedItem();
			try {
				CursoDAO.remover(curso);
				tabela.getItems().remove(curso);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		@FXML
		public void adicionar(ActionEvent event) {
			Stage stage = new Stage();
			try { 
				Parent root = FXMLLoader.load(App.class.getResource("/CadastrarCurso.fxml")); 
				stage.setScene(new Scene(root));
				stage.setTitle("Cadastrar Curso");
				stage.initModality(Modality.WINDOW_MODAL);
				stage.initOwner(((Node)event.getSource()).getScene().getWindow());
				stage.showAndWait();
				carregarListaDeCursos(); 
			} catch (IOException e) { // TODO Auto-generated
				
				e.printStackTrace(); 
			}

		}

}


