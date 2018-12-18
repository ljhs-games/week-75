extends Label

export var scroll_rate = 40.0

var start_counter = 0.0

var credits = """
creikey
as
Team Lead, Programmer Lead, Sound Lead

Stving_artist
as
Lead Artist

Kathan
as
Artist

ApGoldberg
as
Programmer

Michael
as
Left the Club

Frantic Run
Music by Jay Man - OurMusicBox
http://www.youtube.com/c/ourmusicbox
"""

func _ready():
	set_process(true)
	if credits != "":
		self.text = credits

func _process(delta):
	if start_counter < 1.0:
		start_counter += delta
		return
	rect_global_position.y -= scroll_rate*delta
	if margin_bottom <= 500:
		set_process(false)
