extends Node2D

export var width = 8
export var height = 8

var tiles = []

var tile_width = 128
var tile_height = 128

var placeholder = null

func _ready():
  create_empty_grid()

func get_tile(x, y):
  if outside_bounds(x, y):
    return placeholder

  return tiles[x][y]

func outside_bounds(x, y):
  return x < 0 || y < 0 || x >= width || y >= height

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

func pixel_to_grid(x, y):
  var pixel_position = Vector2(x, y)
  var local_position = pixel_position - global_position

  if local_position.x < 0 || local_position.y < 0:
    return null
  if local_position.x > tile_width * width || local_position.y > tile_height * height:
    return null

  var grid_position = Vector2(
      int(local_position.x / tile_width),
      int(local_position.y / tile_height))

  return grid_position

func grid_to_pixel(x, y):
  return Vector2(
      tile_width * x + tile_width / 2,
      tile_height * y + tile_height / 2
    )

func mouse_to_grid():
  var mouse_position = get_viewport().get_mouse_position()
  return pixel_to_grid(mouse_position.x, mouse_position.y)
