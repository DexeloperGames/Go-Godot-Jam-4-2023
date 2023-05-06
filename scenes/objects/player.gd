extends CharacterBody3D
class_name Player

#@export var test : bool = true
@export var PlayerCamera : GimbalCamera
@export var left_weapon : Node
@export var right_weapon : Node
@export var kinetic_acceleration : float = 1.0
@export var kinetic_deceleration : float = 5.0
@export var base_speed : float = 5.0
@export var dash_regen : float = 1.0
@export var dash_drain : float = 1.0
@export var score : int = 0:
	set(n_score):
		score = n_score
		if not is_inside_tree(): await ready
		$UI.score = score
#
#@export var pause_screen : PackedScene = preload("res://scenes/UI/pause_menu.tscn")
#@export var level_finished : PackedScene = preload("res://scenes/UI/win_screen.tscn")
var dashing : bool = false
var dash_amount : float = 1.0
var pre_dash_velocity : Vector3 = Vector3.ZERO
var weapon_idx = 0
var SPEED = 5.0
var JUMP_VELOCITY = 10.0
var can_dash = true
var last_dash_was_surface = false
var previous_position = Vector3.ZERO
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")*3


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta):
	# Add the gravity.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var current_position = global_position
	var world_speed : Vector3 = abs(current_position-previous_position)/delta
	previous_position = current_position
	if world_speed.x**2.0+world_speed.z**2.0 > 4.0:
		SPEED += kinetic_acceleration*delta
	else:
		SPEED = lerpf(SPEED, base_speed, kinetic_deceleration*delta)
	if not (is_on_floor()):
		velocity.y -= gravity * delta
	if is_on_wall() and input_dir.length()>0.5:
		velocity.y = max(velocity.y,0.0)
	# Handle Jump.
#	self.
#	if can_dash and last_dash_was_surface: can_dash = true
	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_wall()):
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
#	print(direction)
#	print(input_dir)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if dashing:
		var new_velocity = velocity+PlayerCamera.camera_global_transform.basis*Vector3(input_dir.x,0,input_dir.y)*SPEED*100.0*dash_amount*delta
#		velocity = lerp(pre_dash_velocity,new_velocity,dash_amount)
		velocity = new_velocity
		dash_amount = max(dash_amount-dash_drain*delta*SPEED,0.0)
		if dash_amount == 0.0:
			velocity = pre_dash_velocity
			dashing = false
#			velocity = pre_dash_velocity
	else:
		dash_amount = min(dash_amount+dash_regen*delta, 1.0)
	get_tree().call_group("Player Data Recievers", "recieve_player_speed", self, SPEED)
	get_tree().call_group("Player Data Recievers", "recieve_player_dash_amount", self, dash_amount)
	move_and_slide()



func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var rotation_vector = event.relative/7.7
		PlayerCamera.gimbal_rotation_degrees.y += -rotation_vector.y
		rotation_degrees.y += -rotation_vector.x
