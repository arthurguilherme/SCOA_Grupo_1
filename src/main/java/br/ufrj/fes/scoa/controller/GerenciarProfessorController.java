package br.ufrj.fes.scoa.controller;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.App;
import br.ufrj.fes.scoa.model.Professor;
import br.ufrj.fes.scoa.model.ProfessorDAO;
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

public class GerenciarProfessorController implements Initializable {
	@FXML
	private TextField filterField;
	@FXML
    private TableView<Professor> tabela;
    @FXML	
    private TableColumn<Professor, Integer> matriculaCol;
    @FXML
    private TableColumn<Professor, String> nomeCol;
    @FXML
    private TableColumn<Professor, String> rgCol;    
    @FXML
    private TableColumn<Professor, String> cpfCol;    
    @FXML
    private Button editar;
    @FXML
    private Button remover;
    
    private ObservableList<Professor> observableProfessor;
    FilteredList<Professor> filteredData;
    
    @Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub
		cpfCol.setCellValueFactory(new PropertyValueFactory<Professor, String>("cpf"));
		rgCol.setCellValueFactory(new PropertyValueFactory<Professor, String>("rg"));
		nomeCol.setCellValueFactory(new PropertyValueFactory<Professor, String>("nome"));
		matriculaCol.setCellValueFactory(new PropertyValueFactory<Professor, Integer>("matricula"));			
		editar.disableProperty().bind(Bindings.isEmpty(tabela.getSelectionModel().getSelectedItems()));
		remover.disableProperty().bind(Bindings.isEmpty(tabela.getSelectionModel().getSelectedItems()));
		filterField.setPromptText("Filtrar resultados");	
		carregarListaDeProfessors();	
		Platform.runLater(() -> {
			tabela.requestFocus();
		    tabela.getSelectionModel().select(0);
		    tabela.scrollTo(0);
		});
	}
	
	private void carregarListaDeProfessors() {
		try {
			observableProfessor = FXCollections.observableArrayList();	
			observableProfessor.addAll(ProfessorDAO.getProfessores());
			filteredData = new FilteredList<>(observableProfessor, p -> true);
	        
			filterField.textProperty().addListener((observable, oldValue, newValue) -> {
	            filteredData.setPredicate(professor -> {
	                if (newValue == null || newValue.isEmpty()) {
	                    return true;
	                }
	                
	                String lowerCaseFilter = newValue.toLowerCase();
	                
	                if (professor.getNome().toLowerCase().contains(lowerCaseFilter)) {
	                    return true; // Filter matches first name.
	                } else if (professor.getCpf().toLowerCase().contains(lowerCaseFilter)) {
	                    return true; // Filter matches last name.
	                } else if (professor.getRg().toLowerCase().contains(lowerCaseFilter)) {
	                	return true;
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
			FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource("/EditarProfessor.fxml"));
			Parent root = fxmlLoader.load();
			stage.setScene(new Scene(root));
		    stage.setTitle("Editar Professor");
		    stage.initModality(Modality.WINDOW_MODAL);
		    stage.initOwner(
		        ((Node)event.getSource()).getScene().getWindow() );
		    EditarProfessorController editar =  fxmlLoader.<EditarProfessorController>getController();
		    editar.initEditarProfessor(tabela.getSelectionModel().getSelectedItem());
		    stage.showAndWait();
		    carregarListaDeProfessors();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	   
	}
	
	@FXML
	public void remover(ActionEvent event) {
		Professor professor = tabela.getSelectionModel().getSelectedItem();
		try {
			ProfessorDAO.remover(professor);
			filteredData.getSource().remove(professor);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@FXML
	public void adicionar(ActionEvent event) {
		Stage stage = new Stage();	    
		try {
			Parent root = FXMLLoader.load(
			    App.class.getResource("/CadastrarProfessor.fxml"));
			stage.setScene(new Scene(root));
		    stage.setTitle("Adicionar Professor");
		    stage.initModality(Modality.WINDOW_MODAL);
		    stage.initOwner(
		        ((Node)event.getSource()).getScene().getWindow() );
		    stage.showAndWait();
		    carregarListaDeProfessors();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	   
	}

}
