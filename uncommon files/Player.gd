extends CharacterBody2D

# common variables
var move_power: Vector2 = Vector2.ZERO
var previous_dir_mov: Vector2 = Vector2.ZERO

# common constants
const Jump_Pwr: float = 150
const speed: float = 50
const friction: float = 0.5
const grav: float = 2

func _ready():
	pass

func _physics_process(delta):
	### movement
	## horizontal movement/velocity
	move_power.x = Input.get_axis("left", "right")
	velocity.x += move_power.x * speed #idk what's better than delta, its problably gonna be locked to 60fps anyways
	velocity.x = lerp(velocity.x, 0.0, friction)
	
	## vertical movement
	if is_on_floor():
		$C_Time.start(0.3)
		if velocity.y > 0: #makes shure it dosent snag on one-way collision.
			velocity.y = 0
	else:
		velocity.y += grav
	
	
	if Input.is_action_just_pressed("jump") and not $C_Time.is_stopped():
			$C_Time.stop()
			print()
			velocity.y += -Jump_Pwr
	### animation
	if velocity.x != 0:
		previous_dir_mov = move_power #might be helpful to leave like this,
	if previous_dir_mov.x == -1:
		$Sprite2D.flip_h = true
	elif previous_dir_mov.x == 1:
		$Sprite2D.flip_h = false
	
	
	### finish
	Global.Player_pos = global_position
	move_and_slide()



# jank solution to a problem :)

func _on_visible_on_screen_notifier_2d_screen_entered():
	Global.visible = true
func _on_visible_on_screen_notifier_2d_screen_exited():
	Global.visible = false

# it dont deserve space :)
