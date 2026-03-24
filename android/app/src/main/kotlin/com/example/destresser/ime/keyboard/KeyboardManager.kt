package com.example.destresser.ime.keyboard

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.inputmethod.EditorInfo
import android.widget.LinearLayout
import android.widget.TextView
import com.example.destresser.R

class KeyboardManager(private val context: Context) {

    private var inputView: LinearLayout? = null
    private var isShiftActive = false
    private var isCapsLock = false
    private var currentImeService: com.example.destresser.ime.FlorisImeService? = null
    
    private val keyRows = listOf(
        listOf("q", "w", "e", "r", "t", "y", "u", "i", "o", "p"),
        listOf("a", "s", "d", "f", "g", "h", "j", "k", "l"),
        listOf("z", "x", "c", "v", "b", "n", "m")
    )
    
    private val numberRow = listOf("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
    
    private val specialKeys = mapOf(
        "shift" to KeyType.SHIFT,
        "backspace" to KeyType.BACKSPACE,
        "space" to KeyType.SPACE,
        "enter" to KeyType.ENTER,
        "123" to KeyType.NUMBER_TOGGLE,
        "abc" to KeyType.LETTER_TOGGLE,
        "globe" to KeyType.SWITCH_KEYBOARD
    )

    fun createInputView(imeService: com.example.destresser.ime.FlorisImeService): View {
        currentImeService = imeService
        
        inputView = LinearLayout(context).apply {
            orientation = LinearLayout.VERTICAL
            setBackgroundColor(0xFFF5F9FB.toInt())
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
        }
        
        buildKeyboard()
        return inputView!!
    }
    
    private fun buildKeyboard() {
        inputView?.removeAllViews()
        
        val numberRowView = createRow(numberRow, isNumberRow = true)
        inputView?.addView(numberRowView)
        
        for (row in keyRows) {
            val rowView = createRow(row)
            inputView?.addView(rowView)
        }
        
        val bottomRow = createBottomRow()
        inputView?.addView(bottomRow)
    }
    
    private fun createRow(keys: List<String>, isNumberRow: Boolean = false): View {
        return LinearLayout(context).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = android.view.Gravity.CENTER
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                dpToPx(48)
            ).apply {
                topMargin = dpToPx(4)
                bottomMargin = dpToPx(4)
            }
            
            val horizontalPadding = if (isNumberRow) dpToPx(8) else dpToPx(12)
            setPadding(horizontalPadding, 0, horizontalPadding, 0)
        }.also { row ->
            keys.forEach { key ->
                row.addView(createKey(key, if (isNumberRow) 36 else 32))
            }
        }
    }
    
    private fun createBottomRow(): View {
        return LinearLayout(context).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = android.view.Gravity.CENTER_VERTICAL
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                dpToPx(48)
            ).apply {
                topMargin = dpToPx(4)
                bottomMargin = dpToPx(8)
            }
            setPadding(dpToPx(8), 0, dpToPx(8), 0)
            
            addView(createSpecialKey("123", dpToPx(48)))
            addView(createSpecialKey("shift", dpToPx(42)))
            addView(createSpaceKey())
            addView(createSpecialKey("backspace", dpToPx(48)))
            addView(createSpecialKey("enter", dpToPx(56)))
        }
    }
    
    private fun createKey(label: String, size: Int): View {
        return TextView(context).apply {
            text = if (isShiftActive || isCapsLock) label.uppercase() else label
            textSize = 18f
            setTextColor(0xFF1F2937.toInt())
            gravity = android.view.Gravity.CENTER
            
            val params = LinearLayout.LayoutParams(0, dpToPx(size)).apply {
                weight = 1f
                marginStart = dpToPx(2)
                marginEnd = dpToPx(2)
            }
            layoutParams = params
            
            setBackgroundResource(android.R.drawable.edit_text)
            isClickable = true
            isFocusable = true
            
            setOnClickListener {
                handleKeyPress(label.first())
            }
            
            setOnTouchListener { v, event ->
                if (event.action == android.view.MotionEvent.ACTION_DOWN) {
                    v.setBackgroundColor(0xFFE0E0E0.toInt())
                } else {
                    v.setBackgroundResource(android.R.drawable.edit_text)
                }
                false
            }
        }
    }
    
    private fun createSpecialKey(label: String, width: Int): View {
        val keyType = specialKeys[label] ?: return View(context)
        
        return TextView(context).apply {
            text = when (keyType) {
                KeyType.SHIFT -> if (isCapsLock) "🔒" else "⬆"
                KeyType.BACKSPACE -> "⌫"
                KeyType.ENTER -> "↵"
                KeyType.SWITCH_KEYBOARD -> "🌐"
                KeyType.NUMBER_TOGGLE -> "123"
                KeyType.LETTER_TOGGLE -> "ABC"
                else -> label
            }
            textSize = if (keyType == KeyType.NUMBER_TOGGLE || keyType == KeyType.LETTER_TOGGLE) 14f else 20f
            setTextColor(0xFF4A90A4.toInt())
            gravity = android.view.Gravity.CENTER
            
            layoutParams = LinearLayout.LayoutParams(dpToPx(width), dpToPx(40)).apply {
                marginStart = dpToPx(2)
                marginEnd = dpToPx(2)
            }
            
            setBackgroundColor(0xFFE8E8E8.toInt())
            setPadding(0, dpToPx(8), 0, dpToPx(8))
            isClickable = true
            isFocusable = true
            
            setOnClickListener {
                handleSpecialKey(keyType)
            }
        }
    }
    
    private fun createSpaceKey(): View {
        return TextView(context).apply {
            text = "space"
            textSize = 12f
            setTextColor(0xFF1F2937.toInt())
            gravity = android.view.Gravity.CENTER
            
            layoutParams = LinearLayout.LayoutParams(0, dpToPx(40)).apply {
                weight = 4f
                marginStart = dpToPx(2)
                marginEnd = dpToPx(2)
            }
            
            setBackgroundColor(0xFFFFFFFF.toInt())
            isClickable = true
            isFocusable = true
            
            setOnClickListener {
                handleKeyPress(' ')
            }
        }
    }
    
    private fun handleKeyPress(char: Char) {
        currentImeService?.let { ime ->
            val displayChar = if (isShiftActive || isCapsLock) char.uppercaseChar() else char
            ime.commitCharacter(displayChar)
            
            if (isShiftActive && !isCapsLock) {
                isShiftActive = false
                updateShiftState()
            }
        }
    }
    
    private fun handleSpecialKey(keyType: KeyType) {
        currentImeService?.let { ime ->
            when (keyType) {
                KeyType.SHIFT -> {
                    if (isCapsLock) {
                        isCapsLock = false
                    } else if (isShiftActive) {
                        isCapsLock = true
                    } else {
                        isShiftActive = true
                    }
                    updateShiftState()
                }
                KeyType.BACKSPACE -> ime.commitBackspace()
                KeyType.SPACE -> ime.commitSpace()
                KeyType.ENTER -> ime.commitEnter()
                KeyType.SWITCH_KEYBOARD -> ime.switchToNextKeyboard()
                KeyType.NUMBER_TOGGLE -> buildKeyboard()
                KeyType.LETTER_TOGGLE -> buildKeyboard()
                else -> {}
            }
        }
    }
    
    private fun updateShiftState() {
        inputView?.let { view ->
            for (i in 0 until view.childCount) {
                val child = view.getChildAt(i)
                if (child is LinearLayout) {
                    for (j in 0 until child.childCount) {
                        val key = child.getChildAt(j)
                        if (key is TextView) {
                            val text = key.text.toString()
                            if (text.length == 1 && text[0].isLetter()) {
                                key.text = if (isShiftActive || isCapsLock) {
                                    text.uppercase()
                                } else {
                                    text.lowercase()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    fun onStartInput() {
        isShiftActive = true
        isCapsLock = false
    }
    
    fun onFinishInput() {
        // Session ends when keyboard closes
    }
    
    private fun dpToPx(dp: Int): Int {
        return (dp * context.resources.displayMetrics.density).toInt()
    }
    
    private enum class KeyType {
        SHIFT, BACKSPACE, SPACE, ENTER, SWITCH_KEYBOARD, NUMBER_TOGGLE, LETTER_TOGGLE
    }
}
