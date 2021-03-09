extends Node2D

onready var entities = $Entities
onready var tiles = $Tiles

func get_tile(x, y):
  if tiles != null:
    return tiles.get_tile(x, y)

func get_entity(x, y):
  if entities != null:
    return entities.get_entity(x, y)
