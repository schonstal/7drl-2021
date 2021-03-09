extends Node

onready var entity = $'..'

func _ready():
  pass
  
func _process(_delta):
  if Input.is_action_just_pressed("move_up"):
    move(0, 1)
  elif Input.is_action_just_pressed("move_left"):
    move(1, 0)
  elif Input.is_action_just_pressed("move_right"):
    move(-1, 0)
  elif Input.is_action_just_pressed("move_down"):
    move(0, -1)
    
func move(dx, dy):
  entity.move(dx, dy)
  EventBus.emit_signal("tick", {})
