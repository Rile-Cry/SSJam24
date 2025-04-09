extends CharacterBody2D

@export var anim_player : AnimationPlayer
@export var sprite : Sprite2D

var dir : Vector2 = Vector2.ZERO
var facing : Vector2 = Vector2i(0, -1)

func _ready() -> void:
	add_to_group(&"Player", true)

func _physics_process(delta: float) -> void:
	get_input()
	set_anim()
	set_movement(delta)

func get_input() -> void:
	dir = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")
	if dir.length() > 1:
		dir = dir.normalized()

func set_anim() -> void:
	if dir.length() == 0:
		anim_player.pause()
		if facing.x == 1:
			sprite.frame_coords = Vector2i(1, 2)
		elif facing.x == -1:
			sprite.frame_coords = Vector2i(1, 1)
		elif facing.y == -1:
			sprite.frame_coords = Vector2i(1, 3)
		elif facing.y == 1:
			sprite.frame_coords = Vector2i(1, 0)
	else:
		if dir.x > 0:
			anim_player.play(&"move_right")
			facing = Vector2i(1, 0)
		elif dir.x < 0:
			anim_player.play(&"move_left")
			facing = Vector2i(-1, 0)
		elif dir.y > 0:
			anim_player.play(&"move_down")
			facing = Vector2i(0, 1)
		elif dir.y < 0:
			anim_player.play(&"move_up")
			facing = Vector2i(0, -1)

func set_movement(delta: float) -> void:
	velocity = dir / delta
	move_and_slide()
