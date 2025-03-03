extends Control

var smelter = preload("res://Buildings/smelter.tscn")
var constructor = preload("res://Buildings/constructor.tscn")
var miner = preload("res://Buildings/miner.tscn")


func _on_building_pressed() -> void:
	$PanelContainer/VBoxContainer/Section/Building.button_pressed = true
	$"PanelContainer/VBoxContainer/Building Summon".show()
	
	$PanelContainer/VBoxContainer/Section/Generation.button_pressed = false
	$"PanelContainer/VBoxContainer/Generation Summon".hide()


func _on_generation_pressed() -> void:
	$PanelContainer/VBoxContainer/Section/Generation.button_pressed = true
	$"PanelContainer/VBoxContainer/Generation Summon".show()
	
	$PanelContainer/VBoxContainer/Section/Building.button_pressed = false
	$"PanelContainer/VBoxContainer/Building Summon".hide()


func _on_smelter_pressed() -> void:
	var new_smelter = smelter.instantiate()
	new_smelter.position = Vector2(570,320)
	get_node("../").add_child(new_smelter)


func _on_constructor_pressed() -> void:
	var new_constructor = constructor.instantiate()
	new_constructor.position = Vector2(570,320)
	get_node("../").add_child(new_constructor)


func _on_miner_pressed() -> void:
	var new_miner = miner.instantiate()
	new_miner.position = Vector2(570,320)
	get_node("../").add_child(new_miner)
