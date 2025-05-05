extends LimboState

var player : Player

func _setup() -> void:
	player = owner as Player

func _enter() -> void:
	player.anim_sm.travel("Moving")
	
	player.anim_tree.set("parameters/Moving/blend_position", player.dir)

func _update(delta: float) -> void:
	_check_movement()
	_animate()

func _check_movement() -> void:
	if player.hsm.get_active_state() == self:
		var new_dir = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")
		if not new_dir.is_zero_approx():
			player.dir = new_dir
		else:
			dispatch(EVENT_FINISHED)
			

func _animate() -> void:
	player.anim_tree.set("parameters/Moving/blend_position", player.dir)
