extends CharacterBody2D

@onready var sprite = $"AnimatedSprite2D"

var weight = 500
var speed = 1000
var in_air = false
var kenetic_power: Vector2

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	movement()
	gravity()
	kenetic()
	move_and_slide()

func gravity():
	if not is_on_floor():
		in_air = true
		if sprite.animation == "Jump":
			sprite.play("Jump")
			sprite.frame = 4
		if velocity.y < weight:
			velocity.y += weight/5
	if is_on_floor() and in_air:
		sprite.play("land")
		in_air = false

func movement():
	var action = false
	if Input.is_action_pressed("Foxy_right"):
		go_right()
		action = true
	if Input.is_action_pressed("Foxy_left"):
		go_left()
		action = true
	if Input.is_action_pressed("Foxy_Jump"):
		jump()
		action = true
	if not action:
		do_default()

func go_right():
	sprite.flip_h = false
	sprite.animation = "walk"
	if in_air: return
	if velocity.x < speed:
		velocity.x = speed/5 

func go_left():
	sprite.flip_h = true
	sprite.animation = "walk"
	if in_air: return
	if velocity.x > -speed:
		velocity.x = -speed/5

func do_default():
	if in_air: return
	sprite.animation = "default"
	velocity.x = velocity.x/2

func jump():
	if is_on_floor():
		sprite.play("Jump")
		sprite.frame = 4
		kenetic_power.y = -speed*3
		in_air = true

func kenetic():
	velocity += kenetic_power/10
	kenetic_power = kenetic_power - kenetic_power/10
