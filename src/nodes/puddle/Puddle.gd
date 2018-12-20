extends Area2D

const sprite_1_pack = preload("res://nodes/puddle/Puddle_1/PuddleAnimatedSprite1.tscn")
const sprite_2_pack = preload("res://nodes/puddle/Puddle_2/PuddleAnimatedSprite2.tscn")
const sprite_3_pack = preload("res://nodes/puddle/Puddle_3/PuddleAnimatedSprite3.tscn")
const sprite_4_pack = preload("res://nodes/puddle/Puddle_4/PuddleAnimatedSprite4.tscn")

const collision_1_pack = preload("res://nodes/puddle/Puddle_1/PuddleCollisionPolygon1.tscn")
const collision_2_pack = preload("res://nodes/puddle/Puddle_2/PuddleCollisionPolygon2.tscn")
const collision_3_pack = preload("res://nodes/puddle/Puddle_3/PuddleCollisionPolygon3.tscn")
const collision_4_pack = preload("res://nodes/puddle/Puddle_4/PuddleCollisionPolygon4.tscn")

const shape_sets = [ 
	[sprite_1_pack, collision_1_pack], 
	[sprite_2_pack, collision_2_pack], 
	[sprite_3_pack, collision_3_pack], 
	[sprite_4_pack, collision_4_pack]
	]

onready var anim_sprite = get_node("PuddleAnimatedSprite1")

func _ready():
	randomize()
	random_shape()

func random_shape():
	for c in get_children():
		c.queue_free()
	var cur_shape_index = randi()%shape_sets.size()
	var cur_sprite = shape_sets[cur_shape_index][0].instance()
	var cur_collision = shape_sets[cur_shape_index][1].instance()
	add_child(cur_sprite)
	add_child(cur_collision)
	anim_sprite = cur_sprite
	anim_sprite.connect("animation_finished", self, "_on_AnimatedSprite_animation_finished")

func shock_everybody():
	anim_sprite.play("light_up")
	for b in get_overlapping_bodies():
		print(b)
		if b.is_in_group("enemy") or b.is_in_group("player"):
			b.shock()

func _on_AnimatedSprite_animation_finished():
	if anim_sprite.animation != "default":
		anim_sprite.play("default")

func _on_Puddle_area_entered(area):
	if area.is_in_group("lightning"):
		shock_everybody()