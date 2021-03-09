extends Node2D

onready var entities = $Board/Entities
onready var tiles = $Board/Tiles

var player = preload("res://Entities/Player/Player.tscn")

func _ready():
  spawn_player()

func spawn_player():
  yield(get_tree().create_timer(0.5), "timeout")
  var spawn_tile = tiles.passable_tiles[0]
  var instance = player.instance()
  entities.add_entity(
    instance,
    spawn_tile.grid_position.x,
    spawn_tile.grid_position.y)

func get_tile(x, y):
  if tiles != null:
    return tiles.get_tile(x, y)

func get_entity(x, y):
  if entities != null:
    return entities.get_entity(x, y)
