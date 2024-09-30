extends Node3D

var correct_shadow_receive := false
var write_depth := false
var trim_edges := false
var min_layers := 8
var max_layers := 32


func _ready() -> void:
	update_materials()


func _process(_delta: float) -> void:
	($FPSLabel as Label).text = "%d FPS (%.2f mspf)" % [Engine.get_frames_per_second(), 1000.0 / Engine.get_frames_per_second()]


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"toggle_correct_shadow_receive"):
		correct_shadow_receive = not correct_shadow_receive
		update_materials()

	if event.is_action_pressed(&"toggle_write_depth"):
		write_depth = not write_depth
		update_materials()

	if event.is_action_pressed(&"toggle_trim_edges"):
		trim_edges = not trim_edges
		update_materials()

	if event.is_action_pressed(&"cycle_layer_count"):
		min_layers = 8 if min_layers == 64 else 64
		max_layers = 32 if max_layers == 64 else 64
		update_materials()



func update_materials() -> void:
	for mesh: MeshInstance3D in find_children("", "MeshInstance3D"):
		mesh.get_surface_override_material(0).heightmap_correct_shadow_receive = correct_shadow_receive
		mesh.get_surface_override_material(0).heightmap_write_depth = write_depth
		mesh.get_surface_override_material(0).heightmap_trim_edges = trim_edges
		mesh.get_surface_override_material(0).heightmap_min_layers = min_layers
		mesh.get_surface_override_material(0).heightmap_max_layers = max_layers

	($Info as RichTextLabel).text = """Correct shadow receive: %s
Write depth: %s
Trim edges: %s
Layers: min. [color=yellow]%d[/color], max. [color=yellow]%d[/color]
""" % [
	"[color=#6f6]Yes[/color]" if correct_shadow_receive else "[color=#f88]No[/color]",
	"[color=#6f6]Yes[/color]" if write_depth else "[color=#f88]No[/color]",
	"[color=#6f6]Yes[/color]" if trim_edges else "[color=#f88]No[/color]",
	min_layers,
	max_layers,
]
