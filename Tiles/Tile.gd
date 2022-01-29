extends Node2D

export var tile_type = "Wall"
export var passable = false

var grid_position = Vector2() setget set_grid_position,get_grid_position

onready var animation = $AnimationPlayer

func _ready():
  pass # Replace with function body.

func appear():
  yield(get_tree().create_timer((grid_position.x + grid_position.y) * 0.05), "timeout")
  animation.play("Appear")

func get_grid_position():
  return grid_position
  
func set_grid_position(value):
  grid_position = value
  position.x = grid_position.x * Grid.tile_width
  position.y = grid_position.y * Grid.tile_height
