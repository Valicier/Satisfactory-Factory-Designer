extends Sprite2D

var dragging = false
var snap = 10

var cnct = null
var cnct_offset = null
var cnct_offset_mod = null
var cnct_rot = null
@onready var length = $Button.size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		var newPos = get_global_mouse_position()
		position = Vector2(snapped(newPos.x, snap), snapped(newPos.y, snap))
		
		#Adjust drag for odd
		var rotated_pos = abs( $Button.size.rotated(global_transform.get_rotation()) )
		rotated_pos = rotated_pos/ max(rotated_pos.x, rotated_pos.y)
		var rotated_sign = Vector2(floor(rotated_pos.x), floor(rotated_pos.y))
		
		if int($Button.size.x/2) % 2 == 1:
			position.x += 5 * abs(rotated_sign.x)
		if int($Button.size.y/2) % 2 == 1:
			position.y += 5 * abs(rotated_sign.y)
		
		# Rotate
		if Input.is_action_just_pressed("Rotate"):
			rotation_degrees += 90
		
	else:
		if cnct != null:
			print("snapped: " + str(cnct))
			position = cnct
			cnct = null
			cnct_offset = null
			cnct_offset_mod = null
			rotation = cnct_rot
			cnct_rot = null

func _on_button_button_down() -> void:
	dragging = true

func _on_button_button_up() -> void:
	dragging = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if dragging:
		var rotated_pos = area.position.rotated(area.global_transform.get_rotation())
		var rotated_pos_simp = Vector2(snapped(rotated_pos.x,1), snapped(rotated_pos.y,1))
		var area_sign = rotated_pos_simp.sign()
		cnct = area.get_parent().position
		cnct_rot = rotated_pos.angle() - PI/2
		cnct_offset = rotated_pos*2 + ($Button.size.rotated(cnct_rot) - rotated_pos*2)/2
		cnct_offset_mod = Vector2($Button.size.rotated(cnct_rot).x/2 * -abs(area_sign.y), $Button.size.rotated(cnct_rot).y/2 * -abs(area_sign.x))
		cnct += cnct_offset + cnct_offset_mod
		
		#print("area local pos: " + str(area.position))
		#print("global pos: " + str(area.global_position))
		#print("area sign: " + str(area_sign))
		#print("cnct: " + str(cnct))
		#print("rot entered pos: " + str(rotated_pos))
		#print("area pos: " + str(area.get_parent().position))
		#print("cnct offset: " + str(cnct_offset_mod))
		#print("cnct offset mod: " + str(cnct_offset))
		#print("cnct offset final: " + str(cnct_offset + cnct_offset_mod))
		#print("size rotated: " + str($Button.size.rotated(cnct_rot)))
		#print("cncy rot: " + str(cnct_rot))
		#print("end")
		
		#_entered_adjust_odd(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	cnct = null
	cnct_offset = null
	cnct_rot = null
	cnct_offset_mod = null

func _entered_adjust_odd(area): # Currently works without this. Keeping if needed
	# Adjust if length/2 is odd
	var par_length = area.get_parent().length/2
	
	# Adjust x
	if int(par_length.x) % 2 == 1:
		cnct.x -= Vector2(5,5).x
	if int(length.x)/2 % 2 == 1:
		cnct.x -= Vector2(5,5).x
	
	# Adjust y
	if int(par_length.y) % 2 == 1 and area.position.y < 0:
		cnct.y -= Vector2(5,5).y
		print("1")
	if int(length.y)/2 % 2 == 1 and area.position.y > 0:
		cnct.y -= Vector2(5,5).y
		print("2")
