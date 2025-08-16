extends Control

func client() -> void:
	LocalNetHandeler.start_client()
	queue_free()

func server() -> void:
	LocalNetHandeler.start_server()
	queue_free()
