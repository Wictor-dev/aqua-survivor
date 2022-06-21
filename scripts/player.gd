extends KinematicBody2D

const SWIM_UP_SPEED = -3 * 96
const PASSIVE_SWIM_UP_SPEED = -1 * 96
const SWIM_DOWN_SPEED = 3 * 96
const PASSIVE_SWIM_DOWN_SPEED = 3 * 96

var vel = 200
onready var swim_level = $swinLevel
var velocity = Vector2()

func _ready():
	pass
	
func _process(delta):
	var dir = Vector2(0,0)
	if Input.is_action_pressed("left"):
		dir.x -= vel
	if Input.is_action_pressed("right"):
		dir.x += vel
		
	move_and_slide(dir)
	
func _apply_vertical_swim_vertical(delta):
	var input = -int(Input.is_action_pressed("up")) + int(Input.is_action_pressed("down"))
	
	var y_speed = PASSIVE_SWIM_UP_SPEED
	if input < 0:
		y_speed = SWIM_UP_SPEED
	elif input > 0:
		y_speed = SWIM_DOWN_SPEED
	
	velocity.y = lerp(velocity.y, y_speed, 0.075 * delta / (1 / 60.0))
func is_in_water():
	var space_state = get_world_2d().direct_space_state
	var results = space_state.intersect_point(swim_level.global_position, 1, [], collisionLayers.WATER)
	return results.size() != 0
