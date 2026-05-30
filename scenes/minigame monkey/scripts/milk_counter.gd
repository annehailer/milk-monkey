extends Label

func _process(_delta):
	text = "Milk: " + str(Globals.milk)
