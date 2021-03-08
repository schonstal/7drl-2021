extends Node2D

export var tile_type = "Wall"
export var passable = false

var width = 128
var height = 128

var grid_position = Vector2() setget set_grid_position,get_grid_position

func _ready():
  pass # Replace with function body.

func appear():
  visible = true

func get_grid_position():
  return grid_position
  
func set_grid_position(value):
  grid_position = value
  position.x = grid_position.x * width
  position.y = grid_position.y * height
