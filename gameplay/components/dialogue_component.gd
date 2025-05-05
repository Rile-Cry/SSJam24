extends Node

@export var timeline : DialogicTimeline

func start_dialogue() -> void:
	if timeline:
		Dialogic.start(timeline)
		GameGlobalEvents.pause_game.emit()
