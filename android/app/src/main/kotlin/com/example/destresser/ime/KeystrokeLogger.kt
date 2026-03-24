package com.example.destresser.ime

import android.content.Context
import android.content.SharedPreferences
import java.util.UUID

class KeystrokeLogger(private val context: Context) {

    private val prefs: SharedPreferences = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
    
    private var currentSessionId: String? = null
    private var sessionStartTime: Long = 0
    private var currentPackage: String = "unknown"
    
    private val keystrokeTimes = mutableListOf<Long>()
    private val keystrokeCharacters = mutableListOf<String>()
    private val backspaceCount = mutableListOf<Long>()
    
    private var totalKeystrokes = 0
    private var totalBackspaces = 0
    private var wordCount = 0
    private var lastWordEnd = 0L
    
    fun isEnabled(): Boolean = prefs.getBoolean(KEY_ENABLED, false)
    
    fun setEnabled(enabled: Boolean) {
        prefs.edit().putBoolean(KEY_ENABLED, enabled).apply()
    }
    
    fun startSession() {
        currentSessionId = UUID.randomUUID().toString()
        sessionStartTime = System.currentTimeMillis()
        
        keystrokeTimes.clear()
        keystrokeCharacters.clear()
        backspaceCount.clear()
        totalKeystrokes = 0
        totalBackspaces = 0
        wordCount = 0
        lastWordEnd = sessionStartTime
        
        saveSessionStart()
    }
    
    fun logKeypress(character: String, timestamp: Long, isError: Boolean) {
        keystrokeTimes.add(timestamp)
        keystrokeCharacters.add(character)
        totalKeystrokes++
        
        if (character == " " || character == "\n") {
            wordCount++
            lastWordEnd = timestamp
        }
        
        saveKeystroke(character, timestamp)
    }
    
    fun logBackspace(timestamp: Long) {
        backspaceCount.add(timestamp)
        totalBackspaces++
        
        saveBackspace(timestamp)
    }
    
    fun endSession(): SessionMetrics {
        val endTime = System.currentTimeMillis()
        val duration = endTime - sessionStartTime
        
        val metrics = calculateMetrics(duration)
        
        saveSessionEnd(metrics)
        
        return metrics
    }
    
    private fun calculateMetrics(duration: Long): SessionMetrics {
        val wpm = if (duration > 0) {
            val minutes = duration / 60000.0
            val words = totalKeystrokes / 5.0
            (words / minutes).toFloat()
        } else 0f
        
        val errorRate = if (totalKeystrokes > 0) {
            (totalBackspaces.toFloat() / totalKeystrokes) * 100
        } else 0f
        
        val hesitationScore = calculateHesitationScore()
        val rhythmScore = calculateRhythmScore()
        val stressScore = calculateStressScore(wpm, errorRate, hesitationScore, rhythmScore)
        
        return SessionMetrics(
            sessionId = currentSessionId ?: UUID.randomUUID().toString(),
            startTime = sessionStartTime,
            endTime = System.currentTimeMillis(),
            duration = duration,
            totalKeystrokes = totalKeystrokes,
            totalBackspaces = totalBackspaces,
            wpm = wpm,
            errorRate = errorRate,
            hesitationScore = hesitationScore,
            rhythmScore = rhythmScore,
            stressScore = stressScore,
            packageName = currentPackage
        )
    }
    
    private fun calculateHesitationScore(): Float {
        if (keystrokeTimes.size < 3) return 0f
        
        val intervals = mutableListOf<Long>()
        for (i in 1 until keystrokeTimes.size) {
            intervals.add(keystrokeTimes[i] - keystrokeTimes[i - 1])
        }
        
        val avgInterval = intervals.average()
        val longPauses = intervals.count { it > avgInterval * 3 }
        
        return (longPauses.toFloat() / intervals.size) * 100
    }
    
    private fun calculateRhythmScore(): Float {
        if (keystrokeTimes.size < 5) return 100f
        
        val intervals = mutableListOf<Long>()
        for (i in 1 until keystrokeTimes.size) {
            intervals.add(keystrokeTimes[i] - keystrokeTimes[i - 1])
        }
        
        intervals.removeAll { it > 1000 }
        if (intervals.isEmpty()) return 100f
        
        val avg = intervals.average()
        val variance = intervals.map { (it - avg) * (it - avg) }.average()
        val stdDev = kotlin.math.sqrt(variance)
        
        val coefficientOfVariation = if (avg > 0) (stdDev / avg) * 100 else 0.0
        
        return (100 - coefficientOfVariation.toFloat()).coerceIn(0f, 100f)
    }
    
    private fun calculateStressScore(
        wpm: Float,
        errorRate: Float,
        hesitationScore: Float,
        rhythmScore: Float
    ): Float {
        var score = 0f
        
        score += when {
            wpm < 30 -> 20f
            wpm < 50 -> 10f
            wpm < 70 -> 5f
            wpm > 100 -> 15f
            else -> 0f
        }
        
        score += when {
            errorRate > 15 -> 30f
            errorRate > 10 -> 20f
            errorRate > 5 -> 10f
            else -> 0f
        }
        
        score += (hesitationScore * 0.5f).coerceAtMost(25f)
        
        score += ((100 - rhythmScore) * 0.3f).coerceAtMost(15f)
        
        return score.coerceIn(0f, 100f)
    }
    
    private fun saveSessionStart() {
        prefs.edit().apply {
            putString(KEY_CURRENT_SESSION_ID, currentSessionId)
            putLong(KEY_SESSION_START_TIME, sessionStartTime)
            putString(KEY_CURRENT_PACKAGE, currentPackage)
            apply()
        }
    }
    
    private fun saveKeystroke(character: String, timestamp: Long) {
        val editor = prefs.edit()
        
        val count = prefs.getInt(KEY_KEYSTROKE_COUNT, 0)
        editor.putInt(KEY_KEYSTROKE_COUNT, count + 1)
        
        val chars = prefs.getString(KEY_KEYSTROKE_CHARS, "") ?: ""
        editor.putString(KEY_KEYSTROKE_CHARS, "$chars$timestamp:$character;")
        
        editor.apply()
    }
    
    private fun saveBackspace(timestamp: Long) {
        val count = prefs.getInt(KEY_BACKSPACE_COUNT, 0)
        prefs.edit().putInt(KEY_BACKSPACE_COUNT, count + 1).apply()
        
        val times = prefs.getString(KEY_BACKSPACE_TIMES, "") ?: ""
        prefs.edit().putString(KEY_BACKSPACE_TIMES, "$times$timestamp;").apply()
    }
    
    private fun saveSessionEnd(metrics: SessionMetrics) {
        prefs.edit().apply {
            putString(KEY_LAST_SESSION_ID, metrics.sessionId)
            putLong(KEY_LAST_SESSION_START, metrics.startTime)
            putLong(KEY_LAST_SESSION_END, metrics.endTime)
            putInt(KEY_LAST_SESSION_KEYSTROKES, metrics.totalKeystrokes)
            putInt(KEY_LAST_SESSION_BACKSPACES, metrics.totalBackspaces)
            putFloat(KEY_LAST_SESSION_WPM, metrics.wpm)
            putFloat(KEY_LAST_SESSION_ERROR_RATE, metrics.errorRate)
            putFloat(KEY_LAST_SESSION_STRESS, metrics.stressScore)
            putFloat(KEY_LAST_SESSION_HESITATION, metrics.hesitationScore)
            putFloat(KEY_LAST_SESSION_RHYTHM, metrics.rhythmScore)
            
            putString(KEY_CURRENT_SESSION_ID, null)
            putLong(KEY_SESSION_START_TIME, 0)
            putString(KEY_KEYSTROKE_CHARS, "")
            putString(KEY_BACKSPACE_TIMES, "")
            putInt(KEY_KEYSTROKE_COUNT, 0)
            putInt(KEY_BACKSPACE_COUNT, 0)
            
            apply()
        }
    }
    
    fun setCurrentPackage(packageName: String) {
        currentPackage = packageName
        prefs.edit().putString(KEY_CURRENT_PACKAGE, packageName).apply()
    }
    
    fun getCurrentSessionId(): String? = currentSessionId
    
    fun hasPendingSession(): Boolean {
        return prefs.getLong(KEY_SESSION_START_TIME, 0) > 0
    }
    
    fun clearSession() {
        prefs.edit().apply {
            remove(KEY_CURRENT_SESSION_ID)
            remove(KEY_SESSION_START_TIME)
            remove(KEY_KEYSTROKE_CHARS)
            remove(KEY_BACKSPACE_TIMES)
            remove(KEY_KEYSTROKE_COUNT)
            remove(KEY_BACKSPACE_COUNT)
            apply()
        }
        
        keystrokeTimes.clear()
        keystrokeCharacters.clear()
        backspaceCount.clear()
        totalKeystrokes = 0
        totalBackspaces = 0
    }
    
    data class SessionMetrics(
        val sessionId: String,
        val startTime: Long,
        val endTime: Long,
        val duration: Long,
        val totalKeystrokes: Int,
        val totalBackspaces: Int,
        val wpm: Float,
        val errorRate: Float,
        val hesitationScore: Float,
        val rhythmScore: Float,
        val stressScore: Float,
        val packageName: String
    )
    
    companion object {
        private const val PREFS_NAME = "destresser_keystroke_logger"
        
        private const val KEY_ENABLED = "keyboard_enabled"
        private const val KEY_CURRENT_SESSION_ID = "current_session_id"
        private const val KEY_SESSION_START_TIME = "session_start_time"
        private const val KEY_CURRENT_PACKAGE = "current_package"
        private const val KEY_KEYSTROKE_COUNT = "keystroke_count"
        private const val KEY_KEYSTROKE_CHARS = "keystroke_chars"
        private const val KEY_BACKSPACE_COUNT = "backspace_count"
        private const val KEY_BACKSPACE_TIMES = "backspace_times"
        
        private const val KEY_LAST_SESSION_ID = "last_session_id"
        private const val KEY_LAST_SESSION_START = "last_session_start"
        private const val KEY_LAST_SESSION_END = "last_session_end"
        private const val KEY_LAST_SESSION_KEYSTROKES = "last_session_keystrokes"
        private const val KEY_LAST_SESSION_BACKSPACES = "last_session_backspaces"
        private const val KEY_LAST_SESSION_WPM = "last_session_wpm"
        private const val KEY_LAST_SESSION_ERROR_RATE = "last_session_error_rate"
        private const val KEY_LAST_SESSION_STRESS = "last_session_stress"
        private const val KEY_LAST_SESSION_HESITATION = "last_session_hesitation"
        private const val KEY_LAST_SESSION_RHYTHM = "last_session_rhythm"
    }
}
