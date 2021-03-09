extends Node2D

class_name Entity

var TYPE_PLAYER = "player"
var TYPE_ENEMY = "enemy"

var grid_position = Vector2(0, 0)

var hp = 0
var entity_type = TYPE_ENEMY
var hostile_types = [TYPE_PLAYER]

var dead = false
var attacked = false
var stunned = false

var damage = 1
var armor = 0
