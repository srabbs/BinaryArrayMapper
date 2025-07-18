extends Button

var state := 0

func _ready():
	pressed.connect(_on_pressed)
	update_visual()

func _on_pressed():
	state = 1 - state
	update_visual()

func update_visual():
	text = str(state)

	var color := Color(0.2, 0.2, 0.2)
	if state == 1:
		color = Color(0.8, 0.8, 0.8)

	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.set_corner_radius_all(4)
	style.set_border_width_all(1)
	style.border_color = Color.BLACK

	add_theme_stylebox_override("normal", style)
	add_theme_stylebox_override("hover", style)
	add_theme_stylebox_override("pressed", style)
