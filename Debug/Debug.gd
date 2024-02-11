extends Node


@onready var version = ProjectSettings.get_setting("application/config/version")


func _ready():
	print("DEBUG ready")
	print("Version: v", version)
