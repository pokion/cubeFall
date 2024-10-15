extends Control

func _on_name_meta_clicked(meta):
	OS.shell_open(str(meta))
