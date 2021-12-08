extends Area2D


signal update_grounded(is_grounded)


# touch ground
func _on_GroundCheck_body_entered(body):
	if body.is_in_group("Enemy"):
		return
	if body.is_in_group("Lava"):
		emit_signal("update_grounded", false)
		return
	emit_signal("update_grounded", true)

# not touch ground
func _on_GroundCheck_body_exited(body):
	if body.is_in_group("Enemy"):
		return
	emit_signal("update_grounded", false)


func _on_GroundCheck_area_entered(area):
	var _area = area as Area2D
	if _area.is_in_group("Enemy"):
		if _area.is_in_group("Head"):
			_area.get_parent().emit_signal("kill")
			get_parent().move.y = -300
