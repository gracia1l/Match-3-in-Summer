extends Node2D

var is_cat = false

func _ready():
	if is_cat:
		$Sprite.texture = preload("res://scenes/cat.tscn")
	else:
		$Sprite.texture = preload("res://scenes/cardboard.tscn")

func transform_to_cat():
	is_cat = true
	$Sprite.texture = preload("res://scenes/cat.tscn")
	# 可以添加更多逻辑，例如动画
