extends Node2D

var pc: PackedScene = preload("res://Szenen/meow_player.tscn")

func _ready() -> void:
	var counter: int = 0
	for dev in Input.get_connected_joypads():
		print("Pad", dev, ":", Input.get_joy_name(dev))
		var player = pc.instantiate()
		self.add_child(player)
		player.dev_id = counter
		counter += 1
