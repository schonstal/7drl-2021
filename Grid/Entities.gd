extends Node2D

onready var grid = $Grid

func get_entity(x, y):
  return grid.get_tile(x, y)
