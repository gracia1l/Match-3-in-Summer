extends Node

# 从场景树中获取音乐播放器节点
@onready var music_player = $music_player

# 从配置管理器中获取音效和音乐开关状态
@onready var sound_on = ConfigManager.sound_on
@onready var music_on = ConfigManager.music_on

# 导出变量，允许在编辑器中设置多个音乐音频流和按钮点击音效
@export var musics: Array[AudioStream]
@export var button_sound: AudioStream

# 当前播放的音乐索引
var music_idx

# 当节点进入场景树时调用
func _ready():
	# 随机种子初始化
	randomize()
	# 随机选择一个音乐索引
	music_idx = randi() % musics.size()
	# 如果音乐被配置管理器关闭，则切换音乐开关状态
	if !ConfigManager.music_on:
		music_toggle()
	# 播放音乐
	play_music()

# 播放音乐的方法
func play_music():
	# 设置音乐播放器的音频流为当前索引的音乐
	music_player.stream = musics[music_idx]
	# 播放音乐
	music_player.play()

# 播放音效的方法
func play_sound(stream : AudioStream):
	# 仅当音效开关打开时才播放音效
	if ConfigManager.sound_on:
		# 创建一个新的音频流播放器实例
		var instance = AudioStreamPlayer.new()
		# 设置音频流为传入的音效流
		instance.stream = stream
		# 连接音效播放完成信号到remove_audio方法
		instance.finished.connect(remove_audio.bind(instance))
		# 将音频流播放器实例添加为子节点
		add_child(instance)
		# 播放音效
		instance.play()

# 移除音效播放器实例的方法
func remove_audio(instance: AudioStreamPlayer):
	# 从场景树中移除并释放音效播放器实例
	instance.queue_free()

# 当音乐播放器播放完成时调用
func _on_music_player_finished():
	# 更新当前音乐索引，循环播放列表
	music_idx = (music_idx + 1) % musics.size()
	# 播放下一首音乐
	play_music()

# 切换音乐开关状态的方法
func music_toggle():
	# 如果音乐播放器的音量大于 -79 dB，则将音量调至 -80 dB（静音）
	if music_player.volume_db > -79:
		music_player.volume_db = -80
	# 否则将音量调至 -16 dB（正常播放）
	else:
		music_player.volume_db = -16

# 按钮点击时播放音效的方法
func button_click():
	# 播放按钮点击音效
	play_sound(button_sound)
