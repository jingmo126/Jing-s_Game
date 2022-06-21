extends Node


# Declare member variables here. Examples:
export(String,FILE,"*.json") var dialogue_path = ""
var dialogue_kv = []
var current = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$DialogueUI.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		show_dialogue()

func show_dialogue():
	if current == 0:
		start_dialogue()
		$DialogueUI.show()
	elif current<dialogue_kv.size():
		$DialogueUI/Name.text = dialogue_kv[current].name
		$DialogueUI/Text.text = dialogue_kv[current].text
		current+=1
	else:
		current = 0
		$DialogueUI.hide()

func index_dialogue():
	dialogue_kv.clear()
	var dialogue  = load_dialogue()
	for num in range(0,dialogue.size()):
		dialogue_kv.append(dialogue[num])

func start_dialogue():
	index_dialogue()
	$DialogueUI/Name.text = dialogue_kv[current].name
	$DialogueUI/Text.text = dialogue_kv[current].text
	current += 1

func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_path):
		file.open(dialogue_path,File.READ)
		var dialogue = parse_json(file.get_as_text())
		file.close()
		return dialogue
