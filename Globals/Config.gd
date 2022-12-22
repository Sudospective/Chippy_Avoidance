extends Node

const SAVE_PATH = "user://data_config.save"

var music_volume := 1.0 setget set_music_volume
var sound_volume := 1.0 setget set_sound_volume
var fullscreen := false setget set_fullscreen
var screen_shake := true setget set_screen_shake


func save_data() -> void:
	var save_dict := {}
	save_dict["music_volume"] = music_volume
	save_dict["sound_volume"] = sound_volume
	save_dict["fullscreen"] = fullscreen
	save_dict["screen_shake"] = screen_shake
	save_dict["keyboard_controls"] = get_keyboard_dict()
	save_dict["gamepad_controls"] = get_gamepad_dict()
	var file := File.new()
	file.open(SAVE_PATH, File.WRITE)
	file.store_var(save_dict)
	file.close()


func load_data() -> void:
	var file := File.new()
	if file.file_exists(SAVE_PATH):
		file.open(SAVE_PATH, File.READ)
		var values : Dictionary = file.get_var()
		
		self.music_volume = values.get("music_volume", 1.0)
		self.sound_volume = values.get("sound_volume", 1.0)
		self.fullscreen = values.get("fullscreen", false)
		self.screen_shake = values.get("screen_shake", true)
		
		var keyboard_controls : Dictionary = values.get("keyboard_controls", {})
		for action in keyboard_controls:
			InputHelper.set_action_key(action, keyboard_controls[action])
		
		var gamepad_controls : Dictionary = values.get("gamepad_controls", {})
		for action in gamepad_controls:
			InputHelper.set_action_button(action, gamepad_controls[action])
		
		file.close()
	else:
		save_data()


func set_music_volume(value: float) -> void:
	music_volume = value
	SoundManager.set_music_volume(value)


func set_sound_volume(value: float) -> void:
	sound_volume = value
	SoundManager.set_sound_volume(value)


func set_screen_shake(value: bool) -> void:
	screen_shake = value


func set_fullscreen(value: bool) -> void:
	fullscreen = value
	OS.window_fullscreen = value


func get_action_list() -> Array:
	return [
		"player_jump", "player_left", "player_right", "player_forward", "player_backward"
	]


func get_keyboard_dict() -> Dictionary:
	var dict := {}
	for action in get_action_list():
		dict[action] = InputHelper.get_action_key(action)
	return dict


func get_gamepad_dict() -> Dictionary:
	var dict := {}
	for action in get_action_list():
		dict[action] = InputHelper.get_action_button(action)
	return dict