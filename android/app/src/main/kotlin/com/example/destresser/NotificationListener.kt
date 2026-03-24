package com.example.destresser

import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log

class NotificationListener : NotificationListenerService() {

    companion object {
        private const val TAG = "NotificationListener"
        var instance: NotificationListener? = null
            private set
    }

    override fun onCreate() {
        super.onCreate()
        instance = this
        Log.d(TAG, "NotificationListener service created")
    }

    override fun onDestroy() {
        super.onDestroy()
        instance = null
        Log.d(TAG, "NotificationListener service destroyed")
    }

    override fun onNotificationPosted(sbn: StatusBarNotification?) {
        sbn?.let {
            val packageName = it.packageName
            val appName = getAppName(packageName)
            val title = it.notification.extras.getCharSequence("android.title")?.toString() ?: ""
            val text = it.notification.extras.getCharSequence("android.text")?.toString() ?: ""
            val combinedText = "$title $text".trim()

            if (combinedText.isNotEmpty() && !isSystemPackage(packageName)) {
                Log.d(TAG, "Notification from $appName: $combinedText")
                NotificationCallbackHandler.onNotificationReceived(appName, combinedText)
            }
        }
    }

    override fun onNotificationRemoved(sbn: StatusBarNotification?) {
        Log.d(TAG, "Notification removed: ${sbn?.packageName}")
    }

    private fun getAppName(packageName: String): String {
        return try {
            val packageManager = applicationContext.packageManager
            val applicationInfo = packageManager.getApplicationInfo(packageName, 0)
            packageManager.getApplicationLabel(applicationInfo).toString()
        } catch (e: Exception) {
            packageName
        }
    }

    private fun isSystemPackage(packageName: String): Boolean {
        return packageName == applicationContext.packageName ||
            packageName == "android" ||
            packageName == "com.android.systemui"
    }
}

object NotificationCallbackHandler {
    private var onNotificationCallback: ((String, String) -> Unit)? = null

    fun setCallback(callback: (String, String) -> Unit) {
        onNotificationCallback = callback
    }

    fun onNotificationReceived(appName: String, text: String) {
        onNotificationCallback?.invoke(appName, text)
    }
}
