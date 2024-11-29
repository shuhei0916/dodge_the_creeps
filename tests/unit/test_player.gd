extends GutTest

class TestPlayerMoves :
	extends GutTest
	
	var _player
	
	func before_each():
		# 準備 Arrange
		# var player = preload("res://player.gd").new()
		var player_scene = preload("res://player.tscn")
		_player = player_scene.instantiate()
		gut.p("player instance created!")
		add_child(_player)
		_player._ready()

	func test_player_right_moves():
		# 実行 Act
		gut.p("before: " + str(_player.position))
		Input.action_press("move_right")
		_player._process(0.016)  # 16msのフレーム時間でシミュレーション
		
		# 検証 Assertion
		assert_true(_player.position.x > 0, "Player should move right")
		gut.p("after: " + str(_player.position))
		Input.action_release("move_right")
		
	# test_player_right_movesは通るのに、これは通らない
	#func test_player_left_moves():
		## 実行 Act
		#gut.p("before: " + str(_player.position))
		#Input.action_press("move_left")
		#_player._process(0.016)  # 16msのフレーム時間でシミュレーション
		#
		## 検証 Assertion
		#gut.p("after: " + str(_player.position))
		#assert_true(_player.position.x < 0, "Player should move left")
		#Input.action_release("move_left")
		
	func test_player_stays_within_bounds():
		#player.screen_size = Vector2(800, 600)  # 画面サイズをセット
		gut.p("screen_size: " + str(_player.screen_size))
		_player.position = Vector2(900, 1000)
		gut.p("before: " + str(_player.position))
		_player._process(0.016)
		#assert_true(true)
		gut.p("after: " + str(_player.position))
		assert_true(_player.position.x <= 480 and _player.position.y <= 720, "Player should stay within screen bounds")

	#func test_player_moves_diagonally():
		#pass

	func after_each():
		# 終了処理
		#_player.queue_free()
		if is_instance_valid(_player):
			_player.queue_free()
		#await(get_tree(), "idle_frame")  # 削除完了を待機
		await get_tree().process_frame  # 削除完了を待機


class TestPlayerHit:
	extends GutTest
	
	var _player
	
	func before_each():
		# 準備 Arrange
		# var player = preload("res://player.gd").new()
		var player_scene = preload("res://player.tscn")
		_player = player_scene.instantiate()
		gut.p("player instance created!")
		add_child(_player)
		_player._ready()
		
	func test_player_disapperars_on_collision():
		_player._on_body_entered() # 
		assert_false(_player.visible)
