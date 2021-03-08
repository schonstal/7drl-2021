extends Node2D

export var width = 8
export var height = 8

export(Array,Resource) var tile_scenes = []

var tiles = []
var tile_width = 128
var tile_height

var wall_tile = preload("res://Tiles/Wall.tscn")
var dummy_wall = null

var enemy_spawn_count = 0

# For easy yield sequencing
signal sequence_completed

func _ready():
  randomize()

  dummy_wall = wall_tile.instance()
  position.x = 1920 / 2 - width * tile_width / 2

  EventBus.connect("level_completed", self, "_on_level_completed")
  EventBus.connect("start_level", self, "_on_start_level")
  EventBus.connect("game_over", self, "_on_game_over")

  create_empty_grid()
  call_deferred("populate_grid")

func get_tile(position):
  if outside_bounds(position):
    return dummy_wall

  return tiles[position.x][position.y]

func outside_bounds(position):
  return position.x < 0 ||\
         position.y < 0 ||\
         position.x >= width ||\
         position.y >= height

func populate_grid():
  clear_grid()
  call_deferred("spawn_tiles")

func clear_grid():
  for x in width:
    for y in height:
      if tiles[x][y] != null:
        tiles[x][y].queue_free()
      tiles[x][y] = null

func create_empty_grid():
  for x in width:
    tiles.append([])
    for y in height:
      tiles[x].append(null)

func spawn_tiles():
  for y in height:
    var tile
    for x in width:
      if tiles[x][y] == null:
        tile = spawn_tile(x, y)
        tile.call_deferred("appear")
      else:
        tile = tiles[x][y]
        tile.call_deferred("appear")

    yield(get_tree().create_timer(0.05), "timeout")

  emit_signal("sequence_completed")

func spawn_tile(x, y):
  var shuffled = tile_scenes.duplicate()
  shuffled.shuffle()

  var instance = null

  while shuffled.size() > 0:
    var scene = shuffled.pop_front()
    instance = scene.instance()
    instance.grid_position = Vector2(x, y)
    tiles[x][y] = instance

  add_child(instance)

  return instance

func pixel_to_grid(pixel_position):
  var local_position = pixel_position - global_position

  if local_position.x < 0 || local_position.y < 0:
    return null
  if local_position.x > tile_width * width || local_position.y > tile_height * height:
    return null

  var grid_position = Vector2(
      int(local_position.x / tile_width),
      int(local_position.y / tile_height))

  return grid_position

func grid_to_pixel(grid_position):
  return Vector2(
      tile_width * grid_position.x + tile_width / 2,
      tile_height * grid_position.y + tile_height / 2
    )

func mouse_to_grid():
  var mouse_position = get_viewport().get_mouse_position()
  return pixel_to_grid(mouse_position)

func _on_level_completed(data):
  pass

func _on_start_level(data):
  pass
  
func _on_game_over(data):
  pass
