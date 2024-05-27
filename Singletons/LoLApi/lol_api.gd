# No class name because this is autoloaded and gets its name there
extends Node
# Wrapper class for communicating with the LoL API through Javascript.
# This class must be autoloaded so it can initialize connections once and be used globally


signal start_message_received(payload)
signal translation_message_received(payload)
signal load_state_message_received(payload)
signal pause_message_received(payload)
signal unpause_message_received(payload)

const INCOMING_MESSAGE_NAMES = {
	"start": "start_message_received",
	"language": "translation_message_received",
	"loadState": "load_state_message_received",
	"pause": "pause_message_received",
	"resume": "unpause_message_received",
}
const OUTGOING_MESSAGE_NAMES = {
	"READY": "gameIsReady",
	"TTS": "speakText",
	"REQ_SAVES": "loadState",
	"SAVE": "saveState",
	"PROGRESS": "progress",
	"COMPLETE": "complete",
}
const OUTGOING_MESSAGE_PAYLOADS = {
	"READY": """{ 
		"aspectRatio": "{aspect_ratio}",
		"resolution": "{resolution}",
		}""",
	"TTS": """{ 
		"key": "{translation_text_key}",
		}""",
	"REQ_SAVES": "\"*\"",
	"SAVE": """{ 
		"data": {data},
		}""",
	"PROGRESS": """{ 
		"currentProgress": {current_progress},
		"maximumProgress": {maximum_progress},
		}""",
}

var _receive_message_callback = JavaScript.create_callback(self, "receive_message")

# Initialize connections to the browser message system for communicating with the LoLApi
func _init():
	if OS.has_feature("LoLApi"):
		JavaScript.get_interface("window").addEventListener("message", _receive_message_callback)


# Callback function for receiving messages from the LoLApi
# @param msg: The message content received from the LoLApi
func receive_message(msg):
	print("receiving message...")
	var json_data = JavaScript.get_interface("JSON").stringify(msg[0].data)
	var message_data = ConversionsLib.json_to_dictionary(json_data)
	var message_name = message_data.messageName
	
	var payload = null
	if message_data.payload:
		payload = ConversionsLib.json_to_dictionary(message_data.payload)
	
	print("received message: ", message_name)
	if message_name in INCOMING_MESSAGE_NAMES.keys():
		emit_signal(INCOMING_MESSAGE_NAMES[message_name], payload)
	else:
		printerr("Unhandled message: " + message_name)


# Send a "game is ready" message to the LoL API
func send_ready_message():
	var payload = OUTGOING_MESSAGE_PAYLOADS.READY.format({
		"aspect_ratio": "16:9",
		"resolution": ConversionsLib.vector2_to_string(OS.window_size),
	})
	_send_message("READY", payload)


# Send a "text to speech" message to the LoL API
func send_tts_message(text_key: String):
	var payload = OUTGOING_MESSAGE_PAYLOADS.TTS.format({
		"translation_text_key": text_key,
	})
	_send_message("TTS", payload)


# Send a saves request message to the LoL API
func send_saves_request_message():
	var payload = OUTGOING_MESSAGE_PAYLOADS.REQ_SAVES
	_send_message("REQ_SAVES", payload)


# Send a save state to the LoL API
func send_save_state_message(data: Dictionary):
	var data_json = ConversionsLib.dictionary_to_json(data)
	
	var payload = OUTGOING_MESSAGE_PAYLOADS.SAVE.format({
		"data": data_json,
	})
	_send_message("SAVE", payload)


# Send a progress update to the LoL API
func send_progress_message(current_progress: int, maximum_progress: int):
	var payload = OUTGOING_MESSAGE_PAYLOADS.PROGRESS.format({
		"current_progress": current_progress,
		"maximum_progress": maximum_progress,
	})
	_send_message("PROGRESS", payload)


# Send a "game completed" message to the LoL API
func send_complete_message():
	_send_message("COMPLETE")


# Send a message to the LoL API
# @param message_name: The message type to send. Must exist as key in the above known outgoing_message_names.
# @param payload: The payload data to send in the message. This should be json in a String format
func _send_message(message_name: String, payload: String = "{}"):
	if OS.has_feature("LoLApi"):
		print("sending message: ", message_name)
		assert(message_name in OUTGOING_MESSAGE_NAMES.keys(), "Unknown message name: " + StringLib.quotify(message_name))
		var message = OUTGOING_MESSAGE_NAMES[message_name]
		
		var command = """
			parent.postMessage({
				message: "{message}",
				payload: JSON.stringify({payload})
			}, '*');
		"""
		JavaScript.eval(command.format({"message": message, "payload": payload}))
		
		if OS.has_feature("editor"):
			print("Sent LoLApi message: {0} with payload: {1}".format([
				StringLib.quotify(message), 
				StringLib.quotify(payload),
			]))
		
		print("sent message: ", message_name)
