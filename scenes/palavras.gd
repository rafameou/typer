extends Node2D

var edit_facil = null;
var edit_medio = null;
var edit_dificil = null;
var edit_impossivel = null;

var file_dialog = null;
var file_dialog_2 = null;

var popup = null;
var label_popup = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	edit_facil = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/edit_facil");
	edit_medio = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/edit_medio");
	edit_dificil = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/edit_dificil");
	edit_impossivel = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/edit_impossivel");
	
	file_dialog = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/FileDialog");
	file_dialog_2 = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/FileDialog2");
	popup = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Popup");
	label_popup = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Popup/HBoxContainer/VBoxContainer/LabelPopup");
	
	for i in g.palavras_facil: edit_facil.text += i + "\n";
	for i in g.palavras_medias: edit_medio.text += i + "\n";
	for i in g.palavras_dificeis: edit_dificil.text += i + "\n";
	for i in g.palavras_acentos: edit_impossivel.text += i + "\n";
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func salvar_palavras(text: String) -> Array:
	var textArr = text.split("\n");
	var newArr = Array(textArr).filter(func(element): return element != "");
	return newArr;

func _on_voltar_pressed() -> void:
	g.palavras_facil = salvar_palavras(edit_facil.text)
	g.palavras_medias = salvar_palavras(edit_medio.text)
	g.palavras_dificeis = salvar_palavras(edit_dificil.text)
	g.palavras_acentos = salvar_palavras(edit_impossivel.text)
	get_tree().change_scene_to_file("res://scenes/opcoes.tscn")
	pass # Replace with function body.

func _on_button_pressed() -> void:
	file_dialog.popup_file_dialog();
	pass # Replace with function body.

func _on_file_dialog_file_selected(path: String) -> void:
	var file = FileAccess.open(path, FileAccess.WRITE);
	file.store_string("\n#fácil\n" + edit_facil.text + "\n#médio\n" + edit_medio.text + "\n#díficil\n" + edit_dificil.text + "\n#impossível\n" + edit_impossivel.text);
	pass # Replace with function body.

func _on_button_2_pressed() -> void:
	file_dialog_2.popup_file_dialog();
	pass # Replace with function body.

func _on_file_dialog_2_file_selected(path: String) -> void:
	var file = FileAccess.open(path, FileAccess.READ);
	var content = file.get_as_text();
	
	if !content.contains("#") || !content.contains("fácil") || !content.contains("médio") || !content.contains("díficil") || !content.contains("impossível"):
		label_popup.text = "Erro de formatação no arquivo carregado.";
		popup.popup_centered_clamped();
		return;
		
	content = content.split("#");
	if content.is_empty():
		label_popup.text = "Arquivo carregado não contém palavras?";
		popup.popup_centered_clamped();
		return;
		
	edit_facil.text = "";
	edit_medio.text = "";
	edit_dificil.text = "";
	edit_impossivel.text = "";
	
	# testando lambda
	# https://docs.godotengine.org/en/latest/tutorials/scripting/gdscript/gdscript_basics.html#lambda-functions
	var receber_var_array = func(extraContent, editor):
		extraContent.remove_at(0);
		for j in extraContent: 
			if !j.is_empty():
				editor.text += j + "\n";
	
	for i in content:
		var extraContent = i.split("\n");
		match extraContent[0]:
			"fácil": receber_var_array.call(extraContent, edit_facil);
			"médio": receber_var_array.call(extraContent, edit_medio);
			"díficil": receber_var_array.call(extraContent, edit_dificil);
			"impossível": receber_var_array.call(extraContent, edit_impossivel);
			_: pass
	
	pass # Replace with function body.


func _on_ok_button_pressed() -> void:
	popup.hide();
	pass # Replace with function body.
