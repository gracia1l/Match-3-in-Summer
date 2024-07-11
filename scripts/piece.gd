extends Node2D

# 导出变量，用于在编辑器中设置对象的颜色
@export var color: String

# 标志该对象是否匹配
var matched = false

# 定义 dim 函数，使对象逐渐变暗和变大，然后消失
func dim():
	# 创建一个平行的 Tween 动画
	var tween = create_tween().set_parallel(true)
	
	# 添加一个属性动画，使对象的 scale在 0.2 秒内变为 Vector2(1.4, 1.4)，使用指数过渡
	tween.tween_property(self, "scale", Vector2(1.4, 1.4), 0.2).set_trans(Tween.TRANS_EXPO)
	
	# 添加一个属性动画，使对象的 modulate在 0.2 秒内变为透明色，使用正弦过渡和缓出效果
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

# 定义 move 函数，使对象移动到目标位置
func move(target):
	# 创建一个 Tween 动画
	var tween = create_tween()
	
	# 添加一个属性动画，使对象的 position（位置）在 0.3 秒内移动到目标位置，从当前的位置开始，使用弹性过渡和缓出效果
	tween.tween_property(self, "position", target, 0.3).from_current().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
