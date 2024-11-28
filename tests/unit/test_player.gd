extends GutTest

func test_passes():
	assert_eq(1, 1)

func test_player_moves():
	# 準備 Arrange
	# var player = preload("res://player.gd").new()
	var player_scene = preload("res://player.tscn")
	var player = player_scene.instantiate()
	add_child(player)
	player._ready()
	
	# 実行 Act
	Input.action_press("move_right")
	player._process(0.016)  # 16msのフレーム時間でシミュレーション
	
	# 検証 Assertion
	assert_true(player.position.x > 0, "Player should move right")

	# 終了処理
	Input.action_release("move_right")
	player.queue_free()
