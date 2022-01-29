extends Node2D

var wall_tile = preload("res://Tiles/Wall.tscn")

var passable_tiles = [] setget ,get_passable_tiles

export(Array,Resource) var tile_scenes = []

onready var grid = $Grid

signal sequence_completed

func _ready():
  grid.placeholder = wall_tile.instance()
  call_deferred("populate_grid")
  
func _process(delta):
  if Input.is_action_just_pressed("ui_accept"):
    call_deferred("populate_grid")
  
func get_passable_tiles():
  var tiles = []
  for x in grid.width:
    for y in grid.height:
      var tile = grid.get_tile(x, y)
      if tile != null && tile.passable:
        tiles.append(tile)
  return tiles
  
func get_tile(x, y):
  return grid.get_tile(x, y)

func populate_grid():
  grid.clear_grid()
  call_deferred("spawn_tiles")
  
func spawn_tiles():
  for y in grid.height:
    var tile
    for x in grid.width:
      if grid.tiles[x][y] == null:
        tile = spawn_tile(x, y)
        tile.call_deferred("appear")
      else:
        tile = grid.tiles[x][y]
        tile.call_deferred("appear")

  emit_signal("sequence_completed")

func spawn_tile(x, y):
  var shuffled = tile_scenes.duplicate()
  shuffled.shuffle()

  var instance = null

  while shuffled.size() > 0:
    var scene = shuffled.pop_front()
    instance = scene.instance()
    instance.grid_position = Vector2(x, y)
    grid.tiles[x][y] = instance

  add_child(instance)

  return instance
