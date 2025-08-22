extends Control

@export var player: CharacterBody2D

@onready var hp = $hp

func _process(delta: float) -> void:
	hp.value = (player.hp/player.max_hp)*100
