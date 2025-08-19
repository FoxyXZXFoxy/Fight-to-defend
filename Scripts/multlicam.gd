extends Camera2D


func _process(delta: float) -> void:
	var Players = get_tree().get_nodes_in_group("PLAYERS")
	if Players.is_empty() or len(Players) < 2: return
		
		
	var pos: Vector2
	var counter: int = 0
	
	for p in Players:
		var player_pos:Vector2 = p.position
		pos.y += player_pos.y
		pos.x += player_pos.x
		counter += 1
		
	pos.x = pos.x/counter
	pos.y = pos.y/counter
	position = pos
	
	
	var max_x: float
	var max_y: float

	for p in Players:
		var player_pos:Vector2 = position - p.position
		if max_x < player_pos.x: max_x = player_pos.x
		if max_y < player_pos.y: max_y = player_pos.y
	
	if max_x > 30:
		zoom.x = 300/(max_x*3)
		zoom.y = zoom.x
