extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -250.0

var is_fireball = false
var current_Fireball: CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var fireball_node: PackedScene = preload("res://Szenen/Fire_ball.tscn")

func summon_fireball():
	print("fire!")
	var fireball = fireball_node.instantiate()
	fireball.caster = self
	print(fireball.caster)
	get_tree().current_scene.add_child(fireball)
	is_fireball = true
	current_Fireball = fireball

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Foxy_Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var direction := Input.get_axis("Foxy_left", "Foxy_right")
	
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("Idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	
	if Input.is_action_just_pressed("Foxy_fireball") and not is_fireball:
		summon_fireball()
	elif Input.is_action_just_pressed("Foxy_fireball") and not current_Fireball.charging:
		summon_fireball()


	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
