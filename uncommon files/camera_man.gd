extends Camera2D

var target_seen = Global.visible

func _physics_process(delta):
	Global.cam_pos = global_position
	if not target_seen:
