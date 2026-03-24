package com.example.destresser.ime

import android.inputmethodservice.InputMethodService
import android.view.View
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputConnection
import com.example.destresser.ime.keyboard.KeyboardManager
import com.example.destresser.ime.keyboard.EditorInstance

class FlorisImeService : InputMethodService() {

    private lateinit var keyboardManager: KeyboardManager
    private lateinit var editorInstance: EditorInstance
    private lateinit var keystrokeLogger: KeystrokeLogger

    private var isSessionActive = false
    private var currentInputPackage: String? = null

    override fun onCreate() {
        super.onCreate()
        keystrokeLogger = KeystrokeLogger(applicationContext)
        keyboardManager = KeyboardManager(this)
        editorInstance = EditorInstance()
    }

    override fun onStartInput(attribute: EditorInfo?, restarting: Boolean) {
        super.onStartInput(attribute, restarting)
        
        currentInputPackage = attribute?.packageName ?: "unknown"
        
        if (!restarting) {
            editorInstance.reset()
        }
        
        if (keystrokeLogger.isEnabled()) {
            if (!isSessionActive) {
                startSession()
            }
            keystrokeLogger.setCurrentPackage(currentInputPackage!!)
        }
    }

    override fun onFinishInput() {
        super.onFinishInput()
        
        if (isSessionActive) {
            endSession()
        }
        editorInstance.reset()
    }

    override fun onCreateInputView(): View {
        return keyboardManager.createInputView(this)
    }

    override fun onStartInputView(info: EditorInfo?, restarting: Boolean) {
        super.onStartInputView(info, restarting)
        keyboardManager.onStartInput()
    }

    override fun onFinishInputView(finishingInput: Boolean) {
        super.onFinishInputView(finishingInput)
        keyboardManager.onFinishInput()
        
        if (finishingInput) {
            endSession()
        }
    }

    override fun onUpdateSelection(oldSelStart: Int, oldSelEnd: Int, newSelStart: Int, newSelEnd: Int, candidatesStart: Int, candidatesEnd: Int) {
        super.onUpdateSelection(oldSelStart, oldSelEnd, newSelStart, newSelEnd, candidatesStart, candidatesEnd)
        editorInstance.updateSelection(newSelStart, newSelEnd)
    }

    fun getInputConnection(): InputConnection? {
        return currentInputConnection
    }

    fun getEditorInstance(): EditorInstance = editorInstance

    private fun startSession() {
        isSessionActive = true
        keystrokeLogger.startSession()
    }

    private fun endSession() {
        if (isSessionActive) {
            isSessionActive = false
            keystrokeLogger.endSession()
        }
    }

    fun commitCharacter(char: Char) {
        val ic = currentInputConnection ?: return
        
        if (keystrokeLogger.isEnabled()) {
            keystrokeLogger.logKeypress(
                character = char.toString(),
                timestamp = System.currentTimeMillis(),
                isError = false
            )
        }
        
        ic.commitText(char.toString(), 1)
    }

    fun commitBackspace() {
        val ic = currentInputConnection ?: return
        
        if (keystrokeLogger.isEnabled()) {
            keystrokeLogger.logBackspace(System.currentTimeMillis())
        }
        
        ic.sendKeyEvent(
            android.view.KeyEvent(
                android.view.KeyEvent.ACTION_DOWN,
                android.view.KeyEvent.KEYCODE_DEL
            )
        )
        ic.sendKeyEvent(
            android.view.KeyEvent(
                android.view.KeyEvent.ACTION_UP,
                android.view.KeyEvent.KEYCODE_DEL
            )
        )
    }

    fun commitSpace() {
        val ic = currentInputConnection ?: return
        
        if (keystrokeLogger.isEnabled()) {
            keystrokeLogger.logKeypress(
                character = " ",
                timestamp = System.currentTimeMillis(),
                isError = false
            )
        }
        
        ic.commitText(" ", 1)
    }

    fun commitEnter() {
        val ic = currentInputConnection ?: return
        
        if (keystrokeLogger.isEnabled()) {
            keystrokeLogger.logKeypress(
                character = "\n",
                timestamp = System.currentTimeMillis(),
                isError = false
            )
        }
        
        ic.sendKeyEvent(
            android.view.KeyEvent(
                android.view.KeyEvent.ACTION_DOWN,
                android.view.KeyEvent.KEYCODE_ENTER
            )
        )
        ic.sendKeyEvent(
            android.view.KeyEvent(
                android.view.KeyEvent.ACTION_UP,
                android.view.KeyEvent.KEYCODE_ENTER
            )
        )
    }

    fun switchToNextKeyboard() {
        switchToNextInputMethod(false)
    }

    override fun onComputeInsets(outInsets: Insets) {
        super.onComputeInsets(outInsets)
        outInsets.contentTopInsets = outInsets.visibleTopInsets
    }

    override fun onKeyDown(keyCode: Int, event: android.view.KeyEvent?): Boolean {
        return if (handleKeyEvent(keyCode, event)) true else super.onKeyDown(keyCode, event)
    }

    override fun onKeyUp(keyCode: Int, event: android.view.KeyEvent?): Boolean {
        return if (handleKeyEvent(keyCode, event)) true else super.onKeyUp(keyCode, event)
    }

    private fun handleKeyEvent(keyCode: Int, event: android.view.KeyEvent?): Boolean {
        if (event == null) return false
        
        when (keyCode) {
            android.view.KeyEvent.KEYCODE_DEL -> {
                if (event.action == android.view.KeyEvent.ACTION_DOWN) {
                    commitBackspace()
                }
                return true
            }
            android.view.KeyEvent.KEYCODE_SPACE -> {
                if (event.action == android.view.KeyEvent.ACTION_DOWN) {
                    commitSpace()
                }
                return true
            }
            android.view.KeyEvent.KEYCODE_ENTER -> {
                if (event.action == android.view.KeyEvent.ACTION_DOWN) {
                    commitEnter()
                }
                return true
            }
        }
        
        return false
    }
}
