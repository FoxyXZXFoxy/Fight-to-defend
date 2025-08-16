extends Node2D

var meow: PackedScene = preload("res://Szenen/meow_player.tscn")
var foxy: PackedScene = preload("res://Szenen/Player_Foxy.tscn")
@onready var world: Node = get_tree().current_scene

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _on_meow_pressed() -> void:
	if !is_multiplayer_authority(): queue_free(); return
	var player = meow.instantiate()
	world.add_child(player)
	queue_free()


func _on_foxy_pressed() -> void:
	if !is_multiplayer_authority(): queue_free(); return
	var player = foxy.instantiate()
	world.add_child(player)
	queue_free()
