extends Node2D
class_name Grid

export var size = Vector2(9, 9)

var tiles = []

const tile_width = 120
const tile_height = 120

var placeholder = null

func _ready():
  create_empty_grid()
  
func set_tile(x, y, tile):
  if outside_bounds(x, y):
    return
  if tiles[x][y] != null:
    tiles[x][y].queue_free()
  tiles[x][y] = tile

func get_tile(x, y):
  if outside_bounds(x, y):
    return placeholder

  return tiles[x][y]

func outside_bounds(x, y):
  return x < 0 || y < 0 || x >= size.x || y >= size.y

func clear_grid():
  for x in size.x:
    for y in size.y:
      if tiles[x][y] != null:
        tiles[x][y].queue_free()
      tiles[x][y] = null

func create_empty_grid():
  for x in size.x:
    tiles.append([])
    for y in size.y:
      tiles[x].append(null)

func pixel_to_grid(x, y):
  var pixel_position = Vector2(x, y)
  var local_position = pixel_position - global_position

  if local_position.x < 0 || local_position.y < 0:
    return null
  if local_position.x > tile_width * size.x || local_position.y > tile_height * size.y:
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
  
func as_index(cell:Vector2) -> int:
  return int(cell.x + size.x * cell.y)
