extends Node2D

const TYPE_ENEMY = 0
const TYPE_PLAYER = 1

export(int, "Enemy", "Player") var entity_type
export var hit_points = 0
export var attack = 1
export var armor = 0

var grid_position = Vector2(0, 0)
var hostile_types = [TYPE_PLAYER]

var dead = false
var attacked = false
var stunned = false

func move(dx, dy):
  position = position - Vector2(dx * 128, dy * 128)
