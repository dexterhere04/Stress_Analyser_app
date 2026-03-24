package com.example.destresser.ime.keyboard

import android.view.inputmethod.InputConnection

class EditorInstance {
    private var ic: InputConnection? = null
    private var selectionStart: Int = 0
    private var selectionEnd: Int = 0
    private var composingStart: Int = -1
    private var composingEnd: Int = -1
    
    fun setInputConnection(inputConnection: InputConnection?) {
        ic = inputConnection
    }
    
    fun getInputConnection(): InputConnection? = ic
    
    fun updateSelection(newSelStart: Int, newSelEnd: Int) {
        selectionStart = newSelStart
        selectionEnd = newSelEnd
    }
    
    fun updateComposingRegion(start: Int, end: Int) {
        composingStart = start
        composingEnd = end
    }
    
    fun isComposing(): Boolean = composingStart >= 0 && composingEnd >= 0
    
    fun getTextBeforeCursor(length: Int): CharSequence? {
        return ic?.getTextBeforeCursor(length, 0)
    }
    
    fun getTextAfterCursor(length: Int): CharSequence? {
        return ic?.getTextAfterCursor(length, 0)
    }
    
    fun getSelectedText(): CharSequence? {
        return ic?.getSelectedText(0)
    }
    
    fun commitText(text: String, newCursorPosition: Int) {
        ic?.commitText(text, newCursorPosition)
    }
    
    fun setComposingText(text: String, newCursorPosition: Int) {
        ic?.setComposingText(text, newCursorPosition)
    }
    
    fun finishComposingText() {
        ic?.finishComposingText()
    }
    
    fun deleteSurroundingText(beforeLength: Int, afterLength: Int) {
        ic?.deleteSurroundingText(beforeLength, afterLength)
    }
    
    fun setSelection(start: Int, end: Int) {
        ic?.setSelection(start, end)
    }
    
    fun getCursorCapsMode(reqModes: Int): Int {
        return ic?.getCursorCapsMode(reqModes) ?: 0
    }
    
    fun sendKeyEvent(event: android.view.KeyEvent) {
        ic?.sendKeyEvent(event)
    }
    
    fun reset() {
        ic = null
        selectionStart = 0
        selectionEnd = 0
        composingStart = -1
        composingEnd = -1
    }
    
    fun getSelectionStart(): Int = selectionStart
    fun getSelectionEnd(): Int = selectionEnd
    fun getComposingStart(): Int = composingStart
    fun getComposingEnd(): Int = composingEnd
}
