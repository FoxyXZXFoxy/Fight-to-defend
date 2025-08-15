extends CharacterBody2D

@onready var sprite = $"AnimatedSprite2D"

var weight = 300
var speed = 200
var in_air = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	movement()
	gravity()
	move_and_slide()

func gravity():
	if not is_on_floor():
		in_air = true
		if is_nan(velocity.y) or velocity.y == 0:
			velocity.y = 1
		velocity.y = velocity.y*(weight/velocity.y)
	if is_on_floor() and in_air:
		sprite.play("land")
		in_air = false
func movement():
	if Input.is_action_pressed("right"):
		go_right()
	elif Input.is_action_pressed("left"):
		go_left()
	elif Input.is_action_pressed("up"):
		jump()
	else:
		do_default()

func go_right():
	sprite.flip_h = false
	sprite.animation = "walk"
	if in_air: return
	if is_nan(velocity.x) or velocity.x == 0:
		velocity.x = 1
	velocity.x = velocity.x*(speed/velocity.x)

func go_left():
	sprite.flip_h = true
	sprite.animation = "walk"
	if in_air: return
	if is_nan(velocity.x) or velocity.x == 0:
		velocity.x = -1
	velocity.x = -velocity.x*(speed/velocity.x)

func do_default():
	if in_air: return
	sprite.animation = "default"
	velocity.x = velocity.x/2

func jump():
	if is_on_floor():
		sprite.play("Jump")
		velocity.y = -speed*100
		in_air = true
