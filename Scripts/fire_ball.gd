extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $"AnimatedSprite2D"
@onready var charge_timer: Timer = $Timer
@onready var collshape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var collshape2: CollisionShape2D = $CollisionShape2D

@export var power: int = 0
var charging = true
var richtung: Vector2
var speed = 100
@export var caster: CharacterBody2D


func _ready() -> void:
	sprite.animation = "Charge"
	sprite.scale = Vector2(0,0)
	collshape.scale = collshape.scale*0
	charge_timer.start()
	

func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and charging:
		charging = false
		richtung = global_position.direction_to(get_global_mouse_position())
		sprite.animation = "Idle"
		collshape.scale = sprite.scale*10
		sprite.scale = sprite.scale*10
		rotation = (get_global_mouse_position() - global_position).normalized().angle()
	if not charging:
		send_fireball()
	else: stay()
	collshape2 = collshape


func charge():
	if Input.is_action_pressed("Foxy_fireball") and power < 50 and charging:
		sprite.scale += Vector2(0.001, 0.001)
		power += 1
		print(power)

func charge_tick() -> void:
	charge()

func send_fireball():
	velocity = richtung * speed
	move_and_slide()

func stay():
	position.x = caster.position.x
	position.y = caster.position.y -25
	sprite.animation = "Charge"


func hit(area: Area2D) -> void:
	queue_free()
