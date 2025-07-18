extends Control

@onready var line_edit_width = $LineEdit_Width
@onready var line_edit_height = $LineEdit_Height
@onready var generate_button = $GenerateButton
@onready var export_button = $ExportButton
@onready var grid_parent = $GridParent
@onready var save_dialog = $SaveDialog

const GridCell = preload("res://GridCell.tscn")

var grid_data = []

func _ready():
	generate_button.pressed.connect(_on_generate_pressed)
	export_button.pressed.connect(_on_export_pressed)
	save_dialog.file_selected.connect(_on_file_selected)

func _on_generate_pressed():
	var width = int(line_edit_width.text)
	var height = int(line_edit_height.text)

	if width <= 0 or height <= 0:
		return

	for child in grid_parent.get_children():
		child.queue_free()

	grid_data.clear()
	grid_parent.columns = width

	for y in range(height):
		var row = []
		for x in range(width):
			var cell = GridCell.instantiate()
			grid_parent.add_child(cell)
			row.append(cell)
		grid_data.append(row)

	export_button.disabled = false

func _on_export_pressed():
	save_dialog.popup_centered()

func _on_file_selected(path):
	var lines = []
	for row in grid_data:
		var line = ""
		for cell in row:
			line += str(cell.state)
		lines.append(line)

	var text = "\n".join(lines)
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(text)
	file.close()
	print("Grid exported to: %s" % path)
