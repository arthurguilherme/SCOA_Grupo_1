package br.ufrj.fes.scoa.controller;

import br.ufrj.fes.scoa.model.Disciplina;
import br.ufrj.fes.scoa.model.DisciplinaDAO;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

public class EditarDisciplinaController {
	@FXML
	private TextField codigoF;
	@FXML
	private TextField nomeF;
	@FXML
	private TextField cargaF;
	@FXML
	private TextField periodoF;
	
	private String oldCodigo;

	public void initEditarDisciplina(Disciplina selectedItem) {
		codigoF.setText(selectedItem.getCodigo());
		nomeF.setText(selectedItem.getNome());
		cargaF.setText(Integer.toString(selectedItem.getCargaHoraria()));
		periodoF.setText(Integer.toString(selectedItem.getPeriodo()));	
		oldCodigo = selectedItem.getCodigo();
	}
	
	
	@FXML
	public void atualizar(ActionEvent event) {
		String codigo = codigoF.getText();
		String nome = nomeF.getText();		
		Disciplina disciplina = null;
		try {					
			disciplina = new Disciplina(codigo, nome);
			disciplina.setCargaHoraria(Integer.parseInt(cargaF.getText()));
			disciplina.setPeriodo(Integer.parseInt(periodoF.getText()));
			DisciplinaDAO.atualizar(oldCodigo, disciplina);
			Alert alert = new Alert(AlertType.INFORMATION);
			alert.setTitle("Atualizado com sucesso");
			alert.setHeaderText(null);
			alert.setContentText("Dados do disciplina atualizados!");
			alert.showAndWait();			
			Stage scene = (Stage) nomeF.getScene().getWindow();
			scene.close();			
		} catch (Exception e) {
			Alert alert = new Alert(AlertType.ERROR);
			alert.setTitle("Erro ao atualizar");
			alert.setHeaderText(null);
			alert.setContentText(e.getMessage());
			alert.showAndWait();
		}
	}

	}
