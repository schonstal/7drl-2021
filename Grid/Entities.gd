extends Node2D

onready var grid = $Grid

func get_entity(x, y):
  return grid.get_tile(x, y)

func add_entity(entity, x, y):
  grid.set_tile(x, y, entity)
  add_child(entity)
