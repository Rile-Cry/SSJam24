class_name Player extends CharacterBody2D

#region Node References
@export_category("State Machine")
@export var hsm : LimboHSM
@export var idle_state : LimboState
@export var move_state : LimboState
#endregion

@export var anim_tree : AnimationTree
@export var sprite : Sprite2D

var anim_sm : AnimationNodeStateMachinePlayback
var dir : Vector2 = Vector2(0, 1)

func _ready() -> void:
	add_to_group(&"Player", true)
	
	anim_tree.set("parameters/Idle/blend_position", dir)
	anim_sm = anim_tree.get("parameters/playback")
	_init_state_machine()

func get_input() -> void:
	dir = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")
	if dir.length() > 1:
		dir = dir.normalized()

func _init_state_machine() -> void:
	hsm.add_transition(idle_state, move_state, "moving")
	hsm.add_transition(move_state, idle_state, move_state.EVENT_FINISHED)
	
	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func set_movement(delta: float) -> void:
	velocity = dir / delta
	move_and_slide()
