extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var versao := get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/Label")
	if versao is Label:
		versao.text = "TYPER v%s ; https://meou.boo/typer" % [ProjectSettings.get_setting("application/config/version")]
	var license := get_node_or_null("PanelContainer/MarginContainer/VBoxContainer2/Label")
	if license is Label:
		license.text = "A versão 1.0 do projeto foi criada na disciplina Padrões De Projeto Com Extensão (CC60C), dentro da Universidade Tecnológica Federal do Paraná (UTFPR) campus Ponta Grossa."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_niveis.tscn")
	pass # Replace with function body.


func _on_opcoes_pressed() -> void:
	pass # Replace with function body.


func _on_sair_pressed() -> void:
	get_tree().quit(1)
	pass # Replace with function body.
