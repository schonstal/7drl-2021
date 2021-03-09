extends Node2D

onready var entities = $Board/Entities
onready var tiles = $Board/Tiles

func get_tile(x, y):
  if tiles != null:
    return tiles.get_tile(x, y)

func get_entity(x, y):
  if entities != null:
    return entities.get_entity(x, y)
