package br.ufrj.fes.scoa.controller;


import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.App;
import br.ufrj.fes.scoa.model.Aluno;
import br.ufrj.fes.scoa.model.AlunoDAO;
import br.ufrj.fes.scoa.model.Curso;
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

public class GerenciarAlunoController implements Initializable {
	@FXML
	private TextField filterField;
	@FXML
    private TableView<Aluno> tabela;
    @FXML	
    private TableColumn<Aluno, Integer> matriculaCol;
    @FXML
    private TableColumn<Aluno, String> nomeCol;
    @FXML
    private TableColumn<Aluno, String> rgCol;    
    @FXML
    private TableColumn<Aluno, String> cpfCol;    
    @FXML
    private TableColumn<Aluno, Curso> cursoCol;
    @FXML
    private TableColumn<Aluno, String> situacaoCol;    
    @FXML
    private Button editar;
    @FXML
    private Button remover;
    
    private ObservableList<Aluno> observableAluno;
    FilteredList<Aluno> filteredData;
    
   	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub
   		System.out.println("iniciando 2");
		cpfCol.setCellValueFactory(new PropertyValueFactory<Aluno, String>("cpf"));
		rgCol.setCellValueFactory(new PropertyValueFactory<Aluno, String>("rg"));
		nomeCol.setCellValueFactory(new PropertyValueFactory<Aluno, String>("nome"));
		matriculaCol.setCellValueFactory(new PropertyValueFactory<Aluno, Integer>("matricula"));
		cursoCol.setCellValueFactory(new PropertyValueFactory<Aluno, Curso>("curso"));
		situacaoCol.setCellValueFactory(new PropertyValueFactory<>("situacao"));
			
		editar.disableProperty().bind(Bindings.isEmpty(tabela.getSelectionModel().getSelectedItems()));
		remover.disableProperty().bind(Bindings.isEmpty(tabela.getSelectionModel().getSelectedItems()));
		filterField.setPromptText("Filtrar resultados");	
		
		Platform.runLater(() -> {
			tabela.requestFocus();
		    tabela.getSelectionModel().select(0);
		    tabela.scrollTo(0);
		});
		
		carregarListaDeAlunos();
	}
	
	private void carregarListaDeAlunos() {
		try {
			observableAluno = FXCollections.observableArrayList();	
			observableAluno.addAll(AlunoDAO.getAlunos());
			filteredData = new FilteredList<>(observableAluno, p -> true);
	        
	        filterField.textProperty().addListener((observable, oldValue, newValue) -> {
	            filteredData.setPredicate(aluno -> {
	                if (newValue == null || newValue.isEmpty()) {
	                    return true;
	                }
	                
	                String lowerCaseFilter = newValue.toLowerCase();
	                
	                if (aluno.getNome().toLowerCase().contains(lowerCaseFilter)) {
	                    return true; // Filter matches first name.
	                } else if (aluno.getCpf().toLowerCase().contains(lowerCaseFilter)) {
	                    return true; // Filter matches last name.
	                } else if (aluno.getRg().toLowerCase().contains(lowerCaseFilter)) {
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
	public void editarAluno(ActionEvent event) {
		Stage stage = new Stage();	    
		try {
			FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource("/EditarAluno.fxml"));
			Parent root = fxmlLoader.load();
			stage.setScene(new Scene(root));
		    stage.setTitle("Editar Aluno");
		    stage.initModality(Modality.WINDOW_MODAL);
		    stage.initOwner(
		        ((Node)event.getSource()).getScene().getWindow() );
		    EditarAlunoController editar =  fxmlLoader.<EditarAlunoController>getController();
		    editar.initEditarAluno(tabela.getSelectionModel().getSelectedItem());
		    stage.showAndWait();
		    carregarListaDeAlunos();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	   
	}
	
	@FXML
	public void removerAluno(ActionEvent event) {
		Aluno aluno = tabela.getSelectionModel().getSelectedItem();
		try {
			AlunoDAO.remover(aluno);
			filteredData.getSource().remove(aluno);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@FXML
	public void abrirAdicionarAlunoWindow(ActionEvent event) {
		Stage stage = new Stage();	    
		try {
			Parent root = FXMLLoader.load(
			    App.class.getResource("/CadastrarAluno.fxml"));
			stage.setScene(new Scene(root));
		    stage.setTitle("Adicionar Aluno");
		    stage.initModality(Modality.WINDOW_MODAL);
		    stage.initOwner(
		        ((Node)event.getSource()).getScene().getWindow() );
		    stage.showAndWait();
		    carregarListaDeAlunos();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	   
	}

}
