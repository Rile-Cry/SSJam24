extends Node

#region Signals
signal pause_game
signal resume_game
#endregion

#region Built-in Methods
func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_dialogue_finished)
#endregion

#region Signal Callbacks
func _on_dialogue_finished() -> void:
	resume_game.emit()
#endregion
