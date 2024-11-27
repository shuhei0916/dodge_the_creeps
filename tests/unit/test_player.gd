extends GutTest

func test_passes():
	assert_eq(1, 1)

func test_player_moves():
	# var player = preload("res://player.gd").new()
	var player_scene = preload("res://player.tscn").instantiate()
	player_scene._ready()
	# 右方向への移動をテスト
	Input.action_press("move_right")
	player_scene._process(0.016)  # 16msのフレーム時間でシミュレーション
	assert_true(player_scene.position.x > 0, "Player should move right")
	Input.action_release("move_right")
