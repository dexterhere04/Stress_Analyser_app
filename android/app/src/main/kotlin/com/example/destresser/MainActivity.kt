package com.example.destresser

import android.provider.Settings
import android.content.Intent
import android.content.ComponentName
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.destresser/notification_listener"
    private val EVENT_CHANNEL = "com.destresser/notifications"
    private val KEYBOARD_CHANNEL = "com.destresser/keyboard"

    private var eventSink: EventChannel.EventSink? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "checkPermission" -> {
                    result.success(isNotificationListenerEnabled())
                }
                "requestPermission" -> {
                    requestNotificationListenerPermission()
                    result.success(isNotificationListenerEnabled())
                }
                "startListening" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                        android.service.notification.NotificationListenerService.requestRebind(
                            ComponentName(this, NotificationListener::class.java)
                        )
                    }
                    result.success(true)
                }
                "stopListening" -> {
                    result.success(true)
                }
                "openNotificationSettings" -> {
                    openNotificationSettings()
                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, KEYBOARD_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isKeyboardEnabled" -> {
                    result.success(isKeyboardEnabled())
                }
                "isKeyboardSelected" -> {
                    result.success(isKeyboardSelected())
                }
                "enableKeyboard" -> {
                    enableKeyboard()
                    result.success(true)
                }
                "disableKeyboard" -> {
                    disableKeyboard()
                    result.success(true)
                }
                "openKeyboardSettings" -> {
                    openKeyboardSettings()
                    result.success(true)
                }
                "getLastSessionMetrics" -> {
                    result.success(getLastSessionMetrics())
                }
                "hasPendingSession" -> {
                    result.success(hasPendingSession())
                }
                "clearSession" -> {
                    clearKeyboardSession()
                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                    NotificationCallbackHandler.setCallback { appName, text ->
                        runOnUiThread {
                            eventSink?.success(mapOf(
                                "appName" to appName,
                                "text" to text
                            ))
                        }
                    }
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                }
            }
        )
    }

    private fun isNotificationListenerEnabled(): Boolean {
        val packageName = packageName
        val flat = Settings.Secure.getString(
            contentResolver,
            "enabled_notification_listeners"
        )
        return flat?.contains(packageName) == true
    }

    private fun requestNotificationListenerPermission() {
        if (!isNotificationListenerEnabled()) {
            try {
                val intent = Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS)
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                startActivity(intent)
            } catch (e: Exception) {
                val intent = Intent(Settings.ACTION_SETTINGS)
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                startActivity(intent)
            }
        }
    }

    private fun openNotificationSettings() {
        try {
            val intent = Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
        } catch (e: Exception) {
            val intent = Intent(Settings.ACTION_SETTINGS)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
        }
    }

    private fun isKeyboardEnabled(): Boolean {
        val enabledInputMethods = Settings.Secure.getString(
            contentResolver,
            Settings.Secure.ENABLED_INPUT_METHODS
        )
        return enabledInputMethods?.contains("com.example.destresser") == true
    }

    private fun isKeyboardSelected(): Boolean {
        val defaultInputMethod = Settings.Secure.getString(
            contentResolver,
            Settings.Secure.DEFAULT_INPUT_METHOD
        )
        return defaultInputMethod?.contains("com.example.destresser") == true
    }

    private fun enableKeyboard() {
        val prefs = getSharedPreferences("destresser_keystroke_logger", MODE_PRIVATE)
        prefs.edit().putBoolean("keyboard_enabled", true).apply()
    }

    private fun disableKeyboard() {
        val prefs = getSharedPreferences("destresser_keystroke_logger", MODE_PRIVATE)
        prefs.edit().putBoolean("keyboard_enabled", false).apply()
    }

    private fun openKeyboardSettings() {
        try {
            val intent = Intent(Settings.ACTION_INPUT_METHOD_SETTINGS)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
        } catch (e: Exception) {
            val intent = Intent(Settings.ACTION_SETTINGS)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
        }
    }

    private fun getLastSessionMetrics(): Map<String, Any?> {
        val prefs = getSharedPreferences("destresser_keystroke_logger", MODE_PRIVATE)
        return mapOf(
            "sessionId" to prefs.getString("last_session_id", null),
            "startTime" to prefs.getLong("last_session_start", 0),
            "endTime" to prefs.getLong("last_session_end", 0),
            "totalKeystrokes" to prefs.getInt("last_session_keystrokes", 0),
            "totalBackspaces" to prefs.getInt("last_session_backspaces", 0),
            "wpm" to prefs.getFloat("last_session_wpm", 0f),
            "errorRate" to prefs.getFloat("last_session_error_rate", 0f),
            "stressScore" to prefs.getFloat("last_session_stress", 0f),
            "hesitationScore" to prefs.getFloat("last_session_hesitation", 0f),
            "rhythmScore" to prefs.getFloat("last_session_rhythm", 0f)
        )
    }

    private fun hasPendingSession(): Boolean {
        val prefs = getSharedPreferences("destresser_keystroke_logger", MODE_PRIVATE)
        return prefs.getLong("session_start_time", 0) > 0
    }

    private fun clearKeyboardSession() {
        val prefs = getSharedPreferences("destresser_keystroke_logger", MODE_PRIVATE)
        prefs.edit().apply {
            remove("current_session_id")
            remove("session_start_time")
            remove("keystroke_chars")
            remove("backspace_times")
            remove("keystroke_count")
            remove("backspace_count")
            apply()
        }
    }
}
