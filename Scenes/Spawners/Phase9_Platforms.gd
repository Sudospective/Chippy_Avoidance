extends Spatial

const PLATFORM := preload("res://Scenes/Universal/RandomPosSolid.tscn")

export var vertical_speed := 0
export var platforms := 15
export var seperation := Vector2(20.0, 5.0)


func _ready() -> void:
	for i in range(platforms):
		var plat_inst := PLATFORM.instance()
		plat_inst.translation = -seperation.y * i
		plat_inst.random_pos_radius = Vector3(seperation.x, 0.0, 0.0)
		add_child(plat_inst)


func _process(delta: float) -> void:
	translation.y += vertical_speed * delta