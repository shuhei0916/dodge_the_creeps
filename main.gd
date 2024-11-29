extends Node

@export var mob_scene: PackedScene
var score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	$HUD.show_game_over()
	
	$Music.stop()
	$DeathSound.play()
	
func new_game():
	# グループ内の全てのノードに対し、名前付きの関数（ここではqueue_free)を呼び出す
	get_tree().call_group("mobs", "queue_free")
	
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	$Music.play()

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	
	# Choose a random location on Path2D
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Set the mob's posistion to a random location 
	mob.position = mob_spawn_location.position
	
	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(50.0, 150.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob) 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
