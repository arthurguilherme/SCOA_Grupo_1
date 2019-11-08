package br.ufrj.fes.scoa.controller;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import br.ufrj.fes.scoa.App;
import br.ufrj.fes.scoa.model.Curso;
import br.ufrj.fes.scoa.model.CursoDAO;
import br.ufrj.fes.scoa.model.Disciplina;
import br.ufrj.fes.scoa.model.DisciplinaDAO;
import javafx.beans.binding.Bindings;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
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
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Modality;
import javafx.stage.Stage;

public class GerenciarDisciplinaController implements Initializable {
	@FXML
    private TableView<Disciplina> tabela;
    @FXML	
    private TableColumn<Disciplina, String> codCol;
    @FXML
    private TableColumn<Disciplina, String> nomeCol;
    @FXML
    private TableColumn<Disciplina, Integer> cargaCol;    
    //@FXML
    //private TableColumn<Aluno, Curso> cursoCol;    
    @FXML
    private TableColumn<Disciplina, Integer> periodoCol;
    @FXML
    private Button editar;
    @FXML
    private Button remover;
    
    private ObservableList<Disciplina> observableDisciplina;
    
    private Curso curso;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub
   		codCol.setCellValueFactory(new PropertyValueFactory<Disciplina, String>("codigo"));
   		nomeCol.setCellValueFactory(new PropertyValueFactory<Disciplina, String>("nome"));	
 		cargaCol.setCellValueFactory(new PropertyValueFactory<Disciplina, Integer>("cargaHoraria"));
 		periodoCol.setCellValueFactory(new PropertyValueFactory<Disciplina, Integer>("periodo"));
			
		editar.disableProperty().bind(Bindings.isEmpty(tabela.getSelectionModel().getSelectedItems()));
		remover.disableProperty().bind(Bindings.isEmpty(tabela.getSelectionModel().getSelectedItems()));
	}
	
	private void carregarListaDeDisciplinas() {
		try {
			observableDisciplina = FXCollections.observableArrayList();
			observableDisciplina.addAll(DisciplinaDAO.getDisciplinas(curso));
			tabela.setItems(observableDisciplina);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void initDisciplina(Curso curso) {		
		this.curso = curso;
		carregarListaDeDisciplinas();
	}
	
	
	@FXML
	public void editar(ActionEvent event) {		
		System.out.println("editar");
		Stage stage = new Stage();	    
		try {
			FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource("/EditarDisciplina.fxml"));
			Parent root = fxmlLoader.load();
			stage.setScene(new Scene(root));
		    stage.setTitle("Editar curso");
		    stage.initModality(Modality.WINDOW_MODAL);
		    stage.initOwner(
		        ((Node)event.getSource()).getScene().getWindow() );
		    EditarDisciplinaController editar =  fxmlLoader.<EditarDisciplinaController>getController();
		    editar.initEditarDisciplina(tabela.getSelectionModel().getSelectedItem());
		    stage.showAndWait();
		    carregarListaDeDisciplinas();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	   
	}
	
	@FXML
	public void remover(ActionEvent event) {
		Disciplina disciplina = tabela.getSelectionModel().getSelectedItem();
		try {
			DisciplinaDAO.remover(disciplina);
			tabela.getItems().remove(disciplina);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@FXML
	public void adicionar(ActionEvent event) {
		System.out.println("adicionar");
		Stage stage = new Stage();
		try { 
			FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource("/CadastrarDisciplina.fxml"));
			Parent root = fxmlLoader.load();
			stage.setScene(new Scene(root));
			stage.setTitle("Cadastrar Disciplina");
			stage.initModality(Modality.WINDOW_MODAL);
			stage.initOwner(((Node)event.getSource()).getScene().getWindow());
			CadastrarDisciplinaController cadastrar =  fxmlLoader.<CadastrarDisciplinaController>getController();
			cadastrar.initCurso(this.curso);
			stage.showAndWait();
			carregarListaDeDisciplinas();
		} catch (IOException e) { // TODO Auto-generated
			
			e.printStackTrace(); 
		}

	}

}
