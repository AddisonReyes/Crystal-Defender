extends Control

var data

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.play("Dance")
	load_data()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$FairiesKilled/Label.text = str(data["FairiesKilles"])
	$CoinsCollected/Label.text = str(data["CoinsCollected"])
	$TimePlayed/Label.text = formatTime(data["TimePlayed"])


func load_data():
	var file = FileAccess.open("res://data.dat", FileAccess.READ)
	data = file.get_var()


func formatTime(seconds: int) -> String:
	var hours = seconds / 3600
	var minutes = (seconds % 3600) / 60
	var remainingSeconds = seconds % 60
	
	var formattedTime = str(hours).pad_zeros(2) + ":" + str(minutes).pad_zeros(2) + ":" + str(remainingSeconds).pad_zeros(2)
	return formattedTime



func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_exit_pressed():
	get_tree().quit()
